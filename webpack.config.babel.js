import webpack from 'webpack'
import path from 'path'
import HtmlWebpackPlugin from 'html-webpack-plugin'
import PurifyCSSPlugin from 'purifycss-webpack'
import glob from 'glob'
import { getIfUtils, removeEmpty } from 'webpack-config-utils'

const { ifProduction, ifDevelopment } = getIfUtils(process.env.NODE_ENV)

const PUBLIC_PATH = '/'
const OUTPUT_PATH = path.join(__dirname, '/docs')
const DEV_SERVER_PORT = 80

module.exports = {
  entry: removeEmpty([
    ...ifDevelopment([
      'react-hot-loader/patch',
      `webpack-dev-server/client?http://localhost:${DEV_SERVER_PORT}`,
      'webpack/hot/only-dev-server',
      path.join(__dirname, '/src/a11y.js')
    ]),
    './src/index.js',
  ]),

  output: {
    filename: `index${ifDevelopment('.js', '.min.js')}`,
    path: OUTPUT_PATH,
    publicPath: PUBLIC_PATH,
  },

  module: {
    rules: [
      {
        test: /\.js$/,
        exclude: /node_modules/,
        use: ['babel-loader'],
      }, {
        test: /\.less/,
        use: [
          'style-loader',
          'css-loader',
          'less-loader',
        ],
      }, {
        test: /\.css$/,
        use: [
          'style-loader',
          'css-loader',
        ],
      }, {
        test: /.*\.svg$/,
        use: [
          'url-loader',
          {
            loader: 'svgo-loader',
            options: {
              plugins: [
                { removeTitle: true },
                { convertColors: { shorthex: false } },
                { convertPathData: false },
              ],
            },
          },
        ],
      }, {
        test: /\.(jpe?g|png|gif)$/i,
        use: ['url-loader'],
      },
    ],
  },

  resolve: {
    alias: {
      pages: path.join(__dirname, '/src/pages'),
      components: path.join(__dirname, '/src/components'),
      commons: path.join(__dirname, '/src/components/commons'),
      utils: path.join(__dirname, '/src/utils'),
      style: path.join(__dirname, '/src/style'),
      assets: path.join(__dirname, '/src/assets'),
    },
  },

  plugins: removeEmpty([
    new HtmlWebpackPlugin({
      inject: true,
      template: path.join(__dirname, '/src/index.html'),
      env: ifDevelopment('development', 'production'),
    }),
    new webpack.DefinePlugin({
      'process.env': {
        NODE_ENV: JSON.stringify(
          ifDevelopment('development', 'production')
        ),
      },
    }),
    ...ifDevelopment([
      new webpack.HotModuleReplacementPlugin(),
      new webpack.NamedModulesPlugin(),
    ]),
    ...ifProduction([
      new PurifyCSSPlugin({
        paths: glob.sync(path.join(__dirname, 'src/**'), { nodir: true }),
        verbose: true,
        minimize: true,
        styleExtensions: ['.css'],
        moduleExtensions: ['.html'],
        purifyOptions: {
          minify: true,
        },
      }),
      new webpack.optimize.UglifyJsPlugin({
        compress: {
          warnings: false,
        },
      }),
      new webpack.optimize.AggressiveMergingPlugin(),
    ]),
  ]),

  devServer: {
    hot: true,
    disableHostCheck: true,
    port: DEV_SERVER_PORT,
    publicPath: PUBLIC_PATH,
  },
}
