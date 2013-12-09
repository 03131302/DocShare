package com.ocse.doc.domain

class AdminUser {

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
    int pxh
    boolean isStop
    String jb

    String getJb() {
        return jb
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

    int getPxh() {
        return pxh
    }

    void setPxh(int pxh) {
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
                ", jb=" + jb +
                ", version=" + version +
                '}';
    }
}
