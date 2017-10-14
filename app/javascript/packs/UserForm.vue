<template>
    <div class="row">
        <form id="user_form" class="form-horizontal" novalidate>
            <input type="hidden" name="user[id]" v-model="user.id">
            {{user}}
            <div class="row">
                <div v-bind:class="Consts.layout.field_label_width">
                    <div class="form-group">
                        <label v-bind:class="Consts.layout.label_width">{{fieldsInfo['username']['attrs']['data-vv-as']}}</label>
                        <div v-bind:class="Consts.layout.field_width">
                            <input type="text" class="form-control"
                                   v-model="user.username"
                                   v-bind="fieldsInfo['username']['attrs']"
                                   v-validate="fieldsInfo['username']['validate']"/>
                            <p class="alert-danger">
                                {{ errors.first('user[username]') }}
                            </p>
                            <div class="setumei">{{fieldsInfo['username']['setumei']}}</div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div v-bind:class="Consts.layout.field_label_width">
                    <div class="form-group">
                        <label v-bind:class="Consts.layout.label_width">{{fieldsInfo['email']['attrs']['data-vv-as']}}</label>
                        <div v-bind:class="Consts.layout.field_width">
                            <input type="text" v-model="user.email" class="form-control"
                                   v-bind="fieldsInfo['email']['attrs']" v-validate="fieldsInfo['email']['validate']"/>
                            <p class="alert-danger">
                                {{ errors.first('user[email]') }}
                            </p>
                            <div class="setumei">{{fieldsInfo['email']['setumei']}}</div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div v-bind:class="Consts.layout.field_label_width">
                    <div class="form-group">
                        <label v-bind:class="Consts.layout.label_width">{{fieldsInfo['password']['attrs']['data-vv-as']}}</label>
                        <div v-bind:class="Consts.layout.field_width">
                            <input type="password" class="form-control"
                                   v-model="user.password"
                                   v-bind="fieldsInfo['password']['attrs']"
                                   v-validate="fieldsInfo['password']['validate']"/>
                            <p class="alert-danger">
                                {{ errors.first('user[password]') }}
                            </p>
                            <div class="setumei">{{fieldsInfo['password']['setumei']}}</div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div v-bind:class="Consts.layout.field_label_width">
                    <div class="form-group">
                        <label v-bind:class="Consts.layout.label_width">{{fieldsInfo['confirm_password']['attrs']['data-vv-as']}}</label>
                        <div v-bind:class="Consts.layout.field_width">
                            <input type="password" class="form-control"
                                   v-model="user.confirm_password"
                                   v-bind="fieldsInfo['confirm_password']['attrs']"
                                   v-validate="fieldsInfo['confirm_password']['validate']"/>
                            <p class="alert-danger">
                                {{ errors.first('user[confirm_password]') }}
                            </p>
                            <div class="setumei">{{fieldsInfo['confirm_password']['setumei']}}</div>
                        </div>
                    </div>
                </div>
            </div>
            <button type="button" class="btn btn-xs btn-primary pull-right" v-on:click="saveOrUpdate"
                    v-bind:disabled="errors.any()">この内容で保存する
            </button>
            <button type="button" class="btn btn-xs btn-sucess pull-right" v-on:click="hide_self">入力フォームを隠す</button>
        </form>
    </div>
</template>

