Feature: Runfile

Scenario: See usage of hyphenated runfile
  Given I am in the "examples/h_hyphen" folder
   When I run "run"
   Then the output should be like "output.txt"

Scenario: Execute hyphenated action
  Given I am in the "examples/h_hyphen" folder
   When I run "run jump-around --up --down"
   Then the output should be like "output2.txt"

