<%@ page import="com.ocse.doc.domain.UserWorkLog" %>



<div class="fieldcontain ${hasErrors(bean: userWorkLogInstance, field: 'content', 'error')} ">
	<label for="content">
		<g:message code="userWorkLog.content.label" default="Content" />
		
	</label>
	<g:textField name="content" value="${userWorkLogInstance?.content}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: userWorkLogInstance, field: 'logDate', 'error')} required">
	<label for="logDate">
		<g:message code="userWorkLog.logDate.label" default="Log Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="logDate" precision="day"  value="${userWorkLogInstance?.logDate}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: userWorkLogInstance, field: 'title', 'error')} ">
	<label for="title">
		<g:message code="userWorkLog.title.label" default="Title" />
		
	</label>
	<g:textField name="title" value="${userWorkLogInstance?.title}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: userWorkLogInstance, field: 'user', 'error')} required">
	<label for="user">
		<g:message code="userWorkLog.user.label" default="User" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="user" name="user.id" from="${com.ocse.doc.domain.AdminUser.list()}" optionKey="id" required="" value="${userWorkLogInstance?.user?.id}" class="many-to-one"/>
</div>

