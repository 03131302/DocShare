package com.ocse.doc.domain

import grails.transaction.Transactional
import groovy.sql.Sql
import pl.touk.excel.export.WebXlsxExporter
import pl.touk.excel.export.getters.PropertyGetter

import static org.springframework.http.HttpStatus.*

@Transactional(readOnly = true)
class InfoLogController {

    def dataSource
    def grailsApplication

    def index(Integer max) {
        params.max = Math.min(max ?: 30, 100)
        params.sort = "infoDate"
        params.order = "desc"
        render view: "index", model: [infoLogInstanceCount: InfoLog.count(),
                logs: InfoLog.list(params)]
    }

    class CurrencyGetter extends PropertyGetter<java.sql.Timestamp, String> {
        CurrencyGetter(String propertyName) {
            super(propertyName)
        }

        @Override
        protected String format(java.sql.Timestamp value) {
            return value.toString()
        }
    }

    def exportToExcel() {
        def withProperties = ['user.userName', 'infoData.title', 'ip', new CurrencyGetter('infoDate'), 'type']
        params.sort = "infoDate"
        params.order = "desc"
        def log = InfoLog.list(params)
        new WebXlsxExporter(grailsApplication.config.info.log).with {
            setResponseHeaders(response)
            add(log, withProperties)
            save(response.outputStream)
        }
    }

    def show(InfoLog infoLogInstance) {
        respond infoLogInstance
    }

    def create() {
        respond new InfoLog(params)
    }

    @Transactional
    def save(InfoLog infoLogInstance) {
        if (infoLogInstance == null) {
            notFound()
            return
        }

        if (infoLogInstance.hasErrors()) {
            respond infoLogInstance.errors, view: 'create'
            return
        }

        infoLogInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'infoLogInstance.label', default: 'InfoLog'), infoLogInstance.id])
                redirect infoLogInstance
            }
            '*' { respond infoLogInstance, [status: CREATED] }
        }
    }

    def edit(InfoLog infoLogInstance) {
        respond infoLogInstance
    }

    @Transactional
    def update(InfoLog infoLogInstance) {
        if (infoLogInstance == null) {
            notFound()
            return
        }

        if (infoLogInstance.hasErrors()) {
            respond infoLogInstance.errors, view: 'edit'
            return
        }

        infoLogInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'InfoLog.label', default: 'InfoLog'), infoLogInstance.id])
                redirect infoLogInstance
            }
            '*' { respond infoLogInstance, [status: OK] }
        }
    }

    def deleteAll() {
        String info = "true"
        Sql sql = new Sql(dataSource: dataSource)
        try {
            sql.execute("TRUNCATE TABLE [DocManage].[dbo].[info_log] ")
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
                    sql.execute("delete from [DocManage].[dbo].[info_log] where id=${data}")
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
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'infoLogInstance.label', default: 'InfoLog'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
