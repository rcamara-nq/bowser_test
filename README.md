This project is intended to help in the test process of the project Bowser. It is a browser plugin so, testing some features are difficult some times.

We have a configuration file config/test_config.yml where you can setup the pincode and the *Steps Url* where the user installs the extension. The project will install automatically the extension in the browser (Chrome for now) and you can write then the next actions to take (go to x website, etc...).

# API methods

Here below the methods you can use to navigate between pages when testing:
- \#open_new_tab:
    - Opens a new tab with the specified url
- \#search_in_google
    - Searches in google a specified string and it goes to the first webpage of the results
- \#switch_to_window
    - Switches to an existent window/tab
- \#execute_script
    - Executes JS code in the current window
- \#quit
    - Stops the browser