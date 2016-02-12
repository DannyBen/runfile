Feature: Usage Example
  In order to provide clearer instructions
  Users can define example text for actions
  Like "example: run server --daemon"

Scenario: Show example in the help
  Given I am in the "examples/q_example" folder
   When I run "run -h"
   Then the output should be like "output.txt"
    And the output should have "Examples:"
    And the output should have "run copy somefile.txt --force"


