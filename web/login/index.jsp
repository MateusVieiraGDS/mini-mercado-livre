<%@page import="model.dao.UsuarioDAO"%>
<%@page import="model.Usuario"%>
<%@page import="model.Produto"%>
<%@page import="model.dao.ProdutoDAO"%>
<%@page import="java.util.List"%>

<%
    Usuario usuarioLogado = (Usuario) session.getAttribute("usuarioLogado");
    if (usuarioLogado != null) {
        // Usuário já está logado, redireciona para a página inicial
        response.sendRedirect("../");
        return;
    }

    // Lógica de login
    String email = request.getParameter("email");
    String senha = request.getParameter("senha");        

    if (email != null && senha != null) {
        try {
            // Instanciando o DAO
            UsuarioDAO usuarioDAO = new UsuarioDAO();
            Usuario usuario = usuarioDAO.login(email, senha);

            if (usuario != null) {
                // Login bem-sucedido: salva o usuário na sessão
                session.setAttribute("usuarioLogado", usuario);
                // Redireciona para a página inicial
                response.sendRedirect("../");
                return;
            } else {
                // Login falhou
                request.setAttribute("errorMessage", "Email ou senha inválidos!");
            }
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Erro ao tentar fazer login: " + e.getMessage());
        }
    }
    
    request.setAttribute("pageTitle", "Entrar - Mini Mercado Livre");
    request.setAttribute("children", "login/indexContent.jsp");

    RequestDispatcher dispatcher = request.getRequestDispatcher("../layout.jsp");
    dispatcher.forward(request, response);
%>
