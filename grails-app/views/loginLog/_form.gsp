<%@ page import="com.ocse.doc.domain.LoginLog" %>



<div class="fieldcontain ${hasErrors(bean: loginLogInstance, field: 'loginDate', 'error')} required">
	<label for="loginDate">
		<g:message code="loginLog.loginDate.label" default="Login Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="loginDate" precision="day"  value="${loginLogInstance?.loginDate}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: loginLogInstance, field: 'ip', 'error')} ">
	<label for="ip">
		<g:message code="loginLog.ip.label" default="Ip" />
		
	</label>
	<g:textField name="ip" value="${loginLogInstance?.ip}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: loginLogInstance, field: 'user', 'error')} required">
	<label for="user">
		<g:message code="loginLog.user.label" default="User" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="user" name="user.id" from="${com.ocse.doc.domain.AdminUser.list()}" optionKey="id" required="" value="${loginLogInstance?.user?.id}" class="many-to-one"/>
</div>

