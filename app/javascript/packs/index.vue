<template>
  <div>
    <p>{{ message }}</p>
  </div>
</template>
<script>
export default {
  data: () => {
    return {
      message: "Hello Vue!"
    }
  }
}
</script>

<style scoped>
p {
  font-size: 10em;
  text-align: center;
  color: blue;
}
</style>
