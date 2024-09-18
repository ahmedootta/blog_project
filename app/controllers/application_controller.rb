class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  

  def decode_token(token)
    JWT.decode(token, ENV['JWT_SECRET_KEY'])
  rescue # LIKE {TRY-EXCEPT}
    nil
  end
end
