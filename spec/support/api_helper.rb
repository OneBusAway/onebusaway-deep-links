module ApiHelper
  def json
    @json_body ||= JSON.parse(response.body)
  end
end