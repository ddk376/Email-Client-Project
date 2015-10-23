class Api::DraftThreadsController < ApplicationController
  def index
    cu = current_user.associated_contact_info
    @threads = cu.draft_threads
    render json: @threads, include: :emails
  end

  # def update
  #   @thread = EmailThread.find(params[:id])
  #   if @thread.update(thread_params)
  #     render json: @thread, include: :emails
  #   end
  # end

  # def edit
  #
  # end
end
