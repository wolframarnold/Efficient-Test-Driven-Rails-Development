require 'selenium/rake/tasks'

Selenium::Rake::RemoteControlStartTask.new do |rc|
  rc.port = 4444 # default Selenium Server port
  rc.timeout_in_seconds = 30
  rc.background = true
  rc.wait_until_up_and_running = true
  rc.jar_file = "vendor/selenium-remote-control/selenium-server.jar"
  rc.additional_args << "-singleWindow"
end

Selenium::Rake::RemoteControlStopTask.new

desc "Restart Selenium Remote Control"
task :'selenium:rc:restart' do
  Rake::Task[:'selenium:rc:stop'].execute [] rescue nil
  Rake::Task[:'selenium:rc:start'].execute []
end
