# This spec pattern chdirs into a directory that is exapected to contain some
# runfiles and a commands.txt with list of commands to test.
shared_examples 'a runfile' do |workspace, approvals_base|
  command_file = 'commands.txt'
  workspace_name = File.basename workspace
  leeway = RUBY_VERSION < '3.4.0' ? 20 : 0
  approvals_base ||= 'integration'

  it 'runs as expected' do
    Dir.chdir workspace do
      skip "No #{command_file} file" unless File.exist? command_file

      commands = File.readlines command_file, chomp: true
      commands.unshift ''
      commands.each do |command|
        mode = :normal
        if command[0] == '!'
          mode = :exception
          command = command[1..]
        end

        filename = command.gsub(/[^a-zA-Z0-9\-\ ]/, '_')
        filename = filename.empty? ? 'run' : "run #{filename}"
        fixture_name = "#{approvals_base}/#{workspace_name}/#{filename}"
        say "    gb`$` [m`#{workspace}`] run #{command}".rstrip
        begin
          argv = Shellwords.split command
          entrypoint = Entrypoint.new argv
          if mode == :exception
            expect { entrypoint.run }.to raise_approval(fixture_name).diff(4)
          else
            expect { entrypoint.run }.to output_approval(fixture_name).diff(leeway)
          end
        rescue Runfile::ExitWithUsage => e
          result = e.message
          expect(result).to match_approval fixture_name
        end
      end
    end
  end
end
