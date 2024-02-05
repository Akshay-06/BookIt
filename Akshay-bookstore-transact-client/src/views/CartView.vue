<script setup lang="ts">
import CartTable from "@/components/CartTable.vue";
import {useCartStore} from "@/stores/cart";
import {useCategoryStore} from "@/stores/category";
import router from "@/router";
import {asDollarsAndCents} from "../utilis";

const categoryStore = useCategoryStore();
const cartStore = useCartStore();
const clearCart = function () {
  cartStore.clearCart();
};

const bookImagePrefix = `${import.meta.env.BASE_URL}/site-images/`;
const filename = 'empty_cart.png'
</script>
<style scoped>
.cart-main {
  display: flex;
  flex-direction: column;
  gap: 1rem;
  height: 83%;
  overflow: auto;
  padding: 1rem 15% 1rem 15%;
  background-color: var(--default-background-color);
}

.label {
  padding: 1rem;
}

.label h1 {
  padding-bottom: 0.5rem;
}

.clear-cart {
  display: flex;
  justify-content: end;
  padding-right: 1rem;
}

.clear-cart button {
  background-color: var(--default-text-color);
  color: var(--secondary-text-color);
  border-radius: 10px;
  width: fit-content;
  padding: 0.5rem;
  border: .1rem solid var(--default-text-color);
  cursor: pointer;
}

.clear-cart button:hover {
  color: var(--default-text-color);
  background-color: var(--secondary-text-color);
  border: .1rem solid var(--default-text-color);
}

.shopping {
  display: flex;
  justify-content: space-around;
  align-items: baseline;
}

.shopping button {
  background-color: var(--default-text-color);
  color: var(--secondary-text-color);
  border-radius: 10px;
  width: fit-content;
  height: fit-content;
  padding: 0.5rem;
  border: .1rem solid var(--default-text-color);
  cursor: pointer;
}

.shopping button:hover {
  color: var(--default-text-color);
  background-color: var(--secondary-text-color);
  border: .1rem solid var(--default-text-color);
}

.shopping button:active {
  transform: scale(0.98);
}

.clear-cart button:active {
  transform: scale(0.98);
}

.cta-button {
  background-color: var(--default-text-color);
  width: 100%;
  color: var(--secondary-text-color);
  outline: none;
  border-radius: 15px;
  cursor: pointer;
  border: .1rem solid var(--default-text-color);
  padding: 1rem;
  transition: all 0.5s;
}

.cta-button:hover {
  background-color: var(--secondary-text-color);
  color: var(--default-text-color);
  border: .1rem solid var(--default-text-color);

}

.cta-button span {
  text-decoration: none;
  position: relative;
  transition: 0.5s;
}

.cta-button span:after {
  content: '\00bb';
  position: absolute;
  opacity: 0;
  top: 0;
  right: -20px;
  transition: 0.5s;
}

.cta-button:hover span {
  padding-right: 1rem;
}

.cta-button:hover span:after {
  opacity: 1;
  right: 0;
}

.cta-button:active {
  transform: scale(0.98);
}

.line {
  width: 100%;
  height: 4%;
  display: block;
  background-color: var(--default-text-color);
}

.cart-count {
  padding-left: 1rem;
}

.shopping-and-checkout {
  display: flex;
  padding: 0rem 1rem;
  justify-content: space-between;
}

.checkout {
  display: flex;
  flex-direction: column;
  gap: 2rem;
}

.checkout span {
  text-align: right;
}

table {
  width: 100%;
  border-collapse: collapse;
  border-spacing: 0;
}

tbody {
  display: table-row-group;
  vertical-align: middle;
  border-color: inherit;
}

.order-totals-table .order-subtotal td:first-of-type {
  display: -ms-flexbox;
  display: flex;
  -ms-flex-align: center;
  align-items: center;
}

.order-totals-table tr td:first-child, .order-totals-table tr td:last-of-type {
  font-family: var(--default-font-family);
  font-size: 16px;
  font-size: 1rem;
  line-height: 20px;
  line-height: 1.25rem;
  letter-spacing: .01em;
}

.order-totals-table tr td:first-child {
  text-transform: capitalize;
  font-weight: 400;
}

.order-totals-table tr td {
  color: var(--default-text-color);
  padding: 10px 0;
}

td {
  padding: 1em;
  vertical-align: top;
}

.order-totals-table tr td:last-of-type {
  text-transform: uppercase;
  font-weight: 600;
}

.order-totals-table tr td + td {
  text-align: right;
}


.order-totals-table tr.order-total td {
  font-weight: 600;
  font-family: var(--default-font-family);
  font-size: 18px;
  font-size: 1.125rem;
  line-height: 20px;
  line-height: 1.25rem;
  letter-spacing: .005em;
  color: var(--default-text-color);
  border-top: 3px solid #e5e5e5;
}

p {
  font-size: 14px;
  text-align: center;
}

.empty-cart{
  display: flex;
  justify-content: center;
  align-items: center;
}
</style>

<template>
  <div class="cart-main">
    <div class="label">
      <h1>Shopping Cart</h1>
      <span class="line"></span>
    </div>
    <div class="cart-count">
    <span v-if="cartStore.count==1">
      Your cart contains {{ cartStore.count }} book
    </span>
      <span v-else-if="cartStore.count>1">
      Your cart contains {{ cartStore.count }} books
    </span>
      
    </div>
    <div v-if="cartStore.empty" class="empty-cart">
      <img :src="`${bookImagePrefix}${filename}`" alt="empty cart">
    </div>
    <div class="clear-cart" v-if="!cartStore.empty">
      <button @click="clearCart()">
        Clear Cart
      </button>
    </div>
    <cart-table v-if="!cartStore.empty"></cart-table>
    <div class="shopping-and-checkout">
      <div class="shopping">
        <button @click="router.push({
          name: 'category-view',
          params: {
            categoryName: categoryStore.categoryName,
          },
        })"><i class="fa fa-arrow-left"></i> Continue Shopping
        </button>
      </div>
      <div class="checkout" v-if="!cartStore.empty">

           <span>  Subtotal: {{ asDollarsAndCents(cartStore.subTotal) }}
           </span>
        <div>
          <button class="cta-button" @click="router.push({
          name: 'checkout-view',
        })">
             <span> Proceed to Checkout
</span>
          </button>
        </div>
      </div>
    </div>
  </div>
</template>