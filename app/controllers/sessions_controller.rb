class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by_credentials(params[:user][:email], params[:user][:password])

    if @user
      sign_in!(@user)
      redirect_to root_url
    else
      flash.now[:errors] = ["The email and password you entered don't match"]
      render :new
    end
  end

  def destroy
    current_user.received_emails.each do |email|
      email.is_checked = false
      email.save
    end
    current_user.sent_emails.each do |email|
      email.is_checked = false
      email.save
    end
    sign_out!
    redirect_to new_session_url
  end
end
