require_relative "../../../../spec/es_spec_helper"
require "logstash/outputs/elasticsearch_java/protocol"

describe "elasticsearch node client", :integration => true do
  # Test ElasticSearch Node Client
  # Reference: http://www.elasticsearch.org/guide/reference/modules/discovery/zen/
  
  subject { LogStash::Outputs::ElasticSearchJavaPlugins::Protocols::NodeClient }


end
