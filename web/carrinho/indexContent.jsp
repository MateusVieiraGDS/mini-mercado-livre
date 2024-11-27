<%@page import="model.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Produto" %>
<%@page import="model.dao.ProdutoDAO" %>
<%@page import="java.util.List" %>
<%@page import="java.util.ArrayList" %>

<%
    Usuario usuarioLogado = (Usuario) session.getAttribute("usuarioLogado");
    if (usuarioLogado == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<Produto> carrinho = (List<Produto>) session.getAttribute("carrinho");
    if (carrinho == null) {
        carrinho = new ArrayList<>();
        session.setAttribute("carrinho", carrinho);
    }

    String adicionarId = request.getParameter("adicionar");
    if (adicionarId != null) {
        try {
            ProdutoDAO produtoDAO = new ProdutoDAO();
            Produto produto = produtoDAO.buscarPorId(Integer.parseInt(adicionarId));
            if (produto != null) {
                carrinho.add(produto);
                session.setAttribute("carrinho", carrinho);
            }
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Erro ao adicionar produto ao carrinho: " + e.getMessage());
        }
    }
%>

<div style="width: 100%; height: 100%; flex: 1;">
    <h1 class="mb-4">Carrinho</h1>

    <% if (request.getAttribute("errorMessage") != null) {%>
    <div class="alert alert-danger"><%= request.getAttribute("errorMessage")%></div>
    <% } %>

    <table class="table">
        <thead>
            <tr>
                <th>Nome</th>
                <th>Preço</th>
                <th>Quantidade</th>
            </tr>
        </thead>
        <tbody>
            <% if (carrinho.isEmpty()) { %>
            <tr>
                <td colspan="3" class="text-center">Seu carrinho está vazio.</td>
            </tr>
            <% } else {
                        for (Produto produto : carrinho) {%>
            <tr>
                <td><%= produto.getNome()%></td>
                <td>R$ <%= produto.getPreco()%></td>
                <td>1</td>
            </tr>
            <% }
                        }%>
        </tbody>
    </table>

    <a href="../finalizar-compra" class="btn btn-success">Finalizar Compra</a>
    <a href="../" class="btn btn-secondary">Continuar Comprando</a>
</div>