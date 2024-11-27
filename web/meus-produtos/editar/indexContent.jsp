<%@page import="model.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Produto" %>
<%@page import="model.dao.ProdutoDAO" %>

<%
    Usuario usuarioLogado = (Usuario) session.getAttribute("usuarioLogado");

    if (usuarioLogado == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    Produto produto = null;
    String idParam = request.getParameter("id");

    if (idParam != null) {
        try {
            ProdutoDAO produtoDAO = new ProdutoDAO();
            produto = produtoDAO.buscarPorId(Integer.parseInt(idParam));

            if (produto == null || produto.getUsuarioId() != usuarioLogado.getId()) {
                response.sendRedirect("meusProdutos.jsp");
                return;
            }
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Erro ao carregar produto: " + e.getMessage());
        }
    }
%>
<div style="width: 100%; height: 100%; flex: 1;">
    <h1 class="mb-4">Editar Produto</h1>

    <% if (request.getAttribute("errorMessage") != null) {%>
    <div class="alert alert-danger"><%= request.getAttribute("errorMessage")%></div>
    <% }%>

    <form action=".?id=<%= produto.getId()%>" method="POST">
        <div class="mb-3">
            <label for="nome" class="form-label">Nome</label>
            <input type="text" class="form-control" id="nome" name="nome" value="<%= produto.getNome()%>" required>
        </div>
        <div class="mb-3">
            <label for="descricao" class="form-label">Descrição</label>
            <textarea class="form-control" id="descricao" name="descricao"><%= produto.getDescricao()%></textarea>
        </div>
        <div class="mb-3">
            <label for="preco" class="form-label">Preço</label>
            <input type="number" step="0.01" class="form-control" id="preco" name="preco" value="<%= produto.getPreco()%>" required>
        </div>
        <div class="mb-3">
            <label for="quantidade" class="form-label">Quantidade</label>
            <input type="number" class="form-control" id="quantidade" name="quantidade" value="<%= produto.getQuantidade()%>" required>
        </div>
        <button type="submit" class="btn btn-primary">Salvar Alterações</button>
        <a href="../" class="btn btn-secondary">Cancelar</a>
    </form>
</div>