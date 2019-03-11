class UserMailer < ApplicationMailer
  def new_pack_off(user, orders)
    @orders_providers = orders
    mail(to: user.email, subject: 'Tu Pedido Ah sido Despachado')
  end
end
