class Api::BccRecipientsController < ApplicationController
  def index
    @email = ElectronicMail.find(params[:email_id])
    @bcc = @email.bcc

    render json: @bcc
  end
end
