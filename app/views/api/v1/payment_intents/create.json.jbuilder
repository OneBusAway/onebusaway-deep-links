if @recurring_response
  json.client_secret(@recurring_response.subscription.latest_invoice.payment_intent.client_secret)
  json.customer_id(@recurring_response.customer_id)
  json.ephemeral_key(@recurring_response.ephemeral_key.secret)
else
  json.client_secret(@intent.client_secret)
end

json.id(SecureRandom.uuid)