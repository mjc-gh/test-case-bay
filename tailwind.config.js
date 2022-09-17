const defaultTheme = require('tailwindcss/defaultTheme');

module.exports = {
  content: [
    'app/**/*.rb',
    'app/**/*.html.erb',
    'app/**/*.js',
  ],

  theme: {
    extend: {
    }
  },

  plugins: [
    require('@tailwindcss/typography'),
    require('@tailwindcss/forms'),
  ],
}
