require 'execjs'
require 'json'
require 'tilt'

module TraceurAssets
  class Template < ::Tilt::Template
    self.default_mime_type = 'application/javascript'

    Node = ::ExecJS::ExternalRuntime.new(
      name: 'Node.js (V8)',
      command: ['nodejs', 'node'],
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

      SOURCE
    end

    def compiler_options
      ::JSON.generate({})
    end
  end
end
