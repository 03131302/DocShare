
<%@ page import="com.ocse.doc.domain.UserCommit" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'userCommit.label', default: 'UserCommit')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-userCommit" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-userCommit" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list userCommit">
			
				<g:if test="${userCommitInstance?.content}">
				<li class="fieldcontain">
					<span id="content-label" class="property-label"><g:message code="userCommit.content.label" default="Content" /></span>
					
						<span class="property-value" aria-labelledby="content-label"><g:fieldValue bean="${userCommitInstance}" field="content"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${userCommitInstance?.logDate}">
				<li class="fieldcontain">
					<span id="logDate-label" class="property-label"><g:message code="userCommit.logDate.label" default="Log Date" /></span>
					
						<span class="property-value" aria-labelledby="logDate-label"><g:formatDate date="${userCommitInstance?.logDate}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${userCommitInstance?.title}">
				<li class="fieldcontain">
					<span id="title-label" class="property-label"><g:message code="userCommit.title.label" default="Title" /></span>
					
						<span class="property-value" aria-labelledby="title-label"><g:fieldValue bean="${userCommitInstance}" field="title"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${userCommitInstance?.user}">
				<li class="fieldcontain">
					<span id="user-label" class="property-label"><g:message code="userCommit.user.label" default="User" /></span>
					
						<span class="property-value" aria-labelledby="user-label"><g:link controller="adminUser" action="show" id="${userCommitInstance?.user?.id}">${userCommitInstance?.user?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:userCommitInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${userCommitInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
