class Api::ImportantThreadsController < ApplicationController
  def index
    cu = current_user.associated_contact_info
    @threads = cu.important_threads
    render json: @threads, include: :emails
  end

end
