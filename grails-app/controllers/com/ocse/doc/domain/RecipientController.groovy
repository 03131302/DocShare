package com.ocse.doc.domain

import grails.transaction.Transactional

import static org.springframework.http.HttpStatus.NOT_FOUND
import static org.springframework.http.HttpStatus.OK

@Transactional(readOnly = true)
class RecipientController {

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Recipient.list(params), model: [recipientInstanceCount: Recipient.count()]
    }

    def show(Recipient recipientInstance) {
        respond recipientInstance
    }

    def create() {
        respond new Recipient(params)
    }

    @Transactional
    def save(Recipient recipientInstance) {
        String info = "true"
        try {
            recipientInstance.save flush: true
            //日志记录
            try {
                InfoLog infoLog = new InfoLog(infoData: recipientInstance.infoData, user: session["adminUser"], infoDate: new Date()
                        , ip: request.getRemoteAddr(), type: "反馈")
                infoLog.save flush: true
            } catch (Exception e) {
                e.printStackTrace()
            }
        } catch (Exception e) {
            e.printStackTrace()
            info = e.getMessage()
        }
        render info
    }

    def edit(Recipient recipientInstance) {
        respond recipientInstance
    }

    @Transactional
    def update(Recipient recipientInstance) {
        if (recipientInstance == null) {
            notFound()
            return
        }

        if (recipientInstance.hasErrors()) {
            respond recipientInstance.errors, view: 'edit'
            return
        }

        recipientInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Recipient.label', default: 'Recipient'), recipientInstance.id])
                redirect recipientInstance
            }
            '*' { respond recipientInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Recipient recipientInstance) {
        String info = "true"
        try {
            if (recipientInstance.text.isInteger() && InfoData.get(recipientInstance.text) != null) {
                InfoData.get(recipientInstance.text).delete flush: true
            }
            recipientInstance.delete flush: true
        } catch (Exception e) {
            e.printStackTrace()
            info = e.getMessage()
        }
        render info
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'recipientInstance.label', default: 'Recipient'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
