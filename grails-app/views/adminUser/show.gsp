
<%@ page import="com.ocse.doc.domain.AdminUser" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'adminUser.label', default: 'AdminUser')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-adminUser" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-adminUser" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list adminUser">
			
				<g:if test="${adminUserInstance?.userName}">
				<li class="fieldcontain">
					<span id="userName-label" class="property-label"><g:message code="adminUser.userName.label" default="User Name" /></span>
					
						<span class="property-value" aria-labelledby="userName-label"><g:fieldValue bean="${adminUserInstance}" field="userName"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${adminUserInstance?.userCode}">
				<li class="fieldcontain">
					<span id="userCode-label" class="property-label"><g:message code="adminUser.userCode.label" default="User Code" /></span>
					
						<span class="property-value" aria-labelledby="userCode-label"><g:fieldValue bean="${adminUserInstance}" field="userCode"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${adminUserInstance?.passWord}">
				<li class="fieldcontain">
					<span id="passWord-label" class="property-label"><g:message code="adminUser.passWord.label" default="Pass Word" /></span>
					
						<span class="property-value" aria-labelledby="passWord-label"><g:fieldValue bean="${adminUserInstance}" field="passWord"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${adminUserInstance?.text}">
				<li class="fieldcontain">
					<span id="text-label" class="property-label"><g:message code="adminUser.text.label" default="Text" /></span>
					
						<span class="property-value" aria-labelledby="text-label"><g:fieldValue bean="${adminUserInstance}" field="text"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${adminUserInstance?.isStop}">
				<li class="fieldcontain">
					<span id="isStop-label" class="property-label"><g:message code="adminUser.isStop.label" default="Is Stop" /></span>
					
						<span class="property-value" aria-labelledby="isStop-label"><g:formatBoolean boolean="${adminUserInstance?.isStop}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${adminUserInstance?.org}">
				<li class="fieldcontain">
					<span id="org-label" class="property-label"><g:message code="adminUser.org.label" default="Org" /></span>
					
						<span class="property-value" aria-labelledby="org-label"><g:link controller="organization" action="show" id="${adminUserInstance?.org?.id}">${adminUserInstance?.org?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${adminUserInstance?.pxh}">
				<li class="fieldcontain">
					<span id="pxh-label" class="property-label"><g:message code="adminUser.pxh.label" default="Pxh" /></span>
					
						<span class="property-value" aria-labelledby="pxh-label"><g:fieldValue bean="${adminUserInstance}" field="pxh"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${adminUserInstance?.roles}">
				<li class="fieldcontain">
					<span id="roles-label" class="property-label"><g:message code="adminUser.roles.label" default="Roles" /></span>
					
						<g:each in="${adminUserInstance.roles}" var="r">
						<span class="property-value" aria-labelledby="roles-label"><g:link controller="adminRole" action="show" id="${r.id}">${r?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:adminUserInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${adminUserInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
