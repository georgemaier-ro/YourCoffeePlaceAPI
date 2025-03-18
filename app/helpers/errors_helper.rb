# Mehods for handling errors

module ErrorsHelper
  # load API response errors
  RESPONSE_ERRORS = YAML.load_file("./config/errors.yml")

  def api_error(error_code, status_code = nil)
    status_code ||= RESPONSE_ERRORS[error_code]["status"]
    fields = {
      error_code:           error_code,
      error_message:        RESPONSE_ERRORS[error_code]["message"],
      error_description:    RESPONSE_ERRORS[error_code]["description"]
    }
  end
end
