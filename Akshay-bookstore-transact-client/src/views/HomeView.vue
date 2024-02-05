<script setup lang="ts">
</script>

<style scoped>
.home-page {
  display: flex;
  height: 83%;
  background-image: url("/site-images/Background_image.png");
  background-size: cover;
  background-position: center;
  width: 100%;
}

.main-content {
  width: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  flex-direction: column;
  text-align: justify;
  color: var(--default-text-color);
  gap: 1em;
}

.a {
  width: 90%;
}

.main-content p {
  margin: 1em 0;
}

.cta-button {
  background-color: var(--default-text-color);
  color: var(--secondary-text-color);
  outline: none;
  border-radius: 15px;
  font-size: 25px;
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

.cta-button a {
  text-decoration: none;
  position: relative;
  transition: 0.5s;
}

.cta-button a:after {
  content: '\00bb';
  position: absolute;
  opacity: 0;
  top: 0;
  right: -20px;
  transition: 0.5s;
}

.cta-button:hover a {
  padding-right: 1rem;
}

.cta-button:hover a:after {
  opacity: 1;
  right: 0;
}

.cta-button:active {
  transform: scale(0.98);
}
</style>
<template>
  <div class="home-page">
    <div class="main-content">
      <div class="a">
        <h1>Discover a world of books at your fingertips</h1>
        <p>
          Explore our vast collection of books, from classics to bestsellers. Whether you're seeking a thrilling
          mystery, a heartwarming romance, or a thought-provoking non-fiction title, we have something for everyone
        </p>
      </div>
      <div>
        <button class="cta-button">
          <router-link to="/AkshayBookstoreTransact/category/Best Sellers">Shop for Books!!</router-link>
        </button>
      </div>
    </div>
    <div class="b">
    </div>
  </div>
</template>


