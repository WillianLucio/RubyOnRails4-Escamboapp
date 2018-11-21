PagSeguro.configure do |config|
  config.token       = Rails.application.secrets.PAGSEGURO_TOKEN
  config.email       = Rails.application.secrets.PAGSEGURO_EMAIL

  if Rails.env.production?
    config.environment = :production
  else
    config.environment = :sandbox
  end
  config.encoding    = "UTF-8" # ou ISO-8859-1. O padrão é UTF-8.
end

# Email: c51768499980820202041@sandbox.pagseguro.com.br
# Senha: p3U3VEDDYrwX1XYp
# Número: 4111111111111111
# Bandeira: VISA Válido até: 12/2030 CVV: 123
