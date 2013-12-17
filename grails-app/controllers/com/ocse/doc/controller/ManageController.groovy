package com.ocse.doc.controller

import com.ocse.doc.domain.AdminUser
import groovy.sql.Sql

class ManageController {

    def dataSource

    def index() {
        render view: "index", model: [data: ""]
    }

    def getOrgTreeData() {
        def listData = []
        Sql sql = new Sql(dataSource: dataSource)
        sql.eachRow("""
                    SELECT [id]
                          ,[version]
                          ,[name]
                          ,[parent_id]
                          ,[pxh]
                          ,[text]
                      FROM [DocManage].[dbo].[organization] order by pxh""") {
            data ->
                def map = [id: data.id, name: data.name, pId: data.parent_id == null ? 0 : data.parent_id, drag: true]
                listData.add(map)
        }
        render(contentType: "text/json") { listData }
    }

    def userManageIndex(Integer max) {
        params.max = Math.min(max ?: 30, 100)
        if (params.userNameLike == null) {
            params.userNameLike = ""
        }
        def c = AdminUser.where {
            userName ==~ "%${params.userNameLike.toString()}%"
        }
        render view: "userManageIndex", model: [users: c.list(params), adminUserInstanceCount: c.count()
                , userNameLike: params.userNameLike]
    }

    def updatePassWord(String oldPassWord, String newPassWord) {
        AdminUser user = session["adminUser"];
        if (user != null && !oldPassWord.empty && !newPassWord.empty) {
            Sql sql = new Sql(dataSource: dataSource);
            String d = "";
            println(oldPassWord + ":" + user.getId() + ":" + oldPassWord.encodeAsMD5())
            sql.eachRow("select id from [DocManage].[dbo].[admin_user] where [id]=? and [pass_word]=?", [user.getId(), oldPassWord.encodeAsMD5()]) {
                data ->
                    d = data.id;
            }
            if (d.empty) {
                render "旧密码不正确！"
            } else {
                sql.execute("update [DocManage].[dbo].[admin_user] set [pass_word]=? where [id]=?", [newPassWord.encodeAsMD5(), d]);
                render "true"
                session.removeAttribute("adminUser");
                session.invalidate();
            }
        } else {
            render "请正确填写新旧密码！"
        }
    }
}
