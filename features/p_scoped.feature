Feature: Scoped Runfile
  In order to prevent conflicts with the Runfile DSL
  Users can have a ".scoped-runfile" file in the current directory

Background:
  Given I am in the "examples/u_scoped_runfile" folder

Scenario: Execute a runfile that includes the module
   When I run "run pass functional"
   Then the output should say "yes"

Scenario: Execute a runfile that does not include the module
   When I run "run fail"
   Then the error output should match "undefined method .name. for main:Object"