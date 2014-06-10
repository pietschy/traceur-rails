require 'sprockets'
require 'traceur/template'

Sprockets.register_engine '.tc', Traceur::Template
