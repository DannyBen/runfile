describe Runner do
  subject { described_class }
  let(:docopt) { 'Usage: backup [PATH --force]' }

  describe '#run' do
    it 'returns the args' do
      expect(subject.run docopt, argv: %w[backup]).to eq({"--force"=>false, "PATH"=>"backup"})
    end

    context 'with invalid docopt' do
      let(:docopt) { 'Usage: backup [PATH --force' }

      it 'raises Runfile::SyntaxError on docopt error' do
        expect { subject.run docopt }.to raise_approval('runner/docopt-error').diff(8)
      end
    end
  end
end
