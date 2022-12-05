describe Initiator do
  describe '#inspect' do
    it 'is inspectable' do
      expect(subject.inspect).to eq '#<Runfile::Initiator>'
    end
  end

  describe '#run' do
    before { FileUtils.rm_f 'spec/tmp/runfile' }

    context 'with "new"' do
      it 'creates a runfile' do
        Dir.chdir 'spec/tmp' do
          expect { subject.run %w[new] }.to output_approval('initiator/new')
          expect(File).to exist 'runfile'
          expect(File.read 'runfile').to eq File.read('../../lib/runfile/templates/runfile')
        end
      end
    end

    context 'with "example"' do
      it 'shows the lsit of examples' do
        Dir.chdir 'spec/tmp' do
          expect { subject.run %w[example] }.to output_approval('initiator/examples')
        end
      end
    end

    context 'with "example minimal"' do
      it 'copies the example file(s) to the current directory' do
        Dir.chdir 'spec/tmp' do
          expect { subject.run %w[example minimal] }.to output_approval('initiator/example-minimal')
          expect(File).to exist 'runfile'
          expect(File.read 'runfile').to eq File.read('../../examples/minimal/runfile')
        end
      end
    end

    context 'with "example invalid-example"' do
      it 'raises an error' do
        Dir.chdir 'spec/tmp' do
          expect { subject.run %w[example invalid-example] }.to raise_approval('initiator/example-invalid')
        end
      end
    end
  end
end
