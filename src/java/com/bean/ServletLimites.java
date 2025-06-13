/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.bean;

import com.controller.Categoria;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import java.time.LocalDate;
import com.model.CategoriaDAO;
import com.model.GastosDAO;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

/**
 *
 * @author letic
 */
@WebServlet(name = "ServletLimites", urlPatterns = {"/ServletLimites"})
public class ServletLimites extends HttpServlet {

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
            HttpSession sessao = request.getSession();
        Integer idUsuario = (Integer) sessao.getAttribute("id");

        if (idUsuario == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Pega mês e ano selecionado ou usa atual
        LocalDate hoje = LocalDate.now();
        int mesSelecionado = request.getParameter("mes") != null ? Integer.parseInt(request.getParameter("mes")) : hoje.getMonthValue();
        int anoSelecionado = request.getParameter("ano") != null ? Integer.parseInt(request.getParameter("ano")) : hoje.getYear();

        try {
            CategoriaDAO categoriaDAO = new CategoriaDAO();
            List<Categoria> categorias = categoriaDAO.listarCategoriasPorUsuarioAll(idUsuario);

            GastosDAO gastoDAO = new GastosDAO();
            Map<Integer, Double> gastosPorCategoria = gastoDAO.somarGastosPorCategoriaNoMes(idUsuario, mesSelecionado, anoSelecionado);

            // Junta tudo para enviar à JSP
            List<Map<String, Object>> listaDados = new ArrayList<>();

            for (Categoria cat : categorias) {
                Map<String, Object> dado = new HashMap<>();
                dado.put("nome", cat.getCategoria());
                dado.put("cor", cat.getCor());
                dado.put("limite", cat.getLimite());
                dado.put("gasto", gastosPorCategoria.getOrDefault(cat.getId(), 0.0));
                listaDados.add(dado);
            }

            request.setAttribute("dados", listaDados);
            request.setAttribute("mesSelecionado", mesSelecionado);
            request.setAttribute("anoSelecionado", anoSelecionado);
            request.getRequestDispatcher("limite.jsp").forward(request, response);

        } catch (Exception e) {
            throw new ServletException("Erro ao carregar limites: " + e.getMessage(), e);
        }
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
