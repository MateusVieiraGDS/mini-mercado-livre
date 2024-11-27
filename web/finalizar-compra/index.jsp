<%@page import="model.Compra"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.dao.CompraDAO"%>
<%@page import="model.Usuario"%>
<%@page import="model.Produto"%>
<%@page import="model.dao.ProdutoDAO"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.Timestamp" %>

<%
    Usuario usuarioLogado = (Usuario) session.getAttribute("usuarioLogado");
    if (usuarioLogado == null) {
        response.sendRedirect("../login");
        return;
    }

    List<Produto> carrinho = (List<Produto>) session.getAttribute("carrinho");
    if (carrinho == null || carrinho.isEmpty()) {
        request.setAttribute("errorMessage", "Carrinho vazio. Adicione produtos antes de finalizar a compra.");
    }
    
    
    // Processar compra ao clicar em "Confirmar Compra"
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String metodoPagamento = request.getParameter("metodoPagamento");

        try {
            CompraDAO compraDAO = new CompraDAO();
            Timestamp dataCompra = new Timestamp(System.currentTimeMillis());
            List<Compra> compras = new ArrayList<>();

            // Criar objetos de compra para cada produto no carrinho
            for (Produto produto : carrinho) {
                Compra compra = new Compra();
                compra.setUsuarioId(usuarioLogado.getId());
                compra.setProdutoId(produto.getId());
                compra.setQuantidade(1); // Assumindo 1 unidade por produto
                compra.setDataCompra(dataCompra);
                compras.add(compra);
            }

            // Registrar todas as compras com o mesmo timestamp
            compraDAO.registrarCompra(compras);

            // Limpa o carrinho após a compra
            carrinho.clear();
            session.setAttribute("carrinho", carrinho);

            // Redireciona para "Minhas Compras"
            request.setAttribute("successMessage", "Compra realizada com sucesso pelo método " + metodoPagamento + "!");
            response.sendRedirect("../minhas-compras");
            return;
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Erro ao finalizar a compra: " + e.getMessage());
        }
    }
    
    request.setAttribute("pageTitle", "Finalizar Compra - Mini Mercado Livre");
    request.setAttribute("children", "finalizar-compra/indexContent.jsp");

    RequestDispatcher dispatcher = request.getRequestDispatcher("../layout.jsp");
    dispatcher.forward(request, response);
%>
