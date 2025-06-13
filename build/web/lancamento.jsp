<%-- 
    Document   : index
    Created on : 2 de jun. de 2025, 13:09:47
    Author     : letic
--%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.text.NumberFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.LinkedHashSet"%> <%--exibir os anos de forma previsível no <select> --%>
<%@page import="java.util.Map"%> <%-- associando o número do mês à lista de gastos correspondentes--%>
<%@page import="java.util.LinkedHashMap"%> <%-- meses ordenados corretamente--%>
<%@page import="java.util.List"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="com.model.TipoReceitaDAO" %>
<%@page import="com.controller.TipoReceita" %>
<%@page import="com.model.ReceitaDAO" %>
<%@page import="com.controller.Receita" %>
<%@page import="com.model.GastosDAO"%>
<%@page import="com.controller.Gasto"%>
<%@page import="com.model.CategoriaDAO"%>
<%@page import="com.controller.Categoria"%>

<%
//usuário logado
boolean logado = session.getAttribute("email") != null;
int idUsuarioLogado = -1;
if (logado && session.getAttribute("id") != null) {
    idUsuarioLogado = Integer.parseInt(session.getAttribute("id").toString());
}
String emailUsuarioLogado = logado ? session.getAttribute("email").toString() : "";

//filtros
List<Receita> listaReceitas = (List<Receita>) request.getAttribute("listaReceitas");
NumberFormat formatoMoeda = NumberFormat.getCurrencyInstance(new java.util.Locale("pt", "BR"));
DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
double totalReceitas = 0;

GastosDAO gastosDAO = new GastosDAO();
ArrayList<Gasto> listarGastos = new ArrayList<>(gastosDAO.pesquisarPorUsuario(idUsuarioLogado));


//filtro
String anoSelecionado = request.getParameter("ano") != null ? request.getParameter("ano") : "";
String mesSelecionado = request.getParameter("mes") != null ? request.getParameter("mes") : "";

//pegar m~es e ano atual
LocalDate hoje = LocalDate.now();
if (anoSelecionado == null || anoSelecionado.isEmpty()) {
    anoSelecionado = String.valueOf(hoje.getYear());
}
if (mesSelecionado == null || mesSelecionado.isEmpty()) {
    mesSelecionado = String.format("%02d", hoje.getMonthValue()); // "01", "02", etc.
}

// Extrair anos disponíveis de gastos e receitas
Set<String> anosDisponiveis = new LinkedHashSet<>();
for (Gasto g : listarGastos) {
    if (g.getDatacadastro() != null) {
        anosDisponiveis.add(String.valueOf(g.getDatacadastro().getYear()));
    }
}
for (Receita r : listaReceitas) {
    if (r.getDatareceita() != null) {
        anosDisponiveis.add(String.valueOf(r.getDatareceita().getYear()));
    }
}

// Se nenhum ano foi selecionado, pega o primeiro disponível
if (anoSelecionado.equals("") && !anosDisponiveis.isEmpty()) {
    anoSelecionado = anosDisponiveis.iterator().next();
}

// Filtrar por ano e mês 
List<Gasto> gastosFiltrados = new ArrayList<>();
List<Receita> receitasFiltradas = new ArrayList<>();
if (!anoSelecionado.isEmpty()) {
    try {
        int anoSel = Integer.parseInt(anoSelecionado);
        Integer mesSel = null;

        if (!mesSelecionado.isEmpty()) {
            mesSel = Integer.parseInt(mesSelecionado);
        }

        final Integer mesSelFinal = mesSel; 

        gastosFiltrados = listarGastos.stream()
            .filter(g -> g.getDatacadastro() != null
                && g.getDatacadastro().getYear() == anoSel
                && (mesSelFinal == null || g.getDatacadastro().getMonthValue() == mesSelFinal))
            .collect(Collectors.toList());

        receitasFiltradas = listaReceitas.stream()
            .filter(r -> r.getDatareceita() != null
                && r.getDatareceita().getYear() == anoSel
                && (mesSelFinal == null || r.getDatareceita().getMonthValue() == mesSelFinal))
            .collect(Collectors.toList());

    } catch (NumberFormatException e) {
        gastosFiltrados = new ArrayList<>();
        receitasFiltradas = new ArrayList<>();
    }
}


// Agrupar por mês
Map<Integer, List<Gasto>> gastosPorMes = new LinkedHashMap<>();
for (Gasto g : gastosFiltrados) {
    int mes = g.getDatacadastro().getMonthValue();
    gastosPorMes.computeIfAbsent(mes, k -> new ArrayList<>()).add(g);
}

