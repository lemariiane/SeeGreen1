/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.model;

/**
 *
 * @author letic
 */

import com.controller.Receita;
import com.controller.TipoReceita;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ReceitaDAO extends DAO {
    public void cadastrarReceita(Receita receita) throws SQLException {
        try {
            abrirBanco();
            String sql = "INSERT INTO receita (descricao, valor, datareceita, idUsuario, idTipoReceita) VALUES (?, ?, ?, ?, ?)";
            pst = con.prepareStatement(sql);
            pst.setString(1, receita.getDescricao());
            pst.setDouble(2, receita.getValor());
            pst.setDate(3, java.sql.Date.valueOf(receita.getDatareceita()));
            pst.setInt(4, receita.getIdUsuario());
            pst.setInt(5, receita.getIdTipoReceita());

            pst.executeUpdate();
            System.out.println("✅ Receita cadastrada com sucesso!");
        } catch (SQLException e) {
            System.out.println("❌ Erro ao cadastrar receita: " + e.getMessage());
            throw e;
        } finally {
            fecharBancoSegura();
        }
    }
    
    public void editarReceita(Receita receita) throws SQLException {
    try {
        abrirBanco();
        String sql = "UPDATE receita SET descricao = ?, valor = ?, datareceita = ?WHERE id = ? AND idUsuario = ?";
        pst = con.prepareStatement(sql);
        pst.setString(1, receita.getDescricao());
        pst.setDouble(2, receita.getValor());
        pst.setDate(3, java.sql.Date.valueOf(receita.getDatareceita()));
        pst.setInt(4, receita.getId());
        pst.setInt(5, receita.getIdUsuario());

        pst.executeUpdate();
        System.out.println("✅ Receita atualizada com sucesso!");
    } catch (SQLException e) {
        System.out.println("❌ Erro ao atualizar receita: " + e.getMessage());
        throw e;
    } finally {
        fecharBancoSegura();
    }
}

    
    public List<Receita> buscarReceitasPorUsuario(int idUsuario) throws SQLException {
    List<Receita> lista = new ArrayList<>();

    try {
        abrirBanco();
        String sql = "SELECT r.*, t.nome AS tipo_nome FROM receita r " +
                     "JOIN tipo_receita t ON r.idTipoReceita = t.id " +
                     "WHERE r.idUsuario = ? ORDER BY r.datareceita DESC";

        pst = con.prepareStatement(sql);
        pst.setInt(1, idUsuario);
        rs = pst.executeQuery();

        while (rs.next()) {
            Receita receita = new Receita();
            receita.setId(rs.getInt("id"));
            receita.setDescricao(rs.getString("descricao"));
            receita.setValor(rs.getDouble("valor"));
            receita.setDatareceita(rs.getDate("datareceita").toLocalDate());

            TipoReceita tipo = new TipoReceita();
            tipo.setId(rs.getInt("idTipoReceita"));
            tipo.setNome(rs.getString("tipo_nome"));
            receita.setTipoReceita(tipo);

            lista.add(receita);
        }

    } finally {
        fecharBancoSegura();
    }

    return lista;
}
    
   public double somarReceitasPorUsuarioEMes(int idUsuario, int mes, int ano) throws SQLException {
    double total = 0.0;

    try {
        abrirBanco();
        String sql = "SELECT SUM(valor) FROM receita " +
                     "WHERE idUsuario = ? AND MONTH(datareceita) = ? AND YEAR(datareceita) = ?";

        pst = con.prepareStatement(sql);
        pst.setInt(1, idUsuario);
        pst.setInt(2, mes);
        pst.setInt(3, ano);

        rs = pst.executeQuery();

        if (rs.next()) {
            total = rs.getDouble(1); // pode ser null, mas getDouble retorna 0.0 nesse caso
        }

    } finally {
        fecharBancoSegura();
    }

    return total;
}


    
    // Método auxiliar para fechar o banco com tratamento
    private void fecharBancoSegura() {
        try {
            fecharBanco();
            System.out.println("✅ Conexão fechada com sucesso!");
        } catch (Exception e) {
            System.out.println("⚠️ Erro ao fechar conexão: " + e.getMessage());
        }
    }
}

