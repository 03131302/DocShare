package com.ocse.doc.domain

import grails.transaction.Transactional
import groovy.sql.Sql

import static org.springframework.http.HttpStatus.NOT_FOUND

@Transactional(readOnly = true)
class InfoDataController {

    def dataSource

    def index(Integer max) {
        params.max = Math.min(max ?: 30, 100)
        params.sort = "saveDate"
        params.order = "desc"
        if (params.titleLikeValue == null) {
            params.titleLikeValue = ""
        }
        def user = session["adminUser"]

        def c = InfoData.where {
            title ==~ "%${params.titleLikeValue.toString()}%" && state == 0
        }
        if ("普通用户".equals(user.jb)) {
            c = c.where {
                user == session["adminUser"]
            }
        }
        render view: "index", model: [infoDataInstanceCount: c.count(),
                infoDataList: c.list(params), titleLikeValue: params.titleLikeValue]
    }

    def cleanAll() {
        String info = "true"
        Sql sql = new Sql(dataSource: dataSource)
        try {
            sql.execute("delete from [DocManage].[dbo].[info_data] where [state]=1")
        } catch (Exception e) {
            e.printStackTrace()
            info = e.getMessage()
        }
        render info
    }

    def recycleIndex(Integer max) {
        params.max = Math.min(max ?: 30, 100)
        params.sort = "saveDate"
        params.order = "desc"
        if (params.titleLikeValue == null) {
            params.titleLikeValue = ""
        }
        def c = InfoData.where {
            title ==~ "%${params.titleLikeValue.toString()}%" && state == 1
        }
        render view: "recycleIndex", model: [infoDataInstanceCount: InfoData.count(),
                infoDataList: c.list(params), titleLikeValue: params.titleLikeValue]
    }

    def show(InfoData infoDataInstance) {
        Sql sql = new Sql(dataSource: dataSource)
        String users = ""
        println infoDataInstance.shareType
        if ("局部".equals(infoDataInstance.shareType)) {
            sql.eachRow("""SELECT (select m.user_name from [DocManage].[dbo].[admin_user] m
                         where m.[id]=t.[user_id]) [user]
                        FROM [DocManage].[dbo].[info_user_scope] t where t.info_id=${infoDataInstance.id}""") {
                data ->
                    users += data.user + ";"
            }
        }
        def fileList = []
        sql.eachRow("""SELECT [id]
                              ,[name]
                              ,[save_date]
                          FROM [DocManage].[dbo].[info_file] t where t.info_data_id=${infoDataInstance.id}""") {
            data ->
                def map = [id: data.id, name: data.name]
                fileList.add(map)
        }
        def c = Recipient.where {
            infoData == infoDataInstance
        }
        //日志记录
        try {
            InfoLog infoLog = new InfoLog(infoData: infoDataInstance, user: session["adminUser"], infoDate: new Date()
                    , ip: request.getRemoteAddr(), type: "浏览")
            infoLog.save flush: true
        } catch (Exception e) {
            e.printStackTrace()
        }
        render view: "show", model: [infoDataInstance: infoDataInstance, users: users,
                fileList: fileList, reTypeList: c.list()]
    }

    def getUserTree() {
        Sql sql = new Sql(dataSource: dataSource)
        def listData = []
        sql.eachRow("""
                    SELECT cast([id] as varchar(100)) [id]
                            ,[version]
                            ,[name]
                            ,[parent_id]
                            ,[pxh]
                            ,[text]
                            FROM [DocManage].[dbo].[organization]
                            UNION ALL
                            select (cast([id] as varchar(100)) + '#'),t.version,t.user_name,t.org_id,t.pxh,t.text from
                            [DocManage].[dbo].admin_user t where t.jb='普通用户' order by pxh""") {
            data ->
                def map = [id: data.id, name: data.name, pId: data.parent_id == null ? 0 : data.parent_id]
                listData.add(map)
        }
        render(contentType: "text/json") { listData }
    }

    def create() {
        respond new InfoData(params)
    }

