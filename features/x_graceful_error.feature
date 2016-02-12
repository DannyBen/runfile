Feature: Graceful Errors
  In order to deal with erroneous runfiles gracefully
  Users can see the error message without the ugly backtrace

Scenario: Run a Runfile that generates an error
  Given I am in the "examples/x_graceful_error" folder
   When I run "run"
   Then the error output should be like "output.txt"
