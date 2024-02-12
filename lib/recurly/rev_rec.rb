module Recurly
  module RevRec
    POB_ATTRIBUTE = %i(performance_obligation_id).freeze
    POB_NATIVE_ATTRIBUTE = %i(performance_obligation_identifier).freeze

    GLA_ID_ATTRIBUTES = %i(liability_gl_account_id revenue_gl_account_id).freeze
    GLA_CODE_ATTRIBUTES = %i(liability_gl_account_code revenue_gl_account_code).freeze

    PRODUCT_NATIVE_ATTRS = (POB_NATIVE_ATTRIBUTE + GLA_ID_ATTRIBUTES).freeze
    PRODUCT_ATTRIBUTES = (POB_ATTRIBUTE + GLA_ID_ATTRIBUTES).freeze

    LINE_ITEM_ATTRIBUTES = (POB_ATTRIBUTE + GLA_CODE_ATTRIBUTES).freeze
    ALL_ATTRIBUTES = (PRODUCT_ATTRIBUTES + LINE_ITEM_ATTRIBUTES).uniq.freeze

    SETUP_FEE_ATTRIBUTES = PRODUCT_ATTRIBUTES.map { |key| :"setup_fee_#{key}" }.freeze
    PLAN_ATTRIBUTES = [*PRODUCT_ATTRIBUTES, *SETUP_FEE_ATTRIBUTES].freeze
  end
end