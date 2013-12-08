<%@ page import="com.ocse.doc.domain.Recipient" %>



<div class="fieldcontain ${hasErrors(bean: recipientInstance, field: 'infoData', 'error')} required">
	<label for="infoData">
		<g:message code="recipient.infoData.label" default="Info Data" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="infoData" name="infoData.id" from="${com.ocse.doc.domain.InfoData.list()}" optionKey="id" required="" value="${recipientInstance?.infoData?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: recipientInstance, field: 'user', 'error')} required">
	<label for="user">
		<g:message code="recipient.user.label" default="User" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="user" name="user.id" from="${com.ocse.doc.domain.AdminUser.list()}" optionKey="id" required="" value="${recipientInstance?.user?.id}" class="many-to-one"/>
</div>

