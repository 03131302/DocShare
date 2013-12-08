package com.ocse.doc.domain

class Organization {

    static constraints = {
        name nullable: false
        parent nullable: true
        text nullable: true
    }
    static hasMany = [roles: AdminRole]

    String name
    String text
    Organization parent

    Organization getParent() {
        return parent
    }

    void setParent(Organization parent) {
        this.parent = parent
    }

    String getText() {
        return text
    }

    void setText(String text) {
        this.text = text
    }
    int pxh

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

    @Override
    public String toString() {
        return "Organization{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", text='" + text + '\'' +
                ", parent=" + parent +
                ", pxh=" + pxh +
                ", version=" + version +
                '}';
    }
}
