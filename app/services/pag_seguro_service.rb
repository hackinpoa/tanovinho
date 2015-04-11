class PagSeguroService

  def self.create_payment_request (purchase, purchase_url, current_user)
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

    payment.register
  end

end
