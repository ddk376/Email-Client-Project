class Api::InboxThreadsController < ApplicationController
  include ThreadsHelper

  def index
    cu = current_user.associated_contact_info
    @threads = cu.received_threads
    render json: @threads, include: :emails
  end
end
