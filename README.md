# svg-component

Inline SVG rendering for Ruby with optional Jekyll integration.

## Features

- Dynamically inject SVG files into HTML output.
- Supports additional attributes: `class`, `width`, `height`, `title`.
- Optional sanitization to remove `<script>` tags for security.
- Includes Jekyll Liquid tag for static site use.

This gem is distributed via GitHub Packages. Add it to your `Gemfile`:

```ruby
source "https://rubygems.pkg.github.com/hwahyeon" do
  gem "svg-component", "version"
end
```

### Configure Local Installation

To install gems locally within the project (recommended):

```bash
bundle config set --local path vendor/bundle
```

Configure GitHub Authentication
GitHub Packages requires authentication, even for public packages.

You must configure your GitHub personal access token (PAT) with at least the `read:packages` scope.

Set your token globally using Bundler:

```bash
bundle config set --global rubygems.pkg.github.com USERNAME:TOKEN
```

- Replace `USERNAME` with your GitHub username.
- Replace `TOKEN` with your GitHub personal access token.

Alternatively, you can set the token for the current session only:

```bash
export BUNDLE_RUBYGEMS__PKG__GITHUB__COM=USERNAME:TOKEN
```

For PowerShell:

```powershell
$env:BUNDLE_RUBYGEMS__PKG__GITHUB__COM="USERNAME:TOKEN"
```

### Install the Gem

```bash
bundle install
```

## Usage

### 1. Ruby Inline Rendering

Render an SVG file directly in your Ruby code:

```ruby
require 'svg/component'

puts Svg::Component.render("icons/icon.svg")
```

Supported Options:

```ruby
Svg::Component.render("icons/icon.svg",
  class: "icon",
  width: "100",
  height: "100",
  title: "Example",
  sanitize: true
)
```

- `class`, `width`, `height` : Override or add attributes to the `<svg>` tag

- `title` : Inserts a `<title>` element inside the SVG

- `sanitize`: true : Removes `<script>` tags for security

- `viewBox` : Automatically generated if `width` and `height` are numeric

### 2. Liquid Template Usage (Jekyll, etc.)

In a template or Markdown file:

```liquid
{% svg icons/icon.svg %}
```

With attributes:

```liquid
{% svg icons/icon.svg, class=icon-large, width=100, height=100, title="Logo" %}
```

- The path to the SVG file should be provided **without quotes**
- Attribute values can be quoted or unquoted
- Boolean attributes like `sanitize` should be passed as `sanitize=true`

### 3. Jekyll Integration

To enable the `{% svg %}` tag in Jekyll:

Copy `lib/jekyll/svg_tag.rb` into your project's `_plugins` folder
OR
Explicitly register the tag in your setup:

```ruby
require 'jekyll/svg_tag'
```

Without this, the `{% svg %}` tag will not be recognized by Liquid or Jekyll.

## Usage Examples

### Ruby Inline Rendering

Basic rendering:

```ruby
Svg::Component.render("icons/icon.svg")
```

With custom class:

```ruby
Svg::Component.render("icons/icon.svg", class: "icon-small")
```

With width and height:

```ruby
Svg::Component.render("icons/icon.svg", width: "24", height: "24")
```

With title:

```ruby
Svg::Component.render("icons/icon.svg", title: "Logo")
```

Sanitize SVG to remove scripts:

```ruby
Svg::Component.render("icons/icon.svg", sanitize: true)
```

Combined example:

```ruby
Svg::Component.render("icons/icon.svg", class: "icon", width: "32", height: "32", title: "Secure Icon", sanitize: true)
```

### Jekyll Integration

Add this in a template or Markdown file:

Basic:

```liquid
{% svg icons/icon.svg %}
```

With class:

```liquid
{% svg icons/icon.svg, class="icon-large" %}
```

With width and height:

```liquid
{% svg icons/icon.svg, width=48, height=48 %}
```

With title:

```liquid
{% svg icons/icon.svg, title="Site Logo" %}
```

With sanitization:

```liquid
{% svg icons/icon.svg, sanitize=true %}
```

Combined example:

```liquid
{% svg icons/icon.svg, class="icon", width=64, height=64, title="Secure Icon", sanitize=true %}
```
