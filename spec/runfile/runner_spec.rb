describe Runner do
  subject { described_class }

  let(:docopt) do
    <<~DOCOPT
      Usage:
        backup [PATH --force#{'  '}
    DOCOPT
  end

  describe '#run' do
    it 'raises Runfile::SyntaxError on docopt error' do
      expect { subject.run docopt }.to raise_approval('runner/docopt-error')
        .diff(8)
    end
  end
end
