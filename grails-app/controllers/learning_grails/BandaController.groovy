package learning_grails

import bandasgrails.Banda
import groovy.BandaEnum

class BandaController extends CrudController{
    static entity = Banda
    def query = {
        if( params.nome )
        {
            ilike( 'nome', "%" + params.nome + "%")
        }}
}
