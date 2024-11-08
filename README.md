# Desafio INSS
  Uma aplicação para gerenciar os funcionários e calcular o  desconto do INSS.

### 🛠️ Stack 
 - Docker Compose
 - Ruby 
 - Rails
 - Postgres
 - Redis 
 - Sidekiq 

### ⚙️ Configurações 
Para rodar o projeto você vai precisar ter instalado o docker

### 🚀 Inicializando o projeto 
1º Clone o repositório

2º Ative os containers do projeto
```
$ docker-compose up
```

3º setup do projeto rails 

 - Instale as dependências `bundle install.`
 - Crie o banco de dados  `db:create`.
 - Rode as migrações com o comando `rails db:migrate`.
 - Rode o seed com o comando `rails db:seed`.
 - Inicie o servidor com o comando `rails server`.
 - Inicie Sidekiq com o comando `bundle exec sidekiq`.

✨ O projeto está rodando e pode ser acessado http://localhost:3000/

### ⚡Como testar   
  Os teste foram escrito com ajuda do [rspec](https://rspec.info/)

 Para rodar os teste 
```
$ rspec 
```