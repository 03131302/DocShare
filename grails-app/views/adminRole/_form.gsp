<%@ page import="com.ocse.doc.domain.AdminRole" %>



<div class="fieldcontain ${hasErrors(bean: adminRoleInstance, field: 'name', 'error')} ">
	<label for="name">
		<g:message code="adminRole.name.label" default="Name" />
		
	</label>
	<g:textField name="name" value="${adminRoleInstance?.name}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: adminRoleInstance, field: 'text', 'error')} ">
	<label for="text">
		<g:message code="adminRole.text.label" default="Text" />
		
	</label>
	<g:textField name="text" value="${adminRoleInstance?.text}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: adminRoleInstance, field: 'level', 'error')} required">
	<label for="level">
		<g:message code="adminRole.level.label" default="Level" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="level" type="number" value="${adminRoleInstance.level}" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: adminRoleInstance, field: 'orgs', 'error')} ">
	<label for="orgs">
		<g:message code="adminRole.orgs.label" default="Orgs" />
		
	</label>
	
</div>

<div class="fieldcontain ${hasErrors(bean: adminRoleInstance, field: 'users', 'error')} ">
	<label for="users">
		<g:message code="adminRole.users.label" default="Users" />
		
	</label>
	
</div>

