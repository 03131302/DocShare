
<%@ page import="com.ocse.doc.domain.InfoLog" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'infoLog.label', default: 'InfoLog')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-infoLog" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-infoLog" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list infoLog">
			
				<g:if test="${infoLogInstance?.ip}">
				<li class="fieldcontain">
					<span id="ip-label" class="property-label"><g:message code="infoLog.ip.label" default="Ip" /></span>
					
						<span class="property-value" aria-labelledby="ip-label"><g:fieldValue bean="${infoLogInstance}" field="ip"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${infoLogInstance?.type}">
				<li class="fieldcontain">
					<span id="type-label" class="property-label"><g:message code="infoLog.type.label" default="Type" /></span>
					
						<span class="property-value" aria-labelledby="type-label"><g:fieldValue bean="${infoLogInstance}" field="type"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${infoLogInstance?.infoData}">
				<li class="fieldcontain">
					<span id="infoData-label" class="property-label"><g:message code="infoLog.infoData.label" default="Info Data" /></span>
					
						<span class="property-value" aria-labelledby="infoData-label"><g:link controller="infoData" action="show" id="${infoLogInstance?.infoData?.id}">${infoLogInstance?.infoData?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${infoLogInstance?.infoDate}">
				<li class="fieldcontain">
					<span id="infoDate-label" class="property-label"><g:message code="infoLog.infoDate.label" default="Info Date" /></span>
					
						<span class="property-value" aria-labelledby="infoDate-label"><g:formatDate date="${infoLogInstance?.infoDate}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${infoLogInstance?.user}">
				<li class="fieldcontain">
					<span id="user-label" class="property-label"><g:message code="infoLog.user.label" default="User" /></span>
					
						<span class="property-value" aria-labelledby="user-label"><g:link controller="adminUser" action="show" id="${infoLogInstance?.user?.id}">${infoLogInstance?.user?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:infoLogInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${infoLogInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
