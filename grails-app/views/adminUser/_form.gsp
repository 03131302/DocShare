<%@ page import="com.ocse.doc.domain.AdminUser" %>



<div class="fieldcontain ${hasErrors(bean: adminUserInstance, field: 'userName', 'error')} ">
	<label for="userName">
		<g:message code="adminUser.userName.label" default="User Name" />
		
	</label>
	<g:textField name="userName" value="${adminUserInstance?.userName}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: adminUserInstance, field: 'userCode', 'error')} ">
	<label for="userCode">
		<g:message code="adminUser.userCode.label" default="User Code" />
		
	</label>
	<g:textField name="userCode" value="${adminUserInstance?.userCode}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: adminUserInstance, field: 'passWord', 'error')} ">
	<label for="passWord">
		<g:message code="adminUser.passWord.label" default="Pass Word" />
		
	</label>
	<g:textField name="passWord" value="${adminUserInstance?.passWord}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: adminUserInstance, field: 'text', 'error')} ">
	<label for="text">
		<g:message code="adminUser.text.label" default="Text" />
		
	</label>
	<g:textField name="text" value="${adminUserInstance?.text}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: adminUserInstance, field: 'isStop', 'error')} ">
	<label for="isStop">
		<g:message code="adminUser.isStop.label" default="Is Stop" />
		
	</label>
	<g:checkBox name="isStop" value="${adminUserInstance?.isStop}" />
</div>

<div class="fieldcontain ${hasErrors(bean: adminUserInstance, field: 'org', 'error')} required">
	<label for="org">
		<g:message code="adminUser.org.label" default="Org" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="org" name="org.id" from="${com.ocse.doc.domain.Organization.list()}" optionKey="id" required="" value="${adminUserInstance?.org?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: adminUserInstance, field: 'pxh', 'error')} required">
	<label for="pxh">
		<g:message code="adminUser.pxh.label" default="Pxh" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="pxh" type="number" value="${adminUserInstance.pxh}" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: adminUserInstance, field: 'roles', 'error')} ">
	<label for="roles">
		<g:message code="adminUser.roles.label" default="Roles" />
		
	</label>
	<g:select name="roles" from="${com.ocse.doc.domain.AdminRole.list()}" multiple="multiple" optionKey="id" size="5" value="${adminUserInstance?.roles*.id}" class="many-to-many"/>
</div>

