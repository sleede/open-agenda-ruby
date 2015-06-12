require 'spec_helper'

describe OpenAgenda::Client do
  subject(:client) { described_class.new }

  it { expect(client.access_token).to be_nil }
  it { expect(client.expires_in).to be_nil }

  context "before any resource call" do
    it { expect(client.resources).to eq({}) }
  end

  context "calling a resource" do
    describe "instantiate a resource and save it" do
      before { client.send(client.class.resources.keys.first) }

      it { expect(client.resources.size).to eq(1) }

      describe "a second call to same resource should not instantiate a new object" do
        before { client.send(client.class.resources.keys.first) }

        it { expect(client.resources.size).to eq(1) }
      end
    end
  end
end
