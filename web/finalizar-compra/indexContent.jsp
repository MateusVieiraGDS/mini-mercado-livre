<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Usuario" %>
<%@page import="model.Produto" %>
<%@page import="model.Compra" %>
<%@page import="model.dao.CompraDAO" %>
<%@page import="java.sql.Timestamp" %>
<%@page import="java.util.List" %>
<%@page import="java.util.ArrayList" %>

<%
    List<Produto> carrinho = (List<Produto>) session.getAttribute("carrinho");
    if (carrinho == null || carrinho.isEmpty()) {
        request.setAttribute("errorMessage", "Carrinho vazio. Adicione produtos antes de finalizar a compra.");
    }

    // Calcula o valor total do carrinho
    double valorTotal = 0;
    if (carrinho != null) {
        for (Produto produto : carrinho) {
            valorTotal += produto.getPreco();
        }
    }   
%>


<div style="width: 100%; height: 100%;" class="card p-5">
    <h1 class="mb-4">Finalizar Compra</h1>

    <% if (request.getAttribute("errorMessage") != null) {%>
    <div class="alert alert-danger"><%= request.getAttribute("errorMessage")%></div>
    <% } else if (request.getAttribute("successMessage") != null) {%>
    <div class="alert alert-success"><%= request.getAttribute("successMessage")%></div>
    <% } %>

    <!-- Exibição dos produtos no carrinho -->
    <table class="table">
        <thead>
            <tr>
                <th>Produto</th>
                <th>Preço</th>
            </tr>
        </thead>
        <tbody>
            <% if (carrinho != null && !carrinho.isEmpty()) {
                            for (Produto produto : carrinho) {%>
            <tr>
                <td><%= produto.getNome()%></td>
                <td>R$ <%= String.format("%.2f", produto.getPreco())%></td>
            </tr>
            <% }
                    } else { %>
            <tr>
                <td colspan="2" class="text-center">Carrinho vazio.</td>
            </tr>
            <% }%>
        </tbody>
        <tfoot>
            <tr>
                <th>Total:</th>
                <th>R$ <%= String.format("%.2f", valorTotal)%></th>
            </tr>
        </tfoot>
    </table>

    <!-- Formulário para finalizar compra -->
    <form action="#" method="POST">
        <div class="mb-3">
            <label for="metodoPagamento" class="form-label">Selecione o método de pagamento:</label>
            <select id="metodoPagamento" name="metodoPagamento" class="form-select" required>
                <option value="Cartão de Crédito">Cartão de Crédito</option>
                <option value="PIX">PIX</option>
                <option value="Boleto Bancário">Boleto Bancário</option>
            </select>
        </div>

        <button type="submit" class="btn btn-success">Confirmar Compra</button>
        <a href="/MiniMercadoLivre/carrinho/" class="btn btn-secondary">Voltar ao Carrinho</a>
    </form>
</div>