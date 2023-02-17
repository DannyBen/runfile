describe Runner do
  subject { described_class }

  let(:docopt) { 'Usage: backup [PATH --force]' }

  describe '#run' do
    it 'returns the args' do
      expect(subject.run docopt, argv: %w[backup]).to eq({ '--force' => false, 'PATH' => 'backup' })
    end

    context 'with --version' do
      it 'raises ExitWithUsage with the version and exit code 0' do
        expect { subject.run docopt, version: '1.2.3', argv: %w[--version] }
          .to raise_error(ExitWithUsage) do |e|
            expect(e.message).to eq '1.2.3'
            expect(e.exit_code).to eq 0
          end
      end
    end

    context 'with --help' do
      it 'raises ExitWithUsage with the help and exit code 0' do
        expect { subject.run docopt, argv: %w[--help] }
          .to raise_error(ExitWithUsage) do |e|
            expect(e.message).to eq docopt
            expect(e.exit_code).to eq 0
          end
      end
    end

    context 'with invalid docopt' do
      let(:docopt) { 'Usage: backup [PATH --force' }

      it 'raises Runfile::SyntaxError on docopt error' do
        expect { subject.run docopt }.to raise_approval('runner/docopt-error').diff(8)
      end
    end
  end
end
