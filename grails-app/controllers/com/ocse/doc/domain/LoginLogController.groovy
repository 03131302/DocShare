package com.ocse.doc.domain

import grails.transaction.Transactional
import groovy.sql.Sql

import static org.springframework.http.HttpStatus.*

@Transactional(readOnly = true)
class LoginLogController {

    def dataSource

    def index(Integer max) {
        params.max = Math.min(max ?: 20, 100)
        render view: "index", model: [logList: LoginLog.list(params), loginLogInstanceCount: LoginLog.count()]
    }

    def show(LoginLog loginLogInstance) {
        respond loginLogInstance
    }

    def create() {
        respond new LoginLog(params)
    }

    @Transactional
    def save(LoginLog loginLogInstance) {
        if (loginLogInstance == null) {
            notFound()
            return
        }

        if (loginLogInstance.hasErrors()) {
            respond loginLogInstance.errors, view: 'create'
            return
        }

        loginLogInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'loginLogInstance.label', default: 'LoginLog'), loginLogInstance.id])
                redirect loginLogInstance
            }
            '*' { respond loginLogInstance, [status: CREATED] }
        }
    }

    def edit(LoginLog loginLogInstance) {
        respond loginLogInstance
    }

    @Transactional
    def update(LoginLog loginLogInstance) {
        if (loginLogInstance == null) {
            notFound()
            return
        }

        if (loginLogInstance.hasErrors()) {
            respond loginLogInstance.errors, view: 'edit'
            return
        }

        loginLogInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'LoginLog.label', default: 'LoginLog'), loginLogInstance.id])
                redirect loginLogInstance
            }
            '*' { respond loginLogInstance, [status: OK] }
        }
    }

    def deleteAll() {
        String info = "true"
        Sql sql = new Sql(dataSource: dataSource)
        try {
            sql.execute("TRUNCATE TABLE [DocManage].[dbo].[login_log] ")
        } catch (Exception e) {
            e.printStackTrace()
            info = e.getMessage()
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
                    sql.execute("delete from [DocManage].[dbo].[login_log] where id=${data}")
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
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'loginLogInstance.label', default: 'LoginLog'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
