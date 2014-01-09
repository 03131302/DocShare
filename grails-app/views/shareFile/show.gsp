
<%@ page import="com.ocse.doc.domain.ShareFile" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'shareFile.label', default: 'ShareFile')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-shareFile" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-shareFile" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list shareFile">
			
				<g:if test="${shareFileInstance?.logDate}">
				<li class="fieldcontain">
					<span id="logDate-label" class="property-label"><g:message code="shareFile.logDate.label" default="Log Date" /></span>
					
						<span class="property-value" aria-labelledby="logDate-label"><g:formatDate date="${shareFileInstance?.logDate}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${shareFileInstance?.path}">
				<li class="fieldcontain">
					<span id="path-label" class="property-label"><g:message code="shareFile.path.label" default="Path" /></span>
					
						<span class="property-value" aria-labelledby="path-label"><g:fieldValue bean="${shareFileInstance}" field="path"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${shareFileInstance?.title}">
				<li class="fieldcontain">
					<span id="title-label" class="property-label"><g:message code="shareFile.title.label" default="Title" /></span>
					
						<span class="property-value" aria-labelledby="title-label"><g:fieldValue bean="${shareFileInstance}" field="title"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:shareFileInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${shareFileInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
