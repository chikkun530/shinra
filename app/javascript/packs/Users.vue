<template>
    <div>
        <div id="page-header" class="page-header">
            <h4>管理者管理</h4>
        </div>
        <user-form ref="user-form" v-show="show_form" :Consts="Consts"  :user="user" v-on:hide-form="hide_form" v-on:refresh-users="refresh_users"></user-form>
        <users-list ref="users-list" :Consts="Consts" :users="users" v-on:new-admin="clear()" v-on:update-admin="insert" v-on:delete-admin="delete_user"></users-list>
    </div>
</template>
<script>
    import UsersList from './IndexUsers.vue'
    import UserForm from './UserForm.vue'
    import consts from './consts.json'
    import axios from 'axios'
    export default {
        name: 'users',
        components: {UsersList, UserForm},
        mounted: function(){
            console.log("mounted")
        },
        methods: {
            clear () {
                this.show_form = true
                this.$refs["user-form"].validate_reset()
                this.user= {id: null, username: null, email: null, password: null, confirm_password: null}
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
                this.show_form = true
                console.log(this.$refs)
                this.$refs["user-form"].validate_reset()
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
                Consts: consts,
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
                this.users = this.users
            }
        }
    }
</script>