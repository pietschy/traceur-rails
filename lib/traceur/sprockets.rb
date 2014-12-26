require 'sprockets'
require 'traceur/template'

Sprockets.register_engine '.tc', Traceur::Template
Sprockets.register_engine '.es6', Traceur::Template
