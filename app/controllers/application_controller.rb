class ApplicationController < ActionController::Base
  def hello
    render html:'helllo world'
  end
end
