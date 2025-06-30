# frozen_string_literal: true

require_relative "component/version"

module Svg
  module Component
    class Error < StandardError; end

    # Render an SVG file with optional attributes, sanitization, and viewBox auto-generation
    #
    # @param [String] path - Path to the SVG file
    # @param [Hash] options - Supported options: :class, :width, :height, :title, :sanitize (true to enable)
    # @return [String] SVG content with applied attributes
    def self.render(path, options = {})
      return "<!-- SVG file not found -->" unless File.exist?(path)

      svg = File.read(path)

      # Remove <script> tags only if sanitize: true is explicitly provided
      svg.gsub!(/<script.*?>.*?<\/script>/m, "") if options[:sanitize] == true

      special_keys = [:title, :sanitize]
      regular_attrs = options.reject { |k, _| special_keys.include?(k) }

      # Modify <svg> tag with new attributes
      svg.sub!(/<svg([^>]*)>/) do
        attrs = Regexp.last_match(1)

        # Remove existing class, width, height if replacements provided
        attrs = attrs.gsub(/\sclass="[^"]*"/, "") if options[:class]
        attrs = attrs.gsub(/\swidth="[^"]*"/, "") if options[:width]
        attrs = attrs.gsub(/\sheight="[^"]*"/, "") if options[:height]

        # Build new attributes
        new_attrs = regular_attrs.map { |k, v| "#{k}=\"#{v}\"" }

        tag = "<svg#{attrs} #{' ' unless attrs.strip.empty?}#{new_attrs.join(' ')}>"

        # Auto-generate viewBox if missing and width/height are valid numbers
        unless tag.include?("viewBox")
          width = options[:width].to_s.gsub("px", "")
          height = options[:height].to_s.gsub("px", "")

          if width.match?(/^\d+$/) && height.match?(/^\d+$/)
            tag.sub!(">", " viewBox=\"0 0 #{width} #{height}\">")
          end
        end

        tag
      end

      # Insert <title> tag if provided
      svg.sub!(">", "><title>#{options[:title]}</title>") if options[:title]

      svg
    end
  end
end
