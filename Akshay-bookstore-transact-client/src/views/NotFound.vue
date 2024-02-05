<script setup lang="ts">
import router from "@/router";

</script>

<style scoped>
.page {
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

.line {
  width: 100%;
  height: 4%;
  display: block;
  background-color: var(--default-text-color);
}

p {
  padding: 0rem 1rem;
}

.invalid{
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
}

.invalid img{
  height: 80%;
  width: 80%;
}

.shopping {
  display: flex;
  align-items: center;
  justify-content: center;
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

.invalid h3{
  padding-bottom: 1rem;
}

</style>
<template>
  <div class="page">
    <div class="label">
      <h1>Invalid Page</h1>
      <span class="line"></span>
    </div>
    <div class="invalid">
    <img src="/site-images/invalid-page.webp" alt="invalid-page">
      <h3>Yikes!</h3>
      <p>We can't find the page you are looking for. We're sorry about that.
      </p>
      <p> You'll find lots to explore on the category page</p></div>
    <div class="shopping">
      <button @click="router.push('/AkshayBookstoreTransact/category')"><i class="fa fa-arrow-left"></i> Shop Books
      </button>
    </div>
  </div>
</template>