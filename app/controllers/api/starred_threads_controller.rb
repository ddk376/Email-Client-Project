class Api::StarredThreadsController < ApplicationController
  def index
    cu = current_user.associated_contact_info
    @threads = cu.starred_threads
    render json: @threads, include: :emails
  end
end
