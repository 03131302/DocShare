package com.ocse.doc.domain

import groovy.sql.Sql

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class InfoDataController {

    def dataSource

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond InfoData.list(params), model: [infoDataInstanceCount: InfoData.count()]
    }

    def show(InfoData infoDataInstance) {
        respond infoDataInstance
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
        println(params)
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
                InfoLog infoLog = new InfoLog()
                infoLog.infoData = infoData
                infoLog.user = session["adminUser"]
                infoLog.infoDate = new Date()
                infoLog.type = "新增"
                infoLog.ip = request.getRemoteAddr()
                infoLog.save flash: true
                println infoData
            } catch (Exception e) {
                e.printStackTrace()
                info = e.getMessage()
            }
        }
        render info
    }

    def edit(InfoData infoDataInstance) {
        respond infoDataInstance
    }

    @Transactional
    def update(InfoData infoDataInstance) {
        if (infoDataInstance == null) {
            notFound()
            return
        }

        if (infoDataInstance.hasErrors()) {
            respond infoDataInstance.errors, view: 'edit'
            return
        }

        infoDataInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'InfoData.label', default: 'InfoData'), infoDataInstance.id])
                redirect infoDataInstance
            }
            '*' { respond infoDataInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(InfoData infoDataInstance) {

        if (infoDataInstance == null) {
            notFound()
            return
        }

        infoDataInstance.delete flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'InfoData.label', default: 'InfoData'), infoDataInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
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
