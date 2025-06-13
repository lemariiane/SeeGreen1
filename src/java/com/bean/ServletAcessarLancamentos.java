/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.bean;

import com.controller.Receita;
import com.model.ReceitaDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;

/**
 *
 * @author letic
 */
@WebServlet(name = "ServletAcessarLancamentos", urlPatterns = {"/AcessarLancamentos"})
public class ServletAcessarLancamentos extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
          
       System.out.println("Sessão: " + request.getSession(false));
       System.out.println("Usuário logado: " + request.getSession(false).getAttribute("usuarioLogado"));

        HttpSession session = request.getSession();
        Integer idUsuario = (Integer) session.getAttribute("id");

        if (session == null || session.getAttribute("id") == null) {
            System.out.println("Sessão inválida ou ID ausente");
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            ReceitaDAO receitaDAO = new ReceitaDAO();
            List<Receita> listaReceitas = receitaDAO.buscarReceitasPorUsuario(idUsuario);
            
            request.setAttribute("listaReceitas", listaReceitas);
            request.getRequestDispatcher("lancamento.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace(); 
            request.setAttribute("mensagemErro", "Erro ao listar receitas: " + e.getMessage());
            request.getRequestDispatcher("lancamento.jsp").forward(request, response); 
}
    
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
