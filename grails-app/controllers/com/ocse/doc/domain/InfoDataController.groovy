package com.ocse.doc.domain

import grails.transaction.Transactional
import groovy.sql.Sql

import static org.springframework.http.HttpStatus.NOT_FOUND
import static org.springframework.http.HttpStatus.OK

@Transactional(readOnly = true)
class InfoDataController {

    def dataSource

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond InfoData.list(params), model: [infoDataInstanceCount: InfoData.count()]
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
        render view: "show", model: [infoDataInstance: infoDataInstance, users: users,
                fileList: fileList, reTypeList: c.list()]
    }

    def getUserTree() {
        Sql sql = new Sql(dataSource: dataSource)
        def listData = []
        sql.eachRow("""
                    SELECT [id]
                                              ,[version]
                                              ,[name]
                                              ,[parent_id]
                                              ,[pxh]
                                              ,[text]
                                          FROM [DocManage].[dbo].[organization]
                     UNION ALL

                    select t.id,t.version,t.user_name,t.org_id,t.pxh,t.text from
                    [DocManage].[dbo].admin_user t where t.jb='普通用户' order by pxh """) {
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
        String info = "true"
        if (infoData.hasErrors()) {
            info = "请检查填写内容！"
        } else {
            try {
                Sql sql = new Sql(dataSource: dataSource)
                infoData.save flash: true
                String filePathValue = params.filePathValue
                if (filePathValue != null && !filePathValue.empty && infoData.id != null) {
                    filePathValue.split(";").each { data ->
                        InfoFile file = new InfoFile()
                        file.infoData = infoData
                        file.saveDate = new Date()
                        file.state = 0
                        file.path = data
                        file.name = data.decodeURL().toString().substring(data.decodeURL().toString().lastIndexOf("/") + 1, data.decodeURL().toString().length())
                        if (file.name != null && !file.name.empty) {
                            file.save flash: true
                        }
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
                    println InfoData.get(params.infoDataObject)
                    Recipient recipient = new Recipient(user: session["adminUser"], infoData: InfoData.get(params.infoDataObject),
                            text: infoData.id)
                    println recipient
                    recipient.save flash: true
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
        println infoData
        infoData.saveDate = new Date()
        infoData.saveState = "修改"
        String info = "true"
        if (infoData.hasErrors()) {
            info = "请检查填写内容！"
        } else {
            try {
                Sql sql = new Sql(dataSource: dataSource)
                infoData.save flash: true
                String filePathValue = params.filePathValue
                if (filePathValue != null && !filePathValue.empty && infoData.id != null) {
                    sql.execute("""delete from [DocManage].[dbo].[info_file] where [info_data_id]=${infoData.id}""")
                    filePathValue.split(";").each { data ->
                        InfoFile file = new InfoFile()
                        file.infoData = infoData
                        file.saveDate = new Date()
                        file.state = 0
                        file.path = data
                        file.name = data.decodeURL().toString().substring(data.decodeURL().toString().lastIndexOf("/") + 1, data.decodeURL().toString().length())
                        if (file.name != null && !file.name.empty) {
                            file.save flash: true
                        }
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
                    println recipient
                    recipient.save flash: true
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
        render(contentType: "text/json") { list }
    }

    @Transactional
    def delete(InfoData infoDataInstance) {

        if (infoDataInstance == null) {
            notFound()
            return
        }
        String info = "true"
        try {
            infoDataInstance.delete flush: true
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
