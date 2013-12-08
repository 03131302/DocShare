package com.ocse.doc.domain

class InfoType {

    static constraints = {
        name nullable: false
    }

    String name
    int pxh
    InfoType parentInfoType

    String getName() {
        return name
    }

    void setName(String name) {
        this.name = name
    }

    int getPxh() {
        return pxh
    }

    void setPxh(int pxh) {
        this.pxh = pxh
    }

    InfoType getParentInfoType() {
        return parentInfoType
    }

    void setParentInfoType(InfoType parentInfoType) {
        this.parentInfoType = parentInfoType
    }

    @Override
    public String toString() {
        return "InfoType{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", pxh=" + pxh +
                ", parentInfoType=" + parentInfoType +
                ", version=" + version +
                '}';
    }
}
