class Api::EmailsController < ApplicationController
  include EmailsHelper
  def index
    cu = current_user.associated_contact_info
    thread = EmailThread.find(params[:email_thread_id])
    @emails = []
    thread.emails.each do |email|
      email.recipients.each do |recipient| @emails << email if recipient.contact_id == cu.id end
      email.bcc_recipients.each do |recipient| @emails << email if recipient.contact_id == cu.id end
      email.cc_recipients.each do |recipient| @emails << email if recipient.contact_id == cu.id end
    end
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
