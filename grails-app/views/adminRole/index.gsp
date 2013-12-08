
<%@ page import="com.ocse.doc.domain.AdminRole" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'adminRole.label', default: 'AdminRole')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-adminRole" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-adminRole" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="name" title="${message(code: 'adminRole.name.label', default: 'Name')}" />
					
						<g:sortableColumn property="text" title="${message(code: 'adminRole.text.label', default: 'Text')}" />
					
						<g:sortableColumn property="level" title="${message(code: 'adminRole.level.label', default: 'Level')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${adminRoleInstanceList}" status="i" var="adminRoleInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${adminRoleInstance.id}">${fieldValue(bean: adminRoleInstance, field: "name")}</g:link></td>
					
						<td>${fieldValue(bean: adminRoleInstance, field: "text")}</td>
					
						<td>${fieldValue(bean: adminRoleInstance, field: "level")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${adminRoleInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
