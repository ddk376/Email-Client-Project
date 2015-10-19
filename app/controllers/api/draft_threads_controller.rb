class Api::DraftThreadsController < ApplicationController
  include ThreadsHelper

  def index
    cu = current_user.associated_contact_info
    @threads = cu.draft_threads
    render json: @threads, include: :emails
  end
end
