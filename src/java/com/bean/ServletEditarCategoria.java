/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.bean;

import com.controller.Categoria;
import com.model.CategoriaDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;

/**
 *
 * @author letic
 */
@WebServlet(name = "ServletEditarCategoria", urlPatterns = {"/ServletEditarCategoria"})
public class ServletEditarCategoria extends HttpServlet {

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
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ServletEditarCategoria</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ServletEditarCategoria at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
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
            int id = Integer.parseInt(request.getParameter("id"));
            String nome = request.getParameter("categoria");
            String cor = request.getParameter("cor");
            double limite = Double.parseDouble(request.getParameter("limite"));

            Categoria categoria = new Categoria();
            categoria.setId(id);
            categoria.setCategoria(nome);
            categoria.setCor(cor);
            categoria.setLimite(limite);

            CategoriaDAO dao = new CategoriaDAO();
            boolean sucesso = dao.editarCategoria(categoria);

            if (sucesso) {
                System.out.println("✅ Categoria atualizada com sucesso!");
            } else {
                System.out.println("⚠️ Nenhuma categoria foi atualizada.");
            }

            response.sendRedirect("ServletBuscarCategorias");

        } catch (SQLException | NumberFormatException e) {
            e.printStackTrace();
            request.setAttribute("erro", "Erro ao editar categoria: " + e.getMessage());
request.getRequestDispatcher("listarCategorias.jsp").forward(request, response);

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
