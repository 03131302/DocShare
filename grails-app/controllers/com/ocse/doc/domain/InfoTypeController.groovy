package com.ocse.doc.domain

import grails.converters.JSON
import groovy.sql.Sql

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class InfoTypeController {
    def dataSource

    def index() {
        render view: "index", model: [data: ""]
    }

    def getOrgTreeData() {
        def listData = []
        Sql sql = new Sql(dataSource: dataSource)
        sql.eachRow("""
                    SELECT [id]
                          ,[version]
                          ,[name]
                          ,[parent_info_type_id]
                          ,[pxh]
                      FROM [DocManage].[dbo].[info_type] order by pxh""") {
            data ->
                def map = [id: data.id, name: data.name, pId: data.parent_info_type_id == null ? 0 : data.parent_info_type_id, drag: true]
                listData.add(map)
        }
        render(contentType: "text/json") { listData }
    }

    def show(InfoType infoTypeInstance) {
        render infoTypeInstance as JSON
    }

    def create() {
        respond new InfoType(params)
    }

    def move(int id, int tid) {
        Sql sql = new Sql(dataSource: dataSource);
        String info = "true"
        try {
            sql.execute("update [DocManage].[dbo].[info_type] set [parent_info_type_id]=${tid} where [id]=${id}")
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
            InfoType infoType = new InfoType(params)
            infoType.save flush: true
        } catch (Exception e) {
            e.printStackTrace()
            info = e.getMessage()
        }
        render info
    }

    def edit(InfoType infoTypeInstance) {
        respond infoTypeInstance
    }

    @Transactional
    def update(InfoType infoTypeInstance) {
        if (infoTypeInstance == null) {
            notFound()
            return
        }

        if (infoTypeInstance.hasErrors()) {
            respond infoTypeInstance.errors, view: 'edit'
            return
        }
        String info = "true"
        try {
            infoTypeInstance.save flush: true
        } catch (Exception e) {
            info = e.getMessage()
            e.printStackTrace()
        }
        render info
    }

    @Transactional
    def delete(InfoType infoTypeInstance) {
        if (infoTypeInstance == null) {
            notFound()
            return
        }
        String info = "true"
        try {
            Sql sql = new Sql(dataSource: dataSource)
            sql.execute("""
                          WITH orgtree([id],[name],[parent_info_type_id],[pxh]) as
                         (
                            SELECT [id],[name],[parent_info_type_id],[pxh] FROM [DocManage].[dbo].[info_type] WHERE id =${
                infoTypeInstance.id
            }
                            UNION ALL
                            SELECT a.[id],a.[name],a.[parent_info_type_id],a.[pxh] FROM [DocManage].[dbo].[info_type] A,orgtree b
                            where a.parent_info_type_id = b.id
                        )
                        delete from [DocManage].[dbo].[info_type] where id in ( SELECT id  from orgtree)""")
        } catch (Exception e) {
            e.printStackTrace()
            info = e.getMessage()
        }
        render info
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'infoTypeInstance.label', default: 'InfoType'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
