# env :GEM_PATH, ENV['GEM_PATH']
# set :environment, "development"
set :output, {:error => "log/cron_error_log.log", :standard => "log/cron_log.log"}

every 6.minutes do
  rake "tmp:clear db:drop db:create db:migrate db:seed"
end
