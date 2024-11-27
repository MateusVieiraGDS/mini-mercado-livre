<%-- 
    Document   : cadastro
    Created on : 27 de nov. de 2024
    Author     : Mateus
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page import="model.dao.UsuarioDAO" %>
<%@page import="model.Usuario" %>
<%@page import="util.ConectaDB" %>

<div style="width: 100%; height: 100%;" class="card p-5">
    <form action="#" method="POST" style="    display: flex;flex-direction: column;gap: 1em;">
        <h1 class="h3 mb-3 fw-normal">Cadastrar-se no Mini Mercado Livre</h1>
        <p>Venha comercializar seus produtos com outros usuários em nossa plataforma</p>

        <div class="form-floating">
            <input type="text" class="form-control" id="floatingName" name="nome" placeholder="Seu Nome" required>
            <label for="floatingName">Nome</label>
        </div>

        <div class="form-floating">
            <input type="email" class="form-control" id="floatingEmail" name="email" placeholder="name@example.com" required>
            <label for="floatingEmail">Email</label>
        </div>

        <div class="form-floating">
            <input type="password" class="form-control" id="floatingPassword" name="senha" placeholder="Senha" required>
            <label for="floatingPassword">Senha</label>
        </div>

        <button class="btn btn-primary w-100 py-2" type="submit">Cadastrar</button>
        <% if (request.getAttribute("errorMessage") != null) {%>
        <div class="alert alert-danger"><%= request.getAttribute("errorMessage")%></div>
        <% }%>
    </form>
</div>
