Feature: Params
  In order to provide a better help text
  Users can document params

Scenario: Show proper help
  Given I am in the "examples/u_params" folder
   When I run "run -h"
   Then the output should be like "output.txt"
    And the output should have "Parameters:"
    And the output should have "SSH Parameters:"

