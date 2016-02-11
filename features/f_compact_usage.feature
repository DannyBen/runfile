Feature: Compact Usage

Scenario: Compact usage
  Given I am in the "examples/l_compact_usage" folder
   When I run "run"
   Then the output should be like "output.txt"

Scenario: Execute an action with its usage hidden
  Given I am in the "examples/l_compact_usage" folder
   When I run "run code"
   Then the output should be "code" exactly

Scenario: Execute a namespaced action with a hidden usage
  Given I am in the "examples/l_compact_usage" folder
   When I run "run weekend play"
   Then the output should be "play" exactly

