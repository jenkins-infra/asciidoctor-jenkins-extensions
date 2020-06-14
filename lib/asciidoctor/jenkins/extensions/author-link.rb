require 'asciidoctor'
require 'asciidoctor/extensions'

#
# Usage:
# author:timja[Tim Jacomb]
# author:timja[]
#
Asciidoctor::Extensions.register do
  inline_macro do
    named :author
    name_positional_attributes 'label'

    process do |parent, target, attrs|
      if attrs['label']
        label = %(#{attrs['label']})
      else
        label = %(#{target})
      end
      target = %(/blog/authors/#{target})
      (create_anchor parent, label, type: :link, target: target).render
    end
  end
end
