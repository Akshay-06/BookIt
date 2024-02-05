<script setup lang="ts">
import type {BookItem} from "@/types";
import {useCartStore} from "@/stores/cart";
import {asDollarsAndCents} from "../utilis";

const cartStore = useCartStore();
const props = defineProps<{
  book: BookItem;
}>();
const bookImageFileName = function (book: BookItem): string {
  let name = book.title.toLowerCase();
  name = name.replace(/ /g, "-");
  name = name.replace(/'/g, "");
  return `${name}.png`;
};

const bookImagePrefix = `${import.meta.env.BASE_URL}/book-images/`;
</script>
<style scoped>
.book-box {
  display: flex;
  width: 33%;
  height: auto;
  padding: 1em;
  gap: 2em;
  min-width: 450px;
  box-shadow: 0px 4px 4px rgba(0, 0, 0, 0.25);
}

.book-image {
  position: relative;
}

.book-image img {
  height: 100%;
  width: auto;
}

.readnow {
  background-color: #F6B93B;
  color: #D63031;
  padding: 0.3rem;
  width: fit-content;
  border: none;
  position: absolute;
  right: 0;
  top: 0;
  cursor: pointer;
}

.book-details {
  display: flex;
  flex-direction: column;
  justify-content: space-around;
  width: 50rem;
}

.book-title {
  font-weight: bold;
  text-decoration: underline;
}

.book-author {
  font-style: italic;
}

.book-price {
  text-align: right;
}

.book-price span {
  color: #f00;
}

.book-details button {
  background-color: var(--default-text-color);
  color: var(--secondary-text-color);
  border-radius: 10px;
  width: fit-content;
  border: .1rem solid var(--default-text-color);
}

.book-details button:hover {
  color: var(--default-text-color);
  background-color: var(--secondary-text-color);
  border: .1rem solid var(--default-text-color);
}

.button:active {
  transform: scale(0.98);
}

.book-rating {
  font-size: large;
}
</style>

<template>
  <li class="book-box">
    <div class="book-image">
      <img
          :src="`${bookImagePrefix}${bookImageFileName(book)}`"
          :alt="book.title"
      />
      <button v-if="book.isPublic" class="readnow"><i class="fa fa-eye"></i> Read Now</button>
    </div>
    <div class="book-details">
      <div class="book-title">{{ book.title }}</div>
      <div class="book-author">{{ book.author }}</div>
      <div class="book-rating">
        Rating:
        <i v-for="rate in book.rating" :key="rate" class="fa fa-star"></i>
        <i v-for="rate in 5-book.rating" :key="rate" class="fa fa-star-o"></i>
      </div>
      <div class="book-price">Buy for: <span>{{ asDollarsAndCents(book.price) }}</span></div>
      <div class="book-add">
        <button class="button" @click="cartStore.addToCart(book)"><i class="fa fa-cart-plus"></i> Add to Cart</button>
      </div>
    </div>
  </li>
</template>
