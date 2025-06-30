# frozen_string_literal: true

require_relative "component/version"

module Svg
  module Component
    class Error < StandardError; end

    # Render an SVG file with optional HTML attributes
    #
    # @param [String] path - The path to the SVG file
    # @param [Hash] options - Supported options: :class, :title, :width, :height
    # @return [String] SVG content with applied attributes, or fallback comment
    def self.render(path, options = {})
      return "<!-- SVG file not found -->" unless File.exist?(path)

      svg = File.read(path)

      # Modify <svg ...> tag with new attributes
      svg.sub!(/<svg([^>]*)>/) do
        attrs = Regexp.last_match(1)

        # Remove existing class, width, height if replacements provided
        attrs = attrs.gsub(/\sclass="[^"]*"/, "") if options[:class]
        attrs = attrs.gsub(/\swidth="[^"]*"/, "") if options[:width]
        attrs = attrs.gsub(/\sheight="[^"]*"/, "") if options[:height]

        # Build new attributes
        new_attrs = []
        new_attrs << "class=\"#{options[:class]}\"" if options[:class]
        new_attrs << "width=\"#{options[:width]}\"" if options[:width]
        new_attrs << "height=\"#{options[:height]}\"" if options[:height]

        "<svg#{attrs} #{' ' unless attrs.strip.empty?}#{new_attrs.join(' ')}>"
      end

      # Insert <title> tag if provided
      if options[:title]
        svg.sub!(">", "><title>#{options[:title]}</title>")
      end

      svg
    end
  end
end
