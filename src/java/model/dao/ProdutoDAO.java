package model.dao;

import model.Produto;
import util.ConectaDB;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProdutoDAO {

    // Método para inserir um novo produto
    public void inserir(Produto produto) throws SQLException, ClassNotFoundException {
        String sql = "INSERT INTO produtos (nome, descricao, preco, quantidade, usuario_id) VALUES (?, ?, ?, ?, ?)";
        try (Connection conexao = ConectaDB.conectar(); PreparedStatement stmt = conexao.prepareStatement(sql)) {
            stmt.setString(1, produto.getNome());
            stmt.setString(2, produto.getDescricao());
            stmt.setDouble(3, produto.getPreco());
            stmt.setInt(4, produto.getQuantidade());
            stmt.setInt(5, produto.getUsuarioId());
            stmt.executeUpdate();
        }
    }

    // Método para listar todos os produtos
    public List<Produto> listarTodos() throws SQLException, ClassNotFoundException {
        List<Produto> produtos = new ArrayList<>();
        String sql = "SELECT * FROM produtos";
        try (Connection conexao = ConectaDB.conectar(); Statement stmt = conexao.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                Produto produto = new Produto();
                produto.setId(rs.getInt("id"));
                produto.setNome(rs.getString("nome"));
                produto.setDescricao(rs.getString("descricao"));
                produto.setPreco(rs.getDouble("preco"));
                produto.setQuantidade(rs.getInt("quantidade"));
                produto.setUsuarioId(rs.getInt("usuario_id"));
                produto.setCriadoEm(rs.getTimestamp("criado_em"));
                produtos.add(produto);
            }
        }
        return produtos;
    }

    public List<Produto> listarTodosComUsuarios() throws SQLException, ClassNotFoundException {
        List<Produto> produtos = new ArrayList<>();
        String sql = "SELECT p.*, u.nome AS vendedor_nome "
                + "FROM produtos p "
                + "JOIN usuarios u ON p.usuario_id = u.id";
        try (Connection conexao = ConectaDB.conectar(); PreparedStatement stmt = conexao.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Produto produto = new Produto();
                produto.setId(rs.getInt("id"));
                produto.setNome(rs.getString("nome"));
                produto.setDescricao(rs.getString("descricao"));
                produto.setPreco(rs.getDouble("preco"));
                produto.setQuantidade(rs.getInt("quantidade"));
                produto.setUsuarioId(rs.getInt("usuario_id"));
                produto.setCriadoEm(rs.getTimestamp("criado_em"));

                // Nome do vendedor
                produto.setVendedorNome(rs.getString("vendedor_nome"));

                produtos.add(produto);
            }
        }
        return produtos;
    }

    // Método para listar produtos de um usuário específico
    public List<Produto> listarPorUsuario(int usuarioId) throws SQLException, ClassNotFoundException {
        List<Produto> produtos = new ArrayList<>();
        String sql = "SELECT * FROM produtos WHERE usuario_id = ?";
        try (Connection conexao = ConectaDB.conectar(); PreparedStatement stmt = conexao.prepareStatement(sql)) {
            stmt.setInt(1, usuarioId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Produto produto = new Produto();
                    produto.setId(rs.getInt("id"));
                    produto.setNome(rs.getString("nome"));
                    produto.setDescricao(rs.getString("descricao"));
                    produto.setPreco(rs.getDouble("preco"));
                    produto.setQuantidade(rs.getInt("quantidade"));
                    produto.setUsuarioId(rs.getInt("usuario_id"));
                    produto.setCriadoEm(rs.getTimestamp("criado_em"));
                    produtos.add(produto);
                }
            }
        }
        return produtos;
    }

    // Método para buscar um produto por ID
    public Produto buscarPorId(int id) throws SQLException, ClassNotFoundException {
        String sql = "SELECT * FROM produtos WHERE id = ?";
        try (Connection conexao = ConectaDB.conectar(); PreparedStatement stmt = conexao.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Produto produto = new Produto();
                    produto.setId(rs.getInt("id"));
                    produto.setNome(rs.getString("nome"));
                    produto.setDescricao(rs.getString("descricao"));
                    produto.setPreco(rs.getDouble("preco"));
                    produto.setQuantidade(rs.getInt("quantidade"));
                    produto.setUsuarioId(rs.getInt("usuario_id"));
                    produto.setCriadoEm(rs.getTimestamp("criado_em"));
                    return produto;
                }
            }
        }
        return null;
    }

    // Método para atualizar um produto
    public void atualizar(Produto produto) throws SQLException, ClassNotFoundException {
        String sql = "UPDATE produtos SET nome = ?, descricao = ?, preco = ?, quantidade = ?, usuario_id = ? WHERE id = ?";
        try (Connection conexao = ConectaDB.conectar(); PreparedStatement stmt = conexao.prepareStatement(sql)) {
            stmt.setString(1, produto.getNome());
            stmt.setString(2, produto.getDescricao());
            stmt.setDouble(3, produto.getPreco());
            stmt.setInt(4, produto.getQuantidade());
            stmt.setInt(5, produto.getUsuarioId());
            stmt.setInt(6, produto.getId());
            stmt.executeUpdate();
        }
    }

    // Método para excluir um produto
    public void excluir(int id) throws SQLException, ClassNotFoundException {
        String sql = "DELETE FROM produtos WHERE id = ?";
        try (Connection conexao = ConectaDB.conectar(); PreparedStatement stmt = conexao.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        }
    }
}
