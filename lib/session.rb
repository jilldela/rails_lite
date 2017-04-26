require 'json'
require 'byebug'

class Session
  # find the cookie for this app
  # deserialize the cookie into a hash
  def initialize(req)
    @cookies = req.cookies['_rails_lite_app']
    if @cookies
      @session = ActiveSupport::JSON.decode(@cookies)
    else
      @session = {}
    end
  end

  def [](key)
    @session[key]
  end

  def []=(key, val)
    @session[key] = val
  end

  # serialize the hash into json and save in a cookie
  # add to the responses cookies
  def store_session(res)
    values = ActiveSupport::JSON.encode(@session)
    res.set_cookie('_rails_lite_app', path: '/', value: values)
  end
end