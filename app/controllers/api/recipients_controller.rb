class Api::RecipientsController < ApplicationController
  def index
    @email = ElectronicMail.find(params[:email_id])
    @to = @email.send_to

    render json: @to
  end
end
