require_relative "../../../spec/es_spec_helper"

describe "outputs/elasticsearch_java" do
  context "registration" do
    it "should register" do
      output = LogStash::Plugin.lookup("output", "elasticsearch_java").new("embedded" => "false", "protocol" => "transport", "manage_template" => "false")
      # register will try to load jars and raise if it cannot find jars
      expect {output.register}.to_not raise_error
    end
  end

  describe "transport protocol" do
    context "host not configured" do
      subject do
        require "logstash/outputs/elasticsearch_java"
        settings = {
          "protocol" => "transport",
          "node_name" => "mynode"
        }
        next LogStash::Outputs::ElasticSearchJava.new(settings)
      end

      it "should set host to localhost" do
        expect(LogStash::Outputs::Elasticsearch::Protocols::TransportClient).to receive(:new).with({
          :host => "localhost",
          :port => "9300-9305",
          :protocol => "transport",
          :client_settings => {
            "client.transport.sniff" => false,
            "node.name" => "mynode"
          }
        })
        subject.register
      end
    end

    context "sniffing => true" do
      subject do
        require "logstash/outputs/elasticsearch_java"
        settings = {
          "host" => "node01",
          "protocol" => "transport",
          "sniffing" => true
        }
        next LogStash::Outputs::ElasticSearchJava.new(settings)
      end

      it "should set the sniffing property to true" do
        expect_any_instance_of(LogStash::Outputs::Elasticsearch::Protocols::TransportClient).to receive(:client).and_return(nil)
        subject.register
        client = subject.instance_eval("@current_client")
        settings = client.instance_eval("@settings")

        expect(settings.build.getAsMap["client.transport.sniff"]).to eq("true")
      end
    end

    context "sniffing => false" do
      subject do
        require "logstash/outputs/elasticsearch_java"
        settings = {
          "host" => "node01",
          "protocol" => "transport",
          "sniffing" => false
        }
        next LogStash::Outputs::ElasticSearchJava.new(settings)
      end

      it "should set the sniffing property to true" do
        expect_any_instance_of(LogStash::Outputs::Elasticsearch::Protocols::TransportClient).to receive(:client).and_return(nil)
        subject.register
        client = subject.instance_eval("@current_client")
        settings = client.instance_eval("@settings")

        expect(settings.build.getAsMap["client.transport.sniff"]).to eq("false")
      end
    end
  end
end
