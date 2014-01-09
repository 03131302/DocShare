<%@ page import="com.ocse.doc.domain.UserCommit" %>



<div class="fieldcontain ${hasErrors(bean: userCommitInstance, field: 'content', 'error')} ">
	<label for="content">
		<g:message code="userCommit.content.label" default="Content" />
		
	</label>
	<g:textField name="content" value="${userCommitInstance?.content}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: userCommitInstance, field: 'logDate', 'error')} required">
	<label for="logDate">
		<g:message code="userCommit.logDate.label" default="Log Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="logDate" precision="day"  value="${userCommitInstance?.logDate}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: userCommitInstance, field: 'title', 'error')} ">
	<label for="title">
		<g:message code="userCommit.title.label" default="Title" />
		
	</label>
	<g:textField name="title" value="${userCommitInstance?.title}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: userCommitInstance, field: 'user', 'error')} required">
	<label for="user">
		<g:message code="userCommit.user.label" default="User" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="user" name="user.id" from="${com.ocse.doc.domain.AdminUser.list()}" optionKey="id" required="" value="${userCommitInstance?.user?.id}" class="many-to-one"/>
</div>

