/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.bean;


import com.model.DAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 *
 * @author letic
 */
public class TesteConexaoServlet extends HttpServlet {

     @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        DAO dao = new DAO();
        response.setContentType("text/html;charset=UTF-8");
        
        try {
            dao.abrirBanco();
            response.getWriter().println("<h1> Conexão com o banco realizada com sucesso!</h1>");
        } catch (Exception e) {
            response.getWriter().println("<h1 Erro ao conectar: " + e.getMessage() + "</h1>");
            e.printStackTrace();
        } finally {
            try {
                dao.fecharBanco();
                response.getWriter().println("<h1>Conexão fechada com sucesso!</h1>");
            } catch (Exception e) {
                response.getWriter().println("<h1> Erro ao fechar conexão: " + e.getMessage() + "</h1>");
                e.printStackTrace();
            }
        }
    }

}
