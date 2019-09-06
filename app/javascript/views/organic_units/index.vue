<template>
    <div>
        <hr>
        <div class="row" style="padding: 0;margin-bottom: 0px;">
            <div class="col s5" style="margin-left: 0;margin-right: 0;padding-left: 0;padding-right: 0;">
                <div class="nav-wrapper" style="margin-top: 5px;">
                    <div class="col s12 no-padding">
                        <a href="/app/#/organic_units" class="breadcrumb br-cru-color size-readcrumbs">
                            <b>Unidades Orgânicas</b>
                        </a>
                    </div>
                </div>
            </div>
            <div class="col s7 right" style="text-align: right; margin-left: 0;margin-right: 0;padding-left: 0;padding-right: 0;">
                <router-link :to="{ name: 'NewOrganicUnit' }" class="waves-effect waves-light btn  modal-trigger" style="background-color: #fab033; color: #fff; margin-left: 5px; ">
                    Adicionar
                </router-link>
            </div>
        </div>
        <hr>

        <!-- Table -->
        <table class="bordered next-stupid-sort" style="100%">
            <thead class="thead-scroll-next tr-scroll-next ">
                <tr class="tr-scroll-next ">
                    <th>Abreviação</th>
                    <th>Nome</th>
                    <th>Tipo</th>
                </tr>
            </thead>
            <tbody class="tbody-scroll-next">
                <tr
                    v-for="item in items"
                    :key="item.id"
                    :data-href="'/app/#/organic_units/show/' + item.id"
                >
                    <td>{{ item.abbreviation }}</td>
                    <td>{{ item.name }}</td>
                    <td>{{ item_types[item.organic_unit_type_id] }}</td>
                </tr>
            </tbody>
        </table>

    </div>
</template>

<script>
import { mapState } from 'vuex';

export default {
    name: 'IndexOrganicUnits',
    data () {
        return {
            items: [],
            item_types: {},
            isLoading: false,
            hadErrorLoading: false,
        }
    },
    computed: {
        ...mapState(['municipalities']),
    },
    methods: {
        getOrganicUnitsType () {
            /* Get establishments types */
            this.axios.get('/organic_unit_types.json')
            .then((data) => {
                // Create an object with id as key and the name as value
                data.data.forEach((_item) => {
                    this.item_types[_item.id] = _item.name;
                });
            })
            .catch(() => {
                this.isLoading = false;
                this.hadErrorLoadingBalcoes = true;
            });
        }
    },
    created () {
        // Load item types
        this.getOrganicUnitsType();
        // Load items
        this.axios.get('/organic_units.json')
        .then((data) => {
            
            /*
            *   Generate a 
            * */
            this.items = data.data;

        })
        .catch(() => {
            this.isLoading = false;
            this.hadErrorLoadingBalcoes = true;
        });
    }
}
</script>

