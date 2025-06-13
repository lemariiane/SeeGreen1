<%-- 
    Document   : selecionarCategoriaReceita
    Created on : 9 de jun. de 2025, 19:45:28
    Author     : letic
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>
<%
    String[][] categoriasReceita = {
        {"Salário", "#198754", "0"},
        {"Freelance", "#20c997", "0"},
        {"Aluguel Recebido", "#0d6efd", "0"},
        {"Dividendos", "#ffc107", "0"},
        {"Rendimentos de Poupança", "#6610f2", "0"},
        {"Venda de Produtos", "#fd7e14", "0"},
        {"13º Salário", "#6f42c1", "0"},
        {"Restituição de Imposto", "#17a2b8", "0"},
        {"Presente em Dinheiro", "#d63384", "0"},
        {"Outros", "#6c757d", "0"}
    };
%>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Escolha suas Categorias de Receita</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        .categoria-box {
            padding: 12px 16px;
            border: 2px solid #ccc;
            border-radius: 15px;
            margin-bottom: 10px;
            transition: background-color 0.3s ease, border-color 0.3s ease;
            cursor: pointer;
        }

        .categoria-box.checked {
            background-color: #d1e7dd;
            border-color: #198754;
        }

        .categoria-box .check-icon {
            display: none;
            margin-left: 10px;
            color: #198754;
        }

        .categoria-box.checked .check-icon {
            display: inline;
        }

        .form-check-input {
            display: none;
        }
    </style>
</head>
<body class="container mt-5">
    <h2>Escolha suas Categorias de Receita</h2>
    <p>Você pode adicionar mais depois. Se não quiser nenhuma, marque "Nenhuma categoria".</p>

    <form action="ServletSalvarCategoriasReceita" method="post">
        <% for (int i = 0; i < categoriasReceita.length; i++) {
            String nome = categoriasReceita[i][0];
            String cor = categoriasReceita[i][1];
            String limite = categoriasReceita[i][2];
        %>
            <div class="categoria-box" onclick="toggleCategoria(this)">
                <input class="form-check-input" type="checkbox" name="categoriasSelecionadas" value="<%= nome %>" id="cat<%= i %>">
                <label class="form-check-label fw-bold" for="cat<%= i %>"><%= nome %></label>
                <span class="check-icon">✔</span>
                <input type="hidden" name="corCategoria_<%= nome %>" value="<%= cor %>">
                <input type="hidden" name="limite_<%= nome %>" value="<%= limite %>">
            </div>
        <% } %>

        <div class="form-check mt-3 mb-4">
            <input class="form-check-input" type="checkbox" name="nenhuma" id="nenhuma" value="true">
            <label class="form-check-label" for="nenhuma">Nenhuma categoria</label>
        </div>

        <button type="submit" class="btn btn-success">Salvar Categorias</button>
    </form>

    <script>
        function toggleCategoria(div) {
            const checkbox = div.querySelector("input[type='checkbox']");
            checkbox.checked = !checkbox.checked;
            div.classList.toggle("checked", checkbox.checked);
        }
    </script>
</body>
</html>