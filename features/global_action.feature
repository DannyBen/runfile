Feature: Global Action
  In order to allow more natural commands
  Users can create actions where the first argument is not an ation
  Like "run FILE"

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

Scenario: Execute a global action in a named runfile
  Given I am in the "examples/t_global_actions_named" folder
   When I run "run one"
   Then the output should say "domination"

Scenario: Execute a regular action in a named runfile
  Given I am in the "examples/t_global_actions_named" folder
   When I run "run one peter"
   Then the output should say "pan"
