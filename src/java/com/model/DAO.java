package com.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DAO {

    protected Connection con;
    protected PreparedStatement pst;
    protected ResultSet rs;

    public void abrirBanco() throws SQLException {
        try {
            // Atualize o driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            String url = "jdbc:mysql://localhost:3306/financa?useUnicode=true&characterEncoding=UTF-8&serverTimezone=UTC";
            String user = "root";
            String senha = "";

            con = DriverManager.getConnection(url, user, senha);
            System.out.println("Conectado ao banco de dados ");
        } catch (ClassNotFoundException ex) {
            System.out.println("Classe não encontrada, adicione o driver nas bibliotecas.");
            throw new RuntimeException(ex);
        } catch (SQLException e) {
            System.out.println("Erro de SQL: " + e.getMessage());
            throw new RuntimeException(e);
        }
    }

    public void fecharBanco() {
        try {
            if (rs != null) {
                rs.close();
                System.out.println("ResultSet fechado");
            }
            if (pst != null) {
                pst.close();
                System.out.println("PreparedStatement fechado");
            }
            if (con != null) {
                con.close();
                System.out.println("Conexão com o banco fechada");
            }
        } catch (SQLException e) {
            System.out.println("Erro ao fechar recursos: " + e.getMessage());
        }
    }
}
