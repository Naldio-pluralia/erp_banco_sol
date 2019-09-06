<template>
    <div>
        <hr>
        <div class="row" style="padding: 0;margin-bottom: 0px;">
            <div class="col s5" style="margin-left: 0;margin-right: 0;padding-left: 0;padding-right: 0;">
                <div class="nav-wrapper" style="margin-top: 5px;">
                    <div class="col s12 no-padding">
                        <a href="/app/#/establishments" class="breadcrumb br-cru-color size-readcrumbs">
                            <b>Novo Balcão</b>
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
                    Nome do Balcão
                </label>
                <input
                    type="text"
                    class="form-control string required"
                    v-model="form.name"
                    name="form.name"
                    v-validate="'required'"
                    data-vv-as="Nome do Balcão"
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
                    Código
                </label>
                <input
                    type="text"
                    class="form-control string required"
                    v-model="form.code"
                    name="form.code"
                    v-validate="'required'"
                    data-vv-as="Código"
                >
                <span class="form-error">{{ errors.first('form.code') }}</span>
            </div>
        </div>

        <div class="row">
            <div class="form-group string required col s4">
                <label for="" class="control-label string required">
                    <abbr title="">*</abbr>
                    Tipo de Balcão
                </label>
                <select
                    id=""
                    class="form-control string required"
                    v-model="form.establishment_type_id"
                    name="form.establishment_type_id"
                    v-validate="'required'"
                    data-vv-as="Tipo de Balcão"
                >
                    <option value="">Selecione uma opção</option>
                    <option :value="establishment.id" v-for="establishment in getEstablishmentTypes" :key="establishment.id">
                        {{ establishment.name }}
                    </option>
                </select>
                <span class="form-error">{{ errors.first('form.establishment_type_id') }}</span>
            </div>

            <div class="form-group string required col s4">
                <label for="" class="control-label string required">
                    <abbr title="">*</abbr>
                    Estado
                </label>
                <select
                    class="form-control string required"
                    name="form.status"
                    v-model="form.status"
                    v-validate="''"
                    data-vv-as="Estado"
                >
                    <option value="open">Aberto</option>
                    <option value="closed">Fechado</option>
                    <option value="in_construction">Em Construção</option>
                </select>
                <span class="form-error">{{ errors.first('form.status') }}</span>
            </div>

            <div class="form-group string required col s4">
                <label for="" class="control-label string required">Data de Inauguração</label>
                <input
                    type="date"
                    class="form-control string required"
                    v-model="form.inaugurated_at"
                >
                <div v-if="false" class="form-group flatpickr required employee_presence_date flex-col-xs-4">
                    <label class="control-label flatpickr required" for="employee_presence_date">
                        <abbr title="required">*</abbr> Data
                    </label>
                    <input class="form-control string flatpickr required flatpickr-input" data-date-format="Y-m-d" name="employee_presence[date]" id="employee_presence_date" type="hidden">
                    <input class="form-control string flatpickr required flatpickr-input input active" placeholder="" tabindex="0" readonly="readonly" type="text">
                </div>
            </div>
        </div>

        <div class="row">
            <div class="form-group string required col s4">
                <label for="" class="control-label string required">
                    <abbr title="">*</abbr>
                    Município
                </label>
                <select
                    id=""
                    class="form-control string required"
                    v-model="form.municipality_id"
                    name="form.municipality_id"
                    v-validate="'required'"
                    data-vv-as="Município"
                >
                    <option value="">Selecione um município</option>
                    <option :value="municipality.id" v-for="municipality in getListMunicipalities" :key="municipality.id">
                        {{ municipality.name }}
                    </option>
                </select>
                <span class="form-error">{{ errors.first('form.municipality_id') }}</span>
            </div>
  
            <div class="form-group string required col s4">
                <label for="" class="control-label string required"> Quantidade de ATMs</label>
                <input
                    type="number"
                    min="0"
                    class="form-control string required"
                    v-model="form.atm_count"
                    name="form.atm_count"
                    v-validate="'integer'"
                    data-vv-as="Quantidade de ATMs"
                >
                <span class="form-error">{{ errors.first('form.atm_count') }}</span>
            </div>
            <div class="form-group string required col s4">
                <label for="" class="control-label string required">Quantidade de TPAs</label>
                <input
                    type="number"
                    min="0"
                    class="form-control string required"
                    v-model="form.tpa_count"
                    name="form.tpa_count"
                    v-validate="'integer'"
                    data-vv-as="Quantidade de TPAs"
                >
                <span class="form-error">{{ errors.first('form.tpa_count') }}</span>
            </div>
        </div>

    </div>
</template>

<script>
import { mapGetters } from 'vuex';

export default {
    name: 'NewEstablishment',
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
        ...mapGetters(['getListMunicipalities', 'getEstablishmentTypes'])
    },
    methods: {
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
            this.axios.post('/establishments.json', this.form)
            .then(() => {
                this.$router.push('/establishments');
            })
            .catch((err) => {
                this.isSaving = false;
                this.hadErrorSubmiting = true;
            });
        }
    }
}
</script>

<style>
</style>

