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
   Then the output should match "Tip: Type 'run make' or 'run make name'..."

Scenario: Autoload helper file
   When I run "run loadchecker check"
   Then the output should be "This message came from helper.rb"

Scenario: Show intro line
   When I run "run"
   Then the output should match "My Command Line"
