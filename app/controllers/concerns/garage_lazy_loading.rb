module GarageLazyLoading
  def require_promises
    raise NotImplementedError
  end

  def require_resources
    promise = require_promises
    @resources = promise.sync.tap do |resources|
      resources.each do |resource|
        resource.represent! unless resource.representer_attrs
        resource.ensure_promises(selector: field_selector)
      end
    end
  end

  def require_promise
    raise NotImplementedError
  end

  def require_resource
    promise = require_promise
    @resource = promise.sync.tap do |resource|
      resource.represent! unless resource.representer_attrs
      resource.ensure_promises(selector: field_selector)
    end
  end
end
