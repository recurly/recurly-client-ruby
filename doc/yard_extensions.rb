class DefineAttributeMethodsHandler < YARD::Handlers::Ruby::AttributeHandler
  handles method_call(:define_attribute_methods)
  namespace_only

  def process
    statement.parameters.first.traverse { |child|
      next unless child.type == :tstring_content
      name = child.source.strip
      object = YARD::CodeObjects::MethodObject.new namespace, name
      namespace.attributes[:instance][name] = {
        :read => object, :write => object 
      }
    }
  end
end
