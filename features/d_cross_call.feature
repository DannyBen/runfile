Feature: Cross Call
  In order to allow code reuse
  Users can easily call actions from other actions
  Like "call other --action"

Scenario: Call another actoin
  Given I am in the "examples/i_crosscall" folder
   When I run "run exercise"
   Then the output should be like "output.txt"

