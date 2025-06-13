<%-- 
    Document   : index
    Created on : 2 de jun. de 2025, 13:09:47
    Author     : letic
--%>
<%@page import="java.time.LocalDate"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.text.DecimalFormat"%>

<%
boolean logado = session.getAttribute("email") != null;
int idUsuarioLogado = -1;
if (logado && session.getAttribute("id") != null) {
    idUsuarioLogado = Integer.parseInt(session.getAttribute("id").toString());
}
String emailUsuarioLogado = logado ? session.getAttribute("email").toString() : "";

DecimalFormat df = new DecimalFormat("#,##0.00");
double totalReceitas = request.getAttribute("totalReceitas") != null ? (Double) request.getAttribute("totalReceitas") : 0.0;
double totalGastos = request.getAttribute("totalGastos") != null ? (Double) request.getAttribute("totalGastos") : 0.0;
double saldoMes = request.getAttribute("saldoMes") != null ? (Double) request.getAttribute("saldoMes") : 0.0;

LocalDate hoje = LocalDate.now();
int mesAtual = hoje.getMonthValue();
int anoAtual = hoje.getYear();

String paramMes = request.getParameter("mes");
String paramAno = request.getParameter("ano");

int mesSelecionado = (paramMes != null) ? Integer.parseInt(paramMes) : mesAtual;
int anoSelecionado = (paramAno != null) ? Integer.parseInt(paramAno) : anoAtual;
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Portal SeeGreen - Menu</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        .btn-close { font-weight: bold; }
        textarea { resize: none; }
        nav{
            background-color: rgba(22, 160, 133, 0.5);
        }
        body{
            background-color: rgba(39, 174, 96, 0.2);
        }
        .bg-blue-light-transparent {
    background-color: rgba(173, 216, 230); 
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
                     <a href="AcessarLancamentos" class="nav-link">Lançamentos</a>
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
 
<div class="d-flex justify-content-between align-items-center mb-3">
    <div class="alert mb-0">
        Bem vindo(a)! <strong><%= emailUsuarioLogado %></strong>
        <h5 class="mb-0">
            Panorama Geral: <%= String.format("%02d/%d", mesSelecionado, anoSelecionado) %>
        </h5>
    </div>

    <form method="get" action="ServletIndex" class="form-inline">
        <select name="mes" class="form-control mr-2">
            <% for (int m = 1; m <= 12; m++) {
                String mesStr = String.format("%02d", m); %>
                <option value="<%= m %>" <%= (m == mesSelecionado) ? "selected" : "" %>>
                    <%= mesStr %>
                </option>
            <% } %>
        </select>

        <select name="ano" class="form-control mr-2">
            <% for (int a = anoAtual; a >= anoAtual - 5; a--) { %>
                <option value="<%= a %>" <%= (a == anoSelecionado) ? "selected" : "" %>>
                    <%= a %>
                </option>
            <% } %>
        </select>

        <button type="submit" class="btn btn-success">Filtrar</button>
    </form>
</div>

    
    <div class="row mb-5">
        <div class="col-md-4">
            <div class="card border-success">
                <div class="card-body text-success">
                    <h5 class="card-title">Receitas</h5>
                    <p class="card-text display-6">R$ <%= df.format(totalReceitas) %></p>
                    <p>Total Receitas: R$ <%= request.getAttribute("totalReceitas") %></p>
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card border-danger">
                <div class="card-body text-danger">
                    <h5 class="card-title">Gastos</h5>
                    <p class="card-text display-6">R$ <%= df.format(totalGastos) %></p>
                    <p>Total Gastos: R$ <%= request.getAttribute("totalGastos") %></p>
                </div>
            </div>
        </div>

        <div class="col-md-4 mb-3">
        <div class="card border-info shadow">
            <div class="card-body">
                <h5 class="card-title text-info">📊 Saldo</h5>
                <p class="card-text display-6">R$ <%= request.getAttribute("saldoMes") %></p>
                <p><strong>Saldo do Mês:</strong> R$ <%= request.getAttribute("saldoMes") %></p>
            </div>
        </div>
    </div>
    </div>

<!-- Gráfico Pizza -->
<div class="card mb-4">
    <div class="card-header bg-blue-light-transparent p-3 rounded text-gray">
        Proporção: Receitas vs Gastos
    </div>
    <div class="card-body d-flex justify-content-center">
        <div style="width: 300px; height: 300px;">
            <canvas id="graficoPizza"></canvas>
        </div>
    </div>
</div>

<!-- Scripts -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
    const ctx = document.getElementById('graficoPizza').getContext('2d');
    new Chart(ctx, {
        type: 'pie',
        data: {
            labels: ['Receitas', 'Gastos'],
            datasets: [{
                data: [
                    <%= request.getAttribute("totalReceitas") != null ? request.getAttribute("totalReceitas") : 0 %>,
                    <%= request.getAttribute("totalGastos") != null ? request.getAttribute("totalGastos") : 0 %>
                ],
                backgroundColor: ['#28a745', '#dc3545']
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: { position: 'bottom' }
            }
        }
    });
</script>


</body>
</html>
