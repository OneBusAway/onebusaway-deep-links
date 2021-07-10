module RequestHelper

  def has_status_code(code)
    expect(response).to have_http_status(code)
  end

  def returns_json
    expect(response.media_type).to eq("application/json")
  end

end