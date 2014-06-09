require 'execjs'
require 'json'
require 'tilt'

module Traceur
  class Template < ::Tilt::Template
    self.default_mime_type = 'application/javascript'

    Node = ::ExecJS::ExternalRuntime.new(
      name: 'Node.js (V8)',
      command: ['nodejs', 'node'],
      runner_path: File.expand_path('../support/runner.js', __FILE__),
      encoding: 'UTF-8'
    )

    def prepare
      # required
    end

    def evaluate(scope, locals, &block)
      @output ||= Node.exec(generate_source(scope))
    end

    private

    def transpiler_path
      File.expand_path('../bin/traceur.js', __FILE__)
    end

    def generate_source(scope)
      <<-SOURCE
        var traceur = require(#{traceur_path});
        var fs = require('fs');
        return '';
      SOURCE
    end

    def traceur_path
      File.expand_path('../bin/traceur.js', __FILE__)
    end
  end
end
