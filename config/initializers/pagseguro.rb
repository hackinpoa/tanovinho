raise "Variável de ambiente PAGSEGURO_EMAIL não informada" if ENV["PAGSEGURO_EMAIL"].nil?
raise "Variável de ambiente PAGSEGURO_TOKEN não informada" if ENV["PAGSEGURO_TOKEN"].nil?
PagSeguro.environment = :sandbox