package com.ocse.doc.domain

import grails.transaction.Transactional
import groovy.sql.Sql
import pl.touk.excel.export.WebXlsxExporter
import pl.touk.excel.export.getters.PropertyGetter

import java.sql.Timestamp

import static org.springframework.http.HttpStatus.*

@Transactional(readOnly = true)
class UserCommitController {

    def dataSource

    def index(Integer max) {
        params.max = Math.min(max ?: 30, 100)
        params.sort = "logDate"
        params.order = "desc"
        render view: "index", model: [userCommitInstanceCount: UserCommit.count(), data: UserCommit.list(params)]
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
        def log = UserCommit.list(params)
        new WebXlsxExporter(grailsApplication.config.info.commit).with {
            setResponseHeaders(response)
            add(log, withProperties)
            save(response.outputStream)
        }
    }

    def show(UserCommit userCommitInstance) {
        respond userCommitInstance
    }

    def create() {
        respond new UserCommit(params)
    }

    def deleteAll() {
        String info = "true"
        Sql sql = new Sql(dataSource: dataSource)
        try {
            sql.execute("TRUNCATE TABLE [DocManage].[dbo].[user_commit] ")
        } catch (Exception e) {
            e.printStackTrace()
            info = e.getMessage()
        }
        render info
    }

    @Transactional
    def save(UserCommit userCommitInstance) {
        String info = "true"
        try {
            userCommitInstance.logDate = new Date()
            userCommitInstance.save flush: true
        } catch (Exception e) {
            e.printStackTrace()
            info = e.getMessage()
        }
        render info
    }

    def edit(UserCommit userCommitInstance) {
        respond userCommitInstance
    }

    @Transactional
    def update(UserCommit userCommitInstance) {
        if (userCommitInstance == null) {
            notFound()
            return
        }

        if (userCommitInstance.hasErrors()) {
            respond userCommitInstance.errors, view: 'edit'
            return
        }

        userCommitInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'UserCommit.label', default: 'UserCommit'), userCommitInstance.id])
                redirect userCommitInstance
            }
            '*' { respond userCommitInstance, [status: OK] }
        }
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
                    sql.execute("delete from [DocManage].[dbo].[user_commit] where id=${data}")
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
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'userCommitInstance.label', default: 'UserCommit'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
