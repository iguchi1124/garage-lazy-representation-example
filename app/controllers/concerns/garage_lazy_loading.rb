module GarageLazyLoading
  def require_promises
    raise NotImplementedError
  end

  def require_resources
    promise = require_promises
    @resources = promise.sync
  end

  def require_promise
    raise NotImplementedError
  end

  def require_resource
    promise = require_promise
    @resources = promise.sync
  end
end
