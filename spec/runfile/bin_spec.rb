describe 'bin/run' do
  let(:bin) { File.expand_path('bin/run', '../../../') }
  let(:leeway) { RUBY_VERSION < "3.2.0" ? 0 : 33 }

  context 'when the file contains a syntax error' do
    it 'errors gracefully' do
      Dir.chdir 'spec/integration/syntax-error' do
        expect(`#{bin} 2>&1`).to match_approval('bin/syntax-error').diff(leeway)
      end
    end
  end

  context 'when the action contains a runtime error' do
    it 'errors gracefully' do
      Dir.chdir 'spec/integration/action-error' do
        expect(`#{bin} greet 2>&1`).to match_approval('bin/action-error').diff(leeway)
      end
    end
  end
end
