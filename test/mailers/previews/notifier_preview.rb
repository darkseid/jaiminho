class NotifierPreview < ActionMailer::Preview
  # Accessible from http://localhost:3000/rails/mailers/notifier/welcome
  def welcome
    NotifierMailer.notify('rafael@teste.com.br', 'nova_compra', {'name' => 'Teste'})
  end
end
