namespace :summary do
  desc "summary of all newly created comments that that day for posts"
  task :summarize_all_daily_comments => :environment do
    @comment = Comment.where("created_at >= ?", Date.today)
    CommentsMailer.daily_entry_list(@comment)
  end
end
