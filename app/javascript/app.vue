<template>
  <div id="app">
    <!-- Views will be rendered here -->
    <router-view></router-view>
  </div>
</template>

<script>
import { mapActions } from 'vuex';
export default {
  data: function () {
    return {}
  },
  methods: {
    ...mapActions(['getMunicipalities', 'getEstablishmentTypes'])
  },
  created () {
    /**
     * Pre request important information
    */
    this.getMunicipalities().then().catch();
    this.getEstablishmentTypes().then().catch();
  }
}
</script>

<style>
.form-error{
  color: red;
  font-size: 12px;
}
</style>
