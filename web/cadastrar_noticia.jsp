<%-- 
    Document   : cadastrar_gasto
    Created on : 2 de jun. de 2025, 13:07:47
    Author     : letic
--%>
<%
    boolean logado = session.getAttribute("email") != null;
    if (!logado) {
%>
    <script>
        window.location.href = "http://localhost:8080/Login_2/login.jsp";
    </script>
<%
        return;
    }
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="com.model.CategoriaDAO"%>
<%@page import="com.controller.Categoria"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Portal de Gastos - Cadastro de Gasto</title>
    <style>
        textarea {
            resize: none;
        }
        form {
            max-width: 400px;
            margin: auto;
        }
        div {
            margin-bottom: 10px;
        }
    </style>
</head>
<body>

<h1>Cadastrar Gasto</h1>

<form action="ServletCadastrarGasto" method="POST">

    <input type="hidden" value="<%= session.getAttribute("id") %>" name="idUsuario">

    <div>
        <label for="descricao">Descrição</label><br>
        <textarea name="descricao" id="descricao" rows="3" required></textarea>
    </div>

    <div>
        <label for="categoria">Categoria</label><br>
        <select name="idCategoria" id="categoria" required>
            <option value="">Selecione...</option>
            <%
                CategoriaDAO categoriaDAO = new CategoriaDAO();
                int idUsuario = Integer.parseInt(session.getAttribute("id").toString());
                List<Categoria> categorias = categoriaDAO.listarPorUsuario(idUsuario);
                for (Categoria c : categorias) {
            %>
                <option value="<%= c.getId() %>"><%= c.getCategoria() %></option>
            <%
                }
            %>
        </select>
    </div>

    <div>
        <label for="valor">Valor</label><br>
        <input type="number" name="valor" id="valor" step="0.01" min="0" required>
    </div>

    <button type="submit">Cadastrar</button>
</form>

</body>
</html>
