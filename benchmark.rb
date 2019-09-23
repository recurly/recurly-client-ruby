require "rubygems"
require "bundler/setup"
require "recurly"
require "benchmark"

N = 1_000

account_body = "{\"id\":\"ljvmmbjchtgs\",\"object\":\"account\",\"code\":\"9ebd49f7288@example.com\",\"parent_account_id\":null,\"bill_to\":\"self\",\"state\":\"active\",\"username\":null,\"email\":null,\"cc_emails\":null,\"preferred_locale\":null,\"first_name\":\"Benjamin\",\"last_name\":\"Du Monde\",\"company\":null,\"vat_number\":null,\"tax_exempt\":false,\"exemption_certificate\":null,\"address\":null,\"billing_info\":null,\"shipping_addresses\":[{\"object\":\"shipping_address\",\"first_name\":\"Benjamin\",\"last_name\":\"Du Monde\",\"company\":null,\"phone\":null,\"street1\":\"1 Tchoupitoulas St\",\"street2\":null,\"city\":\"New Orleans\",\"region\":\"LA\",\"postal_code\":\"70115\",\"country\":\"US\",\"nickname\":\"Home\",\"email\":null,\"vat_number\":null,\"id\":\"ljvmmbk9e1as\",\"account_id\":\"ljvmmbjchtgs\",\"created_at\":\"2019-09-19T22:45:59Z\",\"updated_at\":\"2019-09-19T22:45:59Z\"}],\"custom_fields\":[],\"hosted_login_token\":\"PSvcHow5H4HGEGKTfHXadLNoDcRaDVMK\",\"created_at\":\"2019-09-19T22:45:59Z\",\"updated_at\":\"2019-09-19T22:45:59Z\",\"deleted_at\":null}"

Benchmark.bm do |benchmark|
  benchmark.report("JSON parsing and casting\n") do
    N.times do
      _account = Recurly::JSONParser.parse(nil, account_body)
    end
  end
end
