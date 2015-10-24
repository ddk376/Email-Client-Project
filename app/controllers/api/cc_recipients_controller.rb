class Api::CcRecipientsController < ApplicationController
  def index
    @email = ElectronicMail.find(params[:email_id])
    @cc = @email.cc

    render json: @cc
  end
end
