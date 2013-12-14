package com.ocse.doc.controller

import com.ocse.doc.domain.InfoData
import com.ocse.doc.domain.InfoUserScope
import groovy.sql.Sql

class IndexController {

    def dataSource

    def index() {
        def session = request.getSession()
        if (session["adminUser"] == null) {
            return false
        }
        Sql sql = new Sql(dataSource: dataSource)
        def sendList = []
        sql.eachRow("""
                    SELECT TOP 5 [id]
                          ,[version]
                          ,[save_date]
                          ,[save_state]
                          ,[share_scope]
                          ,[share_type]
                          ,[title]
                          ,(SELECT [name]
                            FROM [DocManage].[dbo].[info_type] n where n.id=[type_id]) type
                          ,[user_id]
                          ,[text_data]
                          ,[re_type]
                      FROM [DocManage].[dbo].[info_data] where [user_id]='${
            session["adminUser"].id
        }' order by [save_date] desc""") {
            data ->
                def map = [id: data.id, date: data.save_date, title: data.title, type: data.type]
                sendList.add(map)
        }
        def allList = []
        sql.eachRow("""
                    SELECT TOP 20 [id]
                                  ,[version]
                                  ,[save_date]
                                  ,[save_state]
                                  ,[share_scope]
                                  ,[share_type]
                                  ,[title]
                                  ,(SELECT n.[name]
                                FROM [DocManage].[dbo].[info_type] n where n.id=[type_id]) type
                                 ,(SELECT [user_name]
                                FROM [DocManage].[dbo].[admin_user] where [id]=[user_id]) [user]
                                  ,[text_data]
                                  ,[re_type]
                              FROM [DocManage].[dbo].[info_data] where [share_type]='全部' order by [save_date] desc""") {
            data ->
                def map = [id: data.id, date: data.save_date, title: data.title, type: data.type,
                        re_type: data.re_type, user: data.user, shareScope: data.share_scope]
                allList.add(map)
        }

        def recveList = []
        sql.eachRow("""
                   SELECT TOP 5  b.[id]
                                ,b.[version]
                                ,[save_date]
                                ,[save_state]
                                ,[share_scope]
                                ,[share_type]
                                ,[title]
                                ,(SELECT [name]
                                FROM [DocManage].[dbo].[info_type] n where n.id=[type_id]) type
                                ,(SELECT [user_name]
                                FROM [DocManage].[dbo].[admin_user] where [id]=b.[user_id]) [user]
                                ,[text_data]
                                ,[re_type]
                                  FROM [DocManage].[dbo].[info_user_scope] a,[DocManage].[dbo].[info_data] b where
                                  b.id=a.info_id and a.[user_id]='${
            session["adminUser"].id
        }' order by [save_date] desc""") {
            data ->
                def map = [id: data.id, date: data.save_date, title: data.title, type: data.type,
                        re_type: data.re_type, user: data.user]
                recveList.add(map)
        }
        render view: "index", model: [sendList: sendList, allList: allList, recveList: recveList]
    }

    def search() {
        String keyValue = params.keyValue
        String typeKey = params.typeKey
        def searchList = []
        String sqlText = "SELECT TOP 1000  b.[id]\n" +
                "   ,b.[version]\n" +
                "   ,[save_date]\n" +
                "   ,[save_state]\n" +
                "   ,[share_scope]\n" +
                "   ,[share_type]\n" +
                "   ,[title]\n" +
                "   ,(SELECT [name]\n" +
                "   FROM [DocManage].[dbo].[info_type] n where n.id=[type_id]) type\n" +
                "   ,(SELECT [user_name]\n" +
                "   FROM [DocManage].[dbo].[admin_user] where [id]=b.[user_id]) [user]\n" +
                "   ,[text_data]\n" +
                "   ,[re_type]\n" +
                "  FROM [DocManage].[dbo].[info_data] b where 1=1 "
        Sql sql = new Sql(dataSource: dataSource)
        if (keyValue != null && !keyValue.empty) {
            sqlText += " and ([title] like '%" + keyValue + "%' or [text_data] like '%" + keyValue + "%')"
        }
        if (typeKey != null && !typeKey.empty) {
            sqlText = "WITH orgtree([id],[name],[parent_info_type_id],[pxh]) as\n" +
                    "(\n" +
                    "SELECT [id],[name],[parent_info_type_id],[pxh] FROM [DocManage].[dbo].[info_type] WHERE id ='${typeKey}'\n" +
                    "UNION ALL\n" +
                    "SELECT a.[id],a.[name],a.[parent_info_type_id],a.[pxh] FROM [DocManage].[dbo].[info_type] A,orgtree b\n" +
                    "where a.parent_info_type_id = b.id\n" +
                    ") \n" + sqlText + " and [type_id] in (SELECT id  from orgtree) "
        }
        log.info(sqlText)
        sql.eachRow(sqlText + " order by [save_date] desc") {
            data ->
                def map = [id: data.id, date: data.save_date, title: data.title, type: data.type,
                        re_type: data.re_type, user: data.user, shareScope: data.share_scope]
                searchList.add(map)
        }
        render view: "search", model: [keyValue: params.keyValue, searchList: searchList, typeKey: params.typeKey,
                typeKeyName: params.typeKeyName]
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

    def more(Integer max) {
        params.max = Math.min(max ?: 30, 100)
        int type = params.theType
        switch (params.theType) {
            case "1":
                def results = InfoData.where {
                    user == session["adminUser"]
                }
                params.sort = "saveDate"
                params.order = "desc"
                render view: "more", model: [infoDataInstanceCount: results.count(),
                        infoData: results.list(params), title: "发件箱"]
                break
            case "2":
                if (params.offset == null) {
                    params.offset = 0
                }
                params.sort = "saveDate"
                params.order = "desc"
                def theData = []
                def results = InfoData.findAll("from InfoData d,InfoUserScope o where o.info=d " +
                        " and  o.user.id=${session["adminUser"].id} order by d.saveDate desc", [max: params.max, offset: params.offset])
                def o = InfoData.executeQuery("select count(d.id) from InfoUserScope o,InfoData d where o.info=d " +
                        " and  o.user.id='${session["adminUser"].id}'")
                results.each { data ->
                    data.each {
                        d->
                            if(d instanceof InfoData){
                                theData.add(d)
                            }
                    }
                }
                render view: "more", model: [infoDataInstanceCount: o[0],
                        infoData: theData, title: "收件箱"]
                break
            case "3":
                def results = InfoData.where {
                    shareType == "全部"
                }
                params.sort = "saveDate"
                params.order = "desc"
                render view: "more", model: [infoDataInstanceCount: results.count(),
                        infoData: results.list(params), title: "共享信息"]
                break
        }
    }
}
