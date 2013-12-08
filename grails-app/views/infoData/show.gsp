
<%@ page import="com.ocse.doc.domain.InfoData" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'infoData.label', default: 'InfoData')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-infoData" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-infoData" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list infoData">
			
				<g:if test="${infoDataInstance?.text}">
				<li class="fieldcontain">
					<span id="text-label" class="property-label"><g:message code="infoData.text.label" default="Text" /></span>
					
						<span class="property-value" aria-labelledby="text-label"><g:fieldValue bean="${infoDataInstance}" field="text"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${infoDataInstance?.saveDate}">
				<li class="fieldcontain">
					<span id="saveDate-label" class="property-label"><g:message code="infoData.saveDate.label" default="Save Date" /></span>
					
						<span class="property-value" aria-labelledby="saveDate-label"><g:formatDate date="${infoDataInstance?.saveDate}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${infoDataInstance?.saveState}">
				<li class="fieldcontain">
					<span id="saveState-label" class="property-label"><g:message code="infoData.saveState.label" default="Save State" /></span>
					
						<span class="property-value" aria-labelledby="saveState-label"><g:fieldValue bean="${infoDataInstance}" field="saveState"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${infoDataInstance?.shareScope}">
				<li class="fieldcontain">
					<span id="shareScope-label" class="property-label"><g:message code="infoData.shareScope.label" default="Share Scope" /></span>
					
						<span class="property-value" aria-labelledby="shareScope-label"><g:fieldValue bean="${infoDataInstance}" field="shareScope"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${infoDataInstance?.shareType}">
				<li class="fieldcontain">
					<span id="shareType-label" class="property-label"><g:message code="infoData.shareType.label" default="Share Type" /></span>
					
						<span class="property-value" aria-labelledby="shareType-label"><g:fieldValue bean="${infoDataInstance}" field="shareType"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${infoDataInstance?.title}">
				<li class="fieldcontain">
					<span id="title-label" class="property-label"><g:message code="infoData.title.label" default="Title" /></span>
					
						<span class="property-value" aria-labelledby="title-label"><g:fieldValue bean="${infoDataInstance}" field="title"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${infoDataInstance?.type}">
				<li class="fieldcontain">
					<span id="type-label" class="property-label"><g:message code="infoData.type.label" default="Type" /></span>
					
						<span class="property-value" aria-labelledby="type-label"><g:link controller="infoType" action="show" id="${infoDataInstance?.type?.id}">${infoDataInstance?.type?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${infoDataInstance?.user}">
				<li class="fieldcontain">
					<span id="user-label" class="property-label"><g:message code="infoData.user.label" default="User" /></span>
					
						<span class="property-value" aria-labelledby="user-label"><g:link controller="adminUser" action="show" id="${infoDataInstance?.user?.id}">${infoDataInstance?.user?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:infoDataInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${infoDataInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
