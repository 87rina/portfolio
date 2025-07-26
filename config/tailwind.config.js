const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
   './app/views/**/*.{erb,html,haml,slim}',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/components/**/*.{erb,html,rb}',
    './app/assets/stylesheets/**/*.css'
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ["Kiwi Maru", "serif"], 
      },
      backgroundImage: {
        'hero-pattern': "url('/assets/background.jpg')", 
      },
    },
  },
  plugins: [
    // require('@tailwindcss/forms'),
    // require('@tailwindcss/typography'),
    // require('@tailwindcss/container-queries'),
  ]
}
