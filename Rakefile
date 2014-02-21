# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/ios'

begin
  require 'bundler'
  Bundler.require
rescue LoadError
end

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'QR'
  app.identifier = 'com.liulantao.QR'
  app.version = '0.0.1'

  app.frameworks += ['AVFoundation']
  app.provisioning_profile = "#{ENV['PROVISION_DIR'] || './mobileprovision'}/liulantao_development.mobileprovision"

  app.icons = ["icon-120.jpg"]

  app.files_dependencies 'app/app_delegate.rb' => 'app/helpers/string.rb'
end