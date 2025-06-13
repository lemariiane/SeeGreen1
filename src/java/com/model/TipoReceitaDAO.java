/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.model;

/**
 *
 * @author letic
 */
import com.controller.TipoReceita;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TipoReceitaDAO extends DAO {

    //listar os tipos
    public List<TipoReceita> listarTodos() throws SQLException {
        List<TipoReceita> tipos = new ArrayList<>();

        try {
            abrirBanco();
            String sql = "SELECT * FROM tipo_receita";
            pst = con.prepareStatement(sql);
            rs = pst.executeQuery();

            while (rs.next()) {
                TipoReceita tipo = new TipoReceita();
                tipo.setId(rs.getInt("id"));
                tipo.setNome(rs.getString("nome"));
                tipos.add(tipo);
            }

            System.out.println("Sucesso ao carregar os tipos.");
        } catch (SQLException e) {
            System.out.println("Erro: " + e.getMessage());
            throw e;
        } finally {
            fecharBancoSegura();
        }

        return tipos;
    }
    
     // Método para fechar o banco com tratamento
    private void fecharBancoSegura() {
        try {
            fecharBanco();
            System.out.println("Conexão fechada com sucesso!");
        } catch (Exception e) {
            System.out.println(" Erro ao fechar conexão: " + e.getMessage());
        }
    }
}
