require 'JSON'
class Api::EmailsController < ApplicationController
  include EmailsHelper
  def create
    thread = EmailThread.find(params[:email_thread_id])
    @email = thread.emails.new(email_params)
    @email.email_thread_id = params[:email_thread_id]
    if @email.save
      if params[:sent].toJSON
        puts
      else
        puts #save as draft
      end
    else

    end
  end
end
