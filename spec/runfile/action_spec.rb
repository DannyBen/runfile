describe Action do
  describe '#inspect' do
    it 'is inspectable' do
      expect(subject.inspect).to eq '#<Runfile::Action name=nil, prefix=nil, shortcut=nil>'
    end
  end
end
