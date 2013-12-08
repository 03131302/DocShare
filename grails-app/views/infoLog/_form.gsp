<%@ page import="com.ocse.doc.domain.InfoLog" %>



<div class="fieldcontain ${hasErrors(bean: infoLogInstance, field: 'ip', 'error')} ">
	<label for="ip">
		<g:message code="infoLog.ip.label" default="Ip" />
		
	</label>
	<g:textField name="ip" value="${infoLogInstance?.ip}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: infoLogInstance, field: 'type', 'error')} ">
	<label for="type">
		<g:message code="infoLog.type.label" default="Type" />
		
	</label>
	<g:textField name="type" value="${infoLogInstance?.type}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: infoLogInstance, field: 'infoData', 'error')} required">
	<label for="infoData">
		<g:message code="infoLog.infoData.label" default="Info Data" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="infoData" name="infoData.id" from="${com.ocse.doc.domain.InfoData.list()}" optionKey="id" required="" value="${infoLogInstance?.infoData?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: infoLogInstance, field: 'infoDate', 'error')} required">
	<label for="infoDate">
		<g:message code="infoLog.infoDate.label" default="Info Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="infoDate" precision="day"  value="${infoLogInstance?.infoDate}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: infoLogInstance, field: 'user', 'error')} required">
	<label for="user">
		<g:message code="infoLog.user.label" default="User" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="user" name="user.id" from="${com.ocse.doc.domain.AdminUser.list()}" optionKey="id" required="" value="${infoLogInstance?.user?.id}" class="many-to-one"/>
</div>

