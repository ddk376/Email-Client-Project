class Api::TrashThreadsController < ApplicationController
  def index
    cu = current_user.associated_contact_info
    @threads = cu.trash_threads
    render json: @threads, include: :emails
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
end
