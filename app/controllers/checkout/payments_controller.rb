class Checkout::PaymentsController < ApplicationController
  def create
    ad = Ad.find(params[:ad_id])
    ad.processing!

    order = Order.create(ad: ad, buyer_id: current_member.id)
    order.waiting!

    render text: "Processando...   Pedido: #{order.status_i18n} - Anúncio: #{ad.status_i18n}"
  end
end

# Email: c51768499980820202041@sandbox.pagseguro.com.br
# Senha: p3U3VEDDYrwX1XYp
# Número: 4111111111111111
# Bandeira: VISA Válido até: 12/2030 CVV: 123
