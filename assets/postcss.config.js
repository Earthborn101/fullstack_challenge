module.exports = {
    purge: [
      '../lib/**/*.ex',
      '../lib/**/*.leex',
      '../lib/**/*.eex',
      './js/**/*.js'
    ],
    plugins: {
      tailwindcss: {},
      autoprefixer: {},
    }
  }