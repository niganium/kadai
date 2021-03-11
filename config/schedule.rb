require File.expand_path(File.dirname(__FILE__) + "/environment")
rails_env = Rails.env.to_sym
set :runner_command, "rails runner"
set :environment, rails_env
set :output, 'log/cron.log'

every 1.day, at: '9:00 am' do
  begin
    runner "DailyMailer.all_notify"
  rescue => e
    Rails.logger.error("aborted rails runner")
    raise e
  end
end
