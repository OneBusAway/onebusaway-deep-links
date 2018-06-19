module RequestHelper
  def has_status_code(code)
    expect(response).to have_http_status(code)
  end
end