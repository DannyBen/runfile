Feature: Environment Variables
  In order to provide a better help text
  Users can document environment variables

Scenario: Show proper help
  Given I am in the "examples/w_env_vars" folder
   When I run "run -h"
   Then the output should be like "output.txt"

