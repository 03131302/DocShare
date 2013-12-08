package com.ocse.doc.domain



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class InfoLogController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond InfoLog.list(params), model: [infoLogInstanceCount: InfoLog.count()]
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

    @Transactional
    def delete(InfoLog infoLogInstance) {

        if (infoLogInstance == null) {
            notFound()
            return
        }

        infoLogInstance.delete flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'InfoLog.label', default: 'InfoLog'), infoLogInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
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
