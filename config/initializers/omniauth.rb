Rails.application.config.middleware.use OmniAuth::Builder do
    provider :github, '9b9be504c37565aec901', '9d5149033e24dac068d8737e16815927ddc7ed24'
end