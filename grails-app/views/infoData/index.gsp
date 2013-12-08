
<%@ page import="com.ocse.doc.domain.InfoData" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'infoData.label', default: 'InfoData')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-infoData" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-infoData" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="text" title="${message(code: 'infoData.text.label', default: 'Text')}" />
					
						<g:sortableColumn property="saveDate" title="${message(code: 'infoData.saveDate.label', default: 'Save Date')}" />
					
						<g:sortableColumn property="saveState" title="${message(code: 'infoData.saveState.label', default: 'Save State')}" />
					
						<g:sortableColumn property="shareScope" title="${message(code: 'infoData.shareScope.label', default: 'Share Scope')}" />
					
						<g:sortableColumn property="shareType" title="${message(code: 'infoData.shareType.label', default: 'Share Type')}" />
					
						<g:sortableColumn property="title" title="${message(code: 'infoData.title.label', default: 'Title')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${infoDataInstanceList}" status="i" var="infoDataInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${infoDataInstance.id}">${fieldValue(bean: infoDataInstance, field: "text")}</g:link></td>
					
						<td><g:formatDate date="${infoDataInstance.saveDate}" /></td>
					
						<td>${fieldValue(bean: infoDataInstance, field: "saveState")}</td>
					
						<td>${fieldValue(bean: infoDataInstance, field: "shareScope")}</td>
					
						<td>${fieldValue(bean: infoDataInstance, field: "shareType")}</td>
					
						<td>${fieldValue(bean: infoDataInstance, field: "title")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${infoDataInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
