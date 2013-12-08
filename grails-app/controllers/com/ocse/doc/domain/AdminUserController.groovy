package com.ocse.doc.domain



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class AdminUserController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond AdminUser.list(params), model: [adminUserInstanceCount: AdminUser.count()]
    }

    def show(AdminUser adminUserInstance) {
        respond adminUserInstance
    }

    def create() {
        respond new AdminUser(params)
    }

    @Transactional
    def save(AdminUser adminUserInstance) {
        if (adminUserInstance == null) {
            notFound()
            return
        }

        if (adminUserInstance.hasErrors()) {
            respond adminUserInstance.errors, view: 'create'
            return
        }

        adminUserInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'adminUserInstance.label', default: 'AdminUser'), adminUserInstance.id])
                redirect adminUserInstance
            }
            '*' { respond adminUserInstance, [status: CREATED] }
        }
    }

    def edit(AdminUser adminUserInstance) {
        respond adminUserInstance
    }

    @Transactional
    def update(AdminUser adminUserInstance) {
        if (adminUserInstance == null) {
            notFound()
            return
        }

        if (adminUserInstance.hasErrors()) {
            respond adminUserInstance.errors, view: 'edit'
            return
        }

        adminUserInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'AdminUser.label', default: 'AdminUser'), adminUserInstance.id])
                redirect adminUserInstance
            }
            '*' { respond adminUserInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(AdminUser adminUserInstance) {

        if (adminUserInstance == null) {
            notFound()
            return
        }

        adminUserInstance.delete flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'AdminUser.label', default: 'AdminUser'), adminUserInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'adminUserInstance.label', default: 'AdminUser'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
