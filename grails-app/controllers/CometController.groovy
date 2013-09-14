

import grails.converters.JSON

class CometController {

    def cometService

    def index = {
        return [:]
    }

    def run = {
        cometService.run()
        render([status: 200] as JSON)
    }
}
