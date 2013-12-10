package com.ocse.doc.domain



import grails.test.mixin.*
import spock.lang.*

@TestFor(LoginLogController)
@Mock(LoginLog)
class LoginLogControllerSpec extends Specification {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void "Test the index action returns the correct model"() {

        when: "The index action is executed"
        controller.index()

        then: "The model is correct"
        !model.loginLogInstanceList
        model.loginLogInstanceCount == 0
    }

    void "Test the create action returns the correct model"() {
        when: "The create action is executed"
        controller.create()

        then: "The model is correctly created"
        model.loginLogInstance != null
    }

    void "Test the save action correctly persists an instance"() {

        when: "The save action is executed with an invalid instance"
        def loginLog = new LoginLog()
        loginLog.validate()
        controller.save(loginLog)

        then: "The create view is rendered again with the correct model"
        model.loginLogInstance != null
        view == 'create'

        when: "The save action is executed with a valid instance"
        response.reset()
        populateValidParams(params)
        loginLog = new LoginLog(params)

        controller.save(loginLog)

        then: "A redirect is issued to the show action"
        response.redirectedUrl == '/loginLog/show/1'
        controller.flash.message != null
        LoginLog.count() == 1
    }

    void "Test that the show action returns the correct model"() {
        when: "The show action is executed with a null domain"
        controller.show(null)

        then: "A 404 error is returned"
        response.status == 404

        when: "A domain instance is passed to the show action"
        populateValidParams(params)
        def loginLog = new LoginLog(params)
        controller.show(loginLog)

        then: "A model is populated containing the domain instance"
        model.loginLogInstance == loginLog
    }

    void "Test that the edit action returns the correct model"() {
        when: "The edit action is executed with a null domain"
        controller.edit(null)

        then: "A 404 error is returned"
        response.status == 404

        when: "A domain instance is passed to the edit action"
        populateValidParams(params)
        def loginLog = new LoginLog(params)
        controller.edit(loginLog)

        then: "A model is populated containing the domain instance"
        model.loginLogInstance == loginLog
    }

    void "Test the update action performs an update on a valid domain instance"() {
        when: "Update is called for a domain instance that doesn't exist"
        controller.update(null)

        then: "A 404 error is returned"
        response.redirectedUrl == '/loginLog/index'
        flash.message != null


        when: "An invalid domain instance is passed to the update action"
        response.reset()
        def loginLog = new LoginLog()
        loginLog.validate()
        controller.update(loginLog)

        then: "The edit view is rendered again with the invalid instance"
        view == 'edit'
        model.loginLogInstance == loginLog

        when: "A valid domain instance is passed to the update action"
        response.reset()
        populateValidParams(params)
        loginLog = new LoginLog(params).save(flush: true)
        controller.update(loginLog)

        then: "A redirect is issues to the show action"
        response.redirectedUrl == "/loginLog/show/$loginLog.id"
        flash.message != null
    }

    void "Test that the delete action deletes an instance if it exists"() {
        when: "The delete action is called for a null instance"
        controller.delete(null)

        then: "A 404 is returned"
        response.redirectedUrl == '/loginLog/index'
        flash.message != null

        when: "A domain instance is created"
        response.reset()
        populateValidParams(params)
        def loginLog = new LoginLog(params).save(flush: true)

        then: "It exists"
        LoginLog.count() == 1

        when: "The domain instance is passed to the delete action"
        controller.delete(loginLog)

        then: "The instance is deleted"
        LoginLog.count() == 0
        response.redirectedUrl == '/loginLog/index'
        flash.message != null
    }
}
