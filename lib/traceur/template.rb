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

    def generate_source(scope)
      <<-SOURCE
        var traceur = require("#{traceur_path}");
        var result  = traceur.compile(#{::JSON.generate(data, quirks_mode: true)}, {
          filename: '#{module_name(scope.root_path, scope.logical_path)}',
          modules:  '#{Traceur::Config.compile_to}'
        });

        if (result.errors && result.errors.length) {
          throw "\\n" + result.errors.join("\\n");
        }

        return result.js;
      SOURCE
    end

    def module_name(root_path, logical_path)
      if prefix = Traceur::Config.lookup_prefix(File.join(root_path, logical_path))
        File.join(prefix, logical_path)
      else
        logical_path
      end
    end

    def traceur_path
      File.expand_path('../support/traceur/src/node/api.js', __FILE__)
    end
  end
end
