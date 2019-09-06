/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

import Vue from 'vue/dist/vue.esm'
import VueRouter from 'vue-router'
import router from './router';
import VueAxios from 'vue-axios';
import axios from 'axios';
import VeeValidate, { Validator } from 'vee-validate';
import store from './store';
// vee-validate
import pt from 'vee-validate/dist/locale/pt_PT';

// Main component / view
import App from '../app.vue'

document.addEventListener('DOMContentLoaded', () => {

  axios.defaults.headers.common['X-CSRF-Token'] = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
  axios.defaults.headers.post['Content-Type'] = 'application/json';

  // Setup vue-router
  Vue.use(VueRouter);

  Vue.use(VueAxios, axios);
  Vue.use(VeeValidate);
  Validator.localize('pt_PT', pt);

  /*
  * Filters
  * */
  Vue.filter('getEstablishmentStatus', (status) => {
    /*
    *   This filter should receive a string as an argument and then return 
    *   a human redeable string.
    * */
    let result = '';
    switch (status) {
        case 'open':
            result = 'Aberto';
            break;
        case 'in_construction':
            result = 'Em Construção';
            break;
        case 'closed':
            result = 'Fechado';
            break;
        default:
            result = 'N/D';
            break;
    }
    return result;
  });

  const app = new Vue({
    router,
    store,
    render: h => h(App),
  }).$mount('#application');

});
