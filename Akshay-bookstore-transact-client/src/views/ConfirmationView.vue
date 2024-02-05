<script setup lang="ts">
import type {OrderDetails} from "@/types";
import {useOrderDetailsStore} from "@/stores/orderDetails";
import {useCartStore} from "@/stores/cart";
import {useCategoryStore} from "@/stores/category";
import {asDollarsAndCents} from "../utilis";
import router from "@/router";
import ConfirmationTable from "@/components/ConfirmationTable.vue";
import {computed} from "vue";

const orderDetailsStore = useOrderDetailsStore();
const cartStore = useCartStore();
const categoryStore = useCategoryStore();

const orderDetails = orderDetailsStore.orderDetails as OrderDetails;
console.log(orderDetailsStore.hasOrderDetails());


const subtotal = computed(function (): number {
  let subtotal = 0;
  for (const item in orderDetails.lineItems) {
    subtotal += orderDetails.books[item].price * orderDetails.lineItems[item].quantity;
  }
  return subtotal;
});


const orderDate = computed(function () {
  let date = new Date(orderDetails.order.dateCreated);
  return date.toLocaleString();
});

const ccExpDate = computed(function (): Date {
  return new Date(orderDetails.customer.ccExpDate);
});

const ccExpYear = computed(function (): number {
  return ccExpDate.value.getFullYear();
});

const ccExpMonth = computed(function (): string {
  let month = ccExpDate.value.getMonth() + 1;
  let result = "" + month;
  if (month < 10) {
    result = "0" + month;
  }
  return result;
});


const bookImagePrefix = `${import.meta.env.BASE_URL}/site-images/`;
const filename = 'shopping-bag.png'
</script>

<style scoped>
.confirmation {
  color: var(--default-text-color);
  height: 83%;
  display: flex;
  flex-direction: column;
  overflow: auto;
  padding: 1rem 15% 1rem 15%;
  background-color: rgba(255, 255, 255, 1);
}

.label {
  padding: 1rem;
}

.label h1 {
  padding-bottom: 0.5rem;
}

.line {
  width: 100%;
  height: 4%;
  display: block;
  background-color: var(--default-text-color);
}

.shopping {
  display: flex;
  align-items: baseline;
  padding: 1rem 0rem;
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

.confirmation-main {
  padding: 1rem;
}

.confirmation-details {
  padding-bottom: 1rem;
}

.order-count {
  padding: 1rem;
}

.order-details {
  display: flex;
  justify-content: space-between;
  padding: 1rem 0rem 1rem 0rem;
}

.customer-details, .payment-method, .order-summary {
  display: flex;
  flex-direction: column;
  gap: 1rem;
  width: 30%;
}

tr td:last-child {
  text-align: end;
}

.order-total {
  font-weight: bold;
}

.order-placed{
  display: flex;
  padding-bottom: 1rem;
}

.order-placed img{
  height: 30px;
  width: 30px;
}

.order-placed h2{
  align-items: end;
  display: flex;
}
</style>

<template>
  <div class="confirmation">
    <div class="label">
      <h1>Order Details</h1>
      <span class="line"></span>
    </div>
    <div class="order-count" v-if="!orderDetailsStore.hasOrderDetails()">
      <span>We have no order records</span>
      <div class="shopping">
        <button @click="router.push({
          name: 'category-view',
          params: {
            categoryName: categoryStore.categoryName,
          },
        })"><i class="fa fa-arrow-left"></i> Continue Shopping
        </button>
      </div>
    </div>
    <div v-else class="confirmation-main">
      <div class="confirmation-details">
        <div class="order-placed">
        <img :src="`${bookImagePrefix}${filename}`" alt="order placed"><h2>Your order is placed successfully!</h2>
        </div><p>
          Your confirmation number: #{{ orderDetails.order.confirmationNumber }}
        </p>
        <p>Order on {{ orderDate }}</p>
      </div>
      <div class="order-details">
        <div class="customer-details">
          <h3>Customer Information</h3>
          <div>
            <p>
              {{ orderDetails.customer.customerName }}
            </p>
            <p>{{ orderDetails.customer.email }}</p>
            <p>{{ orderDetails.customer.address }}</p>
            <p>{{ orderDetails.customer.phone }}</p>
          </div>
        </div>
        <div class="payment-method">
          <h3>Payment Method</h3>
          <p>
            Credit Card: ****{{ orderDetails.customer.ccNumber }}
          </p>
        </div>
        <div class="order-summary">
          <h3>Order Summary</h3>
          <table>
            <tbody>
            <tr>
              <td>Item(s) Subtotal:</td>
              <td>{{ asDollarsAndCents(subtotal) }}</td>
            </tr>
            <tr>
              <td>Shipping Cost:</td>
              <td>{{ asDollarsAndCents(cartStore.cart.shippingCost) }}</td>
            </tr>
            <tr>
              <td>Surcharge:</td>
              <td>{{ asDollarsAndCents(cartStore.cart.surcharge) }}</td>
            </tr>
            <tr class="order-total">
              <td>Order Total:</td>
              <td>{{ asDollarsAndCents(orderDetails.order.amount) }}</td>
            </tr>
            </tbody>
          </table>
        </div>
      </div>
      <confirmation-table></confirmation-table>
      <div class="shopping">
        <button @click="router.push({
          name: 'category-view',
          params: {
            categoryName: categoryStore.categoryName,
          },
        })"><i class="fa fa-arrow-left"></i> Continue Shopping
        </button>
      </div>
    </div>
  </div>
</template>