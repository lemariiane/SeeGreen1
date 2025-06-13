<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Cadastrar Categoria</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body{
            background-color: rgba(39, 174, 96, 0.2);
        }
    </style>
</head>
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

<div class="container d-flex justify-content-center align-items-center min-vh-100">
    <div class="card shadow p-4" style="width: 100%; max-width: 500px;">
        <h4 class="card-title mb-4 text-center">📁 Cadastrar Nova Categoria</h4>

        <form action="ServletSalvarCategoria" method="post">
            <div class="mb-3">
                <label for="nomeCategoria" class="form-label">Nome da Categoria</label>
                <input type="text" class="form-control" id="nomeCategoria" name="nomeCategoria" required>
            </div>

            <div class="mb-3">
                <label for="corCategoria" class="form-label">Cor</label>
                <input type="color" class="form-control form-control-color" id="corCategoria" name="corCategoria" value="#4CAF50" title="Escolha uma cor">
            </div>

            <div class="mb-3">
                <label for="limite" class="form-label">Limite de Gasto (R$)</label>
                <input type="text" class="form-control" id="limite" name="limite" placeholder="Ex: 100.00">
            </div>

            <button type="submit" class="btn btn-success w-100">
                💾 Salvar Categoria
            </button>
        </form>

        <% String erro = (String) request.getAttribute("erro");
           if (erro != null) { %>
            <div class="alert alert-danger mt-3" role="alert">
                <%= erro %>
            </div>
        <% } %>
    </div>
</div>

</body>
</html>
