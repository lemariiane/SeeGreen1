package com.model;

import com.controller.Categoria;
import com.controller.Gasto;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;




public class GastosDAO extends DAO {

    // Método para inserir um gasto
   public void inserirGasto(Gasto gasto) throws SQLException {
    try {
        abrirBanco();
        String sql = "INSERT INTO gasto (descricao, valor, datacadastro, idUsuario, idCategoria) VALUES (?, ?, ?, ?, ?)";
        pst = con.prepareStatement(sql);
        pst.setString(1, gasto.getDescricao());
        pst.setDouble(2, gasto.getValor());
        pst.setDate(3, java.sql.Date.valueOf(gasto.getDatacadastro()));
        pst.setInt(4, gasto.getIdUsuario());
        pst.setInt(5, gasto.getCategoria().getId());
        pst.executeUpdate();
        System.out.println("✅ Gasto inserido com sucesso!");
    } catch (SQLException e) {
        System.out.println("❌ Erro ao inserir gasto: " + e.getMessage());
        throw e;
    } finally {
        fecharBancoSegura();
    }
}

    // Método para listar todos os gastos
    public List<Gasto> listarGastos() throws SQLException {
        List<Gasto> lista = new ArrayList<>();
        try {
            abrirBanco();
            String sql = "SELECT * FROM gasto";
            pst = con.prepareStatement(sql);
            rs = pst.executeQuery();

            while (rs.next()) {
                Gasto gasto = new Gasto();
                gasto.setId(rs.getInt("id")); 
                gasto.setDescricao(rs.getString("descricao"));
                gasto.setValor(rs.getDouble("valor"));
                gasto.setDatacadastro(rs.getDate("datacadastro").toLocalDate()); 
                lista.add(gasto);
            }
            System.out.println("✅ Gastos listados com sucesso!");
        } catch (SQLException e) {
            System.out.println("❌ Erro ao listar gastos: " + e.getMessage());
            throw e;
        } finally {
            fecharBancoSegura();
        }
        return lista;
    }

    // Método para deletar um gasto
    public void deletarGasto(Gasto gasto) throws SQLException {
        try {
            abrirBanco();
            String sql = "DELETE FROM gasto WHERE id = ?";
            pst = con.prepareStatement(sql);
            pst.setInt(1, gasto.getId());
            pst.executeUpdate();
            System.out.println("✅ Gasto deletado com sucesso!");
        } catch (SQLException e) {
            System.out.println("❌ Erro ao deletar gasto: " + e.getMessage());
            throw e;
        } finally {
            fecharBancoSegura();
        }
    }

    // Método para atualizar um gasto
    public void atualizarGasto(Gasto gasto) throws SQLException {
        try {
            abrirBanco();
            String sql = "UPDATE gasto SET descricao = ?, valor = ?, datacadastro = ? WHERE id = ?";
            pst = con.prepareStatement(sql);
            pst.setString(1, gasto.getDescricao());
            pst.setDouble(2, gasto.getValor());
            pst.setDate(3, java.sql.Date.valueOf(gasto.getDatacadastro())); 
            pst.setInt(4, gasto.getId());
            pst.executeUpdate();
            System.out.println("✅ Gasto atualizado com sucesso!");
        } catch (SQLException e) {
            System.out.println("❌ Erro ao atualizar gasto: " + e.getMessage());
            throw e;
        } finally {
            fecharBancoSegura();
        }
    }
    
    // Método para pesquisar gastos por usuário
public List<Gasto> pesquisarPorUsuario(int idUsuario) {
    List<Gasto> lista = new ArrayList<>();

    String sql = "SELECT g.*, c.categoria AS nomeCategoria " +
                 "FROM gasto g " +
                 "JOIN categoria c ON g.idCategoria = c.id " +
                 "WHERE g.idUsuario = ? " +
                 "ORDER BY g.datacadastro DESC";

    try {
        abrirBanco();
        pst = con.prepareStatement(sql);
        pst.setInt(1, idUsuario);
        rs = pst.executeQuery();

        while (rs.next()) {
            Gasto g = new Gasto();
            g.setId(rs.getInt("id"));
            g.setDescricao(rs.getString("descricao"));
            g.setValor(rs.getDouble("valor"));
            g.setDatacadastro(rs.getDate("datacadastro").toLocalDate());
            g.setIdUsuario(rs.getInt("idUsuario"));
            g.setIdCategoria(rs.getInt("idCategoria"));

            // Cria e seta o objeto Categoria
            Categoria c = new Categoria(
                rs.getInt("idCategoria"),
                rs.getString("nomeCategoria")
            );
            g.setCategoria(c);

            lista.add(g);
        }
    } catch (SQLException e) {
        System.out.println("❌ Erro ao buscar gastos: " + e.getMessage());
    } finally {
        fecharBanco();
    }

    return lista;
}

public double somarGastosPorUsuarioEMes(int idUsuario, int mes, int ano) throws SQLException {
    double total = 0.0;

    try {
        abrirBanco();
        String sql = "SELECT SUM(valor) FROM gasto " +
                     "WHERE idUsuario = ? AND MONTH(datacadastro) = ? AND YEAR(datacadastro) = ?";

        pst = con.prepareStatement(sql);
        pst.setInt(1, idUsuario);
        pst.setInt(2, mes);
        pst.setInt(3, ano);

        rs = pst.executeQuery();

        if (rs.next()) {
            total = rs.getDouble(1); // retorna 0.0 se for null
        }

    } finally {
        fecharBancoSegura();
    }

    return total;
}

public Map<Integer, Double> somarGastosPorCategoriaNoMes(int idUsuario, int mes, int ano) throws SQLException {
    Map<Integer, Double> mapa = new HashMap<>();

    try {
        abrirBanco();
        String sql = "SELECT idCategoria, SUM(valor) as total " +
                     "FROM gasto " +
                     "WHERE idUsuario = ? AND MONTH(datacadastro) = ? AND YEAR(datacadastro) = ? " +
                     "GROUP BY idCategoria";
        pst = con.prepareStatement(sql);
        pst.setInt(1, idUsuario);
        pst.setInt(2, mes);
        pst.setInt(3, ano);
        rs = pst.executeQuery();

        while (rs.next()) {
            int idCategoria = rs.getInt("idCategoria");
            double total = rs.getDouble("total");
            mapa.put(idCategoria, total);
        }

    } finally {
        fecharBancoSegura();
    }

    return mapa;
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
