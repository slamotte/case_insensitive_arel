# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{case_insensitive_arel}
  s.version = "0.1.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Steve Lamotte"]
  s.date = %q{2011-05-19}
  s.description = %q{If you're using Oracle or another DBMS that has case-insensitive collation sequences, and you don't want to litter your database access code with case conversions, this gem is for you.}
  s.email = %q{steve@lexor.ca}
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc"
  ]
  s.files = [
    ".document",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "case_insensitive_arel.gemspec",
    "lib/case_insensitive_arel.rb",
    "test/helper.rb",
    "test/support/fake_record.rb",
    "test/test_comparisons.rb",
    "test/test_group_by.rb",
    "test/test_joins.rb",
    "test/test_projects.rb"
  ]
  s.homepage = %q{http://github.com/slamotte/case_insensitive_arel}
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Forces Arel queries to be case-insensitive}
  s.test_files = [
    "test/helper.rb",
    "test/support/fake_record.rb",
    "test/test_comparisons.rb",
    "test/test_group_by.rb",
    "test/test_joins.rb",
    "test/test_projects.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<arel>, [">= 2.0.9"])
      s.add_runtime_dependency(%q<activesupport>, [">= 3.0.0"])
      s.add_development_dependency(%q<shoulda>, [">= 0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.5.2"])
      s.add_development_dependency(%q<rcov>, [">= 0"])
      s.add_runtime_dependency(%q<arel>, [">= 2.0.9"])
      s.add_runtime_dependency(%q<activesupport>, [">= 2.0.0"])
    else
      s.add_dependency(%q<arel>, [">= 2.0.9"])
      s.add_dependency(%q<activesupport>, [">= 3.0.0"])
      s.add_dependency(%q<shoulda>, [">= 0"])
      s.add_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_dependency(%q<jeweler>, ["~> 1.5.2"])
      s.add_dependency(%q<rcov>, [">= 0"])
      s.add_dependency(%q<arel>, [">= 2.0.9"])
      s.add_dependency(%q<activesupport>, [">= 2.0.0"])
    end
  else
    s.add_dependency(%q<arel>, [">= 2.0.9"])
    s.add_dependency(%q<activesupport>, [">= 3.0.0"])
    s.add_dependency(%q<shoulda>, [">= 0"])
    s.add_dependency(%q<bundler>, ["~> 1.0.0"])
    s.add_dependency(%q<jeweler>, ["~> 1.5.2"])
    s.add_dependency(%q<rcov>, [">= 0"])
    s.add_dependency(%q<arel>, [">= 2.0.9"])
    s.add_dependency(%q<activesupport>, [">= 2.0.0"])
  end
end

