#!/usr/bin/env ruby

# require daemon relative library
file = File.symlink?(__FILE__) ? File.readlink(__FILE__) : __FILE__
lib = File.join File.dirname(file), "/../lib/daemon"
require lib


# Bypass user aquisition
class TestUser
  def username
    "TestUser"
  end
end
class Twitter::Status
  def user
    TestUser.new
  end
end


def test_user
  ben = User.new
  puts ben
  
  ben.update(:album, 1, 'Thriller')
  puts ben
  
  ben.update(:album, 2, 'White Album')
  puts ben
  
  ben.update(:album, 3, 'Yellow Submarine')
  puts ben
  
  ben.update(:album, 1, 'Godbluff')
  puts ben
  
  ben.update(:book, 2, 'Bible')
  puts ben
  
  ben.update(:album, 2, 'Test')
  puts ben
end


statuses = ["my #2 book is Kim #hashcatch",
            "#hashcatch #1 film Gladiator",
            "#hashcatch hello world4",
            "#hashcatch Hello World5",
            "#hashcatch an example",
            "hi world"].map { |t|
  Twitter::Status.new(id: 0, text: t)
}

Daemon::Configuration::TEST = true
d = Daemon::Daemon.new
statuses.each { |s| d.handle_status(s) }
