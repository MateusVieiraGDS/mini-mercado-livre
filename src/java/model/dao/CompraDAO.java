package model.dao;

import model.Compra;
import model.Produto;
import util.ConectaDB;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class CompraDAO {

    // Método para registrar uma compra com o mesmo timestamp
    public void registrarCompra(List<Compra> compras) throws SQLException, ClassNotFoundException {
        String sql = "INSERT INTO compras (usuario_id, produto_id, quantidade, data_compra) VALUES (?, ?, ?, ?)";
        try (Connection conexao = ConectaDB.conectar();
             PreparedStatement stmt = conexao.prepareStatement(sql)) {

            // Usar o mesmo timestamp para todas as compras dessa transação
            Timestamp dataCompra = new Timestamp(System.currentTimeMillis());

            for (Compra compra : compras) {
                stmt.setInt(1, compra.getUsuarioId());
                stmt.setInt(2, compra.getProdutoId());
                stmt.setInt(3, compra.getQuantidade());
                stmt.setTimestamp(4, dataCompra);
                stmt.addBatch(); // Adicionar à transação
            }
            stmt.executeBatch(); // Executar a transação
        }
    }

    // Método para listar compras agrupadas por timestamp
    public Map<Timestamp, List<Compra>> listarComprasAgrupadasPorUsuario(int usuarioId) throws SQLException, ClassNotFoundException {
        Map<Timestamp, List<Compra>> comprasAgrupadas = new HashMap<>();

        String sql = "SELECT * FROM compras WHERE usuario_id = ? ORDER BY data_compra DESC";
        try (Connection conexao = ConectaDB.conectar();
             PreparedStatement stmt = conexao.prepareStatement(sql)) {
            stmt.setInt(1, usuarioId);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Compra compra = new Compra();
                    compra.setId(rs.getInt("id"));
                    compra.setUsuarioId(rs.getInt("usuario_id"));
                    compra.setProdutoId(rs.getInt("produto_id"));
                    compra.setQuantidade(rs.getInt("quantidade"));
                    compra.setDataCompra(rs.getTimestamp("data_compra"));

                    // Agrupar por timestamp
                    Timestamp dataCompra = compra.getDataCompra();
                    comprasAgrupadas.putIfAbsent(dataCompra, new ArrayList<>());
                    comprasAgrupadas.get(dataCompra).add(compra);
                }
            }
        }
        return comprasAgrupadas;
    }
}
