package com.ocse.doc.domain

class Recipient {

    static constraints = {
    }

    static belongsTo = [infoData: InfoData, user: AdminUser]

    String text

    String getText() {
        return text
    }

    void setText(String text) {
        this.text = text
    }

    @Override
    public String toString() {
        return "Recipient{" +
                "id=" + id +
                ", text='" + text + '\'' +
                ", version=" + version +
                '}';
    }
}
