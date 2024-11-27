<%@page import="model.Usuario"%>
<%@page import="model.Produto"%>
<%@page import="model.dao.ProdutoDAO"%>
<%@page import="java.util.List"%>

<%
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");
    
    
    Usuario usuarioLogado = (Usuario) session.getAttribute("usuarioLogado");
    if (usuarioLogado == null) {
        response.sendRedirect("../../login");
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
    
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String nome = request.getParameter("nome");
        String descricao = request.getParameter("descricao");
        String precoStr = request.getParameter("preco");
        String quantidadeStr = request.getParameter("quantidade");

        try {
            produto.setNome(nome);
            produto.setDescricao(descricao);
            produto.setPreco(Double.parseDouble(precoStr));
            produto.setQuantidade(Integer.parseInt(quantidadeStr));

            ProdutoDAO produtoDAO = new ProdutoDAO();
            produtoDAO.atualizar(produto);

            response.sendRedirect("../");
            return;
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Erro ao atualizar produto: " + e.getMessage());
        }
    }
    
    request.setAttribute("pageTitle", "Editar Produto - Mini Mercado Livre");
    request.setAttribute("children", "meus-produtos/editar/indexContent.jsp");

    RequestDispatcher dispatcher = request.getRequestDispatcher("../../layout.jsp");
    dispatcher.forward(request, response);
%>
