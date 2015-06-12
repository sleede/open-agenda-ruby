require 'spec_helper'

describe OpenAgenda::Resource do
  subject(:resource) { Class.new(described_class) }

  it 'should have an attribute actions' do
    expect(resource).to respond_to(:actions)
  end

  it 'should respond to path_preffix' do
    expect(resource).to respond_to(:path_preffix)
  end

  describe "define_actions" do
    class ResourceA < described_class
      define_actions do
      end
    end

    it 'should initialize actions attribute' do
      expect(ResourceA.new.class.actions).to eq({})
    end

    describe "action" do
      class ResourceB < described_class
        define_actions do
          action :awesome, :get, '/awesome'
          action :awful, :post, '/awful'
        end
      end

      it 'should define action' do
        expect(ResourceB.new.class.actions).not_to be_empty
      end

      it 'should define correct number of actions' do
        expect(ResourceB.new.class.actions.size).to eq(2)
      end
    end
  end
end
