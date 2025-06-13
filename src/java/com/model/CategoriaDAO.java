/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.model;

/**
 *
 * @author letic
 */

import com.controller.Categoria;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CategoriaDAO extends DAO {

    // Método para verificar se o usuário tem pelo menos uma categoria cadastrada
   public boolean temCategoria(int idUsuario) throws SQLException {
    boolean temCategoria = false;

    try {
        abrirBanco();
        String sql = "SELECT COUNT(*) FROM categoria WHERE idUsuario = ?";
        pst = con.prepareStatement(sql);
        pst.setInt(1, idUsuario);
        rs = pst.executeQuery();

        if (rs.next()) {
            temCategoria = rs.getInt(1) > 0;
        }
    } finally {
        fecharBancoSegura();
    }

    return temCategoria;
}

    
    //Método para inserir as categorias
      public void inserirCategoria(Categoria categoria) throws SQLException {
          try {
        abrirBanco();
        String sql = "INSERT INTO categoria (categoria, cor, limite, idUsuario) VALUES (?, ?, ?, ?)";
        pst = con.prepareStatement(sql);
        pst.setString(1, categoria.getCategoria());
        pst.setString(2, categoria.getCor());
        pst.setDouble(3, categoria.getLimite());
        pst.setInt(4, categoria.getIdUsuario());
        pst.executeUpdate();
    } catch (SQLException e) {
        throw e;
    } finally {
        fecharBancoSegura();
    }
}
      //Método para listar no modal cadastrar gastos
      public List<Categoria> listarCategoriasPorUsuario(int idUsuario) throws SQLException {
    List<Categoria> lista = new ArrayList<>();
    try {
        abrirBanco();
        String sql = "SELECT id, categoria FROM categoria WHERE idUsuario = ?";
        pst = con.prepareStatement(sql);
        pst.setInt(1, idUsuario);
        rs = pst.executeQuery();

        while (rs.next()) {
            Categoria categoria = new Categoria();
            categoria.setId(rs.getInt("id"));
            categoria.setCategoria(rs.getString("categoria"));
            lista.add(categoria);
        }

    } catch (SQLException e) {
        System.out.println("❌ Erro ao listar categorias por usuário: " + e.getMessage());
        throw e;
    } finally {
        fecharBancoSegura();
    }
    return lista;
}

    //Método para listar tudo   
    public List<Categoria> listarCategoriasPorUsuarioAll(int idUsuario) throws SQLException {
    List<Categoria> lista = new ArrayList<>();
    try {
        abrirBanco();
        String sql = "SELECT id, idUsuario, categoria, cor, limite FROM categoria WHERE idUsuario = ?";
        pst = con.prepareStatement(sql);
        pst.setInt(1, idUsuario);
        rs = pst.executeQuery();

        while (rs.next()) {
            Categoria categoria = new Categoria();
            categoria.setId(rs.getInt("id"));
            categoria.setIdUsuario(rs.getInt("idUsuario"));
            categoria.setCategoria(rs.getString("categoria"));
            categoria.setCor(rs.getString("cor"));
            categoria.setLimite(rs.getDouble("limite"));
            lista.add(categoria);
        }

    } catch (SQLException e) {
        System.out.println("❌ Erro ao listar categorias por usuário: " + e.getMessage());
        throw e;
    } finally {
        fecharBancoSegura();
    }

    return lista;
}
     //editar categoria
    public boolean editarCategoria(Categoria categoria) throws SQLException {
    boolean atualizado = false;

    try {
        abrirBanco(); // abre conexão com o banco

        String sql = "UPDATE categoria SET categoria = ?, cor = ?, limite = ? WHERE id = ?";
        pst = con.prepareStatement(sql);
        pst.setString(1, categoria.getCategoria());
        pst.setString(2, categoria.getCor());
        pst.setDouble(3, categoria.getLimite());
        pst.setInt(4, categoria.getId());

        int linhasAfetadas = pst.executeUpdate();
        atualizado = (linhasAfetadas > 0);

    } catch (SQLException e) {
        System.out.println("❌ Erro ao editar categoria: " + e.getMessage());
        throw e;
    } finally {
        fecharBancoSegura(); // fecha conexão com o banco
    }

    return atualizado;
}
    
   public void excluirCategoria(int id) throws SQLException {
    try {
        abrirBanco();
        String sql = "DELETE FROM categoria WHERE id = ?";
        pst = con.prepareStatement(sql);
        pst.setInt(1, id);
        pst.executeUpdate();
    } finally {
        fecharBancoSegura();
    }
}

        public boolean existeCategoriaParaUsuario(String categoria, int idUsuario) throws SQLException {
    try {
        abrirBanco();
        String sql = "SELECT COUNT(*) FROM categoria WHERE categoria = ? AND idUsuario = ?";
        pst = con.prepareStatement(sql);
        pst.setString(1, categoria);
        pst.setInt(2, idUsuario);
        rs = pst.executeQuery();
        if (rs.next()) {
            return rs.getInt(1) > 0;
        }
    } finally {
        fecharBanco();
    }
    return false;
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
