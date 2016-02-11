Feature: Hyphenated Actions
  In order to provide more flexibility when naming actions
  Users can define hyphenated-actions
  Like "run puma-server"

Scenario: See usage of hyphenated runfile
  Given I am in the "examples/h_hyphen" folder
   When I run "run"
   Then the output should be like "output.txt"

Scenario: Execute hyphenated action
  Given I am in the "examples/h_hyphen" folder
   When I run "run jump-around --up --down"
   Then the output should be like "output2.txt"

