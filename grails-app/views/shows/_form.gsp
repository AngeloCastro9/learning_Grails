<div  class="container">
</div>

<g:formRemote name="formNovo" url="[controller: 'show', action: 'save']" role="form" update="conteudo">
    <g:hiddenField name="id" value="${entityInstance?.id}"/>
    <div  class="container">
        <div class="row ajLine">
            <div class="col-md-12 col-lg-12 nopad">
                <g:remoteLink class="btn btn-default" controller="show" action="novo" update="conteudo">
                    <i class="fa fa-file"></i> <g:message code="default.button.create.label"/>
                </g:remoteLink>

                <button type="submit" class="btn btn-danger"><i class="fa fa-check"></i>
                    <g:message code="default.button.save.label"/>
                </button>
                <a href="${createLink(controller: 'show', action: 'index')}" type="button" class="btn btn-default">
                    <i class="fa fa-arrow-left"></i>
                    <g:message code="default.button.label.voltar"/>
                </a>
            </div>
        </div>
    </div>
    <div class="container">
        <div class="row ajLine">
            <div class="col-md-4 nopad">
                <div class="form-group ${entityInstance?.errors?.hasFieldErrors('data')? 'has-error' : ''}">
                    <label for="data"><g:message code="show.data.label"/><span class="labelRequired"/>*
                    </label>

                    <input type="text" id="data" name="data" class="form-control required ${entityInstance?.errors?.hasFieldErrors('data')? 'errorhover' : ''}" value="${entityInstance?.data}"/>
                    <g:message code="show.data.label"/>
                    <input type="text" id="data" name="data" class="form-control required ${entityInstance?.errors?.hasFieldErrors('data')? 'errorhover' : ''}" value="${entityInstance?.data}"/>
                    <span class="help-block">

                        <g:hasErrors bean="${entityInstance}" field="data">
                            <g:renderErrors bean="${entityInstance}" field="data" as="list" />
                        </g:hasErrors>
                    </span>
                    <i class="fa fa-exclamation-circle error-icon"></i>

                </div>
            </div>
        </div>
    </div>
</g:formRemote>