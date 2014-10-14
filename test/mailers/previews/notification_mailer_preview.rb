class NotificationMailerPreview < ActionMailer::Preview
  # Accessible from http://localhost:3000/rails/mailers/notifier/welcome
  def welcome
    NotificationMailer.notify({name: 'Teste'}, 'nova_compra')
  end
end