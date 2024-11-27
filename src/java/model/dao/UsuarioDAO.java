package model.dao;

import model.Usuario;
import util.ConectaDB;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UsuarioDAO {

    // Método para inserir um novo usuário
    public void inserir(Usuario usuario) throws SQLException, ClassNotFoundException {
        String sql = "INSERT INTO usuarios (nome, email, senha) VALUES (?, ?, ?)";
        try (Connection conexao = ConectaDB.conectar();
             PreparedStatement stmt = conexao.prepareStatement(sql)) {
            stmt.setString(1, usuario.getNome());
            stmt.setString(2, usuario.getEmail());
            stmt.setString(3, usuario.getSenha());
            stmt.executeUpdate();
        }
    }

    // Método para listar todos os usuários
    public List<Usuario> listarTodos() throws SQLException, ClassNotFoundException {
        List<Usuario> usuarios = new ArrayList<>();
        String sql = "SELECT * FROM usuarios";
        try (Connection conexao = ConectaDB.conectar();
             Statement stmt = conexao.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                Usuario usuario = new Usuario();
                usuario.setId(rs.getInt("id"));
                usuario.setNome(rs.getString("nome"));
                usuario.setEmail(rs.getString("email"));
                usuario.setSenha(rs.getString("senha"));
                usuario.setCriadoEm(rs.getTimestamp("criado_em"));
                usuarios.add(usuario);
            }
        }
        return usuarios;
    }

    // Método para buscar um usuário por ID
    public Usuario buscarPorId(int id) throws SQLException, ClassNotFoundException {
        String sql = "SELECT * FROM usuarios WHERE id = ?";
        try (Connection conexao = ConectaDB.conectar();
             PreparedStatement stmt = conexao.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Usuario usuario = new Usuario();
                    usuario.setId(rs.getInt("id"));
                    usuario.setNome(rs.getString("nome"));
                    usuario.setEmail(rs.getString("email"));
                    usuario.setSenha(rs.getString("senha"));
                    usuario.setCriadoEm(rs.getTimestamp("criado_em"));
                    return usuario;
                }
            }
        }
        return null;
    }

    // Método para atualizar um usuário
    public void atualizar(Usuario usuario) throws SQLException, ClassNotFoundException {
        String sql = "UPDATE usuarios SET nome = ?, email = ?, senha = ? WHERE id = ?";
        try (Connection conexao = ConectaDB.conectar();
             PreparedStatement stmt = conexao.prepareStatement(sql)) {
            stmt.setString(1, usuario.getNome());
            stmt.setString(2, usuario.getEmail());
            stmt.setString(3, usuario.getSenha());
            stmt.setInt(4, usuario.getId());
            stmt.executeUpdate();
        }
    }

    // Método para excluir um usuário
    public void excluir(int id) throws SQLException, ClassNotFoundException {
        String sql = "DELETE FROM usuarios WHERE id = ?";
        try (Connection conexao = ConectaDB.conectar();
             PreparedStatement stmt = conexao.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        }
    }

    // Método de login
    public Usuario login(String email, String senha) throws SQLException, ClassNotFoundException {
        String sql = "SELECT * FROM usuarios WHERE email = ? AND senha = ?";
        try (Connection conexao = ConectaDB.conectar();
             PreparedStatement stmt = conexao.prepareStatement(sql)) {
            stmt.setString(1, email);
            stmt.setString(2, senha);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Usuario usuario = new Usuario();
                    usuario.setId(rs.getInt("id"));
                    usuario.setNome(rs.getString("nome"));
                    usuario.setEmail(rs.getString("email"));
                    usuario.setSenha(rs.getString("senha"));
                    usuario.setCriadoEm(rs.getTimestamp("criado_em"));
                    return usuario;
                }
            }
        }
        return null;
    }
}