<script>
    import Vue from 'vue'
    import _ from 'lodash'
    import json from './user_form.json'
    import VeeValidate, {Validator} from 'vee-validate'
    import messages from 'vee-validate/dist/locale/ja'
    VeeValidate.Validator.addLocale(messages)
    import axios from 'axios'
    let token = document.getElementsByName('csrf-token')[0].getAttribute('content');
    axios.defaults.headers.common['X-CSRF-Token'] = token;
    axios.defaults.headers['X-Requested-With'] = 'XMLHttpRequest';

    const isUniqueEmail = (value) => {
        return axios.post('/api/users/exists', {email: value.email, id: value.id}).then((res) => {
            return {
                valid: res.data.valid,
                data: {
                    message: "すでにそのメールアドレスは使用されています。"
                }
            };
        });
    };
    Validator.extend('isUniqueEmail', {
        validate: isUniqueEmail,
        getMessage: (field, params, data) => {
            return data.message;
        }
    });
    // import jsonp from 'jsonp'
    // let jsonpAdapter = require('axios-jsonp')
    Vue.use(VeeValidate, {
        locale: 'ja',
        fieldsBagName: 'vFields',
        dictionary: {
            ja: {
                custom: {
                    password: {
                        regex: 'アルファベット大文字・小文字、数字をそれぞれ1文字以上入れてください。'
                    },
                    confirm_password: {
                        regex: 'アルファベット大文字・小文字、数字をそれぞれ1文字以上入れてください。'
                    }
                }
            }
        }
    })
    var fieldsInfo = {}

    // ここにフィールド名の一覧を書く
    var dataInit = {username: '', password: '', confirm_password: '', email: ''}
    export default {
        name: 'UserForm',
        props: ['Consts', 'user'],
        created: function () {
            // dataInitのキーで回して、user_form.jsonから情報を読み取る
            Object.keys(dataInit).forEach((key) => {
                if (!fieldsInfo[key]) {
                    fieldsInfo[key] = {}
                }
                // 表示用のフィールド名(ログイン名など)
                if (json.fields[key] && json.fields[key]['display']) {
                    fieldsInfo[key]['attrs'] = {
                        id: `id_${key}`,
                        "v-mmodel": `user.${key}`,
                        name: `user[${key}]`,
                        'data-vv-as': json.fields[key]['display']
                    }
                } else {
                    // ない場合は「未設定」
                    fieldsInfo[key]['attrs'] = {
                        id: `id_${key}`,
                        "v-mmodel": `user.${key}`,
                        name: `user[${key}]`,
                        'data-vv-as': '未設定'
                    }
                }
                // フィールド名の説明
                if (json.fields[key] && json.fields[key]['setumei']) {
                    fieldsInfo[key]['setumei'] = json.fields[key]['setumei']
                } else {
                    // ない場合は「未設定」
                    fieldsInfo[key]['setumei'] = ""
                }
                // validateの文字列(→vee-validateの簡易版の書き方---Objectの書き方じゃない)
                if (json.fields[key] && json.fields[key]['validate']) {
                    fieldsInfo[key]['validate'] = json.fields[key]['validate']
                } else {
                    fieldsInfo[key]['validate'] = ''
                }
            })
            this.$on('insert-user', function () {
                this.errors.clear()
                console.log('parent event')
            })
        },
        methods: {
            temp () {
                console.log('yeahhhhhhhhhhhhhhhhhh')
            },
            validate_reset() {
                this.errors.clear()
            },
            clear () {
                let u = {id: null, email: null, username: null, password: null}
                this.$data.user = u;
                this.$data.flag = true;
            },
            hide_self () {
                this.$emit('hide-form')
            },
            saveOrUpdate (e) {
                var c_user = _.cloneDeep(this.user);
                this.$validator.validateAll().then(result => {
                    if (result) {
                        if (!c_user['id']) {
                            axios.post('/api/users', {user: c_user})
                                .then((res) => {
                                    this.$emit("refresh-users", res.data.users)
                                })
                                .catch(function (error) {
                                    console.log(error);
                                });
                        } else {
                            // idがある場合は更新
                            axios.put(`/api/users/${c_user['user[id]']}`, {user: c_user})
                                .then((res) => {
                                    console.log(res);
                                    this.$emit("refresh-users", res.data.users)
                                })
                                .catch(function (error) {
                                    console.log(error);
                                });
                        }
                    } else {
                        e.preventDefault();
                    }
                });
            }
        },
        data () {
            // フィールド名とマージして
            return  {
                ...dataInit,
                    enable: true,
                    users: [],
                    json: json,
                    fieldsInfo: fieldsInfo
                }

//            return _.extend(dataInit,
//                {
//                    enable: true,
//                    users: [],
//                    json: json,
//                    fieldsInfo: fieldsInfo
//                })
        }

    }
</script>

<style lang="scss" scoped>
</style>
