'use strict'
const merge = require('webpack-merge')
const prodEnv = require('./prod.env')

module.exports = merge(prodEnv, {
  NODE_ENV: '"development"',
  DB_URL: '"https://apia.jaskapital.com"'
  //DB_URL: '"http://localhost:8081"'
})
