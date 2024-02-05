<script setup lang="ts">
import {useCategoryStore} from "@/stores/category";

const categoryStore = useCategoryStore();
</script>

<style scoped>
.category-nav {
  height: 10%;
  align-items: center;
  display: flex;
  box-shadow: 0px 4px 4px rgba(0, 0, 0, 0.25);
}

.category-buttons {
  display: flex;
  flex-direction: row;
  width: 100%;
  text-align: center;
  justify-content: space-around;
}

.button.category-button {
  background-color: transparent;
  color: var(--default-text-color);
  border-radius: 10px;
}

.button.category-button:hover {
  background-color: var(--default-text-color);
  color: var(--secondary-text-color);
}

.button.category-button.router-link-active {
  background-color: var(--default-text-color);
  color: var(--secondary-text-color);
  transform: scale(0.98);
}
</style>

<template>
  <nav class="category-nav">
    <ul class="category-buttons">
      <li v-for="category in categoryStore.categoryList" :key="category.categoryId">
        <router-link
            :to="'/AkshayBookstoreTransact/category/' + category.name"
            class="button category-button"
        >
          {{ category.name }}
        </router-link>
      </li>
    </ul>
  </nav>
</template>


