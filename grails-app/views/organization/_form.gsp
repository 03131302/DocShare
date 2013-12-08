<%@ page import="com.ocse.doc.domain.Organization" %>



<div class="fieldcontain ${hasErrors(bean: organizationInstance, field: 'name', 'error')} ">
	<label for="name">
		<g:message code="organization.name.label" default="Name" />
		
	</label>
	<g:textField name="name" value="${organizationInstance?.name}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: organizationInstance, field: 'parent', 'error')} ">
	<label for="parent">
		<g:message code="organization.parent.label" default="Parent" />
		
	</label>
	<g:select id="parent" name="parent.id" from="${com.ocse.doc.domain.Organization.list()}" optionKey="id" value="${organizationInstance?.parent?.id}" class="many-to-one" noSelection="['null': '']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: organizationInstance, field: 'text', 'error')} ">
	<label for="text">
		<g:message code="organization.text.label" default="Text" />
		
	</label>
	<g:textField name="text" value="${organizationInstance?.text}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: organizationInstance, field: 'pxh', 'error')} required">
	<label for="pxh">
		<g:message code="organization.pxh.label" default="Pxh" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="pxh" type="number" value="${organizationInstance.pxh}" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: organizationInstance, field: 'roles', 'error')} ">
	<label for="roles">
		<g:message code="organization.roles.label" default="Roles" />
		
	</label>
	<g:select name="roles" from="${com.ocse.doc.domain.AdminRole.list()}" multiple="multiple" optionKey="id" size="5" value="${organizationInstance?.roles*.id}" class="many-to-many"/>
</div>

