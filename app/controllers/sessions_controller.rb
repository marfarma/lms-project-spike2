class SessionsController < Devise::SessionsController

  def new
    @title = "Sign in"
    super
  end

  def create
      @title = "Sign in"
      super
  end

  def destroy
    super
  end
  
end
