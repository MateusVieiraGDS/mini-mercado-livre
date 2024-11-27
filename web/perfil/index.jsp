<%@page import="model.Usuario"%>
<%@page import="model.Produto"%>
<%@page import="model.dao.ProdutoDAO"%>
<%@page import="java.util.List"%>

<%
    Usuario usuarioLogado = (Usuario) session.getAttribute("usuarioLogado");
    if (usuarioLogado == null) {
        response.sendRedirect("../login");
        return;
    }
    
    request.setAttribute("pageTitle", "Perfil - Mini Mercado Livre");
    request.setAttribute("children", "perfil/indexContent.jsp");

    RequestDispatcher dispatcher = request.getRequestDispatcher("../layout.jsp");
    dispatcher.forward(request, response);
%>
