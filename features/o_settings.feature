Feature: Settings File
  In order to allow multiple runfiles per project
  Users can have a ".runfile" file to configure search folder
  Like "folder: lib/commands"

Background:
  Given I am in the "examples/s_settings" folder

Scenario: See list of runfiles in the configured folder
   When I run "run"
   Then the output should match "Usage: run <file>"
    And the output should match "beer.*pizza"

Scenario: See usage of a runfile in the folder
   When I run "run pizza"
   Then the output should match "run pizza order"

Scenario: Execute a runfile in the folder
   When I run "run pizza order"
   Then the output should be "Order Pizza"

Scenario: Execute run bang in a folder with settings
   When I run "run!"
   Then the output should match "Tip: Type 'run new' or 'run new name'..."

Scenario: Autoload helper file
   When I run "run loadchecker check"
   Then the output should be "This message came from helper.rb"

Scenario: Show intro line
   When I run "run"
   Then the output should match "My Command Line"

Scenario: Execute through a shortcut
   When I run "run s"
   Then the output should match "# s > server start"
   Then the output should match "Started in the foreground"

Scenario: Execute through a shortcut with argument
   When I run "run stat prod"
   Then the output should match "Status of prod is A-OK"

Scenario: See list of shortcuts in the configured folder
   When I run "run"
   Then the output should match "Shortcuts:"
    And the output should match "s : server start"
    And the output should match "sd : server start --daemon"
