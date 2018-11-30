package learning_grails

import bandasgrails.Local

class LocalController extends CrudController {
    static entity = Local
    def query = {
        if( params.nome )
        {
            ilike( 'nome', "%" + params.nome + "%")
        }}
}
