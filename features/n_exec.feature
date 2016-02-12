Feature: Exec Extension
  In order to easily execute external commands
  Users can call "run" and "run_bg" 
  Like "run 'server'" or "run_bg 'puma', pid: 'puma'"

Background:
  Given I am in the "examples/r_exec" folder
    And the folder "tmp" exists

Scenario: "Run an external command"
    When I run "run solve"
    Then the output should say "If there was a problem, yo, I'll solve it"

Scenario: "Execute a before and after block"
   When I run "run solve"
   Then the output should be like "output.txt"

Scenario: "Execute a background job"
   When I run "run behind"
   Then the output should say "> exec ls >/dev/null 2>&1"

Scenario: "Execute a background job with a given pid alias"
   When I run "run pid"
   Then the output should say "> exec ls >/dev/null 2>&1"
    And the file "ls.pid" should exist
    And the file "ls.pid" should match "\d+"

Scenario: "Execute a background job storing pid in another folder"
  Given the file "tmp/pidfile.pid" does not exist
   When I run "run piddir"
   Then the file "tmp/pidfile.pid" should exist
    And the file "tmp/pidfile.pid" should match "\d+"
    And the file "pidfile.pid" should not exist

Scenario: "Execute a background job and direct output to a log"
  Given the file "pwd.log" does not exist
   When I run "run log"
   Then the file "pwd.log" should exist
    And the file "pwd.log" should match "runfile/examples/r_exec"

Scenario: "Stop a background job"
   When I run "run sleep"
    And I run "run sleep --stop"
   Then the file "sleeper.pid" should not exist
    And the output should match "kill -s TERM \d+"

Scenario: "Stop a non existing background job"
   When I run "run error"
   Then the output should say "PID file not found"

