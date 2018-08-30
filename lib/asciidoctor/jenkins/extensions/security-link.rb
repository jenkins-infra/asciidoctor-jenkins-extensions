require 'asciidoctor'
require 'asciidoctor/extensions'

#
# Usage:
# security:12345[Issue description]
#
Asciidoctor::Extensions.register do
  inline_macro do
    named :security
    name_positional_attributes 'label', 'date'

    process do |parent, target, attrs|
      if target.include? "-"
        issueId = target
      else
        issueId = %(SECURITY-#{target})
      end

      if attrs['label']
        label = %(#{issueId}: #{attrs['label']})
      else
        label = issueId
      end

    if attrs['date']
        target = %(https://jenkins.io/security/advisory/#{attrs['date']}/##{issueId})
    else
        # TODO(oleg_nenashev): Change to a security issue redirect service if it gets created
        target = %(https://jenkins.io/security/advisories/)
    end

      (create_anchor parent, label, type: :link, target: target).render
    end
  end
end
