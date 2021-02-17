const { environment } = require('@rails/webpacker')
const webpack = require('webpack')

environment.config.node =  {
  global: true,
  __filename: false,
  __dirname: false
}

environment.plugins.append('Provide', new webpack.ProvidePlugin({
  $: 'jquery',
  jQuery: 'jquery',
  Popper: ['popper.js', 'default']
}))

environment.loaders.append('jquery', {
  test: require.resolve('jquery'),
  loader: 'expose-loader',
  options: {
    exposes: ['$', 'jQuery']
  }
})

environment.loaders.append('toastr', {
  test: require.resolve('toastr'),
  loader: 'expose-loader',
  options: {
    exposes: ['toastr']
  }
})

module.exports = environment
