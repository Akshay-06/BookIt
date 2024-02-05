<script setup lang="ts">
import TheHeaderDropdown from "@/components/TheHeaderDropdown.vue";
import {useCartStore} from "@/stores/cart";
import router from "@/router";

const cartStore = useCartStore();
</script>

<style scoped>
@import url("https://fonts.googleapis.com/css?family=Kaushan+Script&display=swap");

header {
  background: var(--default-background-color);
  display: flex;
  height: 10%;
  padding: 0rem 1rem;
  justify-content: space-between;
  align-items: center;
}

.bookstore-logo {
  display: flex;
  align-items: center;
}

img {
  width: 5em;
}

.text-logo {
  font-family: Kaushan Script;
  color: var(--default-text-color) !important;
  font-size: 2vw;
  text-decoration: none;
  opacity: 1;
}

.search-bar {
  padding: 0.5em;
  opacity: 1;
  border: 1px solid var(--default-text-color);
  border-radius: 15px;
  display: flex;
  width: 25em;
}

.search-bar input {
  background: transparent;
  outline: none;
  border: 0;
  flex: 1;
  font-size: 20px;
}

.icon-search {
  background: transparent;
  cursor: pointer;
  align-items: center;
  display: flex;
  color: var(--default-text-color);
}

.header-dropdown-and-cart {
  display: flex;
  justify-content: space-between;
  align-items: center;
  height: 100%;
}

.header-dropdown-and-cart i, button {
  color: var(--default-text-color);
  font-size: 30px;
  position: relative;
  border: none;
  background-color: transparent;
  cursor: pointer;
}

.login-button {
  background: transparent;
  border: none;
  font-size: 20px;
  color: var(--default-text-color);
}

.icon-user, .icon-shopping-cart, .fa-cart-plus {
  padding: 0.5em;
}

.icon-shopping-cart {
  background: transparent;
  border: none;
  color: var(--default-text-color);
}

.fa-cart-plus {
  background: transparent;
  border: none;
  color: var(--default-text-color);
}

.badge {
  padding-left: 9px;
  padding-right: 9px;
  -webkit-border-radius: 9px;
  -moz-border-radius: 9px;
  border-radius: 9px;
}

.label-warning[href],
.badge-warning[href] {
  background-color: #c67605;
}

#lblCartCount {
  font-size: 19px;
  position: absolute;
  font-family: var(--default-font-family);
  font-weight: bolder;
  padding: 0 5px;
  top: 7px;
  left: 38px;
}

</style>

<template>
  <header class="container">
    <section class="bookstore-logo">
      <router-link to="/AkshayBookstoreTransact">
        <img src="/site-images/logo.jpeg" alt="Another Bookstore Logo" width="150"/>
      </router-link>
      <router-link class="text-logo" to="/AkshayBookstoreTransact">
        BookIt
      </router-link>
    </section>
    <section class="title-and-search-bar">
      <form action="" class="search-bar">
        <input type="text" placeholder="Search"/><br/>
        <router-link to="/AkshayBookstoreTransact/category/Best Sellers" class="icon-search"></router-link>
      </form>
    </section>
    <section class="header-dropdown-and-cart">
      <p class="login-button">Hello, Akshay</p>
      <button class="icon-user"></button>
      <the-header-dropdown></the-header-dropdown>
      <button class="fa fa-bell"></button>
      <button v-if="cartStore.count>0" class="icon-shopping-cart"
              @click="router.push({path: '/AkshayBookstoreTransact/cart'})">
        <span class='badge badge-warning' id='lblCartCount'> {{ cartStore.count }} </span>
      </button>
      <button v-else class="fa fa-cart-plus" @click="router.push({path: '/AkshayBookstoreTransact/cart'})"></button>
    </section>
  </header>
</template>

