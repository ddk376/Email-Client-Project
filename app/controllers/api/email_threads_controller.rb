require 'byebug'
class Api::EmailThreadsController < ApplicationController
  include EmailThreadsHelper
  include EmailsHelper
  def index
    cu = current_user.associated_contact_info
    case params[:type]
    when "inbox"
      @threads = cu.received_threads
    when "starred"
      @threads = cu.starred_threads
    when "sent"
      @threads = cu.sent_threads
    when "drafts"
      @threads = cu.draft_threads
    when "important"
      @threads = cu.important_threads
    when "all"
      @threads = cu.all_threads
    when "spam"
      @threads = cu.spam_threads
    when "trash"
      @threads = cu.trash_threads
    else
      @threads = cu.received_threads
    end

    render json: @threads, include: :emails
  end

  def show
    @thread = EmailThread.find(params[:id])
    render json:  @thread, include: :emails
  end

  # def update
  #   @thread = EmailThread.find(params[:id])
  #   if @thread.update(thread_params)
  #     render json: @thread, include: :emails
  #   end
  # end

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

  def destroy
    thread = EmailThread.find(params[:id])
    emails = thread.emails
    ActiveRecord::Base.transaction do
      emails.each do |email|
        email.destroy
      end
      thread.destroy
    end

    render json: thread
  end

  # def edit
  #
  # end

  def new
    @thread = EmailThread.new
    @email = ElectronicMail.new
  end

end
