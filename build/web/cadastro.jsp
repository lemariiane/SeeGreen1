<%-- 
    Document   : cadastrar_gasto
    Created on : 2 de jun. de 2025, 13:08:40
    Author     : letic
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% String erro = (String) request.getAttribute("erro");
   if (erro != null) { %>
    <div style="color:red;"><%= erro %></div>
<% } %>

<% String msg = (String) request.getAttribute("mensagem");
   if (msg != null) { %>
    <div style="color:green;"><%= msg %></div>
<% } %>

<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>SeeGreen - Cadastro</title>
        <link rel="stylesheet" href="assets/css/style.css" />
        <link href="https://fonts.googleapis.com/css2?family=Open+Sans&display=swap" rel="stylesheet" />
    </head>

    <body>
        <img class="wave" src="assets/img/back-wave1.png" />
        <div class="container">
            <div class="img">
                <img src="assets/img/imgcadastro.svg" />
            </div>
            <div class="login-container">
                <form action="ServletCadastroLogin" method="POST">
                    <h2>Cadastre-se no SeeGreen</h2>
                    <div class="input-div two">
                        <div class="i">
                            <i class="fas fa-envelope"></i>
                        </div>
                        <div>
                            <h5>E-mail</h5>
                            <input class="input" type="email" name="email" id="email" required>
                        </div>
                    </div>
                    <div class="input-div one">
                        <div class="i">
                            <i class="fas fa-key"></i>
                        </div>
                        <div>
                            <h5>Senha</h5>
                            <input class="input" type="password" name="senha" id="senha" required>
                        </div>
                    </div>

                    <div>
                        <input type="checkbox" class="custom-control-input" id="customSwitches" required>
                        <label class="custom-control-label" for="customSwitches">Aceito os termos de uso do SeeGreen.</label>
                    </div>
                    <input type="submit" class="btn" value="Cadastrar" />
                    <div class="account">
                        <p>Já possui conta?</p>
                        <a href="login.jsp">Entrar</a>
                    </div>
                </form>
            </div>
        </div>

        <script type="text/javascript" src="assets/js/main.js"></script>
    </body>
</html>
