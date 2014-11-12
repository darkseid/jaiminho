def create_doc

  api :POST, "/emails", "Endpoint responsável por disparar um email transacional"

  formats ["json"]

  description <<-EOS
    * Teste
  EOS

  param :email_report, Hash, desc: "", required: true do
    param :email_to, String, desc: "Endereço que será enviado o email.", required: true
    param :template_name, String, desc: "Identificador de um template de email."
    param :data, Hash, desc: "Estrutura chave/valor com informações que o template pode renderizar"
    param :reply_to, String, desc: "Endereço que vai receber as respostas do email disparado"
    param :cc, String, desc: "Endereço que vai receber uma cópia do email"
    param :bcc, String, desc: "Endereço que vai receber uma cópia oculta do email"
  end

end
