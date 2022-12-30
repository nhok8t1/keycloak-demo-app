<template>
  <v-container fluid fill-height>
    <v-flex xs12 sm8 md4>
      <v-card class="elevation-12">
        <v-btn @click="login()">
          Login via Keycloak
        </v-btn>
      </v-card>
    </v-flex>
  </v-container>
</template>

<script>
export default {
  name: 'LoginVue',
  layout: 'default',
  methods: {
    async login () {
      try {
        await this.$auth.loginWith('keycloak')
        // eslint-disable-next-line
        this.$router.push('/')
      } catch (err) {
        // eslint-disable-next-line
        console.log(err)
      }
    }
  }
}
</script>

<style scoped>

</style>
