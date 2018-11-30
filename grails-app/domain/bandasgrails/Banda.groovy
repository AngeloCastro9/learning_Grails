package bandasgrails


import groovy.BandaEnum

class Banda {
    String nome
    BandaEnum bandaEnum


    static hasMany = [show:Shows]
    static belongsTo =  Shows

    static constraints = {
        bandaEnum blank : false
    }

    String toString() {
        return "${nome}"
    }
}
