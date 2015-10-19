class Api::AllThreadsController < ApplicationController
  include ThreadsHelper

  def index
    cu = current_user.associated_contact_info
    @threads = cu.all_threads
    render json: @threads, include: :emails
  end
end
