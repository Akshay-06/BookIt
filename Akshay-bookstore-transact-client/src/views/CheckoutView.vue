<script setup lang="ts">
import {reactive, ref} from "vue";
import useVuelidate from "@vuelidate/core";
import {email, helpers, maxLength, minLength, required} from "@vuelidate/validators";
import {useCartStore} from "@/stores/cart";
import {asDollarsAndCents} from "@/utilis";
import router from "@/router";
import {useCategoryStore} from "@/stores/category";
import {isCreditCard, isMobilePhone} from "@/validators";
import CheckoutFieldError from "@/components/CheckoutFieldError.vue";
import type {OrderDetails, ServerErrorResponse} from "@/types";


const cartStore = useCartStore();
const categoryStore = useCategoryStore();

const months: string[] = [
  "January",
  "February",
  "March",
  "April",
  "May",
  "June",
  "July",
  "August",
  "September",
  "October",
  "November",
  "December",
];

const form = reactive({
  name: "",
  address: "",
  phone: "",
  email: "",
  ccNumber: "",
  ccExpiryMonth: null,
  ccExpiryYear: null,
  checkoutStatus: "",
});

const rules = {
  name: {
    required: helpers.withMessage("Please provide a name.", required),
    minLength: helpers.withMessage(
        "Name must have at least 4 letters.",
        minLength(4)
    ),
    maxLength: helpers.withMessage(
        "Name can have at most 45 letters.",
        maxLength(45)
    ),
  },
  address: {
    required: helpers.withMessage("Please provide an address.", required),
    minLength: helpers.withMessage(
        "Address must have at least 4 letters.",
        minLength(4)
    ),
    maxLength: helpers.withMessage(
        "Address can have at most 45 letters.",
        maxLength(45)
    ),
  },
  phone: {
    required: helpers.withMessage("Please provide a phone number.", required),
    phone: helpers.withMessage("Please provide a valid phone number.", (phNumber: string) => !helpers.req(phNumber) || isMobilePhone(phNumber))
  },
  email: {
    required: helpers.withMessage("Please provide an email address.", required),
    emailValid: helpers.withMessage("Please provide a valid email.", email)
  },
  ccNumber: {
    required: helpers.withMessage("Please provide a credit card number.", required),
    ccNumber: helpers.withMessage("Please provide a valid Credit Card number.", (cardNumber: string) => !helpers.req(cardNumber) || isCreditCard(cardNumber))
  },
  ccExpiryMonth: {
    required: helpers.withMessage("Please provide Expiry month.", required)
  },
  ccExpiryYear: {
    required: helpers.withMessage("Please provide Expiry year.", required)
  },
  //   TODO: Add more validations for these and other fields that need more validation.
};
const v$ = useVuelidate(rules, form);

async function submitOrder() {
  console.log("Submit order");
  const isFormCorrect = await v$.value.$validate();
  if (!isFormCorrect) {
    form.checkoutStatus = "ERROR";
  } else {
    try {
      form.checkoutStatus = "PENDING";
      serverErrorMessage.value = defaultServerErrorMessage;

      const placeOrderResponse: OrderDetails | ServerErrorResponse =
          await cartStore
              .placeOrder({
                name: form.name,
                address: form.address,
                phone: form.phone,
                email: form.email,
                ccNumber: form.ccNumber,
                ccExpiryMonth: form.ccExpiryMonth == null ? 0 : form.ccExpiryMonth,
                ccExpiryYear: form.ccExpiryYear == null ? 0 : form.ccExpiryYear,
              })

      if ("error" in placeOrderResponse) {
        form.checkoutStatus = "SERVER_ERROR";
        serverErrorMessage.value = placeOrderResponse.message
        console.log("Error placing order", placeOrderResponse);
      } else {
        form.checkoutStatus = "OK";
        await router.push({name: "confirmation-view"});
      }

    } catch (e) {
      form.checkoutStatus = "SERVER_ERROR";
      serverErrorMessage.value = defaultServerErrorMessage;
      console.log("Error placing order", e);
    }
  }
}

