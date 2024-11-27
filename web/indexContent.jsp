<%@page import="model.Produto"%>
<%@page import="model.dao.ProdutoDAO"%>
<%@page import="java.util.List"%>
<%@page import="model.Usuario"%>
<h1 class="mb-4">Bem vindo ao Mini Mercado Livre</h1>

<% 
    Usuario usuarioLogado = (Usuario) session.getAttribute("usuarioLogado");
    List<Produto> produtos = null;

    try {
        ProdutoDAO produtoDAO = new ProdutoDAO();
        produtos = produtoDAO.listarTodosComUsuarios();
    } catch (Exception e) {
        produtos = null;
        request.setAttribute("errorMessage", "Erro ao carregar produtos: " + e.getMessage());
    }
%>

<div id="myCarousel" class="carousel slide mb-6" data-bs-ride="carousel" style="height: 25em; margin-bottom: 50px; min-width: 100%;">
    <div class="carousel-indicators">
        <button type="button" data-bs-target="#myCarousel" data-bs-slide-to="0" class="" aria-label="Slide 1"></button>
        <button type="button" data-bs-target="#myCarousel" data-bs-slide-to="1" aria-label="Slide 2" class=""></button>
        <button type="button" data-bs-target="#myCarousel" data-bs-slide-to="2" aria-label="Slide 3" class="active" aria-current="true"></button>
    </div>
    <div class="carousel-inner" style="height: 100%;">
        <div class="carousel-item" style="height: 100%;">            
            <img src="https://picsum.photos/1200/500/?blur" alt="alt" style="margin-bottom: 10px;height: auto;width: 100%;"/>
            <div style="background: black;position: absolute;width: 100%;height: 100%;top: 0;opacity: .3;"></div>
            <div class="container">
                <div class="carousel-caption text-start">
                    <h1>Super Promoção | 10% OFF.</h1>
                    <p class="opacity-75">Venha aproveitar esse súper desconto que voce só encontra aqui.</p>
                    <p><a class="btn btn-lg btn-primary" href="#">Quero Aproveitar</a></p>
                </div>
            </div>
        </div>
        <div class="carousel-item" style="height: 100%;">
            <img src="https://picsum.photos/1200/500/?blur" alt="alt" style="margin-bottom: 10px;height: auto;width: 100%;"/>
            <div style="background: black;position: absolute;width: 100%;height: 100%;top: 0;opacity: .3;"></div>
            <div class="container">
                <div class="carousel-caption">
                    <h1>Catálogo Completo.</h1>
                    <p>Nossa loja comunitária possui diversos produtos para você e sua família.</p>
                    <p><a class="btn btn-lg btn-primary" href="#">Oque Temos</a></p>
                </div>
            </div>
        </div>
        <div class="carousel-item active" style="height: 100%;">
            <img src="https://picsum.photos/1200/500/?blur" alt="alt" style="margin-bottom: 10px;height: auto;width: 100%;"/>
            <div style="background: black;position: absolute;width: 100%;height: 100%;top: 0;opacity: .3;"></div>
            <div class="container">
                <div class="carousel-caption text-end">
                    <h1>Materiais de Vendas</h1>
                    <p>Entre em contato conosco para solicitar e-books e materias para melhorar suas vendas.</p>
                    <p><a class="btn btn-lg btn-primary" href="#">Contato</a></p>
                </div>
            </div>
        </div>
    </div>
    <button class="carousel-control-prev" type="button" data-bs-target="#myCarousel" data-bs-slide="prev">
        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
        <span class="visually-hidden">Previous</span>
    </button>
    <button class="carousel-control-next" type="button" data-bs-target="#myCarousel" data-bs-slide="next">
        <span class="carousel-control-next-icon" aria-hidden="true"></span>
        <span class="visually-hidden">Next</span>
    </button>
</div>

<div class="row">
    <% if (produtos != null && !produtos.isEmpty()) {
        for (Produto produto : produtos) { %>
            <div class="col-md-4 mb-4" style="width: fit-content;">
                <div class="card" style="width: fit-content; height: fit-content;">
                    <div class="card-body" style="min-height: 34em; display: flex; flex-direction: column; justify-content: space-between; max-width: 19em; min-width: 19em;">
                        <img src="https://via.assets.so/furniture.png?id=<%= ((int) (Math.random() * 20) + 1) %>&q=95&w=260&h=300&fit=fill" alt="Produto" style="margin-bottom: 10px; width: 100%; height: auto;" />
                        <div style="flex: 1;">
                            <div>
                                <h5 class="card-title" style="margin: 0;"><%= produto.getNome() %></h5>
                                <p class="card-text" style="opacity: .6; font-style: italic; margin-bottom: 5px;">Vendedor: <%= produto.getVendedorNome() %></p>
                            </div>
                            <p class="card-text" style="font-size: 1.3em; margin-bottom: .3em;">R$ <%= produto.getPreco() %></p>
                            <p class="card-text" style="opacity: .7;"><%= produto.getDescricao() %></p>                            
                        </div>
                        <div style="margin-top: 10px;">
                            <% if (usuarioLogado != null) { %>
                                <a href="carrinho/?adicionar=<%= produto.getId() %>" class="btn btn-primary">Comprar</a>
                            <% } else { %>
                                <button class="btn btn-primary" disabled>Faça Login para Comprar</button>
                            <% } %>
                        </div>
                    </div>
                </div>
            </div>
    <% }
    } else { %>
        <p class="text-center">Nenhum produto disponível.</p>
    <% } %>
</div>
