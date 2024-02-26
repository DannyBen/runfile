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
      it 'shows the list of examples' do
        Dir.chdir 'spec/tmp' do
          expect { subject.run %w[example] }.to output_approval('initiator/examples')
        end
      end
    end

    context 'with "example EXAMPLE"' do
      before do
        Dir['spec/tmp/**/{runfile,*.runfile,*.rb}'].each { |f| FileUtils.rm f }
      end

      it 'copies the example files to the current directory' do
        Dir.chdir 'spec/tmp' do
          expect { subject.run %w[example import] }.to output_approval('initiator/example-import')
          actual = Dir['**/*'].select { |f| File.file? f }.sort
          expected = Dir.chdir('../../examples/import') { Dir['**/*'] }.select { |f| File.file? f }.sort
          expect(actual).to eq expected
        end
      end

      context 'when one of the files already exists' do
        before do
          FileUtils.mkdir_p 'spec/tmp/tasks'
          File.write 'spec/tmp/tasks/server.runfile', 'original content'
        end

        it 'does not overwrite it' do
          Dir.chdir 'spec/tmp' do
            expect { subject.run %w[example import] }.to output_approval('initiator/example-import-skip')
            expect(File.read 'tasks/server.runfile').to eq 'original content'
          end
        end
      end
    end

    context 'with "example invalid-example"' do
      it 'raises an error' do
        Dir.chdir 'spec/tmp' do
          expect { subject.run %w[example invalid-example] }
            .to raise_approval('initiator/example-invalid')
            .diff(4)
        end
      end
    end
  end
end
