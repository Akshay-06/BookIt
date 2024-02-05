<script setup lang="ts">
</script>

<style scoped>
footer {
  background: var(--default-text-color);
  display: flex;
  height: 7%;
  align-items: center;
  justify-content: space-between;
  padding: 1rem;
}

.social-media-icons a {
  cursor: pointer;
  color: var(--secondary-text-color);
}

.links,
.social-media-icons {
  display: flex;
  flex-direction: row;
  text-align: center;
  gap: 1em;
}

.links a {
  color: var(--secondary-text-color);
  text-decoration: none;
}

.copyright {
  color: var(--secondary-text-color);
}
</style>

<template>
  <footer class="footer-container">
    <section class="social-media-icons">
      <a href="https://www.facebook.com/" target="_blank" class="icon-facebook"></a>
      <a href="https://twitter.com/" target="_blank" class="icon-twitter"></a>
      <a href="https://www.instagram.com/" target="_blank" class="icon-instagram"></a>
    </section>
    <section class="copyright">
      Copyright &copy;, 2023 BookIt.com
    </section>
    <section class="links">
      <a href="#">Location <i class="icon-map-marker"></i></a>
      <a href="#">Contact Us</a>
    </section>
  </footer>
</template>
