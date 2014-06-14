# traceur-rails

```bash
gem install traceur-rails
```

[Here on rubygems.org](https://rubygems.org/gems/traceur-rails)

## Requirements

Requires [`node`](http://nodejs.org) to be installed.

## Usage

Despite being named `traceur-rails` this gem can be used with any project that uses [`sprockets`](https://github.com/sstephenson/sprockets). Use `.tc` as the extension for any file that would normally use a `.js` extension and the file will be compiled with `traceur`.

## traceur modules

Tracuer offers a `modules` configuration option. Generally this will be set in an initializer. This allows you to specify how modules should be compiled. The options are available in the [traceur-compiler wiki](https://github.com/google/traceur-compiler/wiki/Options-for-Compiling)

```ruby
Traceur::Config.compile_to :amd
```

## Author

| [![twitter/_aaronackerman_](http://gravatar.com/avatar/c73ff9c7e654647b2b339d9e08b52143?s=70)](http://twitter.com/_aaronackerman_ "Follow @_aaronackerman_ on Twitter") |
|---|
| [Aaron Ackerman](https://twitter.com/_aaronackerman_) |

