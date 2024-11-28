<%@page import="java.util.List"%>
<%@page import="model.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>


<%
    Usuario usuarioLogado = (Usuario) session.getAttribute("usuarioLogado");

    String pageToInclude = (request.getAttribute("children") != null)
            ? request.getAttribute("children").toString()
            : "404.jsp";

    String logout = request.getParameter("logout");
    if (usuarioLogado != null && logout != null) {
        session.invalidate();
        response.sendRedirect("/MiniMercadoLivre/");
        return; // Evita que o restante do código seja executado
    }
%>

<!DOCTYPE html>
<html lang="pt_BR">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title><%= request.getAttribute("pageTitle") != null ? request.getAttribute("pageTitle") : "Minha Aplicação"%></title>
        <link href="/MiniMercadoLivre/assets/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <style>
            :root {
                --bs-primary: #2D3277;
                --bs-secondary: #FFE600;
                --bs-success: #28a745;
                --bs-info: #17a2b8;
                --bs-warning: #ffc107;
                --bs-danger: #dc3545;
                --bs-light: #f8f9fa;
                --bs-dark: #343a40;

                /* Outros elementos personalizados, se necessário */
                --bs-body-bg: #FFF;
                --bs-body-color: #000;
            }
            header {
                background: #FFE600;
            }
            body {
                background: #ebebeb;
                margin: 0;
                padding: 0;
            }
            .foot {
                background: #FFE600;
                width: 100vw;
                max-width: 100vw;
            }
            .app {
                min-height: calc(100vh - 13.9em);
                display: flex;
                flex-direction: column;
                justify-content: center;
                align-items: center;
            }
        </style>
    </head>
    <body>
        <!-- Header -->
        <header class="p-3 mb-3 border-bottom">
            <div class="container" style="display: flex;">
                <div style="display: flex;align-items: center;font-weight: bold;border-right: solid 1px #0000003b;padding-right: .4em;margin-right: .5em;">
                    <div style="
                         border: solid 4px #2d3277;
                         border-radius: 7em;
                         padding: .3em .1em .3em .1em;
                         ">
                        <span style="
                              font-size: 1.3em;
                              padding: .1em .6em;
                              color: #2d3277;
                              background: #ffe600;
                              border: solid 4px #fff;
                              border-radius: 6em;
                              ">MiniLivre</span>
                    </div>
                </div>
                <div class="d-flex flex-wrap align-items-center justify-content-center justify-content-lg-start" style="flex: 1;">                    
                    <ul class="nav col-12 col-lg-auto me-lg-auto mb-2 justify-content-center mb-md-0" style="font-size: 1.2em;">
                        <li><a href="/MiniMercadoLivre/" class="nav-link px-2 link-body-emphasis">Início</a></li>
                            <% if (usuarioLogado != null) { %>
                        <li><a href="/MiniMercadoLivre/perfil/" class="nav-link px-2 link-body-emphasis">Meu Perfil</a></li>
                        <li><a href="/MiniMercadoLivre/meus-produtos/" class="nav-link px-2 link-body-emphasis">Meus Produtos</a></li>
                        <li><a href="/MiniMercadoLivre/minhas-compras/" class="nav-link px-2 link-body-emphasis">Minhas Compras</a></li>
                            <% } %>
                    </ul>

                    <% if (usuarioLogado != null) {%>
                    <a href="/MiniMercadoLivre/carrinho/" class="btn btn-outline-primary me-3">
                        Carrinho <span class="badge bg-secondary"><%= session.getAttribute("carrinho") != null ? ((List<?>) session.getAttribute("carrinho")).size() : 0%></span>
                    </a>
                    <a href=".?logout=1" class="btn btn-danger">Sair</a>
                    <% } else { %>
                    <a href="/MiniMercadoLivre/login" class="btn btn-primary" style="margin-right: 7px;">Entrar</a>
                    <a href="/MiniMercadoLivre/cadastro" class="btn btn-secondary">Cadastrar</a>
                    <% }%>
                </div>
            </div>
        </header>

        <!-- Conteúdo Dinâmico -->
        <div class="container mt-1 app">
            <jsp:include page="<%= pageToInclude%>" />
        </div>
        <!-- Footer -->
        <div class="container foot">
            <footer class="d-flex flex-wrap justify-content-between align-items-center py-3 my-4 border-top">
                <div class="col-md-4 d-flex align-items-center">
                    <a href="/" class="mb-3 me-2 mb-md-0 text-body-secondary text-decoration-none lh-1">
                        <svg class="bi" width="30" height="24"><use xlink:href="#bootstrap"></use></svg>
                    </a>
                    <span class="mb-3 mb-md-0 text-body-secondary">© 2024 Mini Mercado Livre @ UMC</span>
                </div>              
            </footer>
        </div>
        <script src="/MiniMercadoLivre/assets/bootstrap.bundle.min.js"></script>
    </body>
</html>
