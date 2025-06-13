package com.bean;

import com.controller.Gasto;
import com.model.GastosDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "ServletDeletarGasto", urlPatterns = {"/ServletDeletarGasto"})
public class ServletDeletarGasto extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
                
        response.setContentType("text/html;charset=UTF-8");

        try (PrintWriter out = response.getWriter()) {
            // Recebe o parâmetro do código do gasto
            int id = Integer.parseInt(request.getParameter("id"));
            
            // Cria o objeto gasto
            Gasto gasto = new Gasto();
            gasto.setId(id);
            
            // Instancia o DAO
            GastosDAO gastoDAO = new GastosDAO();
            try {
                gastoDAO.deletarGasto(gasto);
            } catch (Exception e) {
                out.println("<h1>Erro ao deletar gasto: " + e.getMessage() + "</h1>");
                return;
            }
                       
            response.sendRedirect("AcessarLancamentos");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet para deletar Gasto";
    }
}
