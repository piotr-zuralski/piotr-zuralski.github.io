# _plugins/highlight.rb
require "date"
require "jekyll"
require "jekyll/generator"

module MyJekyllPlugins
    # module Generators
        class Generator < Jekyll::Generator

            def generate(site)
                thisDate = Date.today
                
                # site = @context.registers[:site]

                site["currentYear"] = thisDate.strftime("%Y")
                site["experience"] = (site.currentYear-2007)
            end
        end
    # end
end
  