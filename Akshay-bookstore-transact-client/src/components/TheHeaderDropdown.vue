<script setup lang="ts">
import {useCategoryStore} from "@/stores/category";

const categoryStore = useCategoryStore();
</script>

<style scoped>
.header-dropdown {
  padding: 0rem 0.5em;
  opacity: 1;
  border: none;
  border-radius: 15px;
  color: var(--default-text-color);
  position: relative;
  height: 100%;
}

.categories-button {
  border: 0;
  background: transparent;
  position: relative;
  font-size: 20px;
  height: 100%;
  width: 100%;
}

.header-dropdown:hover .categories-button {
  background-color: var(--secondary-text-color);
}

.header-dropdown:hover .dropdown-content {
  transform: scaleY(1);
}

.dropdown-content {
  background: var(--default-background-color);
  width: 100%;
  box-shadow: 0px 8px 16px 0px rgba(0, 0, 0, 0.2);
  transform: scaleY(0);
  transition: all .5s ease-in-out;
  transform-origin: top;
}


.dropdown-content a {
  float: none;
  color: var(--default-text-color);
  padding: 12px 7px;
  text-decoration: none;
  display: block;
  text-align: left;
}


.dropdown-content a:hover {
  background-color: var(--default-text-color);
  color: var(--secondary-text-color);
}


.header-dropdown a {
  color: var(--default-text-color);
  text-decoration: none;
}
</style>

<template>
  <div class="header-dropdown">
    <button class="categories-button">Categories <i class="icon-caret-down"></i></button>
    <div class="dropdown-content">
      <ul>
        <li v-for="category in categoryStore.categoryList" :key="category.categoryId">
          <router-link :to="'/AkshayBookstoreTransact/category/' + category.name">{{ category.name }}</router-link>
        </li>
        <li></li>
      </ul>
    </div>
  </div>
</template>


