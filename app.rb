require 'sinatra' 
require 'braintree' 
require 'shotgun' 


Braintree::Configuration.environment = :sandbox
Braintree::Configuration.merchant_id = 'zk9q2drdp3srv82x'
Braintree::Configuration.public_key = 'gjrs52wfs2s6f54d'
Braintree::Configuration.private_key = '16f1016a4277256980b374c3ce0e4c31'



get "/" do
  erb :braintree
end

post "/create_transaction" do
  result = Braintree::Transaction.sale(
    :amount => "1000.00",
    :credit_card => {
      :number => params[:number],
      :cvv => params[:cvv],
      :expiration_month => params[:month],
      :expiration_year => params[:year]
    },
    :options => {
      :submit_for_settlement => true
    }
  )

  if result.success?
    "<h1>Success! Transaction ID: #{result.transaction.id}</h1>"
  else
    "<h1>Error: #{result.message}</h1>"
  end
end

