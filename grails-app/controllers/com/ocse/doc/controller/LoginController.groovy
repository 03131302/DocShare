package com.ocse.doc.controller

import com.ocse.doc.domain.AdminUser
import com.ocse.doc.domain.LoginLog
import groovy.sql.Sql

class LoginController {

    def dataSource
    def jcaptchaService

    def index() {
        render view: "login", model: [data: ""]
    }

    def login(String userName, String passWord, String code) {
        if (jcaptchaService.validateResponse("imageCaptcha", session.id, code)) {
            if (userName != null && passWord != null && code != null) {
                Sql sql = new Sql(dataSource: dataSource);
                String id = ""
                sql.eachRow("""
                              select [id] from [DocManage].[dbo].[admin_user] where [is_stop]=1 and [user_code]=${
                    userName
                } and [pass_word]=${passWord.encodeAsMD5()} """) {
                    data ->
                        id = data.id
                }
                if (!id.empty) {
                    AdminUser user = AdminUser.get(id);
                    session.setAttribute("adminUser", user);
                    try {
                        LoginLog log = new LoginLog(user: user, ip: request.getRemoteAddr(), loginDate: new Date())
                        log.save flash: true
                    } catch (Exception e) {
                        e.printStackTrace()
                    }
                    redirect([action: "index", controller: "index"])
                } else {
                    render view: "login", model: [data: "用户名、密码错误，或者该账号已停用！"]
                }
            }
        } else {
            render view: "login", model: [data: "验证码错误！"]
            return
        }
    }

    def logout() {
        session.removeAttribute("adminUser");
        session.invalidate();
        render view: "login", model: [data: ""]
    }
}
