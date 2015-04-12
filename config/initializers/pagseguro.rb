raise "Variável de ambiente PAGSEGURO_EMAIL não informada" if ENV["PAGSEGURO_EMAIL"].nil?
raise "Variável de ambiente PAGSEGURO_TOKEN não informada" if ENV["PAGSEGURO_TOKEN"].nil?
raise "Variável de ambiente PAGSEGURO_PRODUCTION não informada" if ENV["PAGSEGURO_PRODUCTION"].nil?

puts "Usando sandbox no PagSeguro" if ENV["PAGSEGURO_PRODUCTION"] == "false"
PagSeguro.environment = :sandbox if ENV["PAGSEGURO_PRODUCTION"] == "false"