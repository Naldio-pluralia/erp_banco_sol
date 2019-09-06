<template>
    <div>
        <hr>
        <div class="row" style="padding: 0;margin-bottom: 0px;">
            <div class="col s5" style="margin-left: 0;margin-right: 0;padding-left: 0;padding-right: 0;">
                <div class="nav-wrapper" style="margin-top: 5px;">
                    <div class="col s12 no-padding">
                        <a href="/app/#/establishments" class="breadcrumb br-cru-color size-readcrumbs">
                            <b>Nova Unidade Organizacional</b>
                        </a>
                    </div>
                </div>
            </div>
            <div class="col s7 right" style="text-align: right; margin-left: 0;margin-right: 0;padding-left: 0;padding-right: 0;">
                <button
                    @click="SaveEstablishment"
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
    name: 'NewOrganicUnit',
    data () {
        return {
            form: {},
            establishments: [],
            isLoading: false,
            isSaving: false,
            hadErrorLoading: false,
        };
    },
    computed: {
        ...mapGetters(['getListOrganicUnitTypes'])
    },
    methods: {
        ...mapActions(['GetOrganicUnitTypes']),
        SaveEstablishment () {
            /*
            *   This method will validate the form and if everything is ok it will
            *   call the method to post the resource 
            */
            this.$validator.validateAll()
            .then((result) => {
                if (result) {
                    this.PostItem();
                } else {
                    this.isLoading = false;
                    this.hadInputErrors = true;
                }
            });

        },
        PostItem () {
            /*
            *   This method will fire a post request to the API in order to save the
            *   item.
            * */
            this.axios.post('/organic_units.json', this.form)
            .then(() => {
                this.$router.push('/organic_units');
            })
            .catch((err) => {
                this.isSaving = false;
                this.hadErrorSubmiting = true;
            });
        }
    },
    created () {
        // Load item types
        this.GetOrganicUnitTypes();
    },
}
</script>

<style>
</style>

