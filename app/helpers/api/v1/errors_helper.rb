module Api::V1::ErrorsHelper
  def render_api_errors(model: nil, message: nil)
    @errors = if model
                model.errors.full_messages
              else
                [message]
              end

    render 'api/v1/common/errors', status: :unprocessable_entity, formats: :json
  end
end