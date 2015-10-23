class Api::InboxThreadsController < ApplicationController
  include EmailThreadsHelper
  include EmailsHelper
  def index
    cu = current_user.associated_contact_info
    @threads = cu.received_threads
    render json: @threads, include: :emails
  end





  def create
    @thread = EmailThread.new(thread_params)
    @email = ElectronicMail.new(email_params)
    ActiveRecord::Base.transaction do
      @thread.save
      @email.email_thread_id = @thread.id
      @email.save
    end

    render json: @thread, include: :emails
  end







end
