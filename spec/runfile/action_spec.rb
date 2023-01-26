describe Action do
  describe '#inspect' do
    it 'is inspectable' do
      expect(subject.inspect).to match_approval('action/inspect')
    end
  end
end
