<%@ page import="com.ocse.doc.domain.ShareFile" %>



<div class="fieldcontain ${hasErrors(bean: shareFileInstance, field: 'logDate', 'error')} required">
	<label for="logDate">
		<g:message code="shareFile.logDate.label" default="Log Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="logDate" precision="day"  value="${shareFileInstance?.logDate}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: shareFileInstance, field: 'path', 'error')} ">
	<label for="path">
		<g:message code="shareFile.path.label" default="Path" />
		
	</label>
	<g:textField name="path" value="${shareFileInstance?.path}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: shareFileInstance, field: 'title', 'error')} ">
	<label for="title">
		<g:message code="shareFile.title.label" default="Title" />
		
	</label>
	<g:textField name="title" value="${shareFileInstance?.title}"/>
</div>

