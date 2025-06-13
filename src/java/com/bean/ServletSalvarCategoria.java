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

@WebServlet(name = "ServletSalvarCategoria", urlPatterns = {"/ServletSalvarCategoria"})
public class ServletSalvarCategoria extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        Integer idUsuario = (Integer) session.getAttribute("id");

        if (idUsuario == null) {
            request.setAttribute("erro", "Usuário não autenticado.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        String nomeCategoria = request.getParameter("nomeCategoria");
        String cor = request.getParameter("corCategoria");
        String limiteStr = request.getParameter("limite");

        if (nomeCategoria == null || nomeCategoria.trim().isEmpty()) {
            request.setAttribute("erro", "O nome da categoria não pode estar vazio.");
            request.getRequestDispatcher("ServletBuscarCategorias").forward(request, response);
            return;
        }

        double limite = 0;
        try {
            if (limiteStr != null && !limiteStr.isEmpty()) {
                limite = Double.parseDouble(limiteStr.replace(",", "."));
            }
        } catch (NumberFormatException e) {
            request.setAttribute("erro", "Limite inválido.");
            request.getRequestDispatcher("ServletBuscarCategorias").forward(request, response);
            return;
        }

        Categoria categoria = new Categoria();
        categoria.setCategoria(nomeCategoria);
        categoria.setCor(cor);
        categoria.setLimite(limite);
        categoria.setIdUsuario(idUsuario);

        CategoriaDAO categoriaDAO = new CategoriaDAO();

        try {
            if (!categoriaDAO.existeCategoriaParaUsuario(nomeCategoria, idUsuario)) {
                categoriaDAO.inserirCategoria(categoria);
                response.sendRedirect("ServletBuscarCategorias");
            } else {
                request.setAttribute("erro", "Essa categoria já existe para você.");
                request.getRequestDispatcher("ServletBuscarCategorias").forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("erro", "Erro ao salvar categoria: " + e.getMessage());
            request.getRequestDispatcher("ServletBuscarCategorias").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet responsável por salvar uma categoria personalizada.";
    }
}


