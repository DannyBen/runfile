Feature: Settings File
  In order to allow multiple runfiles per project
  Users can have a ".runfile" file to configure search folder
  Like "folder: lib/commands"

Background:
  Given I am in the "examples/s_settings" folder

Scenario: See list of runfiles in the configured folder
   When I run "run"
   Then the output should match "run beer"
    And the output should match "run pizza"

Scenario: See usage of a runfile in the folder
   When I run "run pizza"
   Then the output should match "run pizza order"

Scenario: Execute a runfile in the folder
   When I run "run pizza order"
   Then the output should be "Order Pizza"

Scenario: Execute run bang in a folder with settings
   When I run "run!"
   Then the output should match "Tip: Type 'run make' or 'run make name'..."