Map<Integer, List<Receita>> receitasPorMes = new LinkedHashMap<>();
for (Receita r : receitasFiltradas) {
    int mes = r.getDatareceita().getMonthValue();
    receitasPorMes.computeIfAbsent(mes, k -> new ArrayList<>()).add(r);
}

DecimalFormat df = new DecimalFormat("#,##0.00");

CategoriaDAO categoriaDAO = new CategoriaDAO();
List<Categoria> categorias = categoriaDAO.listarCategoriasPorUsuario(idUsuarioLogado);

TipoReceitaDAO tipoDAO = new TipoReceitaDAO();
List<TipoReceita> tipos = tipoDAO.listarTodos();

%>


<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Portal SeeGreen - Gastos</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css">

    <style>
        .btn-close { font-weight: bold; }
        textarea { resize: none; }
        nav{
            background-color: rgba(22, 160, 133, 0.5);
        }
        body{
            background-color: rgba(39, 174, 96, 0.2);
        }

.btn-gasto {
    background-image: url('assets/img/gasto.png');
    background-size: contain;
    background-repeat: no-repeat;
    background-position: center;
    width: 90px;   
    height: 45px;
    border: none;
    background-color: transparent; 
    cursor: pointer;
    padding: 0;
}

.btn-receita {
    background-image: url('assets/img/receita.png');
    background-size: contain;
    background-repeat: no-repeat;
    background-position: center;
    width: 90px;   
    height: 45px;
    border: none;
    background-color: transparent; 
    cursor: pointer;
    padding: 0;
}
    </style>
</head>

<body>
<nav class="navbar navbar-expand-lg navbar-light bg-light shadow-sm">
    <div class="container">
        <a class="navbar-brand d-flex align-items-center" href="ServletIndex">
            <img src="assets/img/logo.png" alt="SeeGreen" height="40">
            <p class="mb-0 ml-2">SeeGreen</p>
        </a>

        <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
            <ul class="navbar-nav">
                <li class="nav-item">
                     <a href="ServletIndex" class="nav-link">Menu</a>
                </li>
                <li class="nav-item">
                     <a href="ServletBuscarCategorias" class="nav-link">Minhas Categorias</a>
                </li>
                <li class="nav-item">
                     <a href="ServletLimites" class="nav-link">Limites</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-danger" href="ServletDeslogar">Sair</a>
                </li>
            </ul>
        </div>
    </div>
</nav>
                            

<div class="container py-5">
    <div class="card mb-4 shadow-sm">
    <div class="card-body py-3">
        <div class="row align-items-center">
            
            <!-- Título -->
            <div class="col-md-4 mb-2 mb-md-0">
                <h5 class="mb-0"><i class="fas fa-calendar-alt mr-2 text-primary"></i>Lançamentos</h5>
            </div>

            <!-- Filtro de Ano -->
            <div class="col-md-4 mb-2 mb-md-0">
                <form method="GET" class="form-inline">
                   <label class="mr-2 font-weight-bold text-dark">Período:</label>

    <select name="mes" class="form-control mr-2">
        <% for (int m = 1; m <= 12; m++) {
            String mesStr = String.format("%02d", m); %>
            <option value="<%= mesStr %>" <%= mesStr.equals(mesSelecionado) ? "selected" : "" %>>
                <%= mesStr %>
            </option>
        <% } %>
    </select>

    <select name="ano" class="form-control mr-2">
        <% for (String ano : anosDisponiveis) { %>
            <option value="<%= ano %>" <%= ano.equals(anoSelecionado) ? "selected" : "" %>>
                <%= ano %>
            </option>
        <% } %>
    </select>

    <button type="submit" class="btn btn-primary">Filtrar</button>
</form>

            </div>

            <!-- Botões -->
            <div class="col-md-4 text-md-right text-center">
                <button class="btn-receita" data-toggle="modal" title="Adicionar receitas" data-target="#modalCadastrarReceita">
                </button>
                <button class="btn-gasto" data-toggle="modal" title="Adicionar gastos" data-target="#modalCadastrar">
                </button>
            </div>
        </div>
    </div>
