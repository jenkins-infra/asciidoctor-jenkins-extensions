require 'asciidoctor'
require 'asciidoctor/extensions'

#
# Usage:
# jep:201[Jenkins Configuration as Code]
#
Asciidoctor::Extensions.register do
  inline_macro do
    named :jep
    name_positional_attributes 'label'

    process do |parent, target, attrs|
      if attrs['label']
        label = %(JEP-#{target}: #{attrs['label']})
      else
        label = %(JEP-#{target})
      end
      target = %(https://github.com/jenkinsci/jep/blob/master/jep/#{target}/README.adoc)
      (create_anchor parent, label, type: :link, target: target).render
    end
  end
end
