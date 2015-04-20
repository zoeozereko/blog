class CommentsMailer < ApplicationMailer

  def notify_entry_owner(comment)
    @comment = comment
    @entry = @comment.entry
    @user = @entry.user
    mail(to: @user.email, subject: "Someone commented on your entry!")
  end

  def daily_entry_list(comment)
    @comment = comment
    @entry = @comment.entry
    @user = @entry.user
    mail(to: @user.email, subject: "Your daily roundup!")
  end

end
