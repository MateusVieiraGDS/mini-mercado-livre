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
    
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String nome = request.getParameter("nome");
        String descricao = request.getParameter("descricao");
        String precoStr = request.getParameter("preco");
        String quantidadeStr = request.getParameter("quantidade");

        try {
            Produto produto = new Produto();
            produto.setNome(nome);
            produto.setDescricao(descricao);
            produto.setPreco(Double.parseDouble(precoStr));
            produto.setQuantidade(Integer.parseInt(quantidadeStr));
            produto.setUsuarioId(usuarioLogado.getId());

            ProdutoDAO produtoDAO = new ProdutoDAO();
            produtoDAO.inserir(produto);

            response.sendRedirect("../");
            return;
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Erro ao adicionar produto: " + e.getMessage());
        }
    }
    
    request.setAttribute("pageTitle", "Criar Produto - Mini Mercado Livre");
    request.setAttribute("children", "meus-produtos/criar/indexContent.jsp");

    RequestDispatcher dispatcher = request.getRequestDispatcher("../../layout.jsp");
    dispatcher.forward(request, response);
%>
