<template>
    <div>
        <table id="user_list" v-bind:class='Consts.layout.table_normal' align="center">
            <thead>
            <tr>
                <th v-for="(value, key) in columns">
                    {{ value }}
                </th>
                <th colspan="2">
                    <button v-bind:class='Consts.layout.xs_button_primary' id="new" v-on:click="clear()">新規管理者</button>
                </th>
            </tr>
            </thead>
            <tbody>
            <tr v-for="user in users">
                <td v-for="(value, key) in columns">
                    {{ user[key] | dformat}}
                </td>
                <td align="center">
                    <button v-bind:class='Consts.layout.xs_button_info' id="edit" v-on:click="insert(user)">編集</button>
                </td>
                <td align="center">
                    <button v-bind:class='Consts.layout.xs_button_warn' id="delete" v-on:click="delete_user(user)">削除
                    </button>
                </td>
            </tr>
            </tbody>
        </table>
    </div>
</template>
<script>
    import axios from 'axios'
    export default {
        props: ['Consts', 'users'],
        filters: {
            dformat: (str) => {
                if (Object.prototype.toString.call(str) !== '[object String]' && Object.prototype.toString.call(str) !== '[object Date]') {
                    return str
                }
                if (Object.prototype.toString.call(str) === '[object Date]') {
                    var dateFormat = new DateFormat("yyyy/MM/dd HH:mm:ss");
                    return dateFormat.format(str); // Date(現在時刻)をStringに変換
                } else if (Object.prototype.toString.call(str) === '[object String]' && /^(\d\d\d\d\-\d\d?\-\d\d?)T(\d\d:\d\d:\d\d).*\Z$/.test(str)) {
                    var r = str.match(/^(\d\d\d\d\-\d\d?\-\d\d?)T(\d\d:\d\d:\d\d).*\Z$/)
                    if (r) {
                        return r[1] + " " + r[2]
                    } else {
                        return str
                    }
                } else {
                    return str
                }
            }
        },
        methods: {
            clear: function () {
                this.$emit('new-admin')
            },
            insert (u) {
                this.$emit('update-admin', u)
            },
            delete_user (u) {
                this.$emit('delete-admin', u)
            }
        },
        created: function () {
        },
        data: function () {
            return {
                columns: {id: 'id', username: 'ユーザ名', email: 'メールアドレス', password: 'パスワード', created_at: '作成日'}
            }
        }
    }
</script>