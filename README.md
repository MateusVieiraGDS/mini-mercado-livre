# Mini Mercado Livre

## Descrição do Projeto

Mini Mercado Livre é um sistema desenvolvido como trabalho acadêmico, inspirado no conceito de plataformas de e-commerce como o Mercado Livre. O objetivo é permitir que usuários se cadastrem, anunciem produtos, realizem compras e gerenciem seus itens de forma prática e intuitiva.

## Funcionalidades

- **Usuários**:
  - Cadastro e login de usuários.
  - Atualização e exclusão de perfil.
  - Visualização dos produtos comprados.

- **Produtos**:
  - Cadastro, edição e exclusão de produtos.
  - Exibição de produtos disponíveis com detalhes, como nome, descrição, preço e vendedor responsável.
  - Listagem de produtos por vendedor.

- **Compras**:
  - Adição de produtos ao carrinho.
  - Registro de compras com quantidade e data.
  - Histórico de compras organizadas por data.

## Tecnologias Utilizadas

### Backend
- **Java**: Linguagem principal para o desenvolvimento do sistema.
- **JSP (JavaServer Pages)**: Para renderização dinâmica das páginas.
- **JDBC**: Para comunicação com o banco de dados.

### Frontend
- **Bootstrap 5**: Framework CSS para estilização e responsividade.
- **HTML5** e **CSS3**: Estruturação e estilo básico das páginas.

### Banco de Dados
- **MySQL**: Gerenciador de banco de dados relacional utilizado para armazenamento.

## Estrutura do Banco de Dados
O banco de dados é composto por três tabelas principais:

1. **Usuários**:
   - Identifica os usuários cadastrados no sistema.

2. **Produtos**:
   - Armazena os produtos disponíveis para compra.
   - Referencia os usuários responsáveis pela criação dos produtos.

3. **Compras**:
   - Registra os produtos comprados pelos usuários e suas respectivas quantidades.

### Script de Criação do Banco de Dados
Consulte o arquivo [`db_mini_ml.sql`](./db_mini_ml.sql) para os detalhes sobre a estrutura do banco de dados.

## Requisitos

- **Java 8+**
- **Apache Tomcat 9+**
- **MySQL 8+**

## Configuração do Ambiente

1. Clone este repositório:
   ```bash
   git clone https://github.com/MateusVieiraGDS/mini-mercado-livre.git
   ```

2. Configure o banco de dados:
   - Execute o script SQL disponível em [`db_mini_ml.sql`](./db_mini_ml.sql).

3. Configure o arquivo `ConectaDB` com as credenciais do seu banco de dados.

4. Compile o projeto e execute-o no Apache Tomcat.

## Referências

- MERCADO LIVRE. **Mercado Livre**. Disponível em: [https://www.mercadolivre.com.br](https://www.mercadolivre.com.br). Acesso em: 27 nov. 2024.
- BOOTSTRAP. **Introdução ao Bootstrap 5**. Disponível em: [https://getbootstrap.com/docs/5.3/getting-started/introduction/](https://getbootstrap.com/docs/5.3/getting-started/introduction/). Acesso em: 27 nov. 2024.
- ORACLE. **Documentação Oficial do Java**. Disponível em: [https://docs.oracle.com/en/java/](https://docs.oracle.com/en/java/). Acesso em: 27 nov. 2024.
- GITHUB. **Mini Mercado Livre - Repositório GitHub**. Disponível em: [https://github.com/MateusVieiraGDS/mini-mercado-livre](https://github.com/MateusVieiraGDS/mini-mercado-livre). Acesso em: 27 nov. 2024.

## Screenshots
- Evidências e imagens demonstrativas podem ser encontradas na pasta [`screenshots`](./screenshots)
- As imagens estão no fluxo de execução

## Licença
Este projeto é de uso acadêmico e não possui licença de distribuição comercial. Fique à vontade para explorá-lo e modificá-lo para fins educacionais.
