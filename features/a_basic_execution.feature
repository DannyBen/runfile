Feature: Basic Runfile execution

Scenario: Execute a minimal runfile
  Given I am in the "examples/a_minimal" folder
   When I run "run greet danny"
   Then the output should say "Hello danny"

Scenario: Show help
  Given I am in the "examples/a_minimal" folder
   When I run "run -h"
   Then the output should be like "output.txt"

Scenario: Show a more detailed help
  Given I am in the "examples/b_basic" folder
   When I run "run -h"
   Then the output should be like "output.txt"

