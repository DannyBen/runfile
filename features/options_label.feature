Feature: Options Label
  In order to better organize help output with many options
  Users can group options under labels
  Like grouping all the "server" command options together

Scenario: Show proper help
  Given I am in the "examples/o_options_label" folder
   When I run "run -h"
   Then the output should be like "output.txt"
    And the output should have "Rename Options:"
    And the output should have "Copy Options:"

