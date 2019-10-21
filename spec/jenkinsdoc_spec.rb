require 'spec_helper'

require 'asciidoctor'
require 'asciidoctor/jenkins/extensions'

describe 'the jenkinsdoc macro' do
    subject(:rendering) { Asciidoctor.render(document) }

    context 'with a simple document' do
        let(:document) {
            "jenkinsdoc:hudson.scm.SCM[]"
        }

        it 'should render properly' do
            expect(rendering).to match(/https:\/\/javadoc.jenkins.io\/hudson\/scm\/SCM.html.+>hudson.scm.SCM/)
        end
    end

    context 'with label' do
        let(:document) {
            "jenkinsdoc:hudson.scm.SCM[a list of all known SCM implementations]"
        }

        it 'should render properly' do
            expect(rendering).to match(/https:\/\/javadoc.jenkins.io\/hudson\/scm\/SCM.html.+>a list of all known SCM implementations/)
        end
    end

    context 'with a fragment' do
        let(:document) {
            "jenkinsdoc:hudson.scm.SCM#all()[]"
        }

        it 'should render properly' do
            expect(rendering).to match(/https:\/\/javadoc.jenkins.io\/hudson\/scm\/SCM.html#all--.+>hudson.scm.SCM/)
        end
    end

    context 'with a short name' do
        let(:document) {
            "jenkinsdoc:SCM[]"
        }

        it 'should render properly' do
            expect(rendering).to match(/https:\/\/javadoc.jenkins.io\/byShortName\/SCM.+>SCM/)
        end
    end

    context 'with a plugin' do
        let(:document) {
            "jenkinsdoc:git:hudson.plugins.git.GitSCM[]"
        }
        it 'should render properly' do
            expect(rendering).to match(/https:\/\/javadoc.jenkins.io\/plugin\/git\/hudson\/plugins\/git\/GitSCM.html.+>hudson.plugins.git.GitSCM/)
        end
    end

    context 'with a plugin and a fragment' do
        let(:document) {
            "jenkinsdoc:git:hudson.plugins.git.GitSCM#getRepositories()[]"
        }
        it 'should render properly' do
            expect(rendering).to match(/https:\/\/javadoc.jenkins.io\/plugin\/git\/hudson\/plugins\/git\/GitSCM.html#getRepositories--.+>hudson.plugins.git.GitSCM/)
        end
    end

    context 'with a component' do
        let(:document) {
            "jenkinsdoc:component:remoting:hudson.remoting.Channel[]"
        }
        it 'should render properly' do
            expect(rendering).to match(/https:\/\/javadoc.jenkins.io\/component\/remoting\/hudson\/remoting\/Channel.html.+>hudson.remoting.Channel/)
        end
    end

    context 'with a component and a fragment' do
        let(:document) {
            "jenkinsdoc:component:remoting:hudson.remoting.Channel#classLoadingCount[]"
        }
        it 'should render properly' do
            expect(rendering).to match(/https:\/\/javadoc.jenkins.io\/component\/remoting\/hudson\/remoting\/Channel.html#classLoadingCount.+>hudson.remoting.Channel/)
        end
    end

end