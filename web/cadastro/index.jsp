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
        // Usuário já está logado, redireciona para a página inicial
        response.sendRedirect("../");
        return; // Retorna para evitar que o código continue
    }

    // Lógica de cadastro e login automático
    String nome = request.getParameter("nome");
    String email = request.getParameter("email");
    String senha = request.getParameter("senha");

    if (nome != null && email != null && senha != null) {
        try {
            // Cria um novo usuário
            Usuario usuario = new Usuario();
            usuario.setNome(nome);
            usuario.setEmail(email);
            usuario.setSenha(senha);

            // Insere o usuário no banco de dados
            UsuarioDAO usuarioDAO = new UsuarioDAO();
            usuarioDAO.inserir(usuario);

            // Realiza o login automaticamente após o cadastro
            usuarioLogado = usuarioDAO.login(email, senha);

            if (usuarioLogado != null) {
                // Salva o usuário na sessão
                session.setAttribute("usuarioLogado", usuarioLogado);

                // Redireciona para a página inicial
                response.sendRedirect("../");
                return; // Retorna para evitar que o código continue
            } else {
                request.setAttribute("errorMessage", "Erro ao fazer login após o cadastro!");
            }
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Erro ao fazer login após o cadastro! " + e.getMessage());
        }
    }

    request.setAttribute("pageTitle", "Cadastro - Mini Mercado Livre");
    request.setAttribute("children", "cadastro/indexContent.jsp");

    // Encaminha para o layout apenas se não houver redirecionamento
    RequestDispatcher dispatcher = request.getRequestDispatcher("../layout.jsp");
    dispatcher.forward(request, response);
%>
