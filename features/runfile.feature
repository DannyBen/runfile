Feature: Runfile

Scenario: Execute a minimal runfile
  Given I am in the "examples/a_minimal" folder
   When I run "run greet danny"
   Then the output should say "Hello danny"

Scenario: Show help
  Given I am in the "examples/a_minimal" folder
   When I run "run -h"
   Then the output should be like "output.txt"

Scenario: Show a more detailed help
  Given I am in the "examples/b_basic" folder
   When I run "run -h"
   Then the output should be like "output.txt"

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

Scenario: See usage of hyphenated runfile
  Given I am in the "examples/h_hyphen" folder
   When I run "run"
   Then the output should be like "output.txt"

Scenario: Execute hyphenated action
  Given I am in the "examples/h_hyphen" folder
   When I run "run jump-around --up --down"
   Then the output should be like "output2.txt"

Scenario: Cross call
  Given I am in the "examples/i_crosscall" folder
   When I run "run exercise"
   Then the output should be like "output.txt"

Scenario: See usage in a named runfile 
  Given I am in the "examples/j_customname" folder
   When I run "run"
   Then the output should say "Tip: Type 'run make' or 'run make name'..."
    And the output should say "For global access, place named.runfiles in..."
    And the output should say "run greet \.* .*/examples/j_customname"

Scenario: Execute named runfile
  Given I am in the "examples/j_customname" folder
   When I run "run greet hello"
   Then the output should be "hello" exactly

Scenario: Execute a namespaced command in a named runfile
  Given I am in the "examples/j_customname" folder
   When I run "run greet spanish hello jack"
   Then the output should be "hola jack" exactly

Scenario: Execute a second namespaced command in a named runfile
  Given I am in the "examples/j_customname" folder
   When I run "run greet french hello jill"
   Then the output should be "bonjour jill" exactly

Scenario: Execute a non namespaced command in a named runfile
  Given I am in the "examples/j_customname" folder
   When I run "run greet bye"
   Then the output should be "bye" exactly

Scenario: Use the endcommand alias
  Given I am in the "examples/k_endcommand" folder
   When I run "run"
   Then the output should be like "output.txt"

Scenario: Execute a command placed after the endcommand marker
  Given I am in the "examples/k_endcommand" folder
   When I run "run eat"
   Then the output should be "eat" exactly

Scenario: Compact usage
  Given I am in the "examples/l_compact_usage" folder
   When I run "run"
   Then the output should be like "output.txt"

Scenario: Execute an action with its usage hidden
  Given I am in the "examples/l_compact_usage" folder
   When I run "run code"
   Then the output should be "code" exactly

@current
Scenario: Execute a namespaced action with a hidden usage
  Given I am in the "examples/l_compact_usage" folder
   When I run "run weekend play"
   Then the output should be "play" exactly

# - dir: m_dynamic_actions
#   cmd: run
#   out: |-
#     Usage:...
# - dir: m_dynamic_actions
#   cmd: run watch a-movie
#   out: a-movie
# - dir: m_dynamic_actions
#   cmd: run git commit
#   out: git commit
# - dir: m_dynamic_actions
#   cmd: run --help
#   out: |-
#     Runfile...
# - dir: n_global_action
#   cmd: run
#   out: |-
#     Usage:...
# - dir: n_global_action
#   cmd: run somefile someuser
#   out: This is a global action with file=somefile and user=someuser
# - dir: n_global_action
#   cmd: run copy somefile
#   out: |-
#     When I say COPY you say PASTE.
#     COPY ...
#     COPY ...
# - dir: n_global_action
#   cmd: run --help
#   out: |-
#     Runfile...
# - dir: o_options_label
#   cmd: run -h
#   out: |-
#     Runfile...
# - dir: x_graceful_error
#   cmd: run 2>&1
#   out: |-
#     Runfile error:
#     undefined local variable or method `boo' for main:Object
#     Runfile:3:in `<top (required)>'
# - dir: p_alias
#   cmd: run
#   out: |-
#     Usage:...
# - dir: p_alias
#   cmd: run s
#   out: Running server...
# - dir: p_alias
#   cmd: run server
#   out: Running server...
# - dir: p_alias
#   cmd: run g danny
#   out: Hello danny
# - dir: p_alias
#   cmd: run greet danny
#   out: Hello danny
# - dir: p_alias
#   cmd: run watch d
#   out: Watch dog
# - dir: p_alias
#   cmd: run watch dog
#   out: Watch dog
# - dir: p_alias
#   cmd: run -h
#   out: |-
#     Runfile...
# - dir: a_minimal
#   cmd: run!
#   out: |-
#     Runfile engine ...
# - dir: q_example
#   cmd: run -h
#   out: |-
#     Runfile...
