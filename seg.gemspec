Gem::Specification.new do |s|
  s.name = "seg"
  s.version = "1.1.0"
  s.summary = %{Segment matcher for paths}
  s.description = %Q{Segment matcher for paths.}
  s.authors = ["Michel Martens"]
  s.email = ["michel@soveran.com"]
  s.homepage = "https://github.com/soveran/seg"
  s.license = "MIT"

  s.files = `git ls-files`.split("\n")

  s.add_development_dependency "cutest"
end
