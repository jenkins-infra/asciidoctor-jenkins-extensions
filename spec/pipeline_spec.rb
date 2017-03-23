require 'spec_helper'

require 'asciidoctor'
require 'asciidoctor/jenkins/extensions'

describe 'the pipeline block' do
  subject(:rendering) { Asciidoctor.render(document) }
  # This regex will indicate that the HTML rendering contains at least the
  # proper opening of our [pipeline] block
  let(:pipeline_div) { /<div class="pipeline-block">/ }

  context 'with a simple document' do
    let(:document) {
      "Hello *World*"
    }

    it 'should render properly' do
      expect(rendering).to match(/<strong>World<\/strong>/)
    end
  end

  context 'with a one-part [pipeline] block' do
    let(:document) {
      '''
[pipeline]
----
Invalid Pipeline block
----
'''
    }

    it 'should warn to stderr' do
      expect($stderr).to receive(:puts).exactly(2).times
      expect(rendering).to match(pipeline_div)
    end
  end

  context 'with a Scripted [pipeline] block' do
    let(:document) {
      '''
[pipeline]
----
// Scripted //
node {
  echo "hello world"
}
----
'''
    }

    it 'should warn about missing declarative to stderr' do
      expect($stderr).to receive(:puts).once
      expect(rendering).to match(pipeline_div)
    end
  end

  context 'with a [pipeline] block containing both syntaxes' do
    let(:document) {
      '''
[pipeline]
----
// Scripted //
node {
  echo "hello world"
}
// Declarative //
pipeline {
  agent any
  stages { stage("Hello") { steps { echo "World" } } }
}
----
'''
    }

    it 'should not warn and render a proper block' do
      expect($stderr).to receive(:puts).never
      expect(rendering).to match(pipeline_div)
    end

    it 'should contain a Declarative Pipeline' do
      expect(rendering).to match(/Jenkinsfile \(Declarative Pipeline\)/)
    end

    it 'should contain a Scripted Pipeline' do
      expect(rendering).to match(/Jenkinsfile \(Scripted Pipeline\)/)
    end
  end
end
