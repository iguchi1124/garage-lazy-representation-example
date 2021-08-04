module GarageLazyRepresenter
  extend ActiveSupport::Concern

  def render_hash(options = {})
    representer_attrs.each do |definition|
      if definition.lazy?
        definition.register(self)
      end
    end

    super(options)
  end

  class Garage::Representer::Definition
    def lazy?
      false
    end
  end

  class Garage::Representer::Collection
    def lazy?
      false
    end
  end

  class Garage::Representer::Link
    def lazy?
      false
    end
  end

  class LazyDefinition < Garage::Representer::Definition
    # Enqueue promise to dataloader
    def register(object)
      object.send(@name)
    end

    def encode(object, responder, selector = nil)
      promise = object.send(@name)
      unless promise.is_a?(Promise)
        raise TypeError, "#{@name} must be wrapped Promise object for lazy loading"
      end

      value = promise.sync
      encode_value(value, responder, selector)
    end

    def lazy?
      true
    end
  end

  class LazyCollection < Garage::Representer::Collection
    def register(object)
      object.send(@name)
    end

    def encode(object, responder, selector = nil)
      promise = object.send(@name)
      unless promise.is_a?(Promise)
        raise TypeError, "#{@name} must be wrapped Promise object for lazy loading"
      end

      value = promise.sync
      value.map do |item|
        encode_value(item, responder, selector)
      end
    end

    def lazy?
      true
    end
  end

  module ClassMethods
    def lazy_property(name, options={})
      representer_attrs << LazyDefinition.new(name, options)
    end

    def lazy_collection(name, options={})
      representer_attrs << LazyCollection.new(name, options)
    end
  end
end
