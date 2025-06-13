/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.bean;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.model.ReceitaDAO;
import com.controller.Receita;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.time.LocalDate;

/**
 *
 * @author letic
 */
@WebServlet(name = "ServletEditarReceita", urlPatterns = {"/ServletEditarReceita"})
public class ServletEditarReceita extends HttpServlet {

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
        processRequest(request, response);
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
         try {

        System.out.println("Sessão: " + request.getSession(false));
       System.out.println("Usuário logado: " + request.getSession(false).getAttribute("usuarioLogado"));

        HttpSession session = request.getSession();
        Integer idUsuario = (Integer) session.getAttribute("id");

        if (session == null || session.getAttribute("id") == null) {
            System.out.println("Sessão inválida ou ID ausente");
            response.sendRedirect("login.jsp");
            return;
        }

            // Recebendo os parâmetros do formulário (ou do modal via JS)
            int id = Integer.parseInt(request.getParameter("id"));
            String descricao = request.getParameter("descricao");
            double valor = Double.parseDouble(request.getParameter("valor"));
            LocalDate data = LocalDate.parse(request.getParameter("datareceita"));


            // Criando o objeto Receita com os dados recebidos
            Receita receita = new Receita();
            receita.setId(id);
            receita.setIdUsuario(idUsuario);
            receita.setDescricao(descricao);
            receita.setValor(valor);
            receita.setDatareceita(data);
            

            // Atualizando no banco
            ReceitaDAO dao = new ReceitaDAO();
            dao.editarReceita(receita);

            // Redirecionando após edição
            response.sendRedirect("AcessarLancamentos?msg=sucesso");
            
System.out.println("Descrição: " + descricao);
System.out.println("Valor: " + valor);
System.out.println("Data: " + data);
System.out.println("Usuário ID: " + idUsuario);


        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("AcessarLancamento?smsg=erro");
        } 
    
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
