<template>
    <div>
        <div id="page-header" class="page-header">
            <h4>管理者管理</h4>
        </div>
        <user-form :Consts="Consts" v-if="show_form"  :user="user" v-on:hide-form="hide_form" v-on:refresh-users="refresh_users"></user-form>
        <users-list :Consts="Consts" :users="users" v-on:new-admin="clear()" v-on:update-admin="insert" v-on:delete-admin="delete_user"></users-list>
        <div>{{show_form}}</div>
    </div>
</template>
<script>
    // v-model="show_form"
    import UsersList from './IndexUsers.vue'
    import UserForm from './UserForm.vue'
    import Consts from './consts.json'
    import axios from 'axios'
    export default {
        name: 'users',
        components: {UsersList, UserForm},
        methods: {
            clear () {
                this.show_form = true
            },
            hide_form () {
                this.show_form = false
            },
            refresh_users (users) {
                this.users = users
            },
            insert (user) {
                this.user = user
                this.user['confirm_password'] = user.password
                console.log(user)
                this.show_form = true
                console.log(this.$children[1])

                if (this.$children[1]) {
                    this.$children[1].validate_reset()
                }
            },
            delete_user (user) {
                axios.delete(`/api/users/${user.id}`)
                    .then((res) => {
                        console.log(res)
                        this.users = res.data.users
                    })
            }
        },
        data ()  {
            return {
                show_form: false,
                Consts: Consts,
                users: [],
                user: {id: null, username: null, email: null, password: null, confirm_password: null}
            }
        },
        created:  function () {
            if (!this.usres) {
                axios.get('/api/users/')
                    .then((res) => {
                        console.log(res)
                        this.users = res.data
                    })
            } else {
                this.users = this.users;
            }
        }
    }
</script>