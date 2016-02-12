Feature: Make Runfile
  In order to allow easy initialization
  Users can create runfile templates
  Like "run make" or "run make named"

Background:
  Given the folder "sandbox" exists

Scenario: "Show help when running without a Runfile"
  Given I am in the "sandbox" folder
    And the folder is empty
   When I run "run"
   Then the output should match "Tip: Type 'run make' or 'run make name'..."
    And the output should match "For global access, place named.runfiles..."
    And the output should match "Runfile not found."

Scenario: Create a runfile
  Given I am in the "sandbox" folder
    And the file "Runfile" does not exist
   When I run "run make"
   Then the output should read "Runfile created"
    And the file "Runfile" should exist
    And the file "Runfile" should contain "hello [<name> --color]"

Scenario: "Create a named runfile"
  Given I am in the "sandbox" folder
    And the folder is empty
   When I run "run make one"
    And I run "run make two"
    And I run "run"
   Then the file "one.runfile" should exist
    And the file "two.runfile" should exist
    And the output should match "Tip: Type 'run make'..."
    And the output should match "run .*sandbox"

Scenario: "Dont show the make tip if the user is already trained"
  Given I am in the "sandbox" folder
    And the file "one.runfile" exists
    And the file "two.runfile" exists
    And the file "three.runfile" exists
   When I run "run"
   Then the output should not match "Tip: Type 'run make' or 'run make name'..."
  
