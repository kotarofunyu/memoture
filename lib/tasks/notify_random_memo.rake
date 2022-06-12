namespace :notify_random_memo do
  desc 'notify daily'
  task notify: :environment do
    NotifyRandomMemoJob.perform_now
  end
end