</div>

    <% for (Map.Entry<Integer, List<Receita>> entry : receitasPorMes.entrySet()) {
    int mes = entry.getKey();
    List<Receita> receitasMes = entry.getValue();
    double totalMes = receitasMes.stream().mapToDouble(Receita::getValor).sum();
%>
      
    <!--Lista de Receita--> 
    <div class="card mb-4">
<div class="card-header" style="background-color: rgba(40, 167, 69, 0.5);">
        <strong>Mês: <%= mes %> | Total de Receitas: R$ <%= df.format(totalMes) %></strong>
    </div>
    <div class="card-body p-0">
        <table class="table mb-0">
            <thead  style="background-color: rgba(40, 167, 69, 0.15);">
                <tr>
                    <th>Tipo</th>
                    <th class="text-center">Descrição</th>
                    <th class="text-center">Data</th>
                    <th class="text-center">Valor</th>
                    <th class="text-center">Ações</th>
                </tr>
            </thead>
            <tbody>
                <% for (Receita r : receitasMes) { %>
                    <tr>
                             <td><%= r.getTipoReceita().getNome() %></td>
                    <td class="text-center align-middle"><%= r.getDescricao() %></td>
                    <td class="text-center align-middle"><%= r.getDatareceita().format(formatter) %></td> 
                    <td class="text-center text-success align-middle"><%= formatoMoeda.format(r.getValor()) %></td>
                    <td class="text-center align-middle">
                                <a href="#" 
                                    class="btn btn-light btn-sm" 
    data-toggle="modal" 
   data-target="#modalEditarReceita"
   data-id="<%= r.getId() %>"
   data-descricao="<%= r.getDescricao() %>"
   data-valor="<%= r.getValor() %>"
   data-datareceita="<%= r.getDatareceita() %>" 
   data-tiporeceita="<%= r.getIdTipoReceita() %>" 
   data-usuario="<%= r.getIdUsuario() %>">
   <i class="fas fa-pen-nib"></i>
</a>

                                <a href="ServletDeletarReceita?id=<%= r.getId() %>"
                                   onclick="return confirm('Tem certeza que deseja apagar esta receita?')"
                                   class="btn btn-outline-danger btn-sm">
                                    <i class="fas fa-trash-alt"></i>
                                </a>
                            </td>
                        </tr>
                <% }} %>
            </tbody>
        </table>
    </div>
</div>
            
<!--Lista de Gastos-->               
<% if (logado) { %>
    <% for (Map.Entry<Integer, List<Gasto>> entry : gastosPorMes.entrySet()) {
        int mes = entry.getKey();
        List<Gasto> gastosMes = entry.getValue();
        double totalMes = gastosMes.stream().mapToDouble(Gasto::getValor).sum();
    %>

    <div class="card mb-4">
        <div class="card-header" style="background-color: rgba(220, 53, 69, 0.5);">
            <strong>Mês: <%= mes %> | Total de Gastos: R$ <%= df.format(totalMes) %> </strong>
        </div>
        <div class="card-body p-0">
            <table class="table mb-0">
                <thead style="background-color: rgba(220, 53, 69, 0.15);">
                    <tr>
                        <th>Categoria</th>
                        <th class="text-center">Descrição</th>
                        <th class="text-center">Data</th>
                        <th class="text-center">Valor</th>
                        <th class="text-center">Ações</th>
                    </tr>
                </thead>
                <tbody>                        
                    <% for (Gasto gasto : gastosMes) { %>
                        <tr>         
                            <td class="align-middle"><%= gasto.getCategoria().getCategoria() %></td>
                            <td class="text-center align-middle"> <%= gasto.getDescricao() %> </td>
                            <td class="text-center align-middle"><%= gasto.getDatacadastro().format(formatter) %></td>
                            <td class="text-center text-danger align-middle">R$ <%= df.format(gasto.getValor()) %></td>                             
                            <td class="text-center align-middle">
                                <a href="#"
   class="btn btn-light btn-sm"
   data-toggle="modal"
   data-target="#modalEditarGasto"
   onclick="editarGasto(
       '<%= gasto.getId() %>',
       '<%= gasto.getDescricao() %>',
       '<%= gasto.getValor() %>',
       '<%= gasto.getDatacadastro().format(formatter) %>'
   )">
   <i class="fas fa-pen-nib"></i>
</a>
                                
                                <a href="ServletDeletarGasto?id=<%= gasto.getId() %>"
                                   onclick="return confirm('Tem certeza que deseja apagar este gasto?')"
                                   class="btn btn-outline-danger">
                                    <i class="fas fa-trash-alt"></i>
                                </a>
                            </td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>
    <% } %>
<% } %>


<!-- Modal Cadastrar Gasto-->
<div class="modal fade" id="modalCadastrar" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <form method="POST" action="ServletCadastrarGasto">
                <div class="modal-header">
                    <h5 class="modal-title">Cadastrar Gasto</h5>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                <div class="modal-body">
    <input type="hidden" name="idUsuario" value="<%= idUsuarioLogado %>">

    <div class="form-group">
        <label>Categoria</label>
        <select class="form-control" name="idCategoria" required>
            <option value="">Selecione...</option>
            <% for (Categoria cat : categorias) { %>
                <option value="<%= cat.getId() %>"><%= cat.getCategoria() %></option>
            <% } %>
        </select>
    </div>

    <div class="form-group">
        <label>Descrição</label>
        <textarea class="form-control" name="descricao" required></textarea>
    </div>

    <div class="form-group">
        <label>Valor</label>
        <input class="form-control" type="number" step="0.01" name="valor" required>
    </div>

    <div class="form-group">
        <label>Data do Gasto</label>
        <input class="form-control" type="date" name="datacadastro" required>
    </div>
