class Api::SpamThreadsController < ApplicationController
  include ThreadsHelper

  def index
    cu = current_user.associated_contact_info
    @threads = cu.spam_threads
    render json: @threads, include: :emails
  end
end
