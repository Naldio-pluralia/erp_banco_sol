<template>
    <div>
        <hr>
        <div class="row" style="padding: 0;margin-bottom: 0px;">
            <div class="col s5" style="margin-left: 0;margin-right: 0;padding-left: 0;padding-right: 0;">
                <div class="nav-wrapper" style="margin-top: 5px;">
                    <div class="col s12 no-padding">
                        <a :href="'/app/#/organic_units/edit/' + $route.params.id" class="breadcrumb br-cru-color size-readcrumbs">
                            <b>Editar Unidade Organizacional: {{ form.name }}</b>
                        </a>
                    </div>
                </div>
            </div>
            <div class="col s7 right" style="text-align: right; margin-left: 0;margin-right: 0;padding-left: 0;padding-right: 0;">
                <button
                    @click="UpdateItem"
                    class="waves-effect waves-light btn"
                    :disabled="isSaving"
                >
                    Guardar
                </button>
            </div>
        </div>
        <hr>

        <div class="row">
            <div class="form-group string required col s4">
                <label for="" class="control-label string required">
                    <abbr title="">*</abbr>
                    Nome
                </label>
                <input
                    type="text"
                    class="form-control string required"
                    v-model="form.name"
                    name="form.name"
                    v-validate="'required'"
                    data-vv-as="Nome"
                >
                <span class="form-error">{{ errors.first('form.name') }}</span>
            </div>

            <div class="form-group string required col s4">
                <label for="" class="control-label string required">
                    <abbr title="">*</abbr>
                    Abreviação
                </label>
                <input
                    type="text"
                    class="form-control string required"
                    v-model="form.abbreviation"
                    name="form.abbreviation"
                    v-validate="'required'"
                    data-vv-as="Abreviação"
                >
                <span class="form-error">{{ errors.first('form.abbreviation') }}</span>
            </div>

            <div class="form-group string required col s4">
                <label for="" class="control-label string required">
                    <abbr title="">*</abbr>
                    Tipo
                </label>
                <select
                    id=""
                    class="form-control string required"
                    v-model="form.organic_unit_type_id"
                    name="form.organic_unit_type_id"
                    v-validate="'required'"
                    data-vv-as="Tipo de Balcão"
                >
                    <option value="">Selecione uma opção</option>
                    <option :value="item.id" v-for="item in getListOrganicUnitTypes" :key="item.id">
                        {{ item.name }}
                    </option>
                </select>
                <span class="form-error">{{ errors.first('form.organic_unit_type_id') }}</span>
            </div>
        </div>

    </div>
</template>

<script>
import { mapGetters, mapActions } from 'vuex';

export default {
    name: 'EditOrganicUnits',
    data () {
        return {
            form: {},
            isLoading: false,
            isSaving: false,
            hadErrorLoading: false,
        };
    },
    computed: {
        ...mapGetters(['getListOrganicUnitTypes'])
    },
    created () {
        // Load item types
        this.GetOrganicUnitTypes();

        /* Get a single item */
        this.axios.get(`/organic_units/${this.$route.params.id}.json`)
        .then(data => this.form = data.data)
        .catch(() => {
            this.isLoading = false;
            this.hadErrorLoadingBalcoes = true;
        });
    },
    methods: {
        ...mapActions(['GetOrganicUnitTypes']),
        UpdateItem () {
            this.$validator.validateAll()
            .then((result) => {
                if (result) {
                    this.axios.patch(`/organic_units/${this.$route.params.id}.json`, this.form)
                    .then(() => {
                        this.$router.push('/organic_units');
                    })
                    .catch((err) => {
                        this.isSaving = false;
                        this.hadErrorSubmiting = true;
                    });
                } else {
                    this.isLoading = false;
                    this.hadInputErrors = true;
                }
            });

        }
    }
}
</script>

<style>
</style>