    @Transactional
    def save() {
        InfoData infoData = new InfoData(params)
        infoData.saveDate = new Date()
        infoData.saveState = "保存"
        infoData.user = session["adminUser"]
        infoData.state = 0
        String info = "true"
        if (infoData.hasErrors()) {
            info = "请检查填写内容！"
        } else {
            try {
                Sql sql = new Sql(dataSource: dataSource)
                infoData.save flash: true
                String filePathValue = params.filePathValue
                String fileNameValue = params.fileNameValue
                println "名称：${fileNameValue}"
                if (filePathValue != null && !filePathValue.empty && infoData.id != null) {
                    def names = fileNameValue.split(";")
                    int i = 0
                    filePathValue.split(";").each { data ->
                        InfoFile file = new InfoFile()
                        file.infoData = infoData
                        file.saveDate = new Date()
                        file.state = 0
                        file.path = data
                        file.name = names[i]
                        if (file.name != null && !file.name.empty) {
                            file.save flash: true
                        }
                        i++
                    }
                }
                String userScopeData = params.userScopeData
                if (userScopeData != null && !userScopeData.empty && infoData.id != null) {
                    userScopeData.split(";").each { data ->
                        int n = 0
                        sql.eachRow("select count([id]) id from [DocManage].[dbo].[admin_user] where Cast([id] as varchar)='${data}'") {
                            d ->
                                n = d.id
                        }
                        if (n > 0) {
                            InfoUserScope infoUserScope = new InfoUserScope()
                            infoUserScope.info = infoData
                            infoUserScope.user = AdminUser.get(data)
                            infoUserScope.save flash: true
                        }
                    }
                }
                if (params.infoDataObject != null && !params.infoDataObject.empty) {
                    Recipient recipient = new Recipient(user: session["adminUser"], infoData: InfoData.get(params.infoDataObject),
                            text: infoData.id)
                    recipient.save flash: true
                    //日志记录
                    try {
                        InfoLog infoLog = new InfoLog(infoData: InfoData.get(params.infoDataObject), user: session["adminUser"], infoDate: new Date()
                                , ip: request.getRemoteAddr(), type: "反馈")
                        infoLog.save flush: true
                    } catch (Exception e) {
                        e.printStackTrace()
                    }
                }
                InfoLog infoLog = new InfoLog()
                infoLog.infoData = infoData
                infoLog.user = session["adminUser"]
                infoLog.infoDate = new Date()
                infoLog.type = "新增"
                infoLog.ip = request.getRemoteAddr()
                infoLog.save flash: true
            } catch (Exception e) {
                e.printStackTrace()
                info = e.getMessage()
            }
        }
        render info
    }

    def edit(InfoData infoDataInstance) {
        def fileList = []
        InfoFile.where {
            infoData == infoDataInstance
        }.list().each {
            data ->
                def map = [id: data.id, path: data.path, name: data.name]
                fileList.add(map)
        }
        def userList = []
        def users = InfoUserScope.where {
            info == infoDataInstance
        }.list().each {
            data ->
                def map = [name: data.user.userName, id: data.user.id]
                userList.add(map)
        }
        InfoType type = InfoType.get(infoDataInstance.type.id)
        render(contentType: "text/json") {
            [infoData: infoDataInstance, files: fileList
                    , users: userList, type: type]
        }
    }

    @Transactional
    def update(InfoData infoDataInstance) {
        InfoData infoData = infoDataInstance
        infoData.saveDate = new Date()
        infoData.saveState = "修改"
        infoData.state = 0
        String info = "true"
        if (infoData.hasErrors()) {
            info = "请检查填写内容！"
        } else {
            try {
                Sql sql = new Sql(dataSource: dataSource)
                infoData.save flash: true
                String filePathValue = params.filePathValue
                String fileNameValue = params.fileNameValue
                println "名称：${fileNameValue}"
                if (filePathValue != null && !filePathValue.empty && infoData.id != null) {
                    sql.execute("""delete from [DocManage].[dbo].[info_file] where [info_data_id]=${infoData.id}""")
                    def names = fileNameValue.split(";")
                    int i = 0
                    filePathValue.split(";").each { data ->
                        InfoFile file = new InfoFile()
                        file.infoData = infoData
                        file.saveDate = new Date()
                        file.state = 0
                        file.path = data
                        file.name = names[i]
                        if (file.name != null && !file.name.empty) {
                            file.save flash: true
                        }
                        i++
                    }
                }
                String userScopeData = params.userScopeData
                if (userScopeData != null && !userScopeData.empty && infoData.id != null) {
                    sql.execute("""delete from [DocManage].[dbo].[info_user_scope] where [info_id]=${infoData.id}""")
                    userScopeData.split(";").each { data ->
                        int n = 0
                        sql.eachRow("select count([id]) id from [DocManage].[dbo].[admin_user] where Cast([id] as varchar)='${data}'") {
                            d ->
                                n = d.id
                        }
                        if (n > 0) {
                            InfoUserScope infoUserScope = new InfoUserScope()
                            infoUserScope.info = infoData
                            infoUserScope.user = AdminUser.get(data)
                            infoUserScope.save flash: true
                        }
                    }
                }
                if (params.infoDataObject != null && !params.infoDataObject.empty) {
                    Recipient recipient = new Recipient(user: session["adminUser"], infoData: InfoData.get(params.infoDataObject),
                            text: infoData.id)
                    recipient.save flash: true
                    //日志记录
                    try {
                        InfoLog infoLog = new InfoLog(infoData: InfoData.get(params.infoDataObject), user: session["adminUser"], infoDate: new Date()
                                , ip: request.getRemoteAddr(), type: "反馈")
                        infoLog.save flush: true
                    } catch (Exception e) {
                        e.printStackTrace()
                    }

                }
                InfoLog infoLog = new InfoLog()
                infoLog.infoData = infoData
                infoLog.user = session["adminUser"]
                infoLog.infoDate = new Date()
                infoLog.type = "修改"
                infoLog.ip = request.getRemoteAddr()
                infoLog.save flash: true
            } catch (Exception e) {
                e.printStackTrace()
                info = e.getMessage()
            }
        }
        render info
    }

