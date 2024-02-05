<script setup lang="ts">
import type {BookItem} from "@/types";
import {useCartStore} from "@/stores/cart";
import {asDollarsAndCents} from "../utilis";

const cartStore = useCartStore();

const bookImageFileName = function (book: BookItem): string {
  let name = book.title.toLowerCase();
  name = name.replace(/ /g, "-");
  name = name.replace(/'/g, "");
  return `${name}.png`;
};
const bookImagePrefix = `${import.meta.env.BASE_URL}/book-images/`;

const updateCart = function (book: BookItem, quantity: number) {
  cartStore.updateBookQuantity(book, quantity);
};
</script>

<style scoped>
.cart-table {
  display: grid;
  grid-template-columns: auto minmax(10em, 20em) repeat(3, auto);
  row-gap: 1em;
  padding: 0rem 1rem 0rem 1rem;
}

ul {
  display: contents;
}

ul > li {
  display: contents;
}

.table-heading {
  background-color: #f2f2f2;
  color: var(--default-text-color);
}

.table-heading > * {
  font-weight: bold;
  background-color: #f2f2f2;
  padding: 1em;
}

.heading-book {
  text-align: left;
}

.heading-price {
  text-align: right;
}

.heading-subtotal {
  text-align: right;
}

.heading-quantity {
  text-align: center;
}

.cart-book-image {
  padding: 0 1em;
  align-items: center;
  justify-content: center;
  display: flex;
}

img {
  display: block;
  width: 100px;
  height: auto;
}

.cart-book-title {
  padding: 1rem;
}

.cart-book-price {
  padding: 1rem;
  text-align: right;
}

.cart-book-quantity {
  padding: 0.5em 1em;
  display: flex;
  align-items: baseline;
  justify-content: center;
}

.cart-book-subtotal {
  text-align: right;
  padding: 1rem;
}

/* Row separators in the table */

.line-sep {
  display: block;
  height: 1px;
  background-color: gray;
  grid-column: 1 / -1;
}

/* Increment/decrement buttons */

.icon-button {
  border: none;
  cursor: pointer;
}

/* Chevron buttons */

.dec-arrow-button,
.inc-arrow-button {
  width: 25%;
  font-size: 1rem;
  background-color: rgb(248, 248, 248);
  padding: 1rem;
}

.inc-arrow-button {
  background-color: var(--secondary-text-color);
}

.dec-arrow-button:hover,
.inc-arrow-button:hover {
  background-color: var(--default-text-color);
  color: #f2f2f2;
}

.quantity {
  width: 25%;
  text-align: center;
}

input[type="number"] {
  width: 4em;
}

select {
  background-color: var(--primary-color);
  color: white;
  border: 2px solid var(--primary-color-dark);
  border-radius: 3px;
}
</style>

<template>
  <div class="cart-table">
    <ul>
      <li class="table-heading">
        <div></div>
        <div class="heading-book">Book</div>
        <div class="heading-price">Price</div>
        <div class="heading-quantity">Quantity</div>
        <div class="heading-subtotal">Total Price</div>
      </li>

      <template v-for="item in cartStore.cart.items" :key="item.book.bookId">
        <li>
          <div class="cart-book-image">
            <img
                :src="`${bookImagePrefix}/${bookImageFileName(item.book)}`"
                :alt="item.book.title"
                width="100px"
                height="auto"
            />
          </div>
          <div class="cart-book-title">{{ item.book.title }}</div>
          <div class="cart-book-price">
            {{ asDollarsAndCents(item.book.price) }}
          </div>
          <div class="cart-book-quantity">
            <button
                class="icon-button dec-arrow-button" @click="updateCart(item.book, item.quantity - 1)"
            >
              -
            </button>
            <span class="quantity">{{ item.quantity }}</span>
            <button
                class="icon-button inc-arrow-button" @click="updateCart(item.book, item.quantity + 1)"
            >
              +
            </button>
          </div>
          <div class="cart-book-subtotal">{{ asDollarsAndCents(item.book.price * item.quantity) }}</div>
        </li>
        <li class="line-sep"></li>
      </template>
    </ul>
  </div>
</template>
