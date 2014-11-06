[![Build Status](https://semaphoreapp.com/api/v1/projects/43f91ce9-ff7c-4086-8a27-e98674964dbc/266674/shields_badge.svg)](https://semaphoreapp.com/darkseid/jaiminho)
# Jaiminho

## Objetivo
Ser uma ferramenta completa para o envio de emails.

### Caracteristicas:
1. Ser assincrono
2. Possuir interface REST
3. Fornecer relatorios (abertura, bounce, etc.)
4. Poder cadastrar e manipular os templates

### Dependencias:
- Redis
- Mysql
- Runtime JavaScript (node.js, por exemplo)

### Como rodar:
- git clone
- bundle install
- bundle exec db:create db:migrate
- bundle exec rails s

### Para enviar emails em DEV

Hoje, utilizamos a GEM MailCatcher. Para conseguir visualizar os emails, basta subir o server SMTP que vem com a gem:

```bundle exec mailcatcher

E depois, abra o navegador no endereco: (http://localhost:1080), para visualizar.
