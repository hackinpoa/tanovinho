class PagSeguroService
  
  def self.email 
    ENV["PAGSEGURO_EMAIL"]
  end

  def self.token
    ENV["PAGSEGURO_TOKEN"]
  end

  def self.statuses
    {
      "1": "waiting_approval",
      "2": "checking_credit_card",
      "3": "paid",
      "4": "finished",
      "5": "dispute",
      "6": "returned",
      "7": "canceled"
    }
  end

  # Busca informaçoes de uma notificação no pagseguro
  def self.notification_info (code)
    Rails.logger.info "Iniciando consulta de notificaçoes de transação..."
    wsUrl = "https://ws.pagseguro.uol.com.br/v3/transactions/notifications/#{code}?token=#{token}&email=#{email}"
    response = HTTParty.get(wsUrl); 
    Rails.logger.info %Q(
        [reference: #{response["transaction"]["reference"]}]
        [status: #{response["transaction"]["status"]}]
      )
    Rails.logger.info "Consulta de notificação de transação realizada."
   
    { 
      :token => response["transaction"]["reference"],
      :status => statuses[response["transaction"]["status"]]
    }
  end


  def self.create_payment_request (purchase, current_user, urls)
    Rails.logger.info "Iniciando integração com PagSeguro..."
    payment = PagSeguro::PaymentRequest.new(email: email, token: token)
    payment.reference = purchase.token
  
    payment.abandon_url = urls[:abandoned]
    payment.notification_url = urls[:notification]
    payment.redirect_url = urls[:redirect]

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
