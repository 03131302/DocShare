package com.ocse.doc.domain

import groovy.sql.Sql

class AdminUser {

    def dataSource

    static constraints = {
        userName nullable: false
        userCode nullable: false
        passWord nullable: false
        text nullable: true
    }

    static mapping = {
        sort pxh: "asc"
    }

    static belongsTo = [org: Organization]
    static hasMany = [roles: AdminRole]

    String userName
    String userCode
    String passWord
    String text
    float pxh
    boolean isStop
    String jb
    int zhiwu

    String getJb() {
        return jb
    }

    int getZhiwu() {
        return zhiwu
    }

    void setZhiwu(int zhiwu) {
        this.zhiwu = zhiwu
    }

    void setJb(String jb) {
        this.jb = jb
    }

    boolean getIsStop() {
        return isStop
    }

    void setIsStop(boolean isStop) {
        this.isStop = isStop
    }

    String getUserName() {
        return userName
    }

    float getPxh() {
        return pxh
    }

    void setPxh(float pxh) {
        this.pxh = pxh
    }

    String getText() {
        return text
    }

    void setText(String text) {
        this.text = text
    }

    void setUserName(String userName) {
        this.userName = userName
    }

    String getUserCode() {
        return userCode
    }

    void setUserCode(String userCode) {
        this.userCode = userCode
    }

    String getPassWord() {
        return passWord
    }

    void setPassWord(String passWord) {
        this.passWord = passWord
    }

    def beforeUpdate() {
        log.info("开始执行:update.......")
        Sql sql = new Sql(dataSource: dataSource);
        String p = "";
        sql.eachRow("select [pass_word] from [DocManage].[dbo].[admin_user] where id=${id}") { data ->
            p = data.pass_word;
        }
        log.info("开始执行:update......." + p + ":" + passWord)
        if (!p.equals(passWord)) {
            passWord = passWord.encodeAsMD5()
        }
    }

    def beforeInsert() {
        log.info("开始执行:insert.......")
        passWord = passWord.encodeAsMD5()
    }

    @Override
    public String toString() {
        return "AdminUser{" +
                "id=" + id +
                ", userName='" + userName + '\'' +
                ", userCode='" + userCode + '\'' +
                ", passWord='" + passWord + '\'' +
                ", text='" + text + '\'' +
                ", pxh=" + pxh +
                ", isStop=" + isStop +
                ", jb='" + jb + '\'' +
                ", zhiwu='" + zhiwu + '\'' +
                ", version=" + version +
                '}';
    }
}
