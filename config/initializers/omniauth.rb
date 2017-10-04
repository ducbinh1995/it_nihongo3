    OmniAuth.config.logger = Rails.logger

    Rails.application.config.middleware.use OmniAuth::Builder do
    provider :facebook, "2051554061731475", "59396141daedbcd17b6ff1fd1d23ba27",
      scope: "public_profile, email", info_fields:
      "id,first_name,last_name,email,name,link", credentials_fields: "token,
      expires_at"
    end
