Feature: Cross Call

Scenario: Call another actoin
  Given I am in the "examples/i_crosscall" folder
   When I run "run exercise"
   Then the output should be like "output.txt"

