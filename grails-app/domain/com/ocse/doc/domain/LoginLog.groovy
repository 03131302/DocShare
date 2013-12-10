package com.ocse.doc.domain

class LoginLog {

    static constraints = {
        loginDate nullable: false
    }

    static belongsTo = [user: AdminUser]

    String ip
    Date loginDate

    String getIp() {
        return ip
    }

    void setIp(String ip) {
        this.ip = ip
    }

    Date getLoginDate() {
        return loginDate
    }

    void setLoginDate(Date loginDate) {
        this.loginDate = loginDate
    }

    @Override
    public String toString() {
        return "LoginLog{" +
                "id=" + id +
                ", ip='" + ip + '\'' +
                ", loginDate=" + loginDate +
                ", version=" + version +
                '}';
    }
}
