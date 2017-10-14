import Vue from 'vue'
import Users from './Users'
window.addEventListener("DOMContentLoaded", () => {
    new Vue({
        el: '#users',
        render: h => h(Users)
    })
})
