unless defined?(Devise)
    require 'devise'
end
require 'devise_user_metering'
require 'devise_user_metering/model'

Devise.add_module :user_metering, :model => 'devise_user_metering/model'

module DeviseUserMetering
end

require 'devise_user_metering/rails'

