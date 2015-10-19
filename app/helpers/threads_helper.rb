module ThreadsHelper
  def show
    @thread = EmailThread.find(params[:id])
    render json:  @thread, include: :emails
  end

  def update
    @thread = EmailThread.find(params[:id])
    if @thread.update(thread_params)
      render json: @thread
    end
  end
  
  private
  def thread_params
    params.require(:thread).permit(:is_checked, :is_archived, :is_trash, :is_important)
  end
end
