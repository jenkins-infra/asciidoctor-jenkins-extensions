#!/usr/bin/env ruby

require 'colorize'
require 'sinatra'

$LOAD_PATH.unshift(File.dirname(__FILE__) + '/lib')
require 'asciidoctor/jenkins/extensions'

class ExtensionsTestApplication < Sinatra::Base
  set :views, 'examples'

  ASSETS = <<-EOF
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
EOF

  # This template will be used by default for all the playground routes
  template :layout do
    <<-EOF
<html>
  <head>
    <title>Asciidoctor::Jenkins::Extensions Playground</title>
    #{ASSETS}
  </head>
  <body>
  <div class="container">
    <h1><%= name %>.adoc</h1>
    <nav class="navbar navbar-default">
      <div class="container-fluid">
        <ul class="nav navbar-nav">
          <% for example in examples %>
            <li>
              <a href="/<%= example %>"><%= example %>.adoc</a>
            </li>
          <% end %>
        </ul>
      </div>
    </nav>
  </div>
  <hr/>
  <div class="container-fluid">
    <div class="row">
      <div class="col-md-6">
        <%= yield %>
      </div>
      <div class="col-md-6"><code><pre><%= raw %></pre></code></div>
    </div>
  </div>
  </body>
</html>'
EOF
  end

  template :index do
    <<-EOF
<html>
  <head>
    <title>Asciidoctor::Jenkins::Extensions Playground</title>
    #{ASSETS}
  </head>
  <body>
    <div class="container">
      <h1>Asciidoctor::Jenkins::Extensions Playground</h1>
      <hr/>
      <strong>Available documents</strong>
      <ul>
        <% for example in examples %>
          <li>
            <a href="/<%= example %>"><%= example %>.adoc</a>
          </li>
        <% end %>
      </ul>
    </div>
  </body>
</html>
EOF
  end

  examples = Dir.glob("#{File.dirname(__FILE__)}/examples/*.adoc")
  example_routes = examples.collect { |e| File.basename(e).split('.').first }
  puts "Found all examples: #{examples}"

  example_routes.each_index do |index|
    route = example_routes[index]
    get "/#{route}" do
      asciidoc route.to_sym,
               layout_engine: :erb,
               locals: { name: route,
                         raw: File.read(examples[index]),
                         examples: example_routes,
               }
    end
    puts "Registered route /#{route}".green
  end

  get '/' do
    erb :index, layout: false, locals: { examples: example_routes }
  end
end

run ExtensionsTestApplication
