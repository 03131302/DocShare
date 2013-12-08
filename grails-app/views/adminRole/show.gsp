
<%@ page import="com.ocse.doc.domain.AdminRole" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'adminRole.label', default: 'AdminRole')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-adminRole" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-adminRole" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list adminRole">
			
				<g:if test="${adminRoleInstance?.name}">
				<li class="fieldcontain">
					<span id="name-label" class="property-label"><g:message code="adminRole.name.label" default="Name" /></span>
					
						<span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${adminRoleInstance}" field="name"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${adminRoleInstance?.text}">
				<li class="fieldcontain">
					<span id="text-label" class="property-label"><g:message code="adminRole.text.label" default="Text" /></span>
					
						<span class="property-value" aria-labelledby="text-label"><g:fieldValue bean="${adminRoleInstance}" field="text"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${adminRoleInstance?.level}">
				<li class="fieldcontain">
					<span id="level-label" class="property-label"><g:message code="adminRole.level.label" default="Level" /></span>
					
						<span class="property-value" aria-labelledby="level-label"><g:fieldValue bean="${adminRoleInstance}" field="level"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${adminRoleInstance?.orgs}">
				<li class="fieldcontain">
					<span id="orgs-label" class="property-label"><g:message code="adminRole.orgs.label" default="Orgs" /></span>
					
						<g:each in="${adminRoleInstance.orgs}" var="o">
						<span class="property-value" aria-labelledby="orgs-label"><g:link controller="organization" action="show" id="${o.id}">${o?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${adminRoleInstance?.users}">
				<li class="fieldcontain">
					<span id="users-label" class="property-label"><g:message code="adminRole.users.label" default="Users" /></span>
					
						<g:each in="${adminRoleInstance.users}" var="u">
						<span class="property-value" aria-labelledby="users-label"><g:link controller="adminUser" action="show" id="${u.id}">${u?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:adminRoleInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${adminRoleInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
