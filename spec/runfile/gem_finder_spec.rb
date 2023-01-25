describe GemFinder do
  subject { described_class }

  let(:gemname) { 'sample_import_gem' }
  let(:file) { 'docker.runfile' }

  describe '::find' do
    it 'returns the path to the gem' do
      expect(subject.find gemname).to end_with 'spec/fixtures/sample_import_gem'
    end

    context 'with file argument' do
      it 'returns the path to the file' do
        expect(subject.find gemname, file).to end_with 'spec/fixtures/sample_import_gem/docker.runfile'
      end
    end

    context 'with invalid gem' do
      let(:gemname) { 'no-such-gem-hopefully' }

      it 'raises an error' do
        expect { subject.find gemname }.to raise_approval('gem_finder/invalid-gem').diff(4)
      end
    end

    context 'when there is no bundler' do
      before { allow(subject).to receive(:bundler?).and_return false }

      it 'returns the path to the gem' do
        expect(subject.find gemname).to end_with 'spec/fixtures/sample_import_gem'
      end
    end
  end
end
