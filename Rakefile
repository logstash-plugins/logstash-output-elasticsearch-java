require "logstash/devutils/rake"

desc "Get jars"
task :vendor do
  version = "2.0.0-beta2"
  jar_target = 'vendor/jar-dependencies/runtime-jars'
  url = "https://download.elasticsearch.org/elasticsearch/release/org/elasticsearch/distribution/tar/elasticsearch/#{version}/elasticsearch-#{version}.tar.gz"

  puts "Will get jars for version #{version}"
  puts "Removing current jars"
  `rm -rf #{jar_target}`
  `mkdir -p #{jar_target}`
  Dir.chdir jar_target

  puts "Will download #{url}"
  `curl #{url} -o elasticsearch.tar.gz`
  puts "Untarring"
  `tar -xzf elasticsearch.tar.gz `
  puts "Deleting original download"
  `rm -rf elasticsearch.tar.gz`


  puts "Relocating Jars"
  `mv elasticsearch-#{version}/lib/*.jar ./`

  puts "Cleaning up"
  `rm -rf elasticsearch-#{version}/`
end
