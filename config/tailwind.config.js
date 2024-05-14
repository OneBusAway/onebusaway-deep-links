const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './public/*.html',
    './app/components/**/*.{rb,html.erb}',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*'
  ],
  theme: {
    extend: {
      colors: {
        brand: "#78aa36",
        "brand-secondary": "#486621",
        "brand-tertiary": "#3eab37",
      }
    }
  },
  plugins: [
    require('@tailwindcss/forms'),
  ]
}
