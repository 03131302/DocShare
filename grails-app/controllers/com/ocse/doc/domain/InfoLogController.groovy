package com.ocse.doc.domain

import grails.transaction.Transactional
import groovy.sql.Sql

import static org.springframework.http.HttpStatus.*

@Transactional(readOnly = true)
class InfoLogController {

    def dataSource

    def index(Integer max) {
        params.max = Math.min(max ?: 30, 100)
        params.sort = "infoDate"
        params.order = "desc"
        render view: "index", model: [infoLogInstanceCount: InfoLog.count(),
                logs: InfoLog.list(params)]
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
