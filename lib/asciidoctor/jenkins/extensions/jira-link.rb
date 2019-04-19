require 'asciidoctor'
require 'asciidoctor/extensions'

#
# Usage:
# jira:JENKINS-12345[Issue description]
#
Asciidoctor::Extensions.register do
  inline_macro do
    named :jira
    name_positional_attributes 'label'

    process do |parent, target, attrs|
      if target.include? "-"
        issueId = target
      else
        issueId = %(JENKINS-#{target})
      end

      if attrs['label']
        label = %(#{issueId}: #{attrs['label']})
      else
        label = issueId
      end

      target = %(https://issues.jenkins-ci.org/browse/#{issueId})
      (create_anchor parent, label, type: :link, target: target).render
    end
  end
end
