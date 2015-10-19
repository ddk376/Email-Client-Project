class Api::TrashThreadsController < ApplicationController
  include ThreadsHelper

  def index
    cu = current_user.associated_contact_info
    @threads = cu.trash_threads
    render json: @threads, include: :emails
  end
end
