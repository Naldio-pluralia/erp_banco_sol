<template>
    <div>
        <hr>
        <div class="row" style="padding: 0;margin-bottom: 0px;">
            <div class="col s5" style="margin-left: 0;margin-right: 0;padding-left: 0;padding-right: 0;">
                <div class="nav-wrapper" style="margin-top: 5px;">
                    <div class="col s12 no-padding">
                        <a href="/app/#/organic_units" class="breadcrumb br-cru-color size-readcrumbs">
                            <b>Unidade Organizacional: {{ item.name }}</b>
                        </a>
                    </div>
                </div>
            </div>
            <div class="col s7 right" style="text-align: right; margin-left: 0;margin-right: 0;padding-left: 0;padding-right: 0;">
                <router-link :to="'/organic_units/edit/' + item.id" class="waves-effect waves-light btn  modal-trigger" style="background-color: #fab033; color: #fff; margin-left: 5px; ">
                    Editar
                </router-link>
                <button
                    class="waves-effect waves-light btn  modal-trigger"
                    style="background-color: #fab033; color: #fff; margin-left: 5px;"
                    @click="RemoveItem"
                >
                    Remover
                </button>
            </div>
        </div>
        <hr>

        <table>
            <tr>
                <td>Nome</td>
                <td>{{ item.name }}</td>
            </tr>
            <tr>
                <td>Abreviação</td>
                <td>{{ item.abbreviation }}</td>
            </tr>
            <tr>
                <td>Tipo</td>
                <td>{{ getOrganicUnitTypes[item.organic_unit_type_id] }}</td>
            </tr>
        </table>
    </div>
</template>

<script>
import { mapGetters, mapState, mapActions } from 'vuex';
export default {
    name: 'ShowOrganicUnit',
    data () {
        return {
            item: {},
            isLoading: false,
            hadErrorLoading: false,
        }
    },
    computed: {
        ...mapGetters(['getOrganicUnitTypes'])
    },
    created () {
        // Load item types
        this.GetOrganicUnitTypes();
        /*
        *   Retrieve a single item from the establishment resource
        * */
        this.axios.get(`/organic_units/${this.$route.params.id}.json`)
        .then((data) => {
            /*
            *   If the request succeeds
            * */
            this.item = data.data;
            this.item.organic_unit_name = this.item_types;
            // console.log(this.item_types[this.item.organic_unit_type_id]);
        })
        .catch(() => {
            this.isLoading = false;
            this.hadErrorLoading = true;
        });
    },
    methods: {
        ...mapActions(['GetOrganicUnitTypes']),
        RemoveItem () {
            /*
            *   This method will fire a delete request in order to remove the item
            * */
            this.axios.delete(`/organic_units/${this.$route.params.id}.json`)
            .then(() => {
                this.$router.push('/organic_units');
            })
            .catch((err) => {
                console.log(err);
            });
        }
    }
}
</script>

<style></style>

