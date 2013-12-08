package com.ocse.doc.domain

class InfoLog {

    static constraints = {
        ip nullable: false
        type nullable: false
    }

    static belongsTo = [infoData: InfoData, user: AdminUser]

    Date infoDate
    String type
    String ip

    String getIp() {
        return ip
    }

    void setIp(String ip) {
        this.ip = ip
    }

    Date getInfoDate() {
        return infoDate
    }

    void setInfoDate(Date infoDate) {
        this.infoDate = infoDate
    }

    String getType() {
        return type
    }

    void setType(String type) {
        this.type = type
    }

    @Override
    public String toString() {
        return "InfoLog{" +
                "id=" + id +
                ", infoDate=" + infoDate +
                ", type='" + type + '\'' +
                ", ip='" + ip + '\'' +
                ", version=" + version +
                ", infoData=" + infoData +
                ", user=" + user +
                '}';
    }
}
