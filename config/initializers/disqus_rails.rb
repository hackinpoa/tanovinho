raise "Variável de ambiente DISQUS_SHORT_NAME não informada" if ENV["PAGSEGURO_EMAIL"].nil?

DisqusRails.setup do |config|
  config::SHORT_NAME   = ENV["DISQUS_SHORT_NAME"]
  config::SECRET_KEY   = ""
  config::PUBLIC_KEY   = ""
  config::ACCESS_TOKEN = ""
end
