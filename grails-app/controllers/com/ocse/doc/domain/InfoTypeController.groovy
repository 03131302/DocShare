package com.ocse.doc.domain



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class InfoTypeController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond InfoType.list(params), model: [infoTypeInstanceCount: InfoType.count()]
    }

    def show(InfoType infoTypeInstance) {
        respond infoTypeInstance
    }

    def create() {
        respond new InfoType(params)
    }

    @Transactional
    def save(InfoType infoTypeInstance) {
        if (infoTypeInstance == null) {
            notFound()
            return
        }

        if (infoTypeInstance.hasErrors()) {
            respond infoTypeInstance.errors, view: 'create'
            return
        }

        infoTypeInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'infoTypeInstance.label', default: 'InfoType'), infoTypeInstance.id])
                redirect infoTypeInstance
            }
            '*' { respond infoTypeInstance, [status: CREATED] }
        }
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

        infoTypeInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'InfoType.label', default: 'InfoType'), infoTypeInstance.id])
                redirect infoTypeInstance
            }
            '*' { respond infoTypeInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(InfoType infoTypeInstance) {

        if (infoTypeInstance == null) {
            notFound()
            return
        }

        infoTypeInstance.delete flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'InfoType.label', default: 'InfoType'), infoTypeInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
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
