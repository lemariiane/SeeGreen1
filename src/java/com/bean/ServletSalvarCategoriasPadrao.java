/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.bean;

import com.controller.Categoria;
import com.model.CategoriaDAO;
import java.io.IOException;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "ServletSalvarCategoriasPadrao", urlPatterns = {"/ServletSalvarCategoriasPadrao"})
public class ServletSalvarCategoriasPadrao extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        Integer idUsuario = (Integer) session.getAttribute("id");

        if (idUsuario == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String[] categoriasSelecionadas = request.getParameterValues("categoriasSelecionadas");

        if (categoriasSelecionadas == null || categoriasSelecionadas.length == 0) {
            // Nenhuma categoria selecionada
            response.sendRedirect("ServletIndex");
            return;
        }

        CategoriaDAO categoriaDAO = new CategoriaDAO();

        for (String nomeCategoria : categoriasSelecionadas) {
            String cor = request.getParameter("corCategoria_" + nomeCategoria);
            String limiteStr = request.getParameter("limite_" + nomeCategoria);
            double limite = 100;

            try {
                if (limiteStr != null && !limiteStr.isEmpty()) {
                    limite = Double.parseDouble(limiteStr.replace(",", "."));
                }
            } catch (NumberFormatException e) {
                limite = 100; // valor padrão se vier inválido
            }

            Categoria categoria = new Categoria();
            categoria.setCategoria(nomeCategoria);
            categoria.setCor(cor);
            categoria.setLimite(limite);
            categoria.setIdUsuario(idUsuario);

            try {
                if (!categoriaDAO.existeCategoriaParaUsuario(nomeCategoria, idUsuario)) {
                    categoriaDAO.inserirCategoria(categoria);
                }
            } catch (SQLException e) {
                e.printStackTrace();
                // Aqui você poderia logar ou salvar o erro num sistema de monitoramento
            }
        }

        response.sendRedirect("ServletIndex");
    }

    @Override
    public String getServletInfo() {
        return "Servlet responsável por salvar as categorias padrão selecionadas pelo usuário no primeiro acesso.";
    }
}
