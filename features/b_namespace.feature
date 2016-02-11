Feature: Namespaced Commands

Scenario: Use namespaced commands
  Given I am in the "examples/f_namespace" folder
   When I run "run"
   Then the output should be like "output.txt"

Scenario: See properly namespaced usage
  Given I am in the "examples/f_namespace" folder
   When I run "run"
   Then the output should be like "output.txt"

Scenario: Execute namespaced command
  Given I am in the "examples/f_namespace" folder
   When I run "run make jam"
   Then the output should say "Making jam..."

Scenario: Execute a non namespaced command in a namespaced file
  Given I am in the "examples/f_namespace" folder
   When I run "run eat"
   Then the output should be "Custard? Good! Jam? Good! Meat? Good!!!" exactly

Scenario: Execute a file with namespace overloading
  Given I am in the "examples/g_overloading" folder
   When I run "run"
   Then the output should be like "output.txt"

Scenario: Execute the overladed command
  Given I am in the "examples/g_overloading" folder
   When I run "run jump"
   Then the output should say "Jump!"

Scenario: Execute the overladed namespace command
  Given I am in the "examples/g_overloading" folder
   When I run "run jump around"
   Then the output should say "Jump around"

Scenario: Use the endcommand alias
  Given I am in the "examples/k_endcommand" folder
   When I run "run"
   Then the output should be like "output.txt"

Scenario: Execute a command placed after the endcommand marker
  Given I am in the "examples/k_endcommand" folder
   When I run "run eat"
   Then the output should be "eat" exactly

