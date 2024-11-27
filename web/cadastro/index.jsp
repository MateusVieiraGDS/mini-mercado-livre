<%@page import="model.dao.UsuarioDAO"%>
<%@page import="model.Usuario"%>
<%@page import="model.Produto"%>
<%@page import="model.dao.ProdutoDAO"%>
<%@page import="java.util.List"%>

<%
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");
    
    
    Usuario usuarioLogado = (Usuario) session.getAttribute("usuarioLogado");
    if (usuarioLogado != null) {
        // Usu�rio j� est� logado, redireciona para a p�gina inicial
        response.sendRedirect("../");
        return; // Retorna para evitar que o c�digo continue
    }

    // L�gica de cadastro e login autom�tico
    String nome = request.getParameter("nome");
    String email = request.getParameter("email");
    String senha = request.getParameter("senha");

    if (nome != null && email != null && senha != null) {
        try {
            // Cria um novo usu�rio
            Usuario usuario = new Usuario();
            usuario.setNome(nome);
            usuario.setEmail(email);
            usuario.setSenha(senha);

            // Insere o usu�rio no banco de dados
            UsuarioDAO usuarioDAO = new UsuarioDAO();
            usuarioDAO.inserir(usuario);

            // Realiza o login automaticamente ap�s o cadastro
            usuarioLogado = usuarioDAO.login(email, senha);

            if (usuarioLogado != null) {
                // Salva o usu�rio na sess�o
                session.setAttribute("usuarioLogado", usuarioLogado);

                // Redireciona para a p�gina inicial
                response.sendRedirect("../");
                return; // Retorna para evitar que o c�digo continue
            } else {
                request.setAttribute("errorMessage", "Erro ao fazer login ap�s o cadastro!");
            }
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Erro ao fazer login ap�s o cadastro! " + e.getMessage());
        }
    }

    request.setAttribute("pageTitle", "Cadastro - Mini Mercado Livre");
    request.setAttribute("children", "cadastro/indexContent.jsp");

    // Encaminha para o layout apenas se n�o houver redirecionamento
    RequestDispatcher dispatcher = request.getRequestDispatcher("../layout.jsp");
    dispatcher.forward(request, response);
%>
