# frozen_string_literal: true

require_relative '' '../lib/bowser_automator'

automator = BowserAutomator.use_plugin 'chrome-staging-1.3-wo-at.crx'
BowserAutomator.run do
  automator.open_new_tab 'https://google.com'
  automator.search_in_google 'lavanguardia'

  automator.open_new_tab 'https://google.com'
  automator.search_in_google 'marca'

  automator.switch_to_window 1
  automator.execute_script 'document.getElementsByTagName' \
'("footer")[0].scrollIntoView()'

  automator.open_new_tab 'https://google.com'
  automator.search_in_google 'sport'

  sleep 3
  automator.quit
end
