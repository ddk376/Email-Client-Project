class Api::EmailsController < ApplicationController
  include EmailsHelper

  def index
    email = ElectronicMail.find(params[:email_id])
    @emails = email.children_emails

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

  def update
    debugger
    email = ElectronicMail.find(params[:email][:id])
    email.update(email_update_params)

    render json: email
  end

  def show
    @email = ElectronicMail.find(params[:id])

    render json: @email, include: [:send_to, :bcc, :cc, :children]
  end

end
