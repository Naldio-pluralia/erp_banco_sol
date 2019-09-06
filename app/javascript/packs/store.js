import Vue from 'vue/dist/vue.esm'
import Vuex from 'vuex';
import axios from 'axios';

Vue.use(Vuex);

export default new Vuex.Store({
    state: {
        municipalities: {},
        establishments_types: [],
        listMunicipalities: [],
        organic_unit_types: {},
        list_organic_unit_types: {}
    },
    getters: {
        getMunicipalities: state => state.municipalities,
        getListMunicipalities: state => state.listMunicipalities,
        getEstablishmentTypes: state => state.establishments_types,
        getOrganicUnitTypes: state => state.organic_unit_types,
        getListOrganicUnitTypes: state => state.list_organic_unit_types
    },
    mutations: {
        SET_MUNICIPALITIES (state, data) {
            // Save the original list of municiapalities
            state.listMunicipalities = data;
            // Generate a custom object with the ids and names of the municiaplities
            let result = {};
            data.forEach((item) => {
                result[item.id] = item.name;
            });

            state.municipalities = result; 
        },
        SET_ESTABLISHMENTS_TYPES (state, data) {
            state.establishments_types = data;
        },
        SET_ORGANIC_UNIT_TYPES (state, data) {
            state.list_organic_unit_types = data;

            // Generate a custom object with the ids and names of the municiaplities
            let result = {};
            data.forEach((item) => {
                result[item.id] = item.name;
            });

            state.organic_unit_types = result; 
        }
    },
    actions: {
        getMunicipalities ({ commit }) {
            return new Promise((resolve, reject) => {
                axios.get('/municipalities.json')
                .then((data) => {
                    commit('SET_MUNICIPALITIES', data.data);
                    resolve(data.data);
                })
                .catch((err) => { 
                    reject(err);
                });
            });
        },
        getEstablishmentTypes ({ commit }) {
            return new Promise((resolve, reject) => {
                axios.get('/establishment_types.json')
                .then((data) => {
                    commit('SET_ESTABLISHMENTS_TYPES', data.data);
                    resolve(data.data);
                })
                .catch((err) => {
                    reject(err);
                });
            });
        },
        GetOrganicUnitTypes ({ commit }) {
            return new Promise((resolve, reject) => {
                axios.get('/organic_unit_types.json')
                .then((data) => {
                    commit('SET_ORGANIC_UNIT_TYPES', data.data);
                    resolve(data.data);
                })
                .catch((err) => {
                    reject(err);
                });
            });
        }
    }
});