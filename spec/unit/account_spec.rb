require 'spec_helper'

module Recurly
  describe Account do
    context "new record" do
      subject{Account.new}

      it { should respond_to(:account_code)}
      it { should respond_to(:username)}
      it { should respond_to(:first_name)}
      it { should respond_to(:last_name)}
      it { should respond_to(:email)}
      it { should respond_to(:company_name)}
      it { should respond_to(:hosted_login_token)}
      it { should respond_to(:accept_language)}
    end

  end
end