package com.bean;

import com.controller.Login;
import com.model.CategoriaDAO;
import com.model.LoginDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "ServletLogin", urlPatterns = {"/ServletLogin"})
public class ServletLogin extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            autenticar(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(ServletLogin.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("login.jsp");
    }

    private void autenticar(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException, SQLException {

        String email = request.getParameter("email");
        String senha = request.getParameter("senha");

        // Validação básica
        if (email == null || senha == null || email.trim().isEmpty() || senha.trim().isEmpty()) {
            request.setAttribute("erro", "Email e senha são obrigatórios.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        Login login = new Login();
        login.setEmail(email);
        login.setSenha(senha);

        LoginDAO loginDAO = new LoginDAO();
        Login loginBuscado = loginDAO.pesquisar(login);

        if (loginBuscado != null && loginBuscado.getEmail() != null) {
            HttpSession session = request.getSession();
            session.setAttribute("email", loginBuscado.getEmail());
            session.setAttribute("id", loginBuscado.getId());
            
            CategoriaDAO categoriaDAO = new CategoriaDAO();
boolean temCategoria = categoriaDAO.temCategoria(loginBuscado.getId());

if (!temCategoria) {
    response.sendRedirect("selecionarCategoriaGasto.jsp");
} else {
    response.sendRedirect("ServletIndex");
}
        } else {
            request.setAttribute("erro", "Email ou senha inválidos.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet responsável pela autenticação do usuário.";
    }
}
