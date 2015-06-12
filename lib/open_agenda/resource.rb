require 'open_agenda/action'
require 'open_agenda/inheritable_attribute'

module OpenAgenda
  class Resource
    extend InheritableAttribute

    inheritable_attr :actions
    @path_preffix = ''
    attr_reader :connection

    def initialize(connection: nil)
      @connection = connection
    end

    def self.define_path_preffix(preffix)
      @path_preffix = preffix
    end

    def self.path_preffix
      @path_preffix
    end

    def self.define_actions(&block)
      self.actions ||= {}

      self.class_eval do
        block.call
      end if block_given?
    end

    def self.action(name, verb, path = nil, &block)
      action = Action.new(name, verb, "#{self.path_preffix}#{path}")
      action.instance_eval(&block) if block_given?
      actions[name] = action
    end

    def method_missing(name, *args, &block)
      if self.class.actions.keys.include?(name)
        self.class.actions[name].invoke(connection, args)
      else
        super
      end
    end
  end
end
