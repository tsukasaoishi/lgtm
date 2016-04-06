worker_processes 3
listen 9293, :tcp_nopush => true
timeout 300
pid 'tmp/pids/unicorn.pid'
preload_app true
stderr_path 'log/unicorn.log'
stdout_path 'log/unicorn.log'
user 'ec2-user'
working_directory '/srv/lgtm/current'


before_fork do |server, worker|
  ENV['BUNDLE_GEMFILE'] = "/srv/lgtm/current/Gemfile"

  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.connection.disconnect!
  end

  old_pid = "#{server.config[:pid]}.oldbin"
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      sig = (worker.nr + 1) >= server.worker_processes ? :QUIT : :TTOU
      puts "Sending #{sig} signal to old unicorn master..."
      Process.kill(sig, File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
    end

    sleep 1
  end
end

after_fork do |server, worker|
  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.establish_connection
  end

  Rails.cache.instance_variable_get(:@data).reset if Rails.cache.instance_variable_get(:@data).respond_to?(:reset)
end
