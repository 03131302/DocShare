<%@ page import="com.ocse.doc.domain.InfoData" %>



<div class="fieldcontain ${hasErrors(bean: infoDataInstance, field: 'text', 'error')} ">
	<label for="text">
		<g:message code="infoData.text.label" default="Text" />
		
	</label>
	<g:textField name="text" value="${infoDataInstance?.text}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: infoDataInstance, field: 'saveDate', 'error')} required">
	<label for="saveDate">
		<g:message code="infoData.saveDate.label" default="Save Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="saveDate" precision="day"  value="${infoDataInstance?.saveDate}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: infoDataInstance, field: 'saveState', 'error')} ">
	<label for="saveState">
		<g:message code="infoData.saveState.label" default="Save State" />
		
	</label>
	<g:textField name="saveState" value="${infoDataInstance?.saveState}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: infoDataInstance, field: 'shareScope', 'error')} ">
	<label for="shareScope">
		<g:message code="infoData.shareScope.label" default="Share Scope" />
		
	</label>
	<g:textField name="shareScope" value="${infoDataInstance?.shareScope}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: infoDataInstance, field: 'shareType', 'error')} ">
	<label for="shareType">
		<g:message code="infoData.shareType.label" default="Share Type" />
		
	</label>
	<g:textField name="shareType" value="${infoDataInstance?.shareType}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: infoDataInstance, field: 'title', 'error')} ">
	<label for="title">
		<g:message code="infoData.title.label" default="Title" />
		
	</label>
	<g:textField name="title" value="${infoDataInstance?.title}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: infoDataInstance, field: 'type', 'error')} required">
	<label for="type">
		<g:message code="infoData.type.label" default="Type" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="type" name="type.id" from="${com.ocse.doc.domain.InfoType.list()}" optionKey="id" required="" value="${infoDataInstance?.type?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: infoDataInstance, field: 'user', 'error')} required">
	<label for="user">
		<g:message code="infoData.user.label" default="User" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="user" name="user.id" from="${com.ocse.doc.domain.AdminUser.list()}" optionKey="id" required="" value="${infoDataInstance?.user?.id}" class="many-to-one"/>
</div>

