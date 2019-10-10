# frozen_string_literal: true

module BowserAutomator
  require_relative './bowser_automator/automator'

  def self.root
    File.dirname __dir__
  end

  def self.use_plugin(plugin_version = 'chrome-staging-1.3.crx')
    @automator = Automator.new plugin_version
  end

  def self.run
    @automator.run do
      yield
    end
  end
end
