Feature: Run Global (Bang)
  In order to run globally available runfiles from a folder that 
  has a runfile
  Users can use the "run!" executable instead of using "run"

Scenario: Show proper usage
  Given I am in the "examples/a_minimal" folder
   When I run "run!"
   Then the output should resemble "output2.txt"

