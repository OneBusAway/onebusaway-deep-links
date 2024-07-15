module Api::V1::ErrorsHelper
  def render_api_errors(model)
    @errors = model.errors.full_messages
    render 'api/v1/common/errors', status: :unprocessable_entity, formats: :json
  end
end