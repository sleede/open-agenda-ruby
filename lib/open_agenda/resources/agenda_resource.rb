require 'open_agenda/resource'

module OpenAgenda
  class AgendaResource < Resource
    define_path_preffix 'agendas'
    
    define_actions do
      action :uid, :get, "/uid/:slug" do
        with_api_public_key
      end
    end
  end
end
