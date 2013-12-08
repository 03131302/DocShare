
<%@ page import="com.ocse.doc.domain.InfoType" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'infoType.label', default: 'InfoType')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-infoType" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-infoType" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list infoType">
			
				<g:if test="${infoTypeInstance?.name}">
				<li class="fieldcontain">
					<span id="name-label" class="property-label"><g:message code="infoType.name.label" default="Name" /></span>
					
						<span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${infoTypeInstance}" field="name"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${infoTypeInstance?.parentInfoType}">
				<li class="fieldcontain">
					<span id="parentInfoType-label" class="property-label"><g:message code="infoType.parentInfoType.label" default="Parent Info Type" /></span>
					
						<span class="property-value" aria-labelledby="parentInfoType-label"><g:link controller="infoType" action="show" id="${infoTypeInstance?.parentInfoType?.id}">${infoTypeInstance?.parentInfoType?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${infoTypeInstance?.pxh}">
				<li class="fieldcontain">
					<span id="pxh-label" class="property-label"><g:message code="infoType.pxh.label" default="Pxh" /></span>
					
						<span class="property-value" aria-labelledby="pxh-label"><g:fieldValue bean="${infoTypeInstance}" field="pxh"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:infoTypeInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${infoTypeInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
