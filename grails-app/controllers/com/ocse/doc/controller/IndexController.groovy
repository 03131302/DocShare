package com.ocse.doc.controller

import com.ocse.doc.domain.InfoData
import com.ocse.doc.domain.Organization
import com.ocse.doc.domain.ShareFile
import groovy.sql.Sql

class IndexController {

    def dataSource

    def index() {
        def session = request.getSession()
        if (session["adminUser"] == null) {
            return false
        }

        def filep = [:]
        filep.max = 3
        filep.sort = "logDate"
        filep.order = "desc"
        def sharefile = ShareFile.list(filep)

        Sql sql = new Sql(dataSource: dataSource)
        def allList = []
        def allListSQL = """
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
                                  ,(select count(m.[id]) from [DocManage].[dbo].[info_log] m where m.info_data_id=t.[id] and m.[user_id]=${
            session["adminUser"].id
        }) log
                              FROM [DocManage].[dbo].[info_data] t where t.[share_type]='全部' and [share_scope] = '工作信息' and [state]=0 order by t.[save_date] desc"""
        if (params.orgID != null && !params.orgID.empty) {
            allListSQL = """
                        WITH orgtree([id],[name],[parent_id],[pxh]) as
                        (
                        SELECT [id],[name],[parent_id],[pxh] FROM [DocManage].[dbo].[organization] WHERE id = ${
                params.orgID
            }
                        UNION ALL
                        SELECT a.[id],a.[name],a.[parent_id],a.[pxh] FROM [DocManage].[dbo].[organization] A,orgtree b
                        where a.parent_id = b.id
                        )
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
                                  ,(select count(m.[id]) from [DocManage].[dbo].[info_log] m where m.info_data_id=t.[id] and m.[user_id]=${
                session["adminUser"].id
            }) log
                              FROM [DocManage].[dbo].[info_data] t where t.[share_type]='全部' and [share_scope] = '工作信息' and [state]=0
                              and t.[user_id] in (SELECT [id] FROM [DocManage].[dbo].[admin_user] u where u.[org_id] in (select [id] from orgtree))
                              order by t.[save_date] desc"""
        }
        log.info(allListSQL)
        sql.eachRow(allListSQL) {
            data ->
                def map = [id: data.id, date: data.save_date, title: data.title, type: data.type,
                        re_type: data.re_type, user: data.user, shareScope: data.share_scope, log: data.log]
                allList.add(map)
        }

        def recveList = []

        def recveListSQL = """
                            SELECT DISTINCT
                            TOP 5 b.[id],
                            b.[version],
                                    [save_date],
                                    [save_state],
                                    [share_scope],
                                    [share_type],
                                    [title],
                                    (
                                    SELECT
                                          [name]
                                    FROM
                            [DocManage].[dbo].[info_type] n
                            WHERE
                                    n.id = [type_id]
                            ) type,
                            (SELECT
                                    [user_name]
                            FROM
                                    [DocManage].[dbo].[admin_user]
                            WHERE
                                    [id] = b.[user_id]
                            ) [user],
                            [re_type],
                            (
                            SELECT
                            COUNT (m.[id])
                                    FROM
                            [DocManage].[dbo].[info_log] m
                            WHERE
                                    m.info_data_id = b.[id]
                                    AND m.[user_id] =  ${session["adminUser"].id}
                            ) log
                            FROM
                            [DocManage].[dbo].[info_data] b
                            LEFT JOIN [DocManage].[dbo].[info_user_scope] a ON (
                                    b.id = a.info_id
                                    OR b.share_type = '全部'
                            )
                            WHERE
                            b.share_scope = '通知公告'
                            AND (
                                    a.[user_id] = ${session["adminUser"].id}
                                    OR b.share_type = '全部'
                            )
                            AND [state] = 0
                            ORDER BY
                            [save_date] DESC
                            """
        if (params.orgID != null && !params.orgID.empty) {
            recveListSQL = """
                        WITH orgtree([id],[name],[parent_id],[pxh]) as
                        (
                        SELECT [id],[name],[parent_id],[pxh] FROM [DocManage].[dbo].[organization] WHERE id = ${
                params.orgID
            }
                        UNION ALL
                        SELECT a.[id],a.[name],a.[parent_id],a.[pxh] FROM [DocManage].[dbo].[organization] A,orgtree b
                        where a.parent_id = b.id
                        )
                        SELECT DISTINCT
                            TOP 5 b.[id],
                            b.[version],
                                    [save_date],
                                    [save_state],
                                    [share_scope],
                                    [share_type],
                                    [title],
                                    (
                                    SELECT
                                          [name]
                                    FROM
                            [DocManage].[dbo].[info_type] n
                            WHERE
                                    n.id = [type_id]
                            ) type,
                            (SELECT
                                    [user_name]
                            FROM
                                    [DocManage].[dbo].[admin_user]
                            WHERE
                                    [id] = b.[user_id]
                            ) [user],
                            [re_type],
                            (
                            SELECT
                            COUNT (m.[id])
                                    FROM
                            [DocManage].[dbo].[info_log] m
                            WHERE
                                    m.info_data_id = b.[id]
                                    AND m.[user_id] =  ${session["adminUser"].id}
                            ) log
                            FROM
                            [DocManage].[dbo].[info_data] b
                            LEFT JOIN [DocManage].[dbo].[info_user_scope] a ON (
                                    b.id = a.info_id
                                    OR b.share_type = '全部'
                            )
                            WHERE
                            b.share_scope = '通知公告'
                            AND (
                                    a.[user_id] = ${session["adminUser"].id}
                                    OR b.share_type = '全部'
                            )
                            AND [state] = 0
                            AND b.[user_id] in (SELECT [id] FROM [DocManage].[dbo].[admin_user] u where u.[org_id] in (select [id] from orgtree))
                            ORDER BY
                            [save_date] DESC
                        """
        }
        log.info(recveListSQL)
        sql.eachRow(recveListSQL) {
            data ->
                def map = [id: data.id, date: data.save_date, title: data.title, type: data.type,
                        re_type: data.re_type, user: data.user, log: data.log]
                recveList.add(map)
        }
        render view: "index", model: [allList: allList, recveList: recveList,
                org: Organization.get(params.orgID), sharefile: sharefile]
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
                "  FROM [DocManage].[dbo].[info_data] b where 1=1 and [state]=0 "
        Sql sql = new Sql(dataSource: dataSource)
        if (keyValue != null && !keyValue.empty) {
            sqlText += " and ([title] like '%" + keyValue + "%' or [text_data] like '%" + keyValue + "%')"
        }
        if (typeKey != null && !typeKey.empty && (params.orgID == null || params.orgID.empty)) {
            sqlText = "WITH orgtree([id],[name],[parent_info_type_id],[pxh]) as\n" +
                    "(\n" +
                    "SELECT [id],[name],[parent_info_type_id],[pxh] FROM [DocManage].[dbo].[info_type] WHERE id ='${typeKey}'\n" +
                    "UNION ALL\n" +
                    "SELECT a.[id],a.[name],a.[parent_info_type_id],a.[pxh] FROM [DocManage].[dbo].[info_type] A,orgtree b\n" +
                    "where a.parent_info_type_id = b.id\n" +
                    ") \n" + sqlText + " and [type_id] in (SELECT id  from orgtree) "
        }
        if (params.orgID != null && !params.orgID.empty && (typeKey != null && !typeKey.empty)) {
            sqlText = """
                        WITH orgtree([id],[name],[parent_id],[pxh]) as
                        (
                        SELECT [id],[name],[parent_id],[pxh] FROM [DocManage].[dbo].[organization] WHERE id = ${
                params.orgID
            }
                        UNION ALL
                        SELECT a.[id],a.[name],a.[parent_id],a.[pxh] FROM [DocManage].[dbo].[organization] A,orgtree b
                        where a.parent_id = b.id
                        ),
                        infotypetree([id],[name],[parent_info_type_id],[pxh]) as
                        (
                        SELECT [id],[name],[parent_info_type_id],[pxh] FROM [DocManage].[dbo].[info_type] WHERE id =${
                typeKey
            }
                        UNION ALL
                        SELECT a.[id],a.[name],a.[parent_info_type_id],a.[pxh] FROM [DocManage].[dbo].[info_type] A,infotypetree b
                        where a.parent_info_type_id = b.id
                        )
                        ${sqlText}
                        and b.[user_id] in (SELECT [id] FROM [DocManage].[dbo].[admin_user] u where u.[org_id] in (select [id] from orgtree))
                        and [type_id] in (SELECT id  from infotypetree)
                        """
        }
        if (params.orgID != null && !params.orgID.empty && (typeKey == null || typeKey.empty)) {
            sqlText = """
                        WITH orgtree([id],[name],[parent_id],[pxh]) as
                        (
                        SELECT [id],[name],[parent_id],[pxh] FROM [DocManage].[dbo].[organization] WHERE id = ${
                params.orgID
            }
                        UNION ALL
                        SELECT a.[id],a.[name],a.[parent_id],a.[pxh] FROM [DocManage].[dbo].[organization] A,orgtree b
                        where a.parent_id = b.id
                        )
                        ${sqlText}
                        and b.[user_id] in (SELECT [id] FROM [DocManage].[dbo].[admin_user] u where u.[org_id] in (select [id] from orgtree))
                        """
        }
        log.info(sqlText)
        sql.eachRow(sqlText + " order by [save_date] desc") {
            data ->
                def map = [id: data.id, date: data.save_date, title: data.title, type: data.type,
                        re_type: data.re_type, user: data.user, shareScope: data.share_scope]
                searchList.add(map)
        }
        render view: "search", model: [keyValue: params.keyValue, searchList: searchList, typeKey: params.typeKey,
                typeKeyName: params.typeKeyName, org: Organization.get(params.orgID)]
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
                    user == session["adminUser"] && state == 0
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
                def results = InfoData.findAll("from InfoData d,InfoUserScope o where (d.shareType='全部' or o.info=d) and o.user.id=${session["adminUser"].id} and d.state = 0 " +
                        "and d.shareScope = '通知公告' " +
                        "  order " +
                        "by d.saveDate desc", [max: params.max, offset: params.offset])
                def o = InfoData.executeQuery("select count(distinct d.id) from InfoUserScope o,InfoData d where (d.shareType='全部' or o.info=d) and d.state = 0 and d.shareScope = '通知公告' " +
                        " and  o.user.id='${session["adminUser"].id}'")
                results.each { data ->
                    data.each {
                        d ->
                            if (d instanceof InfoData && !theData.contains(d)) {
                                theData.add(d)
                            }
                    }
                }
                render view: "more", model: [infoDataInstanceCount: o[0],
                        infoData: theData, title: "收件箱"]
                break
            case "3":
                def results = InfoData.where {
                    shareType == "全部" && state == 0 && shareScope == "工作信息"
                }
                params.sort = "saveDate"
                params.order = "desc"
                render view: "more", model: [infoDataInstanceCount: results.count(),
                        infoData: results.list(params), title: "共享信息"]
                break
        }
    }
}
