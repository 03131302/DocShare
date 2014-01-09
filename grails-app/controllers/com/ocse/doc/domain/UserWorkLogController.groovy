package com.ocse.doc.domain

import grails.converters.JSON
import grails.transaction.Transactional
import groovy.sql.Sql
import pl.touk.excel.export.WebXlsxExporter
import pl.touk.excel.export.getters.PropertyGetter

import java.sql.Timestamp

import static org.springframework.http.HttpStatus.*

@Transactional(readOnly = true)
class UserWorkLogController {

    def dataSource

    def index(Integer max) {
        params.max = Math.min(max ?: 30, 100)
        params.sort = "logDate"
        params.order = "desc"
        def c = UserWorkLog.where {
            user == session["adminUser"]
        }
        render view: "index", model: [userWorkLogInstanceCount: c.count(), data: c.list(params)]
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
        def withProperties = ['user.userName', 'title', new CurrencyGetter('logDate'), 'content']
        params.sort = "logDate"
        params.order = "desc"
        def c = UserWorkLog.where {
            user == session["adminUser"]
        }
        def log = c.list(params)
        new WebXlsxExporter(grailsApplication.config.info.work).with {
            setResponseHeaders(response)
            add(log, withProperties)
            save(response.outputStream)
        }
    }

    def deleteAll() {
        String info = "true"
        Sql sql = new Sql(dataSource: dataSource)
        try {
            sql.execute("delete from [DocManage].[dbo].[user_work_log] where user_id=${session["adminUser"].id}")
        } catch (Exception e) {
            e.printStackTrace()
            info = e.getMessage()
        }
        render info
    }

    def show(String id) {
        Sql sql = new Sql(dataSource: dataSource)
        def dataTemp = []
        sql.eachRow("""SELECT [id]
                              ,[content]
                              ,[log_date] logDate
                              ,[title]
                          FROM [DocManage].[dbo].[user_work_log] where [id]=${id}""") {
            data ->
                dataTemp = [id: data.id, content: data.content, logDate: data.logDate.format("yyyy-MM-dd"), title: data.title]
        }
        render dataTemp as JSON
    }

    def create() {
        respond new UserWorkLog(params)
    }

    @Transactional
    def save(UserWorkLog userWorkLogInstance) {
        String info = "true"
        try {
            userWorkLogInstance.logDate = Date.parse("yyyy-MM-dd", params.logDate)
            userWorkLogInstance.save flush: true
        } catch (Exception e) {
            e.printStackTrace()
            info = e.getMessage()
        }
        render info
    }

    def edit(UserWorkLog userWorkLogInstance) {
        respond userWorkLogInstance
    }

    @Transactional
    def update(UserWorkLog userWorkLogInstance) {
        String info = "true"
        try {
            userWorkLogInstance.logDate = Date.parse("yyyy-MM-dd", params.logDate)
            userWorkLogInstance.save flush: true
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
                    sql.execute("delete from [DocManage].[dbo].[user_work_log] where id=${data}")
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
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'userWorkLogInstance.label', default: 'UserWorkLog'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
