require 'behaviors/runfile'

describe 'integration examples' do
  integrations = Dir['spec/integration/*'].select do |f|
    File.directory?(f) && File.exist?("#{f}/commands.txt")
  end

  examples = Dir['examples/*'].select do |f|
    File.directory?(f) && File.exist?("#{f}/commands.txt")
  end

  workspaces = examples + integrations

  workspaces.each do |workspace|
    workspace_name = File.basename workspace
    describe workspace_name do
      it_behaves_like 'a runfile', workspace
    end
  end
end
