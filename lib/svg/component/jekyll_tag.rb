require "liquid"
require_relative "../component"

module Jekyll
  class SvgTag < Liquid::Tag
    def initialize(tag_name, markup, tokens)
      super
      @args = parse_args(markup)
    end

    def render(context)
      path = @args.delete(:path)
      puts "Looking for file at: #{path.inspect}"
      return "<!-- SVG file not found -->" unless File.exist?(path)

      Svg::Component.render(path, @args)
    end

    private

    def parse_args(markup)
      args = {}
      parts = markup.strip.split(",").map(&:strip)

      if parts[0]
        args[:path] = parts.shift.gsub(/^["']|["']$/, "")
      end

      parts.each do |pair|
        key, value = pair.split("=").map(&:strip)

        if value.downcase == "true"
          args[key.to_sym] = true
        elsif value.downcase == "false"
          args[key.to_sym] = false
        else
          args[key.to_sym] = value.gsub(/^["']|["']$/, "")
        end
      end

      args
    end
  end
end

Liquid::Template.register_tag("svg", Jekyll::SvgTag)
