module EmailThreadsHelper
  def thread_params
    params.require(:thread).permit(:is_checked, :is_archived, :is_trash, :is_important)
  end
end
