<script setup lang="ts">
import type {BaseValidation} from "@vuelidate/core";

const props = defineProps<{
  fieldName: BaseValidation;
}>();
</script>

<style scoped>
.error {
  color: #cb0100;
  font-size: 13px;
  font-style: italic;
}
</style>

<template>
  <template v-if="props.fieldName.$error">
    <span
        class="error"
        v-for="error of props.fieldName.$errors"
        :key="error.$uid"
    >{{ error.$message }}</span
    >
  </template>
</template>