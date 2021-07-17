require 'spec_helper'

require 'asciidoctor'
require 'asciidoctor/jenkins/extensions'

describe 'the staplerdoc macro' do
    subject(:rendering) { Asciidoctor.render(document) }

    context 'with a simple document' do
        let(:document) {
            "staplerdoc:org.kohsuke.stapler.AncestorInPath[]"
        }

        it 'should render properly' do
            expect(rendering).to match(/https:\/\/javadoc.jenkins.io\/component\/stapler\/org\/kohsuke\/stapler\/AncestorInPath.html.+>org.kohsuke.stapler.AncestorInPath/)
        end
    end

    context 'with label' do
        let(:document) {
            "staplerdoc:org.kohsuke.stapler.AncestorInPath[a label]"
        }

        it 'should render properly' do
            expect(rendering).to match(/https:\/\/javadoc.jenkins.io\/component\/stapler\/org\/kohsuke\/stapler\/AncestorInPath.html.+>a label/)
        end
    end

    context 'with a fragment' do
        let(:document) {
            "staplerdoc:org.kohsuke.stapler.WebMethodContext#getName()[]"
        }

        it 'should render properly' do
            expect(rendering).to match(/https:\/\/javadoc.jenkins.io\/component\/stapler\/org\/kohsuke\/stapler\/WebMethodContext.html#getName--.+>org.kohsuke.stapler.WebMethodContext/)
        end
    end

    context 'with a complex fragment' do
        let(:document) {
            "staplerdoc:org.kohsuke.stapler.ReflectionUtils#union-java.lang.annotation.Annotation:A-java.lang.annotation.Annotation:A-[]"
        }

        it 'should render properly' do
            expect(rendering).to match(/https:\/\/javadoc.jenkins.io\/component\/stapler\/org\/kohsuke\/stapler\/ReflectionUtils.html#union-java.lang.annotation.Annotation:A-java.lang.annotation.Annotation:A-.+>org.kohsuke.stapler.ReflectionUtils/)
        end
    end
end
