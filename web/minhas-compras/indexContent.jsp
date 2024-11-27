<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Usuario" %>
<%@page import="model.Compra" %>
<%@page import="model.Produto" %>
<%@page import="model.dao.CompraDAO" %>
<%@page import="model.dao.ProdutoDAO" %>
<%@page import="java.util.List" %>
<%@page import="java.util.Map" %>
<%@page import="java.util.ArrayList" %>
<%@page import="java.sql.Timestamp" %>

<%
    Usuario usuarioLogado = (Usuario) session.getAttribute("usuarioLogado");
    if (usuarioLogado == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    Map<Timestamp, List<Compra>> comprasAgrupadas = null;
    CompraDAO compraDAO = new CompraDAO();
    ProdutoDAO produtoDAO = new ProdutoDAO();

    try {
        comprasAgrupadas = compraDAO.listarComprasAgrupadasPorUsuario(usuarioLogado.getId());
    } catch (Exception e) {
        request.setAttribute("errorMessage", "Erro ao carregar suas compras: " + e.getMessage());
    }
%>


<div style="width: 100%; height: 100%; flex: 1;">
    <h1 class="mb-4">Minhas Compras</h1>

    <% if (request.getAttribute("errorMessage") != null) {%>
    <div class="alert alert-danger"><%= request.getAttribute("errorMessage")%></div>
    <% } %>

    <% if (comprasAgrupadas == null || comprasAgrupadas.isEmpty()) { %>
    <div class="alert alert-info">Nenhuma compra realizada.</div>
    <% } else { %>
    <div class="accordion" id="accordionCompras">
        <% int index = 1;
            double valorTotalGeral = 0.0;

            for (Map.Entry<Timestamp, List<Compra>> entry : comprasAgrupadas.entrySet()) {
                Timestamp dataCompra = entry.getKey();
                List<Compra> compras = entry.getValue();

                double valorTotalCompra = 0.0;
                List<Produto> produtosCompra = new ArrayList<>();

                for (Compra compra : compras) {
                    Produto produto = produtoDAO.buscarPorId(compra.getProdutoId());
                    if (produto != null) {
                        produtosCompra.add(produto);
                        valorTotalCompra += produto.getPreco() * compra.getQuantidade();
                    }
                }

                valorTotalGeral += valorTotalCompra;
        %>

        <div class="accordion-item">
            <h2 class="accordion-header" id="heading<%= index%>">
                <button class="accordion-button <%= index == 1 ? "" : "collapsed"%>" type="button" data-bs-toggle="collapse" data-bs-target="#collapse<%= index%>" aria-expanded="<%= index == 1%>" aria-controls="collapse<%= index%>">
                    Compra realizada em <%= dataCompra%> - Total: R$ <%= String.format("%.2f", valorTotalCompra)%>
                </button>
            </h2>
            <div id="collapse<%= index%>" class="accordion-collapse collapse <%= index == 1 ? "show" : ""%>" aria-labelledby="heading<%= index%>" data-bs-parent="#accordionCompras">
                <div class="accordion-body">
                    <strong>Produtos nesta compra:</strong>
                    <ul>
                        <% for (Produto produto : produtosCompra) {%>
                        <li>
                            <strong>Nome:</strong> <%= produto.getNome()%> - 
                            <strong>Preço:</strong> R$ <%= String.format("%.2f", produto.getPreco())%> - 
                            <strong>Quantidade:</strong> <%= compras.stream().filter(c -> c.getProdutoId() == produto.getId()).findFirst().get().getQuantidade()%>
                        </li>
                        <% }%>
                    </ul>
                    <p><strong>Valor Total da Compra:</strong> R$ <%= String.format("%.2f", valorTotalCompra)%></p>
                </div>
            </div>
        </div>

        <% index++;
                        }%>
    </div>
    <% }%>
</div>