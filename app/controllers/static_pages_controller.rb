class StaticPagesController < ApplicationController
  before_action :require_signed_in!

  def root
    # @email_threads = current_user.inbox_threads
  end
end
