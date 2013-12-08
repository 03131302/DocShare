package com.ocse.doc.domain



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class AdminRoleController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond AdminRole.list(params), model:[adminRoleInstanceCount: AdminRole.count()]
    }

    def show(AdminRole adminRoleInstance) {
        respond adminRoleInstance
    }

    def create() {
        respond new AdminRole(params)
    }

    @Transactional
    def save(AdminRole adminRoleInstance) {
        if (adminRoleInstance == null) {
            notFound()
            return
        }

        if (adminRoleInstance.hasErrors()) {
            respond adminRoleInstance.errors, view:'create'
            return
        }

        adminRoleInstance.save flush:true

        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'adminRoleInstance.label', default: 'AdminRole'), adminRoleInstance.id])
                redirect adminRoleInstance
            }
            '*' { respond adminRoleInstance, [status: CREATED] }
        }
    }

    def edit(AdminRole adminRoleInstance) {
        respond adminRoleInstance
    }

    @Transactional
    def update(AdminRole adminRoleInstance) {
        if (adminRoleInstance == null) {
            notFound()
            return
        }

        if (adminRoleInstance.hasErrors()) {
            respond adminRoleInstance.errors, view:'edit'
            return
        }

        adminRoleInstance.save flush:true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'AdminRole.label', default: 'AdminRole'), adminRoleInstance.id])
                redirect adminRoleInstance
            }
            '*'{ respond adminRoleInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(AdminRole adminRoleInstance) {

        if (adminRoleInstance == null) {
            notFound()
            return
        }

        adminRoleInstance.delete flush:true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'AdminRole.label', default: 'AdminRole'), adminRoleInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'adminRoleInstance.label', default: 'AdminRole'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
