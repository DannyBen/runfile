describe 'bin/run' do
  let(:bin) { File.expand_path('bin/runn', '../../../') }

  context 'when the file contains a syntax error' do
    it 'errors gracefully' do
      Dir.chdir 'spec/integration/syntax-error' do
        expect(`#{bin} 2>&1`).to match_approval('bin/syntax-error')
      end
    end
  end

  context 'when the action contains a runtime error' do
    it 'errors gracefully' do
      Dir.chdir 'spec/integration/action-error' do
        expect(`#{bin} greet 2>&1`).to match_approval('bin/action-error')
      end
    end
  end
end
