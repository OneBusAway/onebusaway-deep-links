module ApiHelper
  def json
    @json_body ||= JSON.parse(response.body)
  end
  
  def get_json(path)
    get(path, headers: { 'Accept': 'application/json' })
  end
end