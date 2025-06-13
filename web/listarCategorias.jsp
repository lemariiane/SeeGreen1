<%-- 
    Document   : listarCategorias
    Created on : 7 de jun. de 2025, 17:51:10
    Author     : letic
--%> <%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, com.controller.Categoria" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Minhas Categorias</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body{
            background-color: rgba(39, 174, 96, 0.2);
        }
    </style>
</head>
<% if (request.getAttribute("erro") != null) { %>
    <div class="alert alert-danger">
        <%= request.getAttribute("erro") %>
    </div>
<% } %>


<body class="bg-light">
    
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
                     <a href="AcessarLancamentos" class="nav-link">Lançamentos</a>
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
    
<div class="container mt-5">
    <div class="card shadow-sm">
        <div class="card-body">
            <div class="d-flex justify-content-between align-items-center mb-3">
    <h2 class="card-title mb-0">Minhas Categorias</h2>
    <a href="cadastrarCategoria.jsp" class="btn btn-success rounded-circle d-flex align-items-center justify-content-center"
       style="width: 40px; height: 40px; font-size: 24px;" title="Adicionar Categoria">
        +
    </a>
</div>

            <%
                List<Categoria> categorias = (List<Categoria>) request.getAttribute("categorias");
                if (categorias != null && !categorias.isEmpty()) {
            %>
            <div class="table-responsive">
                <table class="table table-bordered table-hover align-middle mt-3">
                    <thead class="table-light">
                        <tr>
                            <th>Nome</th>
                            <th>Cor</th>
                            <th>Limite (R$)</th>
                            <th>Ações</th>
                        </tr>
                    </thead>
                    <tbody>
                    <%
                        for (Categoria c : categorias) {
                    %>
                    <tr>
                        <td><%= c.getCategoria() %></td>
                        <td>
                            <span class="d-inline-block rounded-circle me-2" style="width: 16px; height: 16px; background-color: <%= c.getCor() %>; border: 1px solid #ccc;"></span>
                            
                        </td>
                        <td>R$ <%= String.format("%.2f", c.getLimite()) %></td>
                       <td>
    <div class="d-flex gap-2">
        <!-- Botão modal -->
        <button class="btn btn-sm btn-primary" data-bs-toggle="modal" data-bs-target="#editarModal<%= c.getId() %>">
            Editar
        </button>

        <!-- Formulário de exclusão -->
        <form action="ServletExcluirCategoria" method="post" 
      onsubmit="return confirm('Ao excluir esta categoria, todos os gastos vinculados a ela também serão excluídos. Deseja continuar?');" 
      class="d-inline">
    <input type="hidden" name="id" value="<%= c.getId() %>">
            <button type="submit" class="btn btn-sm btn-danger">Excluir</button>
</form>
    </div>
</td>

                    </tr>

                    <!-- Modal de edição -->
                    <div class="modal fade" id="editarModal<%= c.getId() %>" tabindex="-1" aria-labelledby="editarModalLabel<%= c.getId() %>" aria-hidden="true">
                        <div class="modal-dialog">
                            <form action="ServletEditarCategoria" method="post">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="editarModalLabel<%= c.getId() %>">Editar Categoria</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Fechar"></button>
                                    </div>
                                    <div class="modal-body">
                                        <input type="hidden" name="id" value="<%= c.getId() %>">
                                        <div class="mb-3">
                                            <label for="categoria<%= c.getId() %>" class="form-label">Nome da Categoria</label>
                                            <input type="text" class="form-control" id="categoria<%= c.getId() %>" name="categoria" value="<%= c.getCategoria() %>" required>
                                        </div>
                                        <div class="mb-3">
                                            <label for="cor<%= c.getId() %>" class="form-label">Cor</label>
                                            <input type="color" class="form-control form-control-color" id="cor<%= c.getId() %>" name="cor" value="<%= c.getCor() %>">
                                        </div>
                                        <div class="mb-3">
                                            <label for="limite<%= c.getId() %>" class="form-label">Limite (R$)</label>
                                            <input type="number" step="0.01" class="form-control" id="limite<%= c.getId() %>" name="limite" value="<%= c.getLimite() %>">
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                                        <button type="submit" class="btn btn-success">Salvar</button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                    <%
                        }
                    %>
                    </tbody>
                </table>
            </div>
            <%
                } else {
            %>
            <div class="alert alert-info mt-4" role="alert">
                Nenhuma categoria cadastrada.
            </div>
            <%
                }
            %>
        </div>
    </div>
</div>

<!-- Bootstrap JS Bundle (necessário para o modal funcionar) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
