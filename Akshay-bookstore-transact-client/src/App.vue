<script setup lang="ts">
import {useCategoryStore} from "@/stores/category";
import TheHeader from "@/components/TheHeader.vue";
import TheFooter from "@/components/TheFooter.vue";
import {useRoute} from "vue-router";

const categoryStore = useCategoryStore();
categoryStore.fetchCategories()
const route = useRoute();
</script>

<style>

#app {
  height: 100vh;
}

</style>

<template>
  <div id="app">

    <the-header></the-header>
    <router-view :key="route.fullPath"></router-view>
    <the-footer></the-footer>
  </div>
</template>
