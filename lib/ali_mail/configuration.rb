module AliMail
  class Configuration
    attr_accessor :format, :access_key, :access_secret, :region_id,
                  :url, :version, :reply_to_address, :click_trace

    def initialize
      # default configurations
      @format = 'JSON'
      @region_id = 'cn-hangzhou'
      @url = 'https://dm.aliyuncs.com' # https://help.aliyun.com/document_detail/96856.html
      @version = '2015-11-23'
      @reply_to_address = false
      @click_trace = 1
    end
  end
end
