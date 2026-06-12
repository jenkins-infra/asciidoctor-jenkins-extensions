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
        if target.start_with?("JENKINS-")
          issueNumber = target.split('-', 2).last
        else
          # WEBSITE-662 and similar need the full string as issue number
          issueNumber = target
        end
      else
        issueId = %(JENKINS-#{target})
        issueNumber = target
      end

      if attrs['label']
        label = %(#{issueId}: #{attrs['label']})
      else
        label = issueId
      end

      target = %(https://issue-redirect.jenkins.io/issue/#{issueNumber})
      (create_anchor parent, label, type: :link, target: target).render
    end
  end
end
