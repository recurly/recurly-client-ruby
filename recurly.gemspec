# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{recurly}
  s.version = "0.1.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Isaac Hall"]
  s.date = %q{2010-09-14}
  s.description = %q{A Ruby API wrapper for Recurly. Super Simple Subscription billing.}
  s.email = %q{support@recurly.com}
  s.extra_rdoc_files = ["LICENSE", "README.md", "lib/recurly.rb", "lib/recurly/account.rb", "lib/recurly/base.rb", "lib/recurly/billing_info.rb", "lib/recurly/charge.rb", "lib/recurly/credit.rb", "lib/recurly/invoice.rb", "lib/recurly/plan.rb", "lib/recurly/subscription.rb", "lib/recurly/transaction.rb"]
  s.files = ["LICENSE", "README.md", "Rakefile", "init.rb", "lib/recurly.rb", "lib/recurly/account.rb", "lib/recurly/base.rb", "lib/recurly/billing_info.rb", "lib/recurly/charge.rb", "lib/recurly/credit.rb", "lib/recurly/invoice.rb", "lib/recurly/plan.rb", "lib/recurly/subscription.rb", "lib/recurly/transaction.rb", "test/account_test.rb", "test/billing_info_test.rb", "test/charge_test.rb", "test/credit_test.rb", "test/plan_test.rb", "test/subscription_test.rb", "test/test_helper.rb", "test/transaction_test.rb", "Manifest", "recurly.gemspec"]
  s.homepage = %q{http://github.com/recurly/recurly-client-ruby}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Recurly", "--main", "README.md"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{recurly}
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{A Ruby API wrapper for Recurly. Super Simple Subscription billing.}
  s.test_files = ["test/account_test.rb", "test/billing_info_test.rb", "test/charge_test.rb", "test/credit_test.rb", "test/plan_test.rb", "test/subscription_test.rb", "test/test_helper.rb", "test/transaction_test.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
