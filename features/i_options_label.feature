Feature: Options Label

# Scenario: Show proper usage
#   Given I am in the "examples/n_global_action" folder
#    When I run "run"
#    Then the output should be like "output.txt"

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
