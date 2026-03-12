module ResponseHelper
  def json_response(body, status_code = 200)
    status status_code
    body.to_json
  end

  def error_response(message, status_code = 400, details = nil)
    payload = { error: { message: message } }
    payload[:error][:details] = details if details

    json_response(payload, status_code)
  end
end