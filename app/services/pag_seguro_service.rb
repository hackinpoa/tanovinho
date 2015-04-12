class PagSeguroService

  def self.create_payment_request (purchase, purchase_url, current_user)
    Rails.logger.info "Iniciando integração com PagSeguro..."
    payment = PagSeguro::PaymentRequest.new(email: ENV["PAGSEGURO_EMAIL"], token: ENV["PAGSEGURO_TOKEN"])
    payment.reference = purchase.product.id

    payment.items << {
      id: purchase.product.id,
      description:  purchase.product.name,
      amount: purchase.product.price.to_f,
      weight: 0
    }

    payment.sender = {
      email: purchase.user.email,
    }

    Rails.logger.info "Enviando requisição para o PagSeguro."
    response = payment.register
    Rails.logger.info "Requisição enviada sem erros" unless response.errors.any?
    Rails.logger.error "Requisição enviada com erros #{response.errors.join(" | ")}" if response.errors.any?
    response
  end

end
