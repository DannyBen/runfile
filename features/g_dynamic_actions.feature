Feature: Dynamic Actions
  In order to avoid repetition
  Users can define actions in a programmatic manner

Scenario: Show dynamically generated actions
  Given I am in the "examples/m_dynamic_actions" folder
   When I run "run"
   Then the output should be like "output.txt"

Scenario: Execute a dynamically generated action
  Given I am in the "examples/m_dynamic_actions" folder
   When I run "run watch a-movie"
   Then the output should be "a-movie"

Scenario: Execute a dynamically generated action with compact usage
  Given I am in the "examples/m_dynamic_actions" folder
   When I run "run git commit"
   Then the output should be "git commit"

Scenario: Show proper help for dynamically generated actions
  Given I am in the "examples/m_dynamic_actions" folder
   When I run "run --help"
   Then the output should be like "output2.txt"
