module EmailsHelper
  def email_params
    params.require(:email).permit(:parent_email_id, :from, :body, :is_starred, :is_draft, :is_read)
  end
end
