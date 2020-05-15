

const {environment} = require('@rails/webpacker');

const webpack = require('webpack');

environment.plugins.append('Provide', new webpack.ProvidePlugin({
  $: 'jquery',
  jQuery: 'jquery'
}))

 environment.loaders.append('jquery', {
      test: require.resolve('jquery'),
      use: [{
        loader: 'expose-loader',
        options: '$',
      }, {
        loader: 'expose-loader',
        options: 'jQuery',
      }],
    })
  module.exports = environment;