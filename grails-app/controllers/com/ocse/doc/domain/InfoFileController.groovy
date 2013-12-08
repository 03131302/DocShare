package com.ocse.doc.domain



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class InfoFileController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond InfoFile.list(params), model: [infoFileInstanceCount: InfoFile.count()]
    }

    def show(InfoFile infoFileInstance) {
        respond infoFileInstance
    }

    def create() {
        respond new InfoFile(params)
    }

    @Transactional
    def save(InfoFile infoFileInstance) {
        if (infoFileInstance == null) {
            notFound()
            return
        }

        if (infoFileInstance.hasErrors()) {
            respond infoFileInstance.errors, view: 'create'
            return
        }

        infoFileInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'infoFileInstance.label', default: 'InfoFile'), infoFileInstance.id])
                redirect infoFileInstance
            }
            '*' { respond infoFileInstance, [status: CREATED] }
        }
    }

    def edit(InfoFile infoFileInstance) {
        respond infoFileInstance
    }

    @Transactional
    def update(InfoFile infoFileInstance) {
        if (infoFileInstance == null) {
            notFound()
            return
        }

        if (infoFileInstance.hasErrors()) {
            respond infoFileInstance.errors, view: 'edit'
            return
        }

        infoFileInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'InfoFile.label', default: 'InfoFile'), infoFileInstance.id])
                redirect infoFileInstance
            }
            '*' { respond infoFileInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(InfoFile infoFileInstance) {

        if (infoFileInstance == null) {
            notFound()
            return
        }

        infoFileInstance.delete flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'InfoFile.label', default: 'InfoFile'), infoFileInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'infoFileInstance.label', default: 'InfoFile'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
