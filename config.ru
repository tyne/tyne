# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment',  __FILE__)
use Rack::Deflater
use ExceptionNotifier, :email => {
  :email_prefix => "[ERROR] ",
  :sender_address => %{"Tyne" <notifications@tyne-tickets.org>},
  :exception_recipients => %w{exceptions@tyne-tickets.org}
}
run Tyne::Application
