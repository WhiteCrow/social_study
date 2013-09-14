rails_root = "/apps/social_study/current"
rails_env = ENV["RAILS_ENV"] || "production"

worker_processes 4
working_directory rails_root

# listen "#{rails_root}/tmp/sockets/unicorn.sock", :backlog => 2048
listen 80, :tcp_nopush => false

# nuke workers after 30 seconds instead of 60 seconds (the default)
timeout 30

pid "#{rails_root}/tmp/pids/unicorn.pid"

stderr_path "#{rails_root}/log/unicorn.stderr.log"
stdout_path "#{rails_root}/log/unicorn.stdout.log"

preload_app true

# before_exec do |server|
#   ENV["BUNDLE_GEMFILE"] = "#{rails_root}/Gemfile"
# end

before_fork do |server, worker|
  #ActiveRecord::Base.connection.disconnect!
 
  old_pid = "#{server.config[:pid]}.oldbin"
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill("QUIT", File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      # someone else did our job for us
    end
  end
end

after_fork do |server, worker|
  #ActiveRecord::Base.establish_connection
end
