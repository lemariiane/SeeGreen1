/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */package com.bean;

import com.controller.Login;
import com.model.LoginDAO;
 import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "ServletCadastroLogin", urlPatterns = {"/ServletCadastroLogin"})
public class ServletCadastroLogin extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        cadastrar(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("cadastro.jsp");
    }

    private void cadastrar(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {

        String email = request.getParameter("email");
        String senha = request.getParameter("senha");


        if (email == null || senha == null || email.trim().isEmpty() || senha.trim().isEmpty()) {
            request.setAttribute("erro", "Email e senha são obrigatórios.");
            request.getRequestDispatcher("cadastro.jsp").forward(request, response);
            return;
        }

        Login login = new Login();
        login.setEmail(email);
        login.setSenha(senha);

        LoginDAO loginDAO = new LoginDAO();

        try {
            // Ideal verificar se o e-mail já existe
            loginDAO.inserir(login);

            request.setAttribute("mensagem", "Cadastro realizado com sucesso! Faça o login.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("erro", "Erro ao cadastrar: " + e.getMessage());
            request.getRequestDispatcher("cadastro.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet responsável pelo cadastro de novos logins.";
    }
}

