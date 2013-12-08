<%@ page import="com.ocse.doc.domain.InfoType" %>



<div class="fieldcontain ${hasErrors(bean: infoTypeInstance, field: 'name', 'error')} ">
	<label for="name">
		<g:message code="infoType.name.label" default="Name" />
		
	</label>
	<g:textField name="name" value="${infoTypeInstance?.name}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: infoTypeInstance, field: 'parentInfoType', 'error')} required">
	<label for="parentInfoType">
		<g:message code="infoType.parentInfoType.label" default="Parent Info Type" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="parentInfoType" name="parentInfoType.id" from="${com.ocse.doc.domain.InfoType.list()}" optionKey="id" required="" value="${infoTypeInstance?.parentInfoType?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: infoTypeInstance, field: 'pxh', 'error')} required">
	<label for="pxh">
		<g:message code="infoType.pxh.label" default="Pxh" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="pxh" type="number" value="${infoTypeInstance.pxh}" required=""/>
</div>

