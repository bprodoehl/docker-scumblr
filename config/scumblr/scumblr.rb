#     Copyright 2014 Netflix, Inc.
#
#     Licensed under the Apache License, Version 2.0 (the "License");
#     you may not use this file except in compliance with the License.
#     You may obtain a copy of the License at
#
#         http://www.apache.org/licenses/LICENSE-2.0
#
#     Unless required by applicable law or agreed to in writing, software
#     distributed under the License is distributed on an "AS IS" BASIS,
#     WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#     See the License for the specific language governing permissions and
#     limitations under the License.


Rails.application.routes.default_url_options[:host] ||= ENV["SCUMBLR_HOST"]
Rails.application.routes.default_url_options[:protocol] ||= ENV["SCUMBLR_PROTOCOL"]

Scumblr::Application.configure do
  # Use bundled sketchy
  config.sketchy_url = "http://localhost:8000/api/v1.0/capture"
  config.sketchy_use_ssl = false

  # Provider configurations

  config.ebay_access_key = ENV["EBAY_ACCESS_KEY"]

  config.facebook_app_id     = ENV["FACEBOOK_APP_ID"]
  config.facebook_app_secret = ENV["FACEBOOK_APP_SECRET"]

  config.google_developer_key      = ENV["GOOGLE_DEVELOPER_KEY"]
  config.google_cx                 = ENV["GOOGLE_CX"]
  config.google_application_name   = ENV["GOOGLE_APPLICATION_NAME"]
  config.google_application_version = ENV["GOOGLE_APPLICATION_VERSION"]

  config.youtube_developer_key       = ENV["YOUTUBE_DEVELOPER_KEY"]
  config.youtube_application_name    = ENV["YOUTUBE_APPLICATION_NAME"]
  config.youtube_application_version = ENV["YOUTUBE_APPLICATION_VERSION"]

  config.twitter_consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
  config.twitter_consumer_secret     = ENV["TWITTER_CONSUMER_SECRET"]
  config.twitter_access_token        = ENV["TWITTER_ACCESS_TOKEN"]
  config.twitter_access_token_secret = ENV["TWITTER_ACCESS_TOKEN_SECRET"]

  # Email configuration

  if ENV["SMTP_ADDRESS"]
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings.address = ENV["SMTP_ADDRESS"]
    if ENV["SMTP_PORT"]
      config.action_mailer.smtp_settings.port = ENV["SMTP_PORT"]
    end
    config.action_mailer.smtp_settings.domain               = ENV["SMTP_DOMAIN"]
    config.action_mailer.smtp_settings.user_name            = ENV["SMTP_USER"]
    config.action_mailer.smtp_settings.password             = ENV["SMTP_PASSWORD"]
    if ENV["SMTP_AUTHENTICATION"]
      config.action_mailer.smtp_settings.authentication     = ENV["SMTP_AUTHENTICATION"]
    else
      config.action_mailer.smtp_settings.authentication     = "plain"
    end
    if ENV["SMTP_STARTTLS"]
      config.action_mailer.smtp_settings.enable_starttls_auto = ENV["SMTP_STARTTLS"]
    else
      config.action_mailer.smtp_settings.enable_starttls_auto = true
    end
  end
end
