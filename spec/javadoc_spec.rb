require 'spec_helper'

require 'asciidoctor'
require 'asciidoctor/jenkins/extensions'

describe 'the javadoc macro' do
    subject(:rendering) { Asciidoctor.render(document) }

    context 'with a simple document' do
        let(:document) {
            "javadoc:java.nio.file.DirectoryStream.Filter[]"
        }

        it 'should render properly' do
            expect(rendering).to match(/https:\/\/docs.oracle.com\/javase\/8\/docs\/api\/java\/nio\/file\/DirectoryStream.Filter.html.+>java.nio.file.DirectoryStream.Filter/)
        end
    end

    context 'with label' do
        let(:document) {
            "javadoc:java.io.File[file]"
        }

        it 'should render properly' do
            expect(rendering).to match(/https:\/\/docs.oracle.com\/javase\/8\/docs\/api\/java\/io\/File.html.+>file/)
        end
    end

    context 'with a fragment' do
        let(:document) {
            "javadoc:java.io.File#pathSeparator[]"
        }

        it 'should render properly' do
            expect(rendering).to match(/https:\/\/docs.oracle.com\/javase\/8\/docs\/api\/java\/io\/File.html#pathSeparator.+>java.io.File/)
        end
    end
end