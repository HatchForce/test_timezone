class TwilioController < ApplicationController

  skip_before_filter  :verify_authenticity_token

  def make_call
    capability = Twilio::Util::Capability.new ENV['twilio_account_sid'], ENV['twilio_auth_token']
    capability.allow_client_outgoing ENV['twilio_client_outgoing_app_sid']
    @token = capability.generate
    render layout: false
  end

  def call_handler
    logger.debug params
  end

  def voice_request_url
    logger.debug params
  end

  ## twilio capability token and redirect voice url
  def get_twilio_capability_token
    begin
      capability = Twilio::Util::Capability.new ENV['twilio_account_sid'], ENV['twilio_auth_token']
      capability.allow_client_outgoing ENV['twilio_client_outgoing_app_sid']
      token = capability.generate
      status = 'Success'
      response = [status, token]
    rescue Exception => e
      status = 'failure'
      response = [status, "Unable generate token contact admin."]
    end

    render json: response
  end

  def voice_request
    phone_number = params[:phone_number]
    caller_id = '+16142853551'
    response = Twilio::TwiML::Response.new do |r|
      # Should be your Twilio Number or a verified Caller ID
      r.Dial :callerId => caller_id do |d|
        # Test to see if the PhoneNumber is a number, or a Client ID. In
        # this case, we detect a Client ID by the presence of non-numbers
        # in the PhoneNumber parameter.
        if /^[\d\+\-\(\) ]+$/.match(phone_number)
          d.Number(CGI::escapeHTML phone_number)
        else
          d.Client default_client
        end
      end
    end
    logger.debug response.text
    render xml: response.text
  end

  def voice_fallback
    logger.debug params
    render json: {status: :ok}
  end

  def voice_status
    logger.debug params
    render json: {status: :ok}
  end
end
