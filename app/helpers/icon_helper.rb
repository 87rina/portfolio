module IconHelper
    def inline_svg(name, options = {})
      file_path = Rails.root.join("app/assets/icons/#{name}.svg")
      return "(icon missing)" unless File.exist?(file_path)
  
      svg = File.read(file_path)
      doc = Nokogiri::HTML::DocumentFragment.parse(svg)
      svg_tag = doc.at_css "svg"
      svg_tag["class"] = options[:class] if options[:class]
      doc.to_html.html_safe
    end
  end