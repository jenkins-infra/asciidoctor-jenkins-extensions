require 'asciidoctor'
require 'asciidoctor/extensions'

#
# Usage:
#
# For core Javadoc:
#
# jenkinsdoc:SCM[]
# jenkinsdoc:SCM[some label]
# jenkinsdoc:hudson.scm.SCM[]
# jenkinsdoc:hudson.scm.SCM[some label]
# jenkinsdoc:hudson.scm.SCM#anchor[]
# jenkinsdoc:hudson.scm.SCM#anchor[some label]
#
#
# For plugin Javadoc:
#
# jenkinsdoc:git:hudson.plugins.git.GitSCM[]
# jenkinsdoc:git:hudson.plugins.git.GitSCM[some label]
# jenkinsdoc:git:hudson.plugins.git.GitSCM#anchor[]
# jenkinsdoc:git:hudson.plugins.git.GitSCM#anchor[some label]
#
#
# For component Javadoc:
#
# jenkinsdoc:component:remoting:hudson.remoting.Channel[]
# jenkinsdoc:component:remoting:hudson.remoting.Channel[some label]
# jenkinsdoc:component:remoting:hudson.remoting.Channel#anchor[]
# jenkinsdoc:component:remoting:hudson.remoting.Channel#anchor[some label]

Asciidoctor::Extensions.register do
  inline_macro do
    named :jenkinsdoc
    name_positional_attributes 'label'

    process do |parent, target, attrs|

      if target.include? ":"
        parts = target.split(':', 3)

        if parts.first == "component"
          component = parts[1]
        else
          plugin = parts.first
        end
        target = parts.last
      end
      classname = label = title = target

      package_parts = Array.new
      simpleclass_parts = Array.new

      is_package = true

      classname.split('.').each do |part|
        if is_package && /[[:lower:]]/.match(part[0])
          package_parts.push(part)
        elsif match = /(.*)#/.match(part)
          class_part = match.captures
          simpleclass_parts.push(class_part)
          is_package = false

          # escape once fragment has been found, required for complex fragments that contain a '.'
          break
        else
          is_package = false
          simpleclass_parts.push(part)
        end
      end

      package = package_parts.join('.')
      simpleclass = simpleclass_parts.join('.')

      if package.length > 0 || plugin || component
        classname = classname.gsub(/#.*/, '')
        classurl = package.gsub(/\./, '/') + '/' + simpleclass + ".html"

        classfrag = (target.include? "#") ? '#' + target.gsub(/.*#/, '').gsub(/\(\)/, '--') : ''

        if plugin
          label = (attrs.has_key? 'label') ? attrs['label'] : %(#{classname} in #{plugin})
          target = %(https://javadoc.jenkins.io/plugin/#{plugin}/#{classurl}#{classfrag})
        elsif component
          label = (attrs.has_key? 'label') ? attrs['label'] : %(#{classname} in #{component})
          target = %(https://javadoc.jenkins.io/component/#{component}/#{classurl}#{classfrag})
        else
          label = (attrs.has_key? 'label') ? attrs['label'] : classname
          target = %(https://javadoc.jenkins.io/#{classurl}#{classfrag})
        end
      else
        label = (attrs.has_key? 'label') ? attrs['label'] : classname
        target = %(https://javadoc.jenkins.io/byShortName/#{classname})
      end

      title = %(Javadoc for #{classname})

      (create_anchor parent, label, type: :link, target: target, attributes: {'title' => title}).render
    end
  end
end

Asciidoctor::Extensions.register do
  inline_macro do
    named :staplerdoc
    name_positional_attributes 'label'

    process do |parent, target, attrs|

      classname = target

      package_parts = Array.new
      simpleclass_parts = Array.new

      is_package = true

      classname.split('.').each do |part|
        match = /(.*)#/.match(part)
        if is_package && /[[:lower:]]/.match(part[0])
          package_parts.push(part)
        elsif match = /(.*)#/.match(part)
          class_part = match.captures
          simpleclass_parts.push(class_part)
          is_package = false

          # escape once fragment has been found, required for complex fragments that contain a '.'
          break
        else
          is_package = false
          simpleclass_parts.push(part)
        end
      end

      package = package_parts.join('.')
      simpleclass = simpleclass_parts.join('.')

      classname = target.gsub(/#.*/, '')
      classurl = package.gsub(/\./, '/') + '/' + simpleclass + ".html"

      classfrag = (target.include? "#") ? '#' + target.gsub(/.*#/, '').gsub(/\(\)/, '--') : ''
      label = (attrs.has_key? 'label') ? attrs['label'] : classname
      target = %(https://stapler.kohsuke.org/apidocs/#{classurl}#{classfrag})

      title = %(Javadoc for #{classname})

      (create_anchor parent, label, type: :link, target: target, attributes: {'title' => title}).render
    end
  end
end


Asciidoctor::Extensions.register do
  inline_macro do
    named :javadoc
    name_positional_attributes 'label'

    process do |parent, target, attrs|

      classname = target

      package_parts = Array.new
      simpleclass_parts = Array.new

      is_package = true

      classname.split('.').each do |part|
        if is_package && /[[:lower:]]/.match(part[0])
          package_parts.push(part)
        elsif match = /(.*)#/.match(part)
          class_part = match.captures
          simpleclass_parts.push(class_part)
          is_package = false

          # escape once fragment has been found, required for complex fragments that contain a '.'
          break
        else
          is_package = false
          simpleclass_parts.push(part)
        end
      end

      package = package_parts.join('.')
      simpleclass = simpleclass_parts.join('.')

      classname = target.gsub(/#.*/, '')
      classurl = package.gsub(/\./, '/') + '/' + simpleclass + ".html"

      classfrag = (target.include? "#") ? '#' + target.gsub(/.*#/, '').gsub(/\(\)/, '--') : ''
      label = (attrs.has_key? 'label') ? attrs['label'] : classname
      target = %(https://docs.oracle.com/javase/8/docs/api/#{classurl}#{classfrag})

      title = %(Javadoc for #{classname})

      (create_anchor parent, label, type: :link, target: target, attributes: {'title' => title}).render
    end
  end
end
