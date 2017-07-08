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
  app.deployment_target = '10.2'

  app.frameworks += ['AVFoundation']

  app.icons = ["icon-120.jpg"]

  app.files_dependencies 'app/app_delegate.rb' => 'app/helpers/string.rb'

  app.development do
    if ENV['CI']
      app.codesign_certificate = nil
      app.provisioning_profile = nil

    elsif ARGV[0] == 'device'
      app.codesign_certificate = MotionProvisioning.certificate(
        type: :development,
        platform: :ios
      )

      app.provisioning_profile = MotionProvisioning.profile(
        bundle_identifier: app.identifier,
        app_name: app.name,
        platform: :ios,
        type: :development
      )

      puts "Using profile: #{app.provisioning_profile}"
      puts "Using certificate: #{app.codesign_certificate}"

    else
      app.codesign_certificate = nil
      app.provisioning_profile = nil
    end
  end
end