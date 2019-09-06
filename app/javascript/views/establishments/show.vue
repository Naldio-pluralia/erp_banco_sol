<template>
    <div>
        <hr>
        <div class="row" style="padding: 0;margin-bottom: 0px;">
            <div class="col s5" style="margin-left: 0;margin-right: 0;padding-left: 0;padding-right: 0;">
                <div class="nav-wrapper" style="margin-top: 5px;">
                    <div class="col s12 no-padding">
                        <a href="/app/#/establishments" class="breadcrumb br-cru-color size-readcrumbs">
                            <b>Balcão: {{ item.name }}</b>
                        </a>
                    </div>
                </div>
            </div>
            <div class="col s7 right" style="text-align: right; margin-left: 0;margin-right: 0;padding-left: 0;padding-right: 0;">
                <router-link :to="'/establishments/edit/' + item.id" class="waves-effect waves-light btn  modal-trigger" style="background-color: #fab033; color: #fff; margin-left: 5px; ">
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
                <td>Código</td>
                <td>{{ item.code }}</td>
            </tr>
            <tr>
                <td>Nome</td>
                <td>{{ item.name }}</td>
            </tr>
            <tr>
                <td>Abreviação</td>
                <td>{{ item.abbreviation }}</td>
            </tr>
            <tr>
                <td>Tipo de Balcão</td>
                <td>{{ establishment_name }}</td>
            </tr>
            <tr>
                <td>Estado</td>
                <td>{{ item.status | getEstablishmentStatus }}</td>
            </tr>
            <tr>
                <td>Município</td>
                <td>{{ getMunicipalities[item.municipality_id] || 'N/D' }}</td>
            </tr>
            <tr>
                <td>Quantidade de ATMs</td>
                <td>{{ item.atm_count || 'N/D' }}</td>
            </tr>
            <tr>
                <td>Quantidade de TPAs</td>
                <td>{{ item.tpa_count || 'N/D' }}</td>
            </tr>
        </table>
    </div>
</template>

<script>
import { mapGetters, mapState } from 'vuex';
export default {
    name: 'ShowEstablishment',
    data () {
        return {
            item: {},
            establishment_name: '',
            municipality_name_: '',
            m: '',
            isLoading: false,
            hadErrorLoading: false,
        }
    },
    computed: {
        ...mapGetters(['getListMunicipalities', 'getEstablishmentTypes', 'getMunicipalities']),
        ...mapState(['listMunicipalities']),
        municipality_name: () => {
            return this.municipality_name_;
        }
    },
    created () {
        /*
        *   Retrieve a single item from the establishment resource
        * */

        // console.log('OBJECT: ', this.getListMunicipalities);

        this.axios.get(`/establishments/${this.$route.params.id}.json`)
        .then((data) => {
            /*
            *   If the request succeeds
            * */
            this.item = data.data;
        })
        .catch(() => {
            this.isLoading = false;
            this.hadErrorLoading = true;
        });
    },
    watch: {
        m: () => {
            console.log('WATCH', this.getListMunicipalities);
        }
    },
    beforeUpdate () {
        /*
        *   The script bellow will map the related fields coming from another requests
        * */
        if (this.getEstablishmentTypes.length > 0) {
            let establishmentName = this.getEstablishmentTypes.find((_item) => {
                return _item.id === this.item.establishment_type_id;
            });

            if (establishmentName) {
                this.establishment_name = establishmentName.name;
            }
        }
    },
    methods: {
        RemoveItem () {
            /*
            *   This method will fire a delete request in order to remove the item
            * */
            this.axios.delete(`/establishments/${this.$route.params.id}.json`)
            .then(() => {
                this.$router.push('/establishments');
            })
            .catch((err) => {
                console.log(err);
            });
        }
    }
}
</script>

<style></style>

