import Vue from 'vue'
import App from './index.vue';
document.addEventListener('DOMContentLoaded', () => {
    const app = new Vue({ // eslint-disable-line no-new
        el: '#MyAppRoot',
        render: h => h(App)
    })
    console.log(app)
})
