<script setup lang="ts">
import TheCategoryNav from "@/components/TheCategoryNav.vue";
import TheCategoryBookList from "@/components/TheCategoryBookList.vue";
import {useRoute} from "vue-router";
import {useBookStore} from "@/stores/book";
import {watch} from "vue";
import {useCategoryStore} from "@/stores/category";
import router from "@/router";

const route = useRoute();

const bookStore = useBookStore();
const categoryStore = useCategoryStore();
watch(
    () => route.params.categoryName,
    async (newName) => {
      try {
        await categoryStore.setSelectedCategoryName(newName as string)
        await bookStore.fetchBooks(newName as string)
      } catch (e) {
        router.push('/AkshayBookStoreTransact/not-found')
      }
    },
    {immediate: true}
)
</script>

<style scoped>
.category-page {
  height: 83%;
  background: var(--default-background-color);
}

.category-book-list {
  height: 90%;
  display: flex;
  align-items: center;
  justify-content: center;
  color: var(--default-text-color);
}

</style>

<template>
  <div class="category-page">
    <the-category-nav></the-category-nav>
    <section class="category-book-list">
      <the-category-book-list></the-category-book-list>
    </section>
  </div>
</template>
