package com.ocse.doc.controller

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
                    SELECT TOP 10 [id]
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
                        re_type: data.re_type, user: data.user,shareScope:data.share_scope]
                allList.add(map)
        }

        def recveList = []
        sql.eachRow("""
                   SELECT TOP 10  b.[id]
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
}
