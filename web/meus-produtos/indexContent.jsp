<%@page import="model.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Produto" %>
<%@page import="model.dao.ProdutoDAO" %>
<%@page import="java.util.List" %>

<%
    // Recupera o usuário logado da sessão
    Usuario usuarioLogado = (Usuario) session.getAttribute("usuarioLogado");

    if (usuarioLogado == null) {
        // Redireciona para a página de login se o usuário não estiver logado
        response.sendRedirect("login/");
        return;
    }

    // Exclusão de produto
    String excluirId = request.getParameter("excluir");
    if (excluirId != null) {
        try {
            ProdutoDAO produtoDAO = new ProdutoDAO();
            produtoDAO.excluir(Integer.parseInt(excluirId));
            request.setAttribute("successMessage", "Produto excluído com sucesso!");
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Erro ao excluir o produto: " + e.getMessage());
        }
    }

    // Listar os produtos do usuário logado
    List<Produto> produtos = null;
    try {
        ProdutoDAO produtoDAO = new ProdutoDAO();
        produtos = produtoDAO.listarPorUsuario(usuarioLogado.getId());
    } catch (Exception e) {
        produtos = null;
        request.setAttribute("errorMessage", "Erro ao carregar produtos: " + e.getMessage());
    }
%>

<div style="width: 100%; height: 100%; flex: 1;">
    <h1 class="mb-4">Meus Produtos</h1>

    <!-- Botão de adicionar produto -->
    <a href="criar/" class="btn btn-primary mb-4">Adicionar Produto</a>

    <!-- Mensagens de feedback -->
    <% if (request.getAttribute("successMessage") != null) {%>
    <div class="alert alert-success"><%= request.getAttribute("successMessage")%></div>
    <% } else if (request.getAttribute("errorMessage") != null) {%>
    <div class="alert alert-danger"><%= request.getAttribute("errorMessage")%></div>
    <% } %>

    <!-- Tabela de produtos -->
    <table class="table table-striped">
        <thead>
            <tr>
                <th>ID</th>
                <th>Nome</th>
                <th>Preço</th>
                <th>Quantidade</th>
                <th>Ações</th>
            </tr>
        </thead>
        <tbody>
            <% if (produtos != null && !produtos.isEmpty()) {
                            for (Produto produto : produtos) {%>
            <tr>
                <td><%= produto.getId()%></td>
                <td><%= produto.getNome()%></td>
                <td>R$ <%= produto.getPreco()%></td>
                <td><%= produto.getQuantidade()%></td>
                <td>
                    <a href="editar/?id=<%= produto.getId()%>" class="btn btn-warning btn-sm">Editar</a>
                    <a href=".?excluir=<%= produto.getId()%>" class="btn btn-danger btn-sm" 
                       onclick="return confirm('Tem certeza que deseja excluir este produto?')">Excluir</a>
                </td>
            </tr>
            <% }
                    } else { %>
            <tr>
                <td colspan="5" class="text-center">Nenhum produto encontrado.</td>
            </tr>
            <% }%>
        </tbody>
    </table>
</div>