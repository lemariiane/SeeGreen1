package com.bean;

import com.controller.Categoria;
import com.controller.Gasto;
import com.model.GastosDAO;

import java.io.IOException;
import java.time.LocalDate;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "ServletCadastrarGasto", urlPatterns = {"/ServletCadastrarGasto"})
public class ServletCadastrarGasto extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {

        int idUsuario = Integer.parseInt(request.getParameter("idUsuario"));
        int idCategoria = Integer.parseInt(request.getParameter("idCategoria"));
        String descricao = request.getParameter("descricao");
        double valor = Double.parseDouble(request.getParameter("valor")
                .replace(".", "")
                .replace(",", "."));
        LocalDate dataCadastro = LocalDate.parse(request.getParameter("datacadastro"));

        Gasto gasto = new Gasto();
        gasto.setIdUsuario(idUsuario);
        gasto.setDescricao(descricao);
        gasto.setValor(valor);
        gasto.setDatacadastro(dataCadastro);

        Categoria categoria = new Categoria();
        categoria.setId(idCategoria);
        gasto.setCategoria(categoria);

        GastosDAO gastoDAO = new GastosDAO();
        gastoDAO.inserirGasto(gasto);

        response.sendRedirect("AcessarLancamentos");

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(ServletCadastrarGasto.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(ServletCadastrarGasto.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet responsável por cadastrar novos gastos.";
    }
}
