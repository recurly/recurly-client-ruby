module ActiveResource
  class Base

    # Patch for Rails 3.0 and below (fixed in 3.1) to properly
    # resolve resources inside nested modules, allowing for
    # ActiveRecord models and other classes with the same names
    # as Recurly's nested resources (CreditCard, etc)
    #
    #   This issue was unintentially fixed in Rails 3.1 by this commit:
    #     https://github.com/rails/rails/commit/a962bfe47232200c20dce02047201247d24d77f7
    def find_or_create_resource_for(name)
      resource_name = name.to_s.camelize
      
      const_args = RUBY_VERSION < "1.9" ? [resource_name] : [resource_name, false]
      if self.class.const_defined?(*const_args)
        self.class.const_get(*const_args)
      else
        ancestors = self.class.name.split("::")
        if ancestors.size > 1
          find_resource_in_modules(resource_name, ancestors)
        elsif Object.const_defined?(*const_args)
          Object.const_get(*const_args)
        else
          raise NameError
        end
      end
    rescue NameError
      resource = self.class.const_set(resource_name, Class.new(ActiveResource::Base))
      resource.prefix = self.class.prefix
      resource.site   = self.class.site
      resource
    end

  end
end