/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    "./templates/**/*.html",
    "./static/**/*.js"
  ],
  theme: {
    extend: {
      colors: {
        // Dark palette
        'primary': {
          '50': '#f5f7ff',
          '100': '#ebf0fe',
          '200': '#d6e0fd',
          '300': '#b3c7fb',
          '400': '#89a4f8',
          '500': '#637ef4',
          '600': '#4b5cea',
          '700': '#3e49d0',
          '800': '#353ea8',
          '900': '#2f3985',
          '950': '#1e2252',
        },
        'surface': {
          '50': '#f6f7f9',
          '100': '#eceef2',
          '200': '#d3d8e3',
          '300': '#adb6ca',
          '400': '#8492ae',
          '500': '#667696',
          '600': '#515f7d',
          '700': '#434d66',
          '800': '#3a4255',
          '900': '#22262f',
          '950': '#171a22',
        },
        'accent': {
          '50': '#f2f9fd',
          '100': '#e5f1fa',
          '200': '#c5e3f4',
          '300': '#92ccea',
          '400': '#57b0dd',
          '500': '#3496ca',
          '600': '#2479ab',
          '700': '#20628b',
          '800': '#1f5374',
          '900': '#1f4562',
          '950': '#152d42',
        },
      },
    },
  },
  plugins: [],
  darkMode: 'class',
}