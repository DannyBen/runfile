Feature: Action Alias
  In order to allow quicker and more natural command execution
  Users can define an alias to any action
  Like having "s" as an alias to "server"

Scenario: Show proper usage
  Given I am in the "examples/p_alias" folder
   When I run "run"
   Then the output should be like "output.txt"

Scenario: Show proper help
  Given I am in the "examples/p_alias" folder
   When I run "run -h"
   Then the output should be like "output2.txt"

Scenario: Execute aliased action without usage description
  Given I am in the "examples/p_alias" folder
   When I run "run s"
   Then the output should read "Running server..."

Scenario: Execute base aliased action without usage description
  Given I am in the "examples/p_alias" folder
   When I run "run server"
   Then the output should read "Running server..."

Scenario: Execute aliased action with usage
  Given I am in the "examples/p_alias" folder
   When I run "run g danny"
   Then the output should read "Hello danny"

Scenario: Execute base aliased action with usage
  Given I am in the "examples/p_alias" folder
   When I run "run greet danny"
   Then the output should read "Hello danny"

Scenario: Execute namespaced aliased action
  Given I am in the "examples/p_alias" folder
   When I run "run watch d"
   Then the output should read "Watch dog"

Scenario: Execute base namespaced aliased action
  Given I am in the "examples/p_alias" folder
   When I run "run watch dog"
   Then the output should read "Watch dog"
