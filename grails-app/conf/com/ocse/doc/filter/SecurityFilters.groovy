package com.ocse.doc.filter

class SecurityFilters {

    def filters = {
        all(controller: '*', action: '*') {
            before = {
                if (session["adminUser"] == null && !controllerName.equals("login")&& !controllerName.equals("jcaptcha")) {
                    session.removeAttribute("adminUser");
                    session.invalidate();
                    redirect([controller: "login", action: "index"])
                }
            }
            after = { Map model ->
            }
            afterView = { Exception e ->

            }
        }
    }
}
