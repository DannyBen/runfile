Feature: Global Action

Scenario: Show proper usage
  Given I am in the "examples/n_global_action" folder
   When I run "run"
   Then the output should be like "output.txt"

Scenario: Show proper help
  Given I am in the "examples/n_global_action" folder
   When I run "run -h"
   Then the output should be like "output3.txt"

Scenario: Execute the global action
  Given I am in the "examples/n_global_action" folder
   When I run "run somefile someuser"
   Then the output should say "This is a global action with file=somefile and user=someuser"

Scenario: Execute the other actions in the runfile
  Given I am in the "examples/n_global_action" folder
   When I run "run copy somefile"
   Then the output should be like "output2.txt"
