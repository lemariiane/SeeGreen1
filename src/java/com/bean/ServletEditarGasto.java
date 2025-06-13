package com.bean;

import com.controller.Gasto;
import com.model.GastosDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.time.LocalDate;

@WebServlet(name = "ServletEditarGasto", urlPatterns = {"/ServletEditarGasto"})
public class ServletEditarGasto extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
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
            
            
            int id = Integer.parseInt(request.getParameter("id"));
            String descricao = request.getParameter("descricao");
            double valor = Double.parseDouble(request.getParameter("valor").replace(".", "").replace(",", "."));
            
            LocalDate data = LocalDate.parse(request.getParameter("datacadastro"));

            Gasto gasto = new Gasto();
            gasto.setId(id);
            gasto.setDescricao(descricao);
            gasto.setValor(valor);
            gasto.setDatacadastro(data);

            GastosDAO gastoDAO = new GastosDAO();
            gastoDAO.atualizarGasto(gasto);

            request.getRequestDispatcher("AcessarLancamentos").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Erro ao editar gasto: " + e.getMessage());
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
        return "Servlet para editar um gasto";
    }
}