/* NOTE: For example yearFrom(0) == <current_year> */
function yearFrom(index: number) {
  return new Date().getFullYear() + index;
}

const defaultServerErrorMessage = "An unexpected error occurred, please try again."
const serverErrorMessage = ref(defaultServerErrorMessage);

</script>

<style scoped>
/* TODO: Adapt these styles to your page */
.checkout-page {
  color: var(--default-text-color);
  height: 83%;
  display: flex;
  flex-direction: column;
  overflow: auto;
  padding: 1rem 15% 1rem 15%;
  background-color: var(--default-background-color);
}

.checkout-page-body {
  display: flex;
  padding: 1em;
  width: 100%;
}

form {
  display: flex;
  flex-direction: row;
  width: 100%;
  justify-content: space-between;
}

form > div {
  display: flex;
  flex-direction: column;
  gap: 2rem;
}

form > div > div > label, form > div > div > div > label {
  font-weight: bold;
}

.checkoutStatusBox {
  padding: 1em;
  text-align: center;
  font-style: italic;
  font-size: 13px;
  color: #cb0100;
}

.checkout {
  display: flex;
  flex-direction: column;
  padding: 1rem;
  height: fit-content;
  background-color: #f2f2f2;
  gap: 1rem;
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

.cta-button {
  position: relative;
  background-color: var(--default-text-color);
  border: none;
  color: var(--secondary-text-color);
  padding: 1rem;
  border-radius: 10px;
  text-align: center;
  transition-duration: 0.4s;
  text-decoration: none;
  overflow: hidden;
  cursor: pointer;
}

.cta-button:after {
  content: "";
  background: #f1f1f1;
  display: block;
  position: absolute;
  padding-top: 300%;
  padding-left: 350%;
  margin-left: -20px !important;
  margin-top: -120%;
  opacity: 0;
  transition: all 0.8s
}

.cta-button:active:after {
  padding: 0;
  margin: 0;
  opacity: 1;
  transition: 0s
}


.checkout-main {
  display: flex;
  justify-content: space-between;
  flex-direction: column;
  padding: 1rem;
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

.cart-count {
  padding: 1rem;
}

input[type=text] {
  width: 100%;
  padding: 0.5rem 0rem;
  box-sizing: border-box;
  border: none;
  border-bottom: 2px solid #f2f2f2;
  -webkit-transition: 0.5s;
  transition: 0.5s;
  outline: none;
}

input[type=text]:focus {
  border-bottom: 2px solid var(--default-text-color);

}

select {
  width: 100%;
  padding: 0.5rem 0rem;
  border: none;
  -webkit-transition: 0.5s;
  transition: 0.5s;
  border-bottom: 2px solid #f2f2f2;
}

select:focus {
  outline: none;
  border-bottom: 2px solid var(--default-text-color);
}

.exp {
  display: flex;
  gap: 2rem;
}

.exp-month {
  width: 40%;
}

.exp-year {
  width: 20%;
}

input[type=submit] {
  background-color: var(--default-text-color);
  color: var(--secondary-text-color);
  border: .1rem solid var(--default-text-color);
  border-radius: 10px;
  padding: 1rem;
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

.place-order {
  flex-direction: column;
  align-items: baseline;
  gap: 0rem;
}

.place-order input:hover {
  color: var(--default-text-color);
  background-color: var(--secondary-text-color);
  border: .1rem solid var(--default-text-color);
}

.place-order input:active {
  transform: scale(0.98);
}

.input-values {
  width: 50%;
}

</style>

<template>
  <div class="checkout-page">
    <div class="label">
      <h1>Checkout</h1>
      <span class="line"></span>
    </div>
    <div class="cart-count" v-if="cartStore.empty">
      <span>Your cart is empty. Please add an item to your cart to checkout.</span>
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

    <div class="checkout-main" v-if="!cartStore.empty">
      <section class="checkout-page-body">
        <form @submit.prevent="submitOrder">
          <div class="input-values">
            <div>
              <label for="name">Name</label>
              <input
                  type="text"
                  size="20"
                  id="name"
                  name="name"
                  v-model.lazy="v$.name.$model"
              />
              <checkout-field-error :field-name="v$.name"></checkout-field-error>
            </div>
            <div>
              <label for="address">Address</label>
              <input
                  type="text"
                  size="100"
                  id="address"
                  name="address"
                  v-model.lazy="v$.address.$model"
              />
              <checkout-field-error :field-name="v$.address"></checkout-field-error>
            </div>

            <div>
              <label for="phone">Phone</label>
              <input
                  class="textField"
                  type="text"
                  size="20"
                  id="phone"
                  name="phone"
                  v-model.lazy="v$.phone.$model"
              />
              <checkout-field-error :field-name="v$.phone"></checkout-field-error>

            </div>

            <div>
              <label for="email">Email</label>
              <input type="text" size="20" id="email" name="email" v-model.lazy="v$.email.$model"/>
              <checkout-field-error :field-name="v$.email"></checkout-field-error>
            </div>

            <div>
              <label for="ccNumber">Credit card</label>
              <input type="text" size="20" id="ccNumber" name="ccNumber" v-model.lazy="v$.ccNumber.$model"/>
              <checkout-field-error :field-name="v$.ccNumber"></checkout-field-error>
            </div>
            <div class="expiry">
              <label>Expiry Date</label>
              <div class="exp">
                <div class="exp-month">

                  <select v-model="v$.ccExpiryMonth.$model">
                    <option
                        v-for="(month, index) in months"
                        :key="index"
                        :value="index + 1"
                    >
                      {{ month }} ({{ index + 1 }})
                    </option>
                  </select>
                </div>

                <div class="exp-year">
                  <label></label>
                  <select v-model="v$.ccExpiryYear.$model">
                    <option
                        v-for="i in 15"
                        :key="i"
                        :value="yearFrom(i - 1)"
                    >
                      {{ yearFrom(i - 1) }}
                    </option>
                  </select>

                </div>
              </div>
              <checkout-field-error :field-name="v$.ccExpiryMonth"></checkout-field-error>
              <br>
              <checkout-field-error :field-name="v$.ccExpiryYear"></checkout-field-error>
            </div>
          </div>
          <div class="place-order">
            <div class="checkout" v-if="cartStore.count>0">
              <table class="order-totals-table">
                <tbody>
                <tr class="order-subtotal" data-bag-fee="0" data-bag-fee-sku="">
                  <td>
                    Merchandise Subtotal
                  </td>
                  <td>
                    {{ asDollarsAndCents(cartStore.subTotal) }}
                  </td>
                </tr>
                <tr class="order-shipping">
                  <td>
                    Estimated Shipping &amp; Handling
                    <span class="ship-method">- Standard</span>
                  </td>
                  <td>
                    $4.99
                  </td>
                </tr>
                <tr class="order-sales-tax">
                  <td>
                    Surcharge
                  </td>
                  <td>
                    {{ asDollarsAndCents(cartStore.surcharge) }}
                  </td>
                </tr>
                <tr class="order-total">
                  <td>Order Total (USD)</td>
                  <td class="order-value">{{ asDollarsAndCents(cartStore.orderTotal) }}</td>
                </tr>
                </tbody>
              </table>

              <button type="submit" name="submit" :disabled="form.checkoutStatus === 'PENDING'"
                      class="cta-button">
                Complete Purchase
              </button>

            </div>
            <section v-show="form.checkoutStatus !== ''" class="checkoutStatusBox">
              <div v-if="form.checkoutStatus === 'ERROR'">
                Error: Please fix the problems and try again.
              </div>

              <div v-else-if="form.checkoutStatus === 'PENDING'">Processing...</div>

              <div v-else-if="form.checkoutStatus === 'OK'">Order placed...</div>

              <div v-else-if="form.checkoutStatus === 'SERVER_ERROR'">
                {{ serverErrorMessage }}
              </div>

              <div v-else>An unexpected error occurred, please try again.</div>
            </section>
          </div>
        </form>
      </section>
    </div>
  </div>
</template>
