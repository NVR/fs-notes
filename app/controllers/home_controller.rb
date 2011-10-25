class HomeController < ApplicationController
  def index
@title = "hello, world!"
@notes = Note.all
  end

end
