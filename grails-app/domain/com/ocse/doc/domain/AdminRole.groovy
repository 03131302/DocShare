package com.ocse.doc.domain

class AdminRole {

    static constraints = {
        name nullable: false
    }

    static belongsTo = [AdminUser, Organization]
    static hasMany = [users: AdminUser, orgs: Organization]

    String name
    String text
    int level

    String getName() {
        return name
    }

    int getLevel() {
        return level
    }

    void setLevel(int level) {
        this.level = level
    }

    void setName(String name) {
        this.name = name
    }

    String getText() {
        return text
    }

    void setText(String text) {
        this.text = text
    }

    @Override
    public String toString() {
        return "AdminRole{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", text='" + text + '\'' +
                ", level=" + level +
                ", version=" + version +
                '}';
    }
}
