
<%@ page import="com.ocse.doc.domain.InfoType" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'infoType.label', default: 'InfoType')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-infoType" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-infoType" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="name" title="${message(code: 'infoType.name.label', default: 'Name')}" />
					
						<th><g:message code="infoType.parentInfoType.label" default="Parent Info Type" /></th>
					
						<g:sortableColumn property="pxh" title="${message(code: 'infoType.pxh.label', default: 'Pxh')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${infoTypeInstanceList}" status="i" var="infoTypeInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${infoTypeInstance.id}">${fieldValue(bean: infoTypeInstance, field: "name")}</g:link></td>
					
						<td>${fieldValue(bean: infoTypeInstance, field: "parentInfoType")}</td>
					
						<td>${fieldValue(bean: infoTypeInstance, field: "pxh")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${infoTypeInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
