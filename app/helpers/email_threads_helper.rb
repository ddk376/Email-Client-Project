module EmailThreadsHelper
  def show
    @thread = EmailThread.find(params[:id])
    render json:  @thread, include: :emails
  end

  def new
    @thread = EmailThread.new
    @email = ElectronicMail.new
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

  def thread_params
    params.require(:thread).permit(:is_checked, :is_archived, :is_trash, :is_important)
  end
end
