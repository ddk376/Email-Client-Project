class Api::EmailThreadsController < ApplicationController
  def show
    @thread = EmailThread.find(params[:id])
    render json: @thread, include: [:parent_email, :emails]
  end

  def update
    thread = EmailThread.find(params[:email][:id])
    thread.update(thread_update_params)
    render json: thread
  end

  def create
    debugger
  end

  private
  def thread_update_params
    params.require(:email).permit(:is_important, :is_spam, :is_trash, :is_archived, :is_draft, :is_read)
  end

  def thread_params

  end
end
