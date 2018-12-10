import axios from 'axios'

const client = axios.create({
  baseURL: process.env.DB_URL,
  json: true,
  withCredentials: false
})

export default {
  async execute (method, resource, data) {
    // // console.log(client)
    // inject the accessToken for each request
    // let accessToken = JSON.parse(localStorage.getItem('user'))
    let accessToken = 'kresna'
    // console.log('access-token:' + accessToken)
    return client({
      method,
      url: resource,
      data,
      headers: {
        Authorization: `Bearer ${accessToken}`
      }
    }).then(req => {
      // console.log(req.data)
      // // // console.log(accessToken)
      return req.data
    })
  },
  getMatches () {
    return this.execute('get', '/matches')
  },
  getMatch (id) {
    return this.execute('get', `/matches/${id}`)
  },
  createMatch (data) {
    return this.execute('post', '/matches', data)
  },
  updateMatch (id, data) {
    // console.log(data)
    return this.execute('put', `/matches/${id}`, data)
  },
  deleteMatch (id) {
    return this.execute('delete', `/matches/${id}`)
  },
  searchMatch (matchID) {
    return this.execute('get', `/matches?match_id=${matchID}`)
  }
}
