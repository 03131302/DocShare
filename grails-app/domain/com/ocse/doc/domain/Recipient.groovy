package com.ocse.doc.domain

class Recipient {

    static constraints = {
    }

    static belongsTo = [infoData: InfoData, user: AdminUser]
}
