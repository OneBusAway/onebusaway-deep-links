class Api::V1::PaymentIntentsController < Api::V1::ApiController
  skip_before_action :load_region

  def create
    if params[:donation_frequency] == 'recurring'
      @recurring_response = Donations::Recurring.new(params[:donation_amount_in_cents]).run
      @error = @recurring_response.error
    else
      @intent, @error = Donations::OneTime.new(params[:donation_amount_in_cents]).run
    end

    if @error
      logger.error(@error.message)
      head :internal_server_error
    else
      respond_to {|format| format.json}
    end
  end
end
