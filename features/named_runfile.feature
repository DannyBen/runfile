Feature: Named Runfiles
  In order to allow dealing with many runfiles
  And in order to allow globally accessible runfiles
  Users can define a named Runfile
  Like "server.runfile"

Scenario: See usage in a named runfile 
  Given I am in the "examples/j_customname" folder
   When I run "run"
   Then the output should match "Tip: Type 'run new' or 'run new name'..."
    And the output should match "For global access, place named.runfiles in..."
    And the output should match "run greet \.* .*/examples/j_customname"

Scenario: Execute named runfile
  Given I am in the "examples/j_customname" folder
   When I run "run greet hello"
   Then the output should be "hello"

Scenario: Execute a namespaced command in a named runfile
  Given I am in the "examples/j_customname" folder
   When I run "run greet spanish hello jack"
   Then the output should be "hola jack"

Scenario: Execute a second namespaced command in a named runfile
  Given I am in the "examples/j_customname" folder
   When I run "run greet french hello jill"
   Then the output should be "bonjour jill"

Scenario: Execute a non namespaced command in a named runfile
  Given I am in the "examples/j_customname" folder
   When I run "run greet bye"
   Then the output should be "bye"

