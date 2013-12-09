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
        params.max = Math.min(max ?: 20, 100)
        render view: "userManageIndex", model: [users: AdminUser.list(params), adminUserInstanceCount: AdminUser.count()]
    }
}
