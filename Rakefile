# -*- coding: utf-8 -*-
#$:.unshift("/Library/RubyMotion/lib")
$:.unshift("/Users/eloy/Code/RubyMotion/Source/RubyMotion/lib")
require 'motion/project/template/osx'
#require 'motion/project/template/ios'

begin
  require 'bundler'
  Bundler.require
rescue LoadError
end

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'TestPLCrashReporter'
  app.pods do
    pod 'PLCrashReporter', '1.2-rc5'
  end
end
