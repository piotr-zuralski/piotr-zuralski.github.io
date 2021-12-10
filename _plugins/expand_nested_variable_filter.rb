
module ExpandNestedVariableFilter
  def flatify(input)
      # site = @context.registers[:site]
      # converter = site.find_converter_instance(Jekyll::Converters::Markdown)
      # input = Jekyll::Converters::Markdown.new(site).convert(input)
      # Liquid::Template.parse(input).render(@context)
      content = 'TestTestTest'
      content

  end
end

Liquid::Template.register_filter(ExpandNestedVariableFilter)
