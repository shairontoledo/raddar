set :output, "log/cron_log.log"

every 1.day, :at => '4:30 am' do 
  runner 'CalculateUserRanksJob.new.perform'
end