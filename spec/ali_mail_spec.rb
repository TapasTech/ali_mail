RSpec.describe AliMail do
  it "has a version number" do
    expect(AliMail::VERSION).not_to be nil
  end

  # 来自官方文档签名示例: https://help.aliyun.com/document_detail/29442.html
  # 注意：示例中的StringToSign是不对的，其中含有没有被转码的&符号, 而最终的签名结果是正确的。
  let(:params) do
    {
      "AccessKeyId" => "testid",
      "AccountName" => "<a%b'>",
      "Action" => "SingleSendMail",
      "AddressType" => 1,
      "Format" => "XML",
      "HtmlBody" => 4,
      "RegionId" => "cn-hangzhou",
      "ReplyToAddress" => true,
      "SignatureMethod" => "HMAC-SHA1",
      "SignatureNonce" => "c1b2c332-4cfb-4a0f-b8cc-ebe622aa0a5c",
      "SignatureVersion" => "1.0",
      "Subject" => 3,
      "TagName" => 2,
      "Timestamp" => "2016-10-20T06:27:56Z",
      "ToAddress" => "1@test.com",
      "Version" => "2015-11-23"
    }
  end

  it "Can sign params correctly" do
    AliMail.configure do |config|
      config.access_secret = 'testsecret'
    end

    expect(AliMail::Sign.sign_params(params)['Signature']).to eq 'llJfXJjBW3OacrVgxxsITgYaYm0='
  end
end