</div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Fechar</button>
                    <button type="submit" class="btn btn-primary">Cadastrar</button>
                </div>
            </form>
        </div>
    </div>
</div>
  
<!-- Modal Cadastrar Receita -->
<div class="modal fade" id="modalCadastrarReceita" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <form method="POST" action="ServletCadastrarReceita">
                <div class="modal-header">
                    <h5 class="modal-title">Cadastrar Receita</h5>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
               <div class="modal-body">
          <div class="form-group">
        <label for="tipo" class="form-label">Tipo de Receita</label>
            <select class="form-control" name="tipo" required>
              <option value="">Selecione...</option>
              <% for (TipoReceita tipo : tipos) { %>
                <option value="<%= tipo.getId() %>"><%= tipo.getNome() %></option>
              <% } %>
            </select>
    </div>
          <div class="mb-3">
            <label for="descricao" class="form-label">Descrição</label>
            <input type="text" class="form-control" name="descricao" required>
          </div>
          <div class="mb-3">
            <label for="valor" class="form-label">Valor (R$)</label>
            <input type="number" class="form-control" name="valor" step="0.01" required>
          </div>
          <div class="mb-3">
            <label for="data" class="form-label">Data</label>
            <input type="date" class="form-control" name="data" required>
          </div>
</div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Fechar</button>
                    <button type="submit" class="btn btn-primary">Cadastrar</button>
                </div>
            </form>
        </div>
    </div>
</div>
    
<!-- Modal Editar Receita -->
<div class="modal fade" id="modalEditarReceita" tabindex="-1" role="dialog" aria-labelledby="modalEditarReceitaLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <form action="ServletEditarReceita" method="post" class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="modalEditarReceitaLabel">Editar Receita</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Fechar">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <input type="hidden" name="id" id="edit-id">
        <input type="hidden" name="idUsuario" id="edit-idUsuario">
        
        <div class="form-group">
          <label>Descrição</label>
          <input type="text" name="descricao" class="form-control" id="edit-descricao" required>
        </div>

        <div class="form-group">
          <label>Valor</label>
          <input type="text" name="valor" class="form-control" id="edit-valor" required>
        </div>

        <div class="form-group">
          <label>Data</label>
          <input type="text" name="datareceita" class="form-control" id="edit-datareceita" placeholder="dd/MM/yyyy" required>
        </div>

      <div class="modal-footer">
        <button type="submit" class="btn btn-success">Salvar</button>
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
      </div>
    </form>
  </div>
</div>

<!--Modal Editar Gasto-->
<div class="modal fade" id="modalEditarGasto" tabindex="-1" role="dialog" aria-labelledby="modalEditarGastoLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <form action="ServletEditarGasto" method="post">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="modalEditarGastoLabel">Editar Gasto</h5>
          <button type="button" class="close" data-dismiss="modal" aria-label="Fechar">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body">
          
          <input type="hidden" id="gastoId" name="id">
          
          <div class="form-group">
            <label for="descricaoGasto">Descrição</label>
            <input type="text" class="form-control" id="descricaoGasto" name="descricao" required>
          </div>

          <div class="form-group">
            <label for="valorGasto">Valor</label>
            <input type="number" step="0.01" class="form-control" id="valorGasto" name="valor" required>
          </div>
          
          <div class="form-group">
            <label>Data do Gasto</label>
            <input class="form-control" type="date" id="datacadastro" required>
        </div>

        </div>
        <div class="modal-footer">
          <button type="submit" class="btn btn-primary">Salvar</button>
          <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
        </div>
      </div>
    </form>
  </div>
</div>


<!-- Scripts -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>

<script>
    function editarGasto(id, descricao, valor) {
    document.getElementById('gastoId').value = id;
    document.getElementById('descricaoGasto').value = descricao;
    document.getElementById('valorGasto').value = valor; 
    document.getElementById('datacadastro').value = datacadastro;
  }
    
    //puxar os dados para o editar receita
    $('#modalEditarReceita').on('show.bs.modal', function (event) {
    var button = $(event.relatedTarget); 
    
    $('#edit-id').val(button.data('id'));
    $('#edit-descricao').val(button.data('descricao'));
    $('#edit-valor').val(button.data('valor'));
    $('#edit-datareceita').val(button.data('datareceita'));
    $('#edit-idTipoReceita').val(button.data('tiporeceita'));
    $('#edit-idUsuario').val(button.data('usuario'));
  });
</script>


        
</body>
</html>