describe Entrypoint do
  subject { described_class.new argv }

  let(:argv) { %w[hello world] }

  describe '#inspect' do
    it 'is inspectable' do
      expect(subject.inspect).to eq '#<Runfile::Entrypoint argv=["hello", "world"]>'
    end
  end

  describe '#run!' do
    it 'calls #run' do
      expect(subject).to receive(:run)
      subject.run!
    end

    it 'exits gracefully on Runfile::ExitWithUsage' do
      allow(subject).to receive(:run).and_raise(Runfile::ExitWithUsage, 'usage text')
      expect { subject.run! }.to output(/usage text/).to_stdout
    end

    it 'exits gracefully on Runfile::UserError' do
      allow(subject).to receive(:run).and_raise(Runfile::UserError, 'some user error')
      expect { subject.run! }.to output(/some user error/).to_stderr
    end

    it 'exits gracefully on Interrupt' do
      allow(subject).to receive(:run).and_raise(Interrupt)
      expect { subject.run! }.to output(/Goodbye/).to_stderr
    end

    it 'exits gracefully on all other errors' do
      allow(subject).to receive(:run).and_raise(StandardError, 'some error')
      expect { subject.run! }.to output(/some error/).to_stderr
    end
  end
end
