# -*- encoding: utf-8 -*-
# stub: will_paginate-materialize 0.1.2 ruby lib

Gem::Specification.new do |s|
  s.name = "will_paginate-materialize".freeze
  s.version = "0.1.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Patrick Lindsay".freeze]
  s.bindir = "exe".freeze
  s.date = "2015-10-02"
  s.description = "This gem integrates the MaterializeCSS pagination component with the will_paginate pagination gem.".freeze
  s.email = ["patrick.lindsay@sage.com".freeze]
  s.homepage = "https://github.com/patricklindsay/will_paginate-materialize".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.6.12".freeze
  s.summary = "MaterializeCSS pagination renderer for the will_paginate pagination gem.".freeze

  s.installed_by_version = "2.6.12" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>.freeze, ["~> 1.10"])
      s.add_development_dependency(%q<rake>.freeze, ["~> 10.0"])
      s.add_development_dependency(%q<rspec>.freeze, [">= 0"])
      s.add_runtime_dependency(%q<will_paginate>.freeze, ["~> 3.0.6"])
    else
      s.add_dependency(%q<bundler>.freeze, ["~> 1.10"])
      s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
      s.add_dependency(%q<rspec>.freeze, [">= 0"])
      s.add_dependency(%q<will_paginate>.freeze, ["~> 3.0.6"])
    end
  else
    s.add_dependency(%q<bundler>.freeze, ["~> 1.10"])
    s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
    s.add_dependency(%q<rspec>.freeze, [">= 0"])
    s.add_dependency(%q<will_paginate>.freeze, ["~> 3.0.6"])
  end
end
