<%-- 
    Document   : profile
    Created on : 27 de nov. de 2024
    Author     : Mateus
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.dao.UsuarioDAO" %>
<%@page import="model.Usuario" %>

<%
    // Recupera o usuário logado da sessão
    Usuario usuarioLogado = (Usuario) session.getAttribute("usuarioLogado");

    if (usuarioLogado == null) {
        // Redireciona para a página de login se o usuário não estiver logado
        response.sendRedirect("login/");
        return;
    }

    // Processamento de requisições POST (edição ou exclusão)
    String action = request.getParameter("action");

    if ("editar".equals(action)) {
        // Editar dados do usuário
        String nome = request.getParameter("nome");
        String email = request.getParameter("email");
        String senha = request.getParameter("senha");

        if (nome != null && email != null) {
            try {
                // Atualiza os dados do usuário
                UsuarioDAO usuarioDAO = new UsuarioDAO();
                usuarioLogado.setNome(nome);
                usuarioLogado.setEmail(email);

                if (senha != null && !senha.isEmpty()) {
                    usuarioLogado.setSenha(senha);
                }

                usuarioDAO.atualizar(usuarioLogado);

                // Atualiza o usuário na sessão
                session.setAttribute("usuarioLogado", usuarioLogado);
                request.setAttribute("successMessage", "Dados atualizados com sucesso!");
            } catch (Exception e) {
                request.setAttribute("errorMessage", "Erro ao atualizar perfil: " + e.getMessage());
            }
        }
    } else if ("excluir".equals(action)) {
        // Excluir conta do usuário
        try {
            UsuarioDAO usuarioDAO = new UsuarioDAO();
            usuarioDAO.excluir(usuarioLogado.getId());

            // Invalida a sessão
            session.invalidate();

            // Redireciona para a página de login
            response.sendRedirect("login/?account_deleted=1");
            return;
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Erro ao excluir conta: " + e.getMessage());
        }
    }
%>

<div style="width: 100%; height: 100%; flex: 1;">

    <h1 class="h3 mb-4 fw-normal text-center">Meu Perfil</h1>

    <!-- Mensagens de feedback -->
    <% if (request.getAttribute("successMessage") != null) {%>
    <div class="alert alert-success"><%= request.getAttribute("successMessage")%></div>
    <% } else if (request.getAttribute("errorMessage") != null) {%>
    <div class="alert alert-danger"><%= request.getAttribute("errorMessage")%></div>
    <% }%>

    <!-- Formulário de edição -->
    <form method="POST" action="#">
        <input type="hidden" name="action" value="editar">

        <div class="form-floating mb-3">
            <input type="text" class="form-control" id="nome" name="nome" placeholder="Seu Nome" value="<%= usuarioLogado.getNome()%>" required>
            <label for="nome">Nome</label>
        </div>

        <div class="form-floating mb-3">
            <input type="email" class="form-control" id="email" name="email" placeholder="name@example.com" value="<%= usuarioLogado.getEmail()%>" required>
            <label for="email">Email</label>
        </div>

        <div class="form-floating mb-3">
            <input type="password" class="form-control" id="senha" name="senha" placeholder="Nova Senha (deixe em branco para manter a atual)">
            <label for="senha">Nova Senha</label>
        </div>

        <button type="submit" class="btn btn-primary w-100">Salvar Alterações</button>
    </form>

    <!-- Botão para excluir conta -->
    <form method="POST" action="#" class="mt-4">
        <input type="hidden" name="action" value="excluir">
        <button type="submit" class="btn btn-danger w-100" onclick="return confirm('Tem certeza que deseja excluir sua conta? Esta ação é irreversível.')">
            Excluir Minha Conta
        </button>
    </form>

    <div class="mt-4 text-center">
        <a href="/MiniMercadoLivre" class="btn btn-secondary">Voltar à Página Inicial</a>
        <a href="logout.jsp" class="btn btn-danger">Sair</a>
    </div>
</div>