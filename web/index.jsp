<%@page import="model.Usuario"%>
<%@page import="model.Produto"%>
<%@page import="model.dao.ProdutoDAO"%>
<%@page import="java.util.List"%>

<%    
    request.setAttribute("pageTitle", "Mini Mercado Livre");
    request.setAttribute("children", "indexContent.jsp");

    RequestDispatcher dispatcher = request.getRequestDispatcher("layout.jsp");
    dispatcher.forward(request, response);
%>
