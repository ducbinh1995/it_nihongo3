class Notifications::CommentReplyService
  def initialize comment
    @comment = comment
  end

  def perform
    ActivityNotification::Notification.notify :users, @comment,
      key: "comment.reply", notifier: @comment.user, group: @comment.recipe
  end
end
