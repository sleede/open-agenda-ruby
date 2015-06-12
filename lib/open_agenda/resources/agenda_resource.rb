require 'open_agenda/resource'

module OpenAgenda
  class AgendaResource < Resource

    # def self.path_preffix
    #   'agendas'
    # end

    define_path_preffix 'agendas'

    # def uid(slug: '')
    #   get "/uid/#{slug}", {}, api_public_key: true
    # end

    define_actions do
      # action 'tamere'
      action :uid, :get, "/uid/:slug" do
        with_api_public_key
      end
      #   do
      #   with_api_public_key
      # end
    end
  end
end
