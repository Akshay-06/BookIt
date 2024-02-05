<script setup lang="ts">
import {useOrderDetailsStore} from "@/stores/orderDetails";

import {asDollarsAndCents} from "../utilis";
import type {BookItem, OrderDetails} from "@/types";

const orderDetailsStore = useOrderDetailsStore();
const orderDetails: OrderDetails = orderDetailsStore.orderDetails as OrderDetails;

// A helper function - optional to use
const bookAt = function (orderDetails: OrderDetails, index: number): BookItem {
  return orderDetails.books[index];
};

const bookImageFileName = function (book: BookItem): string {
  let name = book.title.toLowerCase();
  name = name.replace(/ /g, "-");
  name = name.replace(/'/g, "");
  return `${name}.png`;
};
const bookImagePrefix = `${import.meta.env.BASE_URL}/book-images/`;
</script>


<style scoped>
img {
  display: block;
  width: 100px;
  height: 130px;
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

.order-heading {
  padding: 1rem 0rem;
}


.order-loop-div {
  display: flex;
  justify-content: space-between;
  width: 60%;
  border: 1px solid gray;
  border-radius: 10px;
  padding: 1rem;
}

.order-book-details {
  display: flex;
  flex-direction: column;
  justify-content: space-evenly;
}

.order-img-and-details {
  display: flex;
  gap: 1rem;
}

.repeat {
  display: flex;
  gap: 1rem;
  flex-direction: column;
}

.order-book-price, .order-book-quantity, .order-subtotal {
  color: #636e72;
}

.order-subtotal {
  display: flex;
  align-items: center;
}

.order-book-title {
  font-weight: bold;
}
</style>


<template>
  <div class="order-heading">
    <h3>Books Ordered</h3></div>
  <div class="repeat">
    <div v-for="(item, index) in orderDetails.lineItems"
         :key="orderDetails.order.orderId + '-' + item.bookId" class="order-loop-div">
      <div class="order-img-and-details">
        <div>
          <img
              :src="`${bookImagePrefix}/${bookImageFileName(orderDetails.books[index])}`"
              :alt="orderDetails.books[index].title"
              width="100px"
              height="130px"
          />
        </div>
        <div class="order-book-details">
          <div class="order-book-title">{{ orderDetails.books[index].title }}</div>
          <div class="order-book-price">
            {{ asDollarsAndCents(orderDetails.books[index].price) }}
          </div>
          <div class="order-book-quantity">

            <span class="quantity">Qty: {{ item.quantity }}</span>

          </div>
        </div>
      </div>
      <div class="order-subtotal">{{ asDollarsAndCents(orderDetails.books[index].price * item.quantity) }}</div>
    </div>
  </div>
</template>

