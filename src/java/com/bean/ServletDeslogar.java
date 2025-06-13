/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.bean;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.PrintWriter;

@WebServlet(name = "ServletDeslogar", urlPatterns = {"/ServletDeslogar"})
public class ServletDeslogar extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        deslogar(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        deslogar(request, response);
    }

    private void deslogar(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        HttpSession session = request.getSession(false); // false evita criar sessão nova
        if (session != null) {
            session.invalidate();
        }
        response.sendRedirect("login.jsp");
    }

    @Override
    public String getServletInfo() {
        return "Servlet que realiza o logout do usuário e redireciona para a página inicial.";
    }
}
