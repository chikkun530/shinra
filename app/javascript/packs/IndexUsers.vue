<template>
    <div>
        <table id="user_list" class='table-striped table-condensed table-bordered' style="table-layout: fixed;" align="center">
            <thead>
            <tr>
                <th v-for="(value, key) in columns">
                {{ value }}
                </th>
                <th colspan="2"><button class="btn btn-xs btn-primary" id="new" v-on:click = "clear()">新規管理者</button></th>
            </tr>
            </thead>
            <tbody>
            <tr v-for="user in users">
                <td v-for="(value, key) in columns">
                {{ user[key] }}
                </td>
                <td align="center"><button class="btn btn-xs btn-info" id="edit" v-on:click = "insert(user)">編集</button></td>
                <td align="center"><button class="btn btn-xs btn-warn" id="delete" v-on:click = "delete_user(user)">削除</button></td>
            </tr>
            </tbody>
        </table>
    </div>
</template>
<script>
    import axios from 'axios'
    export default {
        props: ['Consts', 'users'],
        methods: {
            clear: function() {
                this.$emit('new-admin')
            },
            insert (u) {
                this.$emit('update-admin', u)
            },
            delete_user (u) {
                this.$emit('delete-admin', u)
            }
        },
        data: () => {
            return {
                columns: {id: 'id',username: 'ユーザ名', email: 'メールアドレス', password: 'パスワード', created_at: '作成日'}
            }
        }
    }
</script>