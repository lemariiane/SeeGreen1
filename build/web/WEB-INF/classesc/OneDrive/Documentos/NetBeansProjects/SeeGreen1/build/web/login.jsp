<%-- 
    Document   : cadastrar_gasto
    Created on : 2 de jun. de 2025, 13:07:47
    Author     : letic
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-br">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>SeeGreen - Login</title>
    <link rel="stylesheet" href="assets/css/style.css"/>
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans&display=swap" rel="stylesheet" />
    <style>
        .wave{
            width:1800px;
        }
    </style>
  </head>

  <body>
    <img class="wave" src="assets/img/back-wave.png"/>
    <div class="container">
      <div class="img">
        <img src="assets/img/cadastro.svg" />
      </div>
      <div class="login-container">
        <form action="ServletLogin" method="POST">
          <img class="avatar" src="assets/img/passlogin1.svg" />
          <h2>Login</h2>
          <p>Bem-vindo de volta ao SeeGreen!</p>
          <div class="input-div one">
            <div class="i">
              <i class="fas fa-user"></i>
            </div>
            <div>
              <h5>E-mail</h5>
              <input class="input" type="email" name="email" id="email" required>
            </div>
          </div>
          <div class="input-div two">
            <div class="i">
              <i class="fas fa-key"></i>
            </div>
            <div>
              <h5>Senha</h5>
              <input class="input" type="password" name="senha" id="senha" required>
            </div>
          </div>
          <input type="submit" class="btn" value="Entrar" />
          <div class="others">
            <hr />
            <p>OU</p>
            <hr />
          </div>

          <div class="account">
            <p>Ainda não possui conta?</p>
            <a href="cadastro.jsp">Cadastre-se</a>
          </div>
        </form>
      </div>
    </div>

    <script type="text/javascript" src="assets/js/main.js"></script>
  </body>
</html>

