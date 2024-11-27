<%@page import="model.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Produto" %>
<%@page import="model.dao.ProdutoDAO" %>

<div style="width: 100%; height: 100%; flex: 1;">
    <h1 class="mb-4">Adicionar Produto</h1>

    <!-- Mensagens de feedback -->
    <% if (request.getAttribute("errorMessage") != null) { %>
    <div class="alert alert-danger"><%= request.getAttribute("errorMessage") %></div>
    <% } %>

    <!-- Formulário de criação -->
    <form action="#" method="POST">
        <div class="mb-3">
            <label for="nome" class="form-label">Nome</label>
            <input type="text" class="form-control" id="nome" name="nome" required>
        </div>
        <div class="mb-3">
            <label for="descricao" class="form-label">Descrição</label>
            <textarea class="form-control" id="descricao" name="descricao"></textarea>
        </div>
        <div class="mb-3">
            <label for="preco" class="form-label">Preço</label>
            <input type="number" step="0.01" class="form-control" id="preco" name="preco" required>
        </div>
        <div class="mb-3">
            <label for="quantidade" class="form-label">Quantidade</label>
            <input type="number" class="form-control" id="quantidade" name="quantidade" required>
        </div>
        <button type="submit" class="btn btn-primary">Salvar</button>
        <a href="../" class="btn btn-secondary">Cancelar</a>
    </form>
</div>