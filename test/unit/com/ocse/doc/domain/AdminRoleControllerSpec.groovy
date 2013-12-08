package com.ocse.doc.domain



import grails.test.mixin.*
import spock.lang.*

@TestFor(AdminRoleController)
@Mock(AdminRole)
class AdminRoleControllerSpec extends Specification {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void "Test the index action returns the correct model"() {

        when: "The index action is executed"
        controller.index()

        then: "The model is correct"
        !model.adminRoleInstanceList
        model.adminRoleInstanceCount == 0
    }

    void "Test the create action returns the correct model"() {
        when: "The create action is executed"
        controller.create()

        then: "The model is correctly created"
        model.adminRoleInstance != null
    }

    void "Test the save action correctly persists an instance"() {

        when: "The save action is executed with an invalid instance"
        def adminRole = new AdminRole()
        adminRole.validate()
        controller.save(adminRole)

        then: "The create view is rendered again with the correct model"
        model.adminRoleInstance != null
        view == 'create'

        when: "The save action is executed with a valid instance"
        response.reset()
        populateValidParams(params)
        adminRole = new AdminRole(params)

        controller.save(adminRole)

        then: "A redirect is issued to the show action"
        response.redirectedUrl == '/adminRole/show/1'
        controller.flash.message != null
        AdminRole.count() == 1
    }

    void "Test that the show action returns the correct model"() {
        when: "The show action is executed with a null domain"
        controller.show(null)

        then: "A 404 error is returned"
        response.status == 404

        when: "A domain instance is passed to the show action"
        populateValidParams(params)
        def adminRole = new AdminRole(params)
        controller.show(adminRole)

        then: "A model is populated containing the domain instance"
        model.adminRoleInstance == adminRole
    }

    void "Test that the edit action returns the correct model"() {
        when: "The edit action is executed with a null domain"
        controller.edit(null)

        then: "A 404 error is returned"
        response.status == 404

        when: "A domain instance is passed to the edit action"
        populateValidParams(params)
        def adminRole = new AdminRole(params)
        controller.edit(adminRole)

        then: "A model is populated containing the domain instance"
        model.adminRoleInstance == adminRole
    }

    void "Test the update action performs an update on a valid domain instance"() {
        when: "Update is called for a domain instance that doesn't exist"
        controller.update(null)

        then: "A 404 error is returned"
        response.redirectedUrl == '/adminRole/index'
        flash.message != null


        when: "An invalid domain instance is passed to the update action"
        response.reset()
        def adminRole = new AdminRole()
        adminRole.validate()
        controller.update(adminRole)

        then: "The edit view is rendered again with the invalid instance"
        view == 'edit'
        model.adminRoleInstance == adminRole

        when: "A valid domain instance is passed to the update action"
        response.reset()
        populateValidParams(params)
        adminRole = new AdminRole(params).save(flush: true)
        controller.update(adminRole)

        then: "A redirect is issues to the show action"
        response.redirectedUrl == "/adminRole/show/$adminRole.id"
        flash.message != null
    }

    void "Test that the delete action deletes an instance if it exists"() {
        when: "The delete action is called for a null instance"
        controller.delete(null)

        then: "A 404 is returned"
        response.redirectedUrl == '/adminRole/index'
        flash.message != null

        when: "A domain instance is created"
        response.reset()
        populateValidParams(params)
        def adminRole = new AdminRole(params).save(flush: true)

        then: "It exists"
        AdminRole.count() == 1

        when: "The domain instance is passed to the delete action"
        controller.delete(adminRole)

        then: "The instance is deleted"
        AdminRole.count() == 0
        response.redirectedUrl == '/adminRole/index'
        flash.message != null
    }
}
