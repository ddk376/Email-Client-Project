class Api::SentThreadsController < ApplicationController
  include ThreadsHelper

  def index
    cu = current_user.associated_contact_info
    @threads = cu.sent_threads
    render json: @threads, include: :emails
  end
end
