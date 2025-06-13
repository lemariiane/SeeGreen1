/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.model;

import com.controller.Login;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class LoginDAO extends DAO {

    public void inserir(Login login) throws Exception {
    try {
        abrirBanco();
        String query = "INSERT INTO login (email, senha) VALUES(?, ?)";
        pst = con.prepareStatement(query);
        pst.setString(1, login.getEmail());
        pst.setString(2, login.getSenha());

        int rowsAffected = pst.executeUpdate();
        System.out.println("Linhas inseridas: " + rowsAffected);

    } catch (Exception e) {
        e.printStackTrace(); // MOSTRA A STACKTRACE COMPLETA
    } finally {
        fecharBanco(); // sempre fechar
    }
}


    public Login pesquisar(Login login) {
        Login loginBuscado = new Login();

        try {
            abrirBanco();
            String query = "SELECT id, email, senha FROM login WHERE email = ? AND senha = ?";
            pst = con.prepareStatement(query);
            pst.setString(1, login.getEmail());
            pst.setString(2, login.getSenha());

            ResultSet rs = pst.executeQuery();

            while (rs.next()) {
                loginBuscado.setId(rs.getInt("id"));
                loginBuscado.setEmail(rs.getString("email"));
            }

            fecharBanco();
        } catch (Exception e) {
            System.out.println("Erro " + e.getMessage());
        }

        return loginBuscado;
    }
}
