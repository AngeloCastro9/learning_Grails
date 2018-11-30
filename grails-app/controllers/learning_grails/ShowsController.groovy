package learning_grails

import bandasgrails.Shows

class ShowsController extends CrudController{

    static entity = Shows
    def query = {
        if( params.data )
        {
            ilike( 'data', "%" + params.data + "%")
        }}
}
