
<%@ page import="com.ocse.doc.domain.InfoLog" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'infoLog.label', default: 'InfoLog')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-infoLog" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-infoLog" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="ip" title="${message(code: 'infoLog.ip.label', default: 'Ip')}" />
					
						<g:sortableColumn property="type" title="${message(code: 'infoLog.type.label', default: 'Type')}" />
					
						<th><g:message code="infoLog.infoData.label" default="Info Data" /></th>
					
						<g:sortableColumn property="infoDate" title="${message(code: 'infoLog.infoDate.label', default: 'Info Date')}" />
					
						<th><g:message code="infoLog.user.label" default="User" /></th>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${infoLogInstanceList}" status="i" var="infoLogInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${infoLogInstance.id}">${fieldValue(bean: infoLogInstance, field: "ip")}</g:link></td>
					
						<td>${fieldValue(bean: infoLogInstance, field: "type")}</td>
					
						<td>${fieldValue(bean: infoLogInstance, field: "infoData")}</td>
					
						<td><g:formatDate date="${infoLogInstance.infoDate}" /></td>
					
						<td>${fieldValue(bean: infoLogInstance, field: "user")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${infoLogInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
