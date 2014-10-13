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