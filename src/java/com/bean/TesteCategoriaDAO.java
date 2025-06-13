/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.bean;

import com.controller.Categoria;
import com.model.CategoriaDAO;
/**
 *
 * @author letic
 */import java.sql.SQLException;
import java.util.List;

public class TesteCategoriaDAO {

   public static void main(String[] args) {
        CategoriaDAO dao = new CategoriaDAO();
        Categoria c = new Categoria();

        // Preencha com os dados reais da categoria que você quer editar
        c.setId(2); // ID da categoria existente
        c.setCategoria("Presentes Aniversário");
        c.setCor("#00bfff");
        c.setLimite(1500.00);

        try {
            boolean sucesso = dao.editarCategoria(c);
            if (sucesso) {
                System.out.println("✅ Categoria atualizada com sucesso!");
            } else {
                System.out.println("⚠️ Nenhuma categoria foi atualizada. Verifique o ID.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}

