class Api::EmailsController < ApplicationController
  include EmailsHelper
  def index
    thread = EmailThread.find(params[:email_thread_id])
    @emails = thread.emails
    render json: @emails
  end

  def create
    thread = EmailThread.find(params[:email_thread_id])
    @email = thread.emails.new(email_params)
    @email.email_thread_id = params[:email_thread_id]
    if @email.save
      if
        puts
      else
        puts #save as draft
      end
    else
      render :json =>@email.errors.full_messages, status: :uprocessable_entity
    end
  end
end
