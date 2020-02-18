require 'erb'
require 'base64'
require 'openssl'
module AliMail
  class Sign
    def self.sign_params(params, method='POST')
      query_string = params.sort.map { |k, v| [escape(k), escape(v)].join('=') }.join('&')
      string_to_sign = method + '&' + escape('/') + '&' + escape(query_string)
      access_secret = AliMail.configuration.access_secret
      raise ConfigError, 'access_secret not configured' unless access_secret

      signature = Base64.strict_encode64(OpenSSL::HMAC.digest('sha1', access_secret + '&', string_to_sign))
      params.merge({'Signature' => signature})
    end

    def self.escape(str)
      ERB::Util.url_encode(str.to_s)
    end
  end
end
