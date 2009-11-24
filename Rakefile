require 'rake'
require 'spec/rake/spectask'
require 'rake/rdoctask'

desc "Run all examples with RCov"
Spec::Rake::SpecTask.new('rcov') do |t|
  t.spec_files = FileList['spec/**/*.rb']
  t.rcov = true
  t.rcov_opts = ['--exclude', 'spec,/Library/Ruby/*,/usr/lib/ruby/*' ]
end

Rake::RDocTask.new do |rdoc|
      files = ['README',
               'lib/**/*.rb', 'doc/**/*.rdoc', 'spec/**/*.rb']
      rdoc.rdoc_files.add(files)
      rdoc.main = 'README'
      rdoc.title = 'WordPairs RDoc'
      rdoc.rdoc_dir = 'doc'
      rdoc.options << '--line-numbers' << '--inline-source'
end