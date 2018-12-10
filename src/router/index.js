import Vue from 'vue'
import Router from 'vue-router'
import LiveScore from '@/components/LiveScore'
import vSelect from 'vue-select'

Vue.component('v-select', vSelect)
Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      name: 'LiveScore',
      component: LiveScore
    }
  ]
})
