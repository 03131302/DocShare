package com.ocse.doc.domain

import grails.transaction.Transactional
import groovy.sql.Sql
import pl.touk.excel.export.WebXlsxExporter
import pl.touk.excel.export.getters.PropertyGetter

import java.sql.Timestamp

import static org.springframework.http.HttpStatus.*

@Transactional(readOnly = true)
class LoginLogController {

    def dataSource

    def index(Integer max) {
        params.max = Math.min(max ?: 30, 100)
        params.sort = "loginDate"
        params.order = "desc"
        render view: "index", model: [logList: LoginLog.list(params), loginLogInstanceCount: LoginLog.count()]
    }

    class CurrencyGetter extends PropertyGetter<Timestamp, String> {
        CurrencyGetter(String propertyName) {
            super(propertyName)
        }

        @Override
        protected String format(java.sql.Timestamp value) {
            return value.toString()
        }
    }

    def exportToExcel() {
        def withProperties = ['user.userName', 'ip', new CurrencyGetter('loginDate')]
        params.sort = "loginDate"
        params.order = "desc"
        def log = LoginLog.list(params)
        new WebXlsxExporter(grailsApplication.config.info.login).with {
            setResponseHeaders(response)
            add(log, withProperties)
            save(response.outputStream)
        }
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
