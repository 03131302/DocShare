<%@ page import="com.ocse.doc.domain.InfoFile" %>



<div class="fieldcontain ${hasErrors(bean: infoFileInstance, field: 'name', 'error')} ">
	<label for="name">
		<g:message code="infoFile.name.label" default="Name" />
		
	</label>
	<g:textField name="name" value="${infoFileInstance?.name}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: infoFileInstance, field: 'path', 'error')} ">
	<label for="path">
		<g:message code="infoFile.path.label" default="Path" />
		
	</label>
	<g:textField name="path" value="${infoFileInstance?.path}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: infoFileInstance, field: 'infoData', 'error')} required">
	<label for="infoData">
		<g:message code="infoFile.infoData.label" default="Info Data" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="infoData" name="infoData.id" from="${com.ocse.doc.domain.InfoData.list()}" optionKey="id" required="" value="${infoFileInstance?.infoData?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: infoFileInstance, field: 'saveDate', 'error')} required">
	<label for="saveDate">
		<g:message code="infoFile.saveDate.label" default="Save Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="saveDate" precision="day"  value="${infoFileInstance?.saveDate}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: infoFileInstance, field: 'state', 'error')} required">
	<label for="state">
		<g:message code="infoFile.state.label" default="State" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="state" type="number" value="${infoFileInstance.state}" required=""/>
</div>

