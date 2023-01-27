describe Action do
  subject do
    result = described_class.new
    result.name = 'start'
    result
  end

  describe '#inspect' do
    it 'is inspectable' do
      expect(subject.inspect).to match_approval('action/inspect')
    end
  end
end
