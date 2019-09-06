<template>
    <div>
        <hr>
        <div class="row" style="padding: 0;margin-bottom: 0px;">
            <div class="col s5" style="margin-left: 0;margin-right: 0;padding-left: 0;padding-right: 0;">
                <div class="nav-wrapper" style="margin-top: 5px;">
                    <div class="col s12 no-padding">
                        <a href="/app/#/establishments" class="breadcrumb br-cru-color size-readcrumbs">
                            <b>Balcões</b>
                        </a>
                    </div>
                </div>
            </div>
            <div class="col s7 right" style="text-align: right; margin-left: 0;margin-right: 0;padding-left: 0;padding-right: 0;">
                <router-link :to="{ name: 'NewEstablishment' }" class="waves-effect waves-light btn  modal-trigger" style="background-color: #fab033; color: #fff; margin-left: 5px; ">
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
                    <th>Código</th>
                    <th>Tipo</th>
                    <th v-if="false">Município</th>
                    <th>Quantidade de ATMs</th>
                    <th>Quantidade de TPAs</th>
                </tr>
            </thead>
            <tbody class="tbody-scroll-next">
                <tr
                    v-for="(establishment) in establishments"
                    :key="establishment.id"
                    :data-href="'/app/#/establishments/show/' + establishment.id"
                >
                    <td>{{ establishment.abbreviation }}</td>
                    <td>{{ establishment.name }}</td>
                    <td>{{ establishment.code }}</td>
                    <td>{{ establishment.type }}</td>
                    <td v-if="false">{{ establishment.municipality || 'N/D' }}</td>
                    <td>{{ establishment.atm || 'N/D' }}</td>
                    <td>{{ establishment.tpa || 'N/D' }}</td>
                </tr>
            </tbody>
        </table>

        <!-- Modal to add a new establishment -->
        <!-- Modal Structure -->
        <div id="add-establishment" class="modal">
            <div class="modal-content">
                <h4>Modal Header</h4>
                <p>A bunch of text</p>
            </div>
            <div class="modal-footer">
                <a href="#!" class="modal-close waves-effect waves-green btn-flat">Agree</a>
            </div>
        </div>

    </div>
</template>

<script>
import { mapState } from 'vuex';

export default {
    name: 'IndexEstablishments',
    data () {
        return {
            establishments: [],
            isLoading: false,
            hadErrorLoading: false,
        }
    },
    computed: {
        ...mapState(['municipalities']),
    },
    methods: {
        getEstablishments () {
            /* Get establishments types */
            this.axios.get('/establishment_types.json')
            .then((data) => {
                this.establishmentsTypes = data.data;
            })
            .catch(() => {
                this.isLoading = false;
                this.hadErrorLoadingBalcoes = true;
            });
        }
    },
    created () {
        // Load establishments types
        this.getEstablishments();
        // Load Municpalities
        this.axios.get('/establishments.json')
        .then((data) => {
            let _data = data.data.map((balcao) => {

                let tipoDeBalcao = this.establishmentsTypes.find((el) => {
                    return el.id === balcao.establishment_type_id;
                });
 
                return {
                    name: balcao.name,
                    code: balcao.code,
                    abbreviation: balcao.abbreviation,
                    type: tipoDeBalcao.name,
                    municipality: balcao.municipality_id,
                    atm: balcao.atm_count,
                    tpa: balcao.tpa_count,
                    id: balcao.id
                };
            });

            this.establishments = _data;

        })
        .catch(() => {
            this.isLoading = false;
            this.hadErrorLoadingBalcoes = true;
        });
    }
}
</script>

