module Request
  module JsonHelper
    def response_body_as_json
      JSON.parse(last_response.body)
    end
  end
end
