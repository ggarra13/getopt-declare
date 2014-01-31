require "rubygems"

sp = Gem::Specification.new do |s|
	s.name = "getopt-declare"
	s.version = '1.32'
	s.author = "Gonzalo Garramuno" 
	s.email = 'ggarra13@gmail.com'
	s.homepage = 'http://www.rubyforge.org/projects/getoptdeclare/'
	s.summary = 'A regex command-line parsing library.'
	s.license = 'GPL'
	s.require_path = "lib"
	s.files = 
		     ['getopt-declare.gemspec'] +
                     Dir.glob("lib/Getopt/*.rb") + 
		     Dir.glob("samples/*.rb") + Dir.glob("test/*.rb")
	s.extra_rdoc_files = ["Manifest.txt", "README.txt"] + 
				Dir.glob("docs/*/*")
	s.has_rdoc = true
	s.rubyforge_project = 'getopt-declare'
	s.required_ruby_version = '>= 1.8.0'
	s.description = <<-EOF
	A command-line parser using regular expressions.
EOF
end
