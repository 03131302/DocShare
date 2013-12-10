
<%@ page import="com.ocse.doc.domain.LoginLog" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'loginLog.label', default: 'LoginLog')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-loginLog" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-loginLog" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list loginLog">
			
				<g:if test="${loginLogInstance?.loginDate}">
				<li class="fieldcontain">
					<span id="loginDate-label" class="property-label"><g:message code="loginLog.loginDate.label" default="Login Date" /></span>
					
						<span class="property-value" aria-labelledby="loginDate-label"><g:formatDate date="${loginLogInstance?.loginDate}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${loginLogInstance?.ip}">
				<li class="fieldcontain">
					<span id="ip-label" class="property-label"><g:message code="loginLog.ip.label" default="Ip" /></span>
					
						<span class="property-value" aria-labelledby="ip-label"><g:fieldValue bean="${loginLogInstance}" field="ip"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${loginLogInstance?.user}">
				<li class="fieldcontain">
					<span id="user-label" class="property-label"><g:message code="loginLog.user.label" default="User" /></span>
					
						<span class="property-value" aria-labelledby="user-label"><g:link controller="adminUser" action="show" id="${loginLogInstance?.user?.id}">${loginLogInstance?.user?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:loginLogInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${loginLogInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
