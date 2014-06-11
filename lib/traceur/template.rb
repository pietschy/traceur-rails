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
          modules: 'register'
        });

        if (result.error) {
          throw result.error;
        }

        return result.js;
      SOURCE
    end

    def module_name(root_path, logical_path)
      path = ''
      if prefix = Traceur::Config.lookup_prefix(File.join(root_path, logical_path))
        path = File.join(prefix, logical_path)
      else
        path = logical_path
      end

      if Traceur::Config.transform
        path = Traceur::Config.transform.call(path)
      end

      path
    end

    def traceur_path
      File.expand_path('../support/traceur/src/node/api.js', __FILE__)
    end
  end
end
