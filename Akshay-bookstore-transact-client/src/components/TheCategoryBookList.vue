<script setup lang="ts">
import {useBookStore} from "@/stores/book";
import CategoryBookListItem from "@/components/CategoryBookListItem.vue";

const bookStore = useBookStore();
</script>

<style scoped>
#book-boxes {
  display: flex;
  flex-wrap: wrap;
  padding: 1em;
  gap: 1em;
  justify-content: space-evenly;
  height: 100%;
  overflow: auto;
}
</style>

<template>
  <ul id="book-boxes">
    <category-book-list-item v-for="book in bookStore.bookList" :key="book.bookId"
                             :book="book"></category-book-list-item>
  </ul>
</template>
