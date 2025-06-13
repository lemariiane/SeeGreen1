<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> 
<%@ page import="java.util.*" %>
<%
    String[][] categoriasComuns = {
        {"Mercado", "#28a745", "100"},
        {"Padaria", "#a3cfbb", "100"},
        {"Lazer", "#ffc107", "100"},
        {"Transporte", "#0d6efd", "100"},
        {"Saúde", "#dc3545", "100"},
        {"Educação", "#6610f2", "100"},
        {"Entretenimento", "#fd7e14", "100"},
        {"Vestuário", "#d63384", "100"},
        {"Moradia", "#6c757d", "100"},
        {"Investimentos", "#20c997", "100"},
        {"Assinaturas", "#17a2b8", "100"}
    };
%>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Escolha suas Categorias</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body{
            background-color: rgba(39, 174, 96, 0.2);
        }
        .container-categorias {
            max-width: 600px;
            margin: auto;
            background-color: #ffffff;
            padding: 2rem;
            border-radius: 1rem;
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
        }
        .form-check-label {
            font-weight: 500;
        }
        .btn-custom {
            width: 100%;
            font-size: 1.1rem;
            padding: 0.75rem;
            margin-top: 1rem;
        }
        .form-check-input:checked {
            background-color: #198754;
            border-color: #198754;
        }
    </style>
</head>
<body>
    <div class="container mt-5">
        <div class="container-categorias">
            <h2 class="text-center mb-3">Escolha suas Categorias</h2>
            <p class="text-center text-muted">Você poderá adicionar mais categorias depois.</p>

            <form action="ServletSalvarCategoriasPadrao" method="post">
                <% for (int i = 0; i < categoriasComuns.length; i++) {
                    String nomeCategoria = categoriasComuns[i][0];
                    String corCategoria = categoriasComuns[i][1];
                    String limite = categoriasComuns[i][2];
                %>
                    <div class="form-check form-switch mb-3">
                        <input class="form-check-input" type="checkbox" name="categoriasSelecionadas" value="<%= nomeCategoria %>" id="cat<%= i %>">
                        <label class="form-check-label" for="cat<%= i %>"><%= nomeCategoria %></label>
                        <input type="hidden" name="corCategoria_<%= nomeCategoria %>" value="<%= corCategoria %>">
                        <input type="hidden" name="limite_<%= nomeCategoria %>" value="<%= limite %>">
                    </div>
                <% } %>

                <button type="submit" class="btn btn-success btn-custom">Salvar Categorias</button>
            </form>
        </div>
    </div>
</body>
</html>
