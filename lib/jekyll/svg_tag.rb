require_relative "../svg/component"

module Jekyll
  class SvgTag < Liquid::Tag
    def initialize(tag_name, markup, tokens)
      super
      @args = parse_args(markup)
    end

    def render(context)
      path = @args.delete(:path)
      return "<!-- Missing SVG path -->" unless path

      Svg::Component.render(path, @args)
    end

    private

    def parse_args(markup)
      args = {}
      parts = markup.strip.split(",").map(&:strip)
      args[:path] = parts.shift if parts[0]

      parts.each do |pair|
        key, value = pair.split("=").map(&:strip)
        args[key.to_sym] = value.gsub(/^["']|["']$/, "") if key && value
      end

      args
    end
  end
end

Liquid::Template.register_tag('svg', Jekyll::SvgTag)
