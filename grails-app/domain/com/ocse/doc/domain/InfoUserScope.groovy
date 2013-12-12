package com.ocse.doc.domain

class InfoUserScope {

    static constraints = {
    }

    static belongsTo = [user: AdminUser, info: InfoData]
}
