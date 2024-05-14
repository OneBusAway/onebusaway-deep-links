class Api::V1::PaymentIntentsController < Api::V1::ApiController
  skip_before_action :load_region

  def create
    data = JSON.parse(request.raw_post)

    if data['donation_frequency'] == 'recurring'
      @recurring_response = Donations::Recurring.new(data).run
      @error = @recurring_response.error
    else
      @intent, @error = Donations::OneTime.new(data).run
    end

    if @error
      logger.error(@error.message)
      head :internal_server_error
    else
      respond_to {|format| format.json}
    end
  end
end
