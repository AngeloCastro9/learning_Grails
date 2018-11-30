<div  class="container">
    <div class="row ajLine">
        <h1 class="Titulo">
            <g:message code="default.label.cadastroDe"/> <span class="identBloco">teste</span>
            <button type="button" class="btn btn-info pull-right" data-toggle="modal" data-target="#modalHelp">
                <i class="fa fa-question-circle"></i>
            </button>
        </h1>
    </div>
</div>

<g:formRemote name="formNovo" url="[controller: 'banda', action: 'save']" role="form" update="conteudo">
    <g:hiddenField name="id" value="${entityInstance?.id}"/>
    <div  class="container">
        <div class="row ajLine">
            <div class="col-md-12 col-lg-12 nopad">
                <g:remoteLink class="btn btn-default" controller="banda" action="novo" update="conteudo">
                    <i class="fa fa-file"></i> <g:message code="default.button.create.label"/>
                </g:remoteLink>

                <button type="submit" class="btn btn-danger"><i class="fa fa-check"></i>
                    <g:message code="default.button.save.label"/>
                </button>
                <a href="${createLink(controller: 'banda', action: 'index')}" type="button" class="btn btn-default">
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
                    <label for="nome"><g:message code="banda.nome.label"/><span class="labelRequired">*

                    </label>
                    <input type="text" id="nome" name="nome" class="form-control required ${entityInstance?.errors?.hasFieldErrors('nome')? 'errorhover' : ''}" value="${entityInstance?.nome}"/>
                    <span class="help-block">
                        <g:select name="bandaEnum" id="id" from="${groovy.BandaEnum.values()}"/>
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