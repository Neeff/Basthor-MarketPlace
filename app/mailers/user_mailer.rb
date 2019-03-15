class UserMailer < ApplicationMailer
  def new_pack_off(user, orders)
    @orders_per_user = orders
    mail(to: user.email, subject: 'Tu Pedido Ah sido Despachado')
  end
end
