package com.ocse.doc.domain

import grails.converters.JSON
import groovy.sql.Sql

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class OrganizationController {

    def dataSource

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Organization.list(params), model: [organizationInstanceCount: Organization.count()]
    }

    def show(Organization organizationInstance) {
        render organizationInstance as JSON
    }

    def create() {
        respond new Organization(params)
    }

    def move(int id, int tid) {
        Sql sql = new Sql(dataSource: dataSource);
        String info = "true"
        try {
            sql.execute("update [DocManage].[dbo].[organization] set [parent_id]=${tid} where [id]=${id}")
        } catch (Exception e) {
            e.printStackTrace()
            info = e.getMessage();
        }
        render info
    }

    @Transactional
    def save() {
        params.id = null;
        println(params)
        String info = "true"
        try {
            Organization organization = new Organization(params)
            organization.save flush: true
        } catch (Exception e) {
            e.printStackTrace()
            info = e.getMessage()
        }
        render info
    }

    def edit(Organization organizationInstance) {
        respond organizationInstance
    }

    @Transactional
    def update(Organization organizationInstance) {
        println(organizationInstance)
        if (organizationInstance == null) {
            notFound()
            return
        }

        if (organizationInstance.hasErrors()) {
            respond organizationInstance.errors, view: 'edit'
            return
        }
        String info = "true"
        try {
            organizationInstance.save flush: true
        } catch (Exception e) {
            e.printStackTrace();
            info = e.getMessage();
        }
        render info
    }

    @Transactional
    def delete(Organization organizationInstance) {

        if (organizationInstance == null) {
            notFound()
            return
        }
        String info = "true"
        try {
            Sql sql = new Sql(dataSource: dataSource)
            sql.execute("""
                          WITH orgtree([id],[name],[parent_id],[pxh]) as
                         (
                            SELECT [id],[name],[parent_id],[pxh] FROM [DocManage].[dbo].[organization] WHERE id =${
                organizationInstance.id
            }
                            UNION ALL
                            SELECT a.[id],a.[name],a.[parent_id],a.[pxh] FROM [DocManage].[dbo].[organization] A,orgtree b
                            where a.parent_id = b.id
                        )
                        delete from [DocManage].[dbo].[organization] where id in ( SELECT id  from orgtree)""")
        } catch (Exception e) {
            e.printStackTrace()
            info = e.getMessage()
        }
        render info
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'organizationInstance.label', default: 'Organization'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
