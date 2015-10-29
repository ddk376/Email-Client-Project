class Api::EmailThreadsController < ApplicationController
  def show
    @thread = EmailThread.find(params[:id])
    render json: @thread, include: [:parent_email, :emails]
  end
end
