package com.ocse.doc.domain

import grails.converters.JSON
import groovy.sql.Sql

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class AdminUserController {

    def dataSource

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond AdminUser.list(params), model: [adminUserInstanceCount: AdminUser.count()]
    }

    def show(int id) {
        Sql sql = new Sql(dataSource: dataSource)
        def dataTemp = []
        sql.eachRow("""SELECT [id]
                      ,[version]
                      ,[is_stop] isStop
                      ,[org_id] org
                      ,(select t.name from [DocManage].[dbo].[organization] t where t.id =[org_id]) orgName
                      ,[pass_word] passWord
                      ,[pxh]
                      ,[text]
                      ,[user_code] userCode
                      ,[user_name] userName
                      ,[jb],[zhiwu]
                  FROM [DocManage].[dbo].[admin_user] where [id]=${id}""") {
            data ->
                dataTemp = [id: data.id, isStop: data.isStop, org: data.org, orgName: data.orgName, passWord: data.passWord,
                        pxh: data.pxh, text: data.text, userCode: data.userCode, userName: data.userName, jb: data.jb,zhiwu:data.zhiwu]
        }
        render dataTemp as JSON
    }

    def create() {
        respond new AdminUser(params)
    }

    @Transactional
    def save(AdminUser adminUserInstance) {
        println(adminUserInstance)
        String info = "true"
        try {
            adminUserInstance.save flush: true
        } catch (Exception e) {
            e.printStackTrace()
            info = e.getMessage()
        }
        println(adminUserInstance.id)
        render info
    }

    def edit(AdminUser adminUserInstance) {
        respond adminUserInstance
    }

    @Transactional
    def update(AdminUser adminUserInstance) {
        String info = "true"
        try {
            adminUserInstance.save flush: true
        } catch (Exception e) {
            info = e.getMessage()
            e.printStackTrace()
        }
        render info
    }

    @Transactional
    def delete(String id) {

        if (id == null) {
            notFound()
            return
        }
        String info = "true"
        Sql sql = new Sql(dataSource: dataSource)
        id.split(",").each {
            data ->
                try {
                    sql.execute("delete from [DocManage].[dbo].[admin_user] where id=${data}")
                } catch (Exception e) {
                    e.printStackTrace()
                    info = e.getMessage()
                }
        }
        render info
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'adminUserInstance.label', default: 'AdminUser'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
