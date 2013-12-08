
<%@ page import="com.ocse.doc.domain.InfoFile" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'infoFile.label', default: 'InfoFile')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-infoFile" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-infoFile" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list infoFile">
			
				<g:if test="${infoFileInstance?.name}">
				<li class="fieldcontain">
					<span id="name-label" class="property-label"><g:message code="infoFile.name.label" default="Name" /></span>
					
						<span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${infoFileInstance}" field="name"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${infoFileInstance?.path}">
				<li class="fieldcontain">
					<span id="path-label" class="property-label"><g:message code="infoFile.path.label" default="Path" /></span>
					
						<span class="property-value" aria-labelledby="path-label"><g:fieldValue bean="${infoFileInstance}" field="path"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${infoFileInstance?.infoData}">
				<li class="fieldcontain">
					<span id="infoData-label" class="property-label"><g:message code="infoFile.infoData.label" default="Info Data" /></span>
					
						<span class="property-value" aria-labelledby="infoData-label"><g:link controller="infoData" action="show" id="${infoFileInstance?.infoData?.id}">${infoFileInstance?.infoData?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${infoFileInstance?.saveDate}">
				<li class="fieldcontain">
					<span id="saveDate-label" class="property-label"><g:message code="infoFile.saveDate.label" default="Save Date" /></span>
					
						<span class="property-value" aria-labelledby="saveDate-label"><g:formatDate date="${infoFileInstance?.saveDate}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${infoFileInstance?.state}">
				<li class="fieldcontain">
					<span id="state-label" class="property-label"><g:message code="infoFile.state.label" default="State" /></span>
					
						<span class="property-value" aria-labelledby="state-label"><g:fieldValue bean="${infoFileInstance}" field="state"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:infoFileInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${infoFileInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
