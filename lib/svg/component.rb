# frozen_string_literal: true

require_relative "component/version"

module Svg
  module Component
    class Error < StandardError; end

    # Render an SVG file with optional HTML attributes
    #
    # @param [String] path - The path to the SVG file
    # @param [Hash] options - Optional HTML attributes (e.g., :class, :title)
    # @return [String] Rendered SVG content or a fallback comment
    def self.render(path, options = {})
      return "<!-- SVG file not found -->" unless File.exist?(path)

      svg = File.read(path)

      # Add class attribute if provided
      if options[:class]
        svg.sub!("<svg", "<svg class=\"#{options[:class]}\"")
      end

      # Add title tag for accessibility if provided
      if options[:title]
        svg.sub!(">", "><title>#{options[:title]}</title>")
      end

      svg
    end
  end
end
