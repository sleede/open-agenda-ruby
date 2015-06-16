require 'open_agenda/resource'

module OpenAgenda
  class LocationResource < Resource
    define_path_preffix 'locations'

    define_actions do
      action :create, :post do
        with_param :nonce, -> { SecureRandom.hex }
      end
    end
  end
end
