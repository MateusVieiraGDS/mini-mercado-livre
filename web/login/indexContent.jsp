<%-- 
    Document   : login
    Created on : 27 de nov. de 2024, 05:56:05
    Author     : Mateus
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page import="model.dao.UsuarioDAO" %>
<%@page import="model.Usuario" %>
<%@page import="util.ConectaDB" %>


<div>
    <form action="#" method="POST" style="display: flex;flex-direction: column;gap: 1em;width: 37em;max-width: 90vw;">
        <h1 class="h3 mb-3 fw-normal">Entrar no Mini Mercado</h1>

        <% if (request.getAttribute("errorMessage") != null) { %>
            <div class="alert alert-danger"><%= request.getAttribute("errorMessage") %></div>
        <% } %>

        <div class="form-floating">
            <input type="email" class="form-control" id="floatingInput" name="email" placeholder="name@example.com" required>
            <label for="floatingInput">Endereço de Email</label>
        </div>
        <div class="form-floating">
            <input type="password" class="form-control" id="floatingPassword" name="senha" placeholder="Password" required>
            <label for="floatingPassword">Senha</label>
        </div>

        <button class="btn btn-primary w-100 py-2" type="submit">Entrar</button>
    </form>
</div>
