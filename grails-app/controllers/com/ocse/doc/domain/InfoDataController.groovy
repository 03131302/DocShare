package com.ocse.doc.domain



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class InfoDataController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond InfoData.list(params), model: [infoDataInstanceCount: InfoData.count()]
    }

    def show(InfoData infoDataInstance) {
        respond infoDataInstance
    }

    def create() {
        respond new InfoData(params)
    }

    @Transactional
    def save(InfoData infoDataInstance) {
        if (infoDataInstance == null) {
            notFound()
            return
        }

        if (infoDataInstance.hasErrors()) {
            respond infoDataInstance.errors, view: 'create'
            return
        }

        infoDataInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'infoDataInstance.label', default: 'InfoData'), infoDataInstance.id])
                redirect infoDataInstance
            }
            '*' { respond infoDataInstance, [status: CREATED] }
        }
    }

    def edit(InfoData infoDataInstance) {
        respond infoDataInstance
    }

    @Transactional
    def update(InfoData infoDataInstance) {
        if (infoDataInstance == null) {
            notFound()
            return
        }

        if (infoDataInstance.hasErrors()) {
            respond infoDataInstance.errors, view: 'edit'
            return
        }

        infoDataInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'InfoData.label', default: 'InfoData'), infoDataInstance.id])
                redirect infoDataInstance
            }
            '*' { respond infoDataInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(InfoData infoDataInstance) {

        if (infoDataInstance == null) {
            notFound()
            return
        }

        infoDataInstance.delete flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'InfoData.label', default: 'InfoData'), infoDataInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'infoDataInstance.label', default: 'InfoData'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
