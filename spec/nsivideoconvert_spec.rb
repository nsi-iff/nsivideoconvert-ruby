require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'base64'

$folder = File.expand_path(File.dirname(__FILE__))

describe NSIVideoConvert do

  before :all do
    @nsivideoconvert = NSIVideoConvert::Client.new user: 'test', password: 'test',
                                           host: 'localhost', port: '9886'
    @fake_cloudooo = NSIVideoConvert::FakeServerManager.new.start_server
  end

  after :all do
    @fake_cloudooo.stop_server
  end

  context "cannot connect to the server" do
    it "throws error if couldn't connec to the server" do
      nsivideoconvert = NSIVideoConvert::Client.new user: 'test', password: 'test',
                                           host: 'localhost', port: '4000'
      expect { nsivideoconvert.convert(:file => 'video', :filename => "teste.flv") }.to \
             raise_error(NSIVideoConvert::Errors::Client::ConnectionRefusedError)
    end
  end

  context "simple convertion" do
    it "can send a video to be converted by a nsivideoconvert node" do
      response = @nsivideoconvert.convert(:file => 'video', :filename => 'video.ogv')
      response.should_not be_nil
      response["key"].should == "key for video video.ogv"
    end

    it "should throw error if any required parameter is missing" do
      expect { @nsivideoconvert.convert(:file => 'video') }.to raise_error(NSIVideoConvert::Errors::Client::MissingParametersError)
      expect { @nsivideoconvert.convert(:cloudooo_uid => 'video') }.to raise_error(NSIVideoConvert::Errors::Client::MissingParametersError)
      expect { @nsivideoconvert.convert(:filename => 'video') }.to raise_error(NSIVideoConvert::Errors::Client::MissingParametersError)
    end
  end

  context "convertion with download" do
    it "can download videos from a link to be convertd by a cloudooo node" do
      response = @nsivideoconvert.convert(:video_link => "http://video_link/video.ogv")
      response.should_not be_nil
      response["key"].should == "key for video video.ogv"
    end
  end

  context "convertion with callback" do
    it "can send a video to be converted by a cloudooo node and specify a callback url" do
      response = @nsivideoconvert.convert(:file => 'video', :filename => 'video.ogv', :callback => 'http://google.com')
      response.should_not be_nil
      response["key"].should == "key for video video.ogv"
      response["callback"].should == 'http://google.com'
    end

    it "can send a video to be convertd by a cloudooo node and specify the verb" do
      response = @nsivideoconvert.convert(:file => 'video', :filename => 'video.ogv', :callback => 'http://google.com', :verb => 'PUT')
      response.should_not be_nil
      response["key"].should == "key for video video.ogv"
      response["callback"].should == 'http://google.com'
      response["verb"].should == 'PUT'
    end
  end

  context "verify convertion" do
    it "can verify is a convertion is done or not" do
      key = @nsivideoconvert.convert(:file => 'video', :filename => '2secs.flv')["key"]
      @nsivideoconvert.done(key)["done"].should be_false
      @nsivideoconvert.done(key)["done"].should be_true
    end

    it "raises an error when trying to verify if non-existing key is done" do
      expect { @nsivideoconvert.done("dont")["done"].should be_false }.to raise_error(NSIVideoConvert::Errors::Client::KeyNotFoundError)
    end

    it "raises an error when the server can't connect to the queue service" do
      expect { @nsivideoconvert.convert(:file => 'video', :filename => 'queue error' ).should be_false }.to raise_error(NSIVideoConvert::Errors::Client::QueueServiceConnectionError)
    end

  end

  context "get configuration" do
    before do
      NSIVideoConvert::Client.configure do
        user     "why"
        password "chunky"
        host     "localhost"
        port     "8888"
      end
    end

    it "by configure" do
      cloudooo = NSIVideoConvert::Client.new
      cloudooo.instance_variable_get(:@user).should == "why"
      cloudooo.instance_variable_get(:@password).should == "chunky"
      cloudooo.instance_variable_get(:@host).should == "localhost"
      cloudooo.instance_variable_get(:@port).should == "8888"
    end

    it "by initialize parameters" do
      cloudooo = NSIVideoConvert::Client.new(user: 'luckystiff', password: 'bacon', host: 'why.com', port: '9999')
      cloudooo.instance_variable_get(:@user).should == "luckystiff"
      cloudooo.instance_variable_get(:@password).should == "bacon"
      cloudooo.instance_variable_get(:@host).should == "why.com"
      cloudooo.instance_variable_get(:@port).should == "9999"
    end
  end

end

