require "logstash/devutils/rake"

desc "Get jars"
task :vendor do
  version = "1.7.3"
  jar_target = 'vendor/jar-dependencies/runtime-jars'
  url = "https://download.elastic.co/elasticsearch/elasticsearch/elasticsearch-#{version}.tar.gz"

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
