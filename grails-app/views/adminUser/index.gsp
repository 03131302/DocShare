
<%@ page import="com.ocse.doc.domain.AdminUser" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'adminUser.label', default: 'AdminUser')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-adminUser" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-adminUser" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="userName" title="${message(code: 'adminUser.userName.label', default: 'User Name')}" />
					
						<g:sortableColumn property="userCode" title="${message(code: 'adminUser.userCode.label', default: 'User Code')}" />
					
						<g:sortableColumn property="passWord" title="${message(code: 'adminUser.passWord.label', default: 'Pass Word')}" />
					
						<g:sortableColumn property="text" title="${message(code: 'adminUser.text.label', default: 'Text')}" />
					
						<g:sortableColumn property="isStop" title="${message(code: 'adminUser.isStop.label', default: 'Is Stop')}" />
					
						<th><g:message code="adminUser.org.label" default="Org" /></th>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${adminUserInstanceList}" status="i" var="adminUserInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${adminUserInstance.id}">${fieldValue(bean: adminUserInstance, field: "userName")}</g:link></td>
					
						<td>${fieldValue(bean: adminUserInstance, field: "userCode")}</td>
					
						<td>${fieldValue(bean: adminUserInstance, field: "passWord")}</td>
					
						<td>${fieldValue(bean: adminUserInstance, field: "text")}</td>
					
						<td><g:formatBoolean boolean="${adminUserInstance.isStop}" /></td>
					
						<td>${fieldValue(bean: adminUserInstance, field: "org")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${adminUserInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
