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
      name: "Nando Vieira",
      email: "c96974594326141990972@sandbox.pagseguro.com.br",
      cpf: "21639716866",
      phone: {
        area_code: 11,
        number: "12345678"
      }
    }

    payment.shipping = {
      type_name: "sedex",
      address: {
        street: "R. Vergueiro",
        number: 1421,
        complement: "Sala 213",
        city: "São Paulo",
        state: "SP",
        district: "Vila Mariana"
      }
    }
          
    payment.register
  end

end