    def downloadFile(InfoData infoDataInstance) {
        def list = []
        if (infoDataInstance != null) {
            def c = InfoFile.where {
                infoData == infoDataInstance
            }
            c.list().each {
                data ->
                    list.add(data.id)
            }
        }
        //日志记录
        try {
            InfoLog infoLog = new InfoLog(infoData: infoDataInstance, user: session["adminUser"], infoDate: new Date()
                    , ip: request.getRemoteAddr(), type: "文件下载")
            infoLog.save flush: true
        } catch (Exception e) {
            e.printStackTrace()
        }
        render(contentType: "text/json") { list }
    }

    @Transactional
    def deleteInfo(String id) {
        if (id == null) {
            notFound()
            return
        }
        String info = "true"
        Sql sql = new Sql(dataSource: dataSource)
        id.split(",").each {
            data ->
                try {
                    //日志记录
                    try {
                        InfoLog infoLog = new InfoLog(infoData: InfoData.get(data), user: session["adminUser"], infoDate: new Date()
                                , ip: request.getRemoteAddr(), type: "删除")
                        infoLog.save flush: true
                    } catch (Exception e) {
                        e.printStackTrace()
                    }
                    sql.execute("delete from [DocManage].[dbo].[info_data] where id=${data}")
                } catch (Exception e) {
                    e.printStackTrace()
                    info = e.getMessage()
                }
        }
        render info
    }

    @Transactional
    def deleteAll(String id) {
        if (id == null) {
            notFound()
            return
        }
        String info = "true"
        Sql sql = new Sql(dataSource: dataSource)
        id.split(",").each {
            data ->
                try {
                    //日志记录
                    try {
                        InfoLog infoLog = new InfoLog(infoData: InfoData.get(data), user: session["adminUser"], infoDate: new Date()
                                , ip: request.getRemoteAddr(), type: "删除")
                        infoLog.save flush: true
                    } catch (Exception e) {
                        e.printStackTrace()
                    }
                    sql.execute("update [DocManage].[dbo].[info_data] set [state]=1 where id=${data}")
                } catch (Exception e) {
                    e.printStackTrace()
                    info = e.getMessage()
                }
        }
        render info
    }

    @Transactional
    def recover(String id) {
        if (id == null) {
            notFound()
            return
        }
        String info = "true"
        Sql sql = new Sql(dataSource: dataSource)
        id.split(",").each {
            data ->
                try {
                    sql.execute("update [DocManage].[dbo].[info_data] set [state]=0 where id=${data}")
                } catch (Exception e) {
                    e.printStackTrace()
                    info = e.getMessage()
                }
        }
        render info
    }

    @Transactional
    def delete(InfoData infoDataInstance) {

        if (infoDataInstance == null) {
            notFound()
            return
        }
        String info = "true"
        try {
            //日志记录
            try {
                InfoLog infoLog = new InfoLog(infoData: infoDataInstance, user: session["adminUser"], infoDate: new Date()
                        , ip: request.getRemoteAddr(), type: "删除")
                infoLog.save flush: true
            } catch (Exception e) {
                e.printStackTrace()
            }
            infoDataInstance.state = 1
            infoDataInstance.save flush: true
        } catch (Exception e) {
            e.printStackTrace()
            info = e.getMessage()
        }
        render info
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'infoDataInstance.label', default: 'InfoData'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
