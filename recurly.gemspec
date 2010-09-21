# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{recurly}
  s.version = "0.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Isaac Hall"]
  s.date = %q{2010-09-21}
  s.description = %q{A Ruby API wrapper for Recurly. Super Simple Subscription billing.}
  s.email = %q{support@recurly.com}
  s.extra_rdoc_files = ["LICENSE", "README.md", "lib/recurly.rb", "lib/recurly/account.rb", "lib/recurly/base.rb", "lib/recurly/billing_info.rb", "lib/recurly/charge.rb", "lib/recurly/credit.rb", "lib/recurly/formats/xml_with_pagination.rb", "lib/recurly/invoice.rb", "lib/recurly/plan.rb", "lib/recurly/subscription.rb", "lib/recurly/transaction.rb"]
  s.files = ["Gemfile", "Gemfile.lock", "LICENSE", "README.md", "Rakefile", "init.rb", "lib/recurly.rb", "lib/recurly/account.rb", "lib/recurly/base.rb", "lib/recurly/billing_info.rb", "lib/recurly/charge.rb", "lib/recurly/credit.rb", "lib/recurly/formats/xml_with_pagination.rb", "lib/recurly/invoice.rb", "lib/recurly/plan.rb", "lib/recurly/subscription.rb", "lib/recurly/transaction.rb", "recurly.gemspec", "spec/integration/account_spec.rb", "spec/integration/billing_info_spec.rb", "spec/integration/charge_spec.rb", "spec/integration/credit_spec.rb", "spec/integration/invoice_spec.rb", "spec/integration/plan_spec.rb", "spec/integration/subscription_spec.rb", "spec/integration/transaction_spec.rb", "spec/spec_helper.rb", "spec/spec_settings.yml.example", "spec/support/factory.rb", "spec/support/spec_settings.rb", "spec/support/vcr.rb", "spec/vcr/account/close/1284948142.yml", "spec/vcr/account/close/1285055128.yml", "spec/vcr/account/close/1285055170.yml", "spec/vcr/account/create/1284948142.yml", "spec/vcr/account/create/1285055128.yml", "spec/vcr/account/create/1285055170.yml", "spec/vcr/account/find/1284948142.yml", "spec/vcr/account/find/1285055128.yml", "spec/vcr/account/find/1285055170.yml", "spec/vcr/account/update/1284948142.yml", "spec/vcr/account/update/1285055128.yml", "spec/vcr/account/update/1285055170.yml", "spec/vcr/billing/create/1284893017.yml", "spec/vcr/billing/create/1285055140.yml", "spec/vcr/billing/find/1284893017.yml", "spec/vcr/billing/find/1285055140.yml", "spec/vcr/charge/create/1284948450.yml", "spec/vcr/charge/create/1284948499.yml", "spec/vcr/charge/create/1285055145.yml", "spec/vcr/charge/list/1284948450.yml", "spec/vcr/charge/list/1284948499.yml", "spec/vcr/charge/list/1285055145.yml", "spec/vcr/charge/lookup/1284948450.yml", "spec/vcr/charge/lookup/1284948499.yml", "spec/vcr/charge/lookup/1285055145.yml", "spec/vcr/credit/create/1284948450.yml", "spec/vcr/credit/create/1284948503.yml", "spec/vcr/credit/create/1285055149.yml", "spec/vcr/credit/list/1284948450.yml", "spec/vcr/credit/list/1284948503.yml", "spec/vcr/credit/list/1285055149.yml", "spec/vcr/credit/lookup/1284948450.yml", "spec/vcr/credit/lookup/1284948503.yml", "spec/vcr/credit/lookup/1285055149.yml", "spec/vcr/invoice/create/1284948067.yml", "spec/vcr/invoice/create/1284948107.yml", "spec/vcr/invoice/create/1284948329.yml", "spec/vcr/invoice/create/1284948506.yml", "spec/vcr/invoice/create/1285055152.yml", "spec/vcr/invoice/list/1284948067.yml", "spec/vcr/invoice/list/1284948107.yml", "spec/vcr/invoice/list/1284948329.yml", "spec/vcr/invoice/list/1284948506.yml", "spec/vcr/invoice/list/1285055152.yml", "spec/vcr/invoice/lookup/1284948092.yml", "spec/vcr/invoice/lookup/1284948107.yml", "spec/vcr/invoice/lookup/1284948329.yml", "spec/vcr/invoice/lookup/1284948506.yml", "spec/vcr/invoice/lookup/1285055152.yml", "spec/vcr/plan/all.yml", "spec/vcr/plan/find.yml", "spec/vcr/plan/update.yml", "spec/vcr/subscription/cancel/1284892691.yml", "spec/vcr/subscription/cancel/1285055160.yml", "spec/vcr/subscription/create/1284892691.yml", "spec/vcr/subscription/create/1285055160.yml", "spec/vcr/subscription/refund/1284892691.yml", "spec/vcr/subscription/refund/1285055160.yml", "spec/vcr/subscription/update/1284892691.yml", "spec/vcr/subscription/update/1285055160.yml", "spec/vcr/transaction/all/1284948509.yml", "spec/vcr/transaction/all/1285055166.yml", "spec/vcr/transaction/create-no-account/1284948509.yml", "spec/vcr/transaction/create-no-account/1285055166.yml", "spec/vcr/transaction/create-with-account/1284948509.yml", "spec/vcr/transaction/create-with-account/1285055166.yml", "spec/vcr/transaction/list-empty/1284948509.yml", "spec/vcr/transaction/list-empty/1285055166.yml", "spec/vcr/transaction/list-filled/1284948509.yml", "spec/vcr/transaction/list-filled/1285055166.yml", "spec/vcr/transaction/lookup/1284948509.yml", "spec/vcr/transaction/lookup/1285055166.yml", "Manifest"]
  s.homepage = %q{http://github.com/recurly/recurly-client-ruby}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Recurly", "--main", "README.md"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{recurly}
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{A Ruby API wrapper for Recurly. Super Simple Subscription billing.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
