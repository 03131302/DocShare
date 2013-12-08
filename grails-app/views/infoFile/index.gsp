
<%@ page import="com.ocse.doc.domain.InfoFile" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'infoFile.label', default: 'InfoFile')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-infoFile" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-infoFile" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="name" title="${message(code: 'infoFile.name.label', default: 'Name')}" />
					
						<g:sortableColumn property="path" title="${message(code: 'infoFile.path.label', default: 'Path')}" />
					
						<th><g:message code="infoFile.infoData.label" default="Info Data" /></th>
					
						<g:sortableColumn property="saveDate" title="${message(code: 'infoFile.saveDate.label', default: 'Save Date')}" />
					
						<g:sortableColumn property="state" title="${message(code: 'infoFile.state.label', default: 'State')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${infoFileInstanceList}" status="i" var="infoFileInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${infoFileInstance.id}">${fieldValue(bean: infoFileInstance, field: "name")}</g:link></td>
					
						<td>${fieldValue(bean: infoFileInstance, field: "path")}</td>
					
						<td>${fieldValue(bean: infoFileInstance, field: "infoData")}</td>
					
						<td><g:formatDate date="${infoFileInstance.saveDate}" /></td>
					
						<td>${fieldValue(bean: infoFileInstance, field: "state")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${infoFileInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
