require "ali_mail/version"
require "ali_mail/configuration"
require "ali_mail/sign"
require 'securerandom'
require 'net/http'

module AliMail
  class ConfigError < StandardError; end

  class << self
    attr_writer :configuration

    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield(configuration)
    end

    # from:string 管理控制台中配置的发信地址。
    # to:array 收件人地址数组
    # subject:string 邮件主题
    # text_body:string 邮件纯文本格式正文 
    # options:hash 自定义或覆盖其它默认参数, key包含公共参数和ACTION参数, 如: 
    ## ClickTrace:[0|1] 是否开启邮件追踪, 0:关闭,
    ## FromAlias:string 发件人昵称, 
    ## TagName:tring 标签, 
    ## ReplyToAddress:bool, 使用管理控制台中配置的回信地址（状态必须是验证通过）。
    ## AddressType:[0|1] 发信地址类型
    ## 例如：{ 'FromAlias' => 'Stephen' } 
    # 阿里云文档地址：https://help.aliyun.com/document_detail/29444.html
    def send_text(from:, to:, subject:, text_body:, options: {})
      params = build_single_send_params(
        from: from,
        to: to,
        subject: subject,
        options: options.merge({ 'TextBody' => text_body })
      )

      send_single(params)
    end

    # from:string 管理控制台中配置的发信地址。
    # to:array 收件人地址数组
    # subject:string 邮件主题
    # html_body:string 邮件html格式正文 
    # options:hash 自定义或覆盖其它默认参数, key包含公共参数和ACTION参数, 如: 
    ## ClickTrace:[0|1] 是否开启邮件追踪, 0:关闭,
    ## FromAlias:string 发件人昵称, 
    ## TagName:tring 标签, 
    ## ReplyToAddress:bool, 使用管理控制台中配置的回信地址（状态必须是验证通过）。
    ## AddressType:[0|1] 发信地址类型
    ## 例如：{ 'FromAlias' => 'Stephen' } 
    # 阿里云文档地址：https://help.aliyun.com/document_detail/29444.html
    def send_html(from:, to:, subject:, html_body:, options:)
      params = build_single_send_params(
        from: from,
        to: to,
        subject: subject,
        options: options.merge({ 'HtmlBody' => html_body })
      )

      send_single(params)
    end

    def send_batch
      # todo
    end

    private

    def send_single(final_params)
      url = URI.parse(configuration.url)
      res = Net::HTTP.post_form(url, final_params)
      res.body
    end

    # 公共参数，阿里云文档：https://help.aliyun.com/document_detail/29440.html
    def public_params
      raise ConfigError, 'access_key not configured' unless configuration.access_key

      {
        'Format' => configuration.format,
        'Version' => configuration.version,
        'SignatureMethod' => 'HMAC-SHA1', # 目前仅支持 HMAC-SHA1
        'SignatureVersion' => '1.0',
        'AccessKeyId' => configuration.access_key,
        'RegionId' => configuration.region_id,
        'Timestamp' => Time.now.utc.strftime('%Y-%m-%dT%H:%M:%SZ'),
        'SignatureNonce' => SecureRandom.uuid.to_s
      }
    end

    # 默认ACTION参数
    def default_action_params
      {
        'ReplyToAddress' => configuration.reply_to_address, # 使用管理控制台中配置的回信地址（状态必须是验证通过）。
        'ClickTrace' => configuration.click_trace, # 是否开启邮件追踪, 0:关闭, 1:开启
        'AddressType' => 1 # 发信地址类型, 0:随机账号，1:发信地址
      }
    end

    # 默认请求参数
    def default_params
      public_params.merge default_action_params
    end

    def build_single_send_params(from:, to:, subject:, options:)
      params = { 'Action' => 'SingleSendMail' }
      params['AccountName'] = from
      params['ToAddress'] = Array(to).join(',')
      params['Subject'] = subject

      params = default_params.merge(params).merge(options)
      AliMail::Sign.sign_params(params, 'POST')
    end

    def not_null_params

    end
  end
end
