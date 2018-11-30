<div  class="container">
</div>

<g:formRemote name="formNovo" url="[controller: 'local', action: 'save']" role="form" update="conteudo">
    <g:hiddenField name="id" value="${entityInstance?.id}"/>
    <div  class="container">
        <div class="row ajLine">
            <div class="col-md-12 col-lg-12 nopad">
                <g:remoteLink class="btn btn-default" controller="local" action="novo" update="conteudo">
                    <i class="fa fa-file"></i> <g:message code="default.button.create.label"/>
                </g:remoteLink>

                <button type="submit" class="btn btn-danger"><i class="fa fa-check"></i>
                    <g:message code="default.button.save.label"/>
                </button>
                <a href="${createLink(controller: 'local', action: 'index')}" type="button" class="btn btn-default">
                    <i class="fa fa-arrow-left"></i>
                    <g:message code="default.button.label.voltar"/>
                </a>
            </div>
        </div>
    </div>
    <div class="container">
        <div class="row ajLine">
            <div class="col-md-4 nopad">
                <div class="form-group ${entityInstance?.errors?.hasFieldErrors('nome')? 'has-error' : ''}">
                    <label for="nome"><g:message code="local.nome.label"/><span class="labelRequired"/>*
                    </label>

                    <input type="text" id="nome" name="nome" class="form-control required ${entityInstance?.errors?.hasFieldErrors('nome')? 'errorhover' : ''}" value="${entityInstance?.nome}"/>
                    <g:message code="local.capacidade.label"/>
                    <input type="text" id="capacidade" name="capacidade" class="form-control required ${entityInstance?.errors?.hasFieldErrors('capacidade')? 'errorhover' : ''}" value="${entityInstance?.capacidade}"/>
                    <span class="help-block">

                        <g:hasErrors bean="${entityInstance}" field="nome">
                            <g:renderErrors bean="${entityInstance}" field="nome" as="list" />
                        </g:hasErrors>
                    </span>
                    <i class="fa fa-exclamation-circle error-icon"></i>

                </div>
            </div>
        </div>
    </div>
</g:formRemote>