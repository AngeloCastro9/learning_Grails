<%@ page import="groovy.BandaEnum" %>

<g:hiddenField name="msgDeletar" value="deletar" />
<g:hiddenField name="msgDesativar" value="desativar" />

<div class="container">
    <div class="row ajLine">
        <table class="table table-striped">
            <thead>
            <tr class="headerTable">
                %{--<util:remoteSortableColumn class="labelCabecalhoDefault" update="conteudo" action="list" property="descricao" title="${message( code: 'tipoProdutoEstoque.descricao.label' )}" params="${filters}" />--}%
                <th>Nome da banda</th>
                <th>Genero da banda</th>
            </tr>
            </thead>
            <tbody class="bordaCorpoTabela">
            <g:each in="${entityInstanceList}" var="entityInstance" status="i">
                <tr>
                    <td>
                        ${entityInstance.nome}

                    </td>
                    <td>${entityInstance.bandaEnum.value}</td>

                    <td class="text-center">

                        <g:remoteLink id="${entityInstance?.id}" class="btn btn-primary ${entityInstance?.nome ? '' : 'disabled'}" controller="tipoProdutoEstoque" action="edit" update="conteudo" title="Editar" data-placement="top" data-toggle="tooltip">
                            <i class="fa fa-edit"></i>
                        </g:remoteLink>
                        <g:if test="${entityInstance}">
                            <button type="button" class="btn btn-danger" onclick="deletar('${createLink(action: 'delete')}/${entityInstance.id}')" title="${message(code: 'default.button.delete.label')}" data-placement="top" data-toggle="tooltip">
                                <i class="fa fa-trash"></i>
                            </button>
                        </g:if>
                        <g:else>
                            <g:remoteLink id="${entityInstance?.id}" class="btn btn-success" controller="tipoProdutoEstoque" action="ativarDesativar" update="conteudo">
                                <i class="fa fa-check"></i>
                            </g:remoteLink>
                        </g:else>
                    </td>
                </tr>

            </g:each>
            </tbody>
        </table>
        <div style="text-align: center;">
            <util:remotePaginate action="list" total="${entityInstanceTotal == null ? 0:entityInstanceTotal}" params="${filters}" update="conteudo"/>
        </div>
    </div>
</div>