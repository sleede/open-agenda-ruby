require 'spec_helper'

describe OpenAgenda do
  it { expect(OpenAgenda).to respond_to(:configure) }

  context "after configure" do
    before :all do
      OpenAgenda.configure do |config|
      end
    end

    it { expect(OpenAgenda.config).to respond_to(:api_secret_key) }
    it { expect(OpenAgenda.config).to respond_to(:api_public_key) }
    it { expect(OpenAgenda.config).to respond_to(:logger) }
  end
end
