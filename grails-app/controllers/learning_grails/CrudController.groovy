package learning_grails

import grails.web.servlet.mvc.GrailsParameterMap
class CrudController {
    def beforeInterceptor = {}

    def index() {
        flash.clear()
        def model = list()
        model
    }

    def beforeList(){}

    def list = {
        beforeList()

        if( params.manterFlash == null || params.manterFlash == false || params.manterFlash.equals("false") ){
            flash.clear()
        }

        if(params.offset==null || params.offset=="null"){
            params.offset = 0;
        }

        def criteria = entity.createCriteria()
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        def entities = criteria.list(query, max: params.max, offset: params.offset)
        def filters = params

        def model = [entityInstanceList: entities, entityInstanceTotal: entities.totalCount, filters: filters]

        model = editaModelDoList( model )

        params.put( 'manterFlash', false )

        returnList(model)
    }

    def editaModelDoList( def model )
    {
        return model
    }

    def returnList(LinkedHashMap<String, GrailsParameterMap> model) {
        if (request.xhr && !params.dontSearch) {
            render(template: "grid", layout: "ajax", model: model)
        } else if (params.dontSearch.equals("true")) {
            render(template: "form", layout: "ajax", model: model)
        } else {
            model
        }
    }

    def novo() {
        flash.clear()
        def filters = params
        def offset = params.offset
        def model = [entityInstance: entity.newInstance(params)]

        model = editaModelDoNovo( model )

        render( template: "form", layout: "ajax" , model: model, filters: filters, offset: offset )
    }

    def editaModelDoNovo( def model )
    {
        return model
    }

    def beforeSave(entityInstance,model){}

    def setCollettions(entityInstance){}

    def getInstanceEntity()
    {
        def entityInstance
        if( params.id )
        {
            entityInstance = entity.get(params.id)
            entityInstance.properties = params
        }
        else
        {
            entityInstance = entity.newInstance( params )
        }

        setCollettions( entityInstance )

        entityInstance
    }

    //TODO tratar a StaleObjectStateException, baixa prioridade pra o projeto FIBER, mas alta para próximos projetos
    def save() {
        flash.clear()
        def model = [:]
        def entityInstance
        boolean edit = params.id ? true:false
        boolean editPai = params.editPai ? true:false
        entityInstance = getInstanceEntity()

        if( edit && entityInstance.hasProperty( 'isEditavel' ) && entityInstance.isEditavel == false )
        {
            flash.error = message( code: 'default.dont.edit.message' )
        }
        else
        {
            beforeSave( entityInstance, model )
            if( entityInstance.errors.getErrorCount() < 1 && entityInstance.validate() )
            {
                if (entityInstance.save(flush: true)) {
                    afterSave(entityInstance,model);
                    if(edit){
                        flash.message = message(code: 'default.updated.message')
                    }else{
                        flash.message = message(code: 'default.created.message')
                    }
                }else{
                    if(edit){
                        flash.error = message(code: 'default.dont.updated.message')
                    }else{
                        flash.error = message(code: 'default.dont.created.message')
                    }
                }
            }
            else{
                afterInvalido( entityInstance, model )
            }
        }

        println entityInstance.errors

        model = editaModelDoSave( model )

        returnSave( edit, editPai, entityInstance, model)
    }

    def returnSave(boolean edit, boolean editPai,def entityInstance, LinkedHashMap model) {
        if (!((edit || editPai) || !entityInstance.validate())) {
            entityInstance = entity.newInstance()
        }
        model.put('entityInstance', entityInstance)
        def offset = params.offset
        if (params.dontSearch) {
            model.put('entityInstanceList', entity.list())
        }
        render(template: "form", layout: "ajax", model: model, offset: offset)
    }

    def afterInvalido( entityInstance, model ){}

    def afterSave(entityInstance,model){}

    def edit() {
        flash.clear()
        def entityInstance = entity.get(params.id)
        def offset = params.offset
        def model = [entityInstance: entityInstance, offset: offset]

        model = editaModelDoEdit( model )

        render(template: "form", layout: "ajax", model: model )
    }

    def editaModelDoEdit( def model )
    {
        return model
    }

    def editaModelDoSave( def model )
    {
        return model
    }

    //TODO tratar a StaleObjectStateException, baixa prioridade pra o projeto FIBER, mas alta para próximos projetos
    def delete() {
        flash.clear()
        def entityInstance = entity.get(params.id)
        if( entityInstance )
        {
            if( entityInstance.hasProperty( "isRemovivel" ) && entityInstance.isRemovivel == false )
            {
                flash.error = message( code: 'default.dont.delete.message' )
            }
            else
            {
                try
                {
                    entity.withTransaction {
                        entityInstance.delete(flush: true)
                        flash.message = message(code: 'default.deleted.message', args: [message(code: '${entity.getSimpleName()}.label', default: entity.getSimpleName()), params.id])
                    }
                }
                catch( org.springframework.dao.DataIntegrityViolationException e )
                {
                    entityInstance = entity.get( params.id )

                    if( entityInstance.hasProperty( "ativo" ) )
                    {
                        entityInstance.ativo = false
                        entityInstance.save( flush: true, failOnError: true )
                    }
                    flash.warning = message( code: 'default.desativadoNaoRemovivel.message' )
                }
            }
        }
        else {
            flash.message = message(code: 'default.not.found.message', args: [message(code: '${entity.getSimpleName()}.label', default: entity.getSimpleName()), params.id])
        }

        params.put( 'manterFlash', true )
        list()
    }

    List parseLista( listaGenerica )
    {
        if( listaGenerica instanceof String  )
        {
            List lista = new ArrayList()
            lista.add( listaGenerica )

            return lista
        }
        else
        {
            return listaGenerica
        }
    }

    def ativarDesativar()
    {
        if( params.manterFlash == null || params.manterFlash == false )
        {
            flash.clear()
        }

        def entityInstance = entity.get( params.id )

        if( entityInstance )
        {
            entityInstance.ativo = !entityInstance.ativo

            if( !entityInstance.save( failOnError: true, flush: true ) )
            {
                flash.error = message(code: 'default.dont.updated.message')
                params.put( 'manterFlash', true )
            }
        }
        else
        {
            flash.message = message( code: 'default.not.found.message', args: [getNomeEntidadeParaUsuario(), params.id] )
            params.put( 'manterFlash', true )
        }

        list()
    }

    String getNomeEntidadeParaUsuario()
    {
        return message( code: '${entity.getSimpleName()}.label', default: entity.getSimpleName() )
    }
}
