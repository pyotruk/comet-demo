<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main" />
    <style type="text/css">
        #widget {
            overflow: hidden;
        }
        #run-button {
            height: 40px;
            width: 100px;
        }
        #run-button > input {
            height: 100%;
        }
    </style>
</head>

<r:require modules="grailsEvents, jquery-ui"/>
<r:script disposition="defer">
    jQuery(document).ready(function ($) {

        var widget = {

            /**
             * Returns interface for progressbar
             */
            progressbarSet : function(containers) {
                return {
                    set : function(data) {
                        this.containers.filter('#1').progressbar('value', data[0].progress)
                        this.containers.filter('#2').progressbar('value', data[1].progress)
                        this.containers.filter('#3').progressbar('value', data[2].progress)
                    },
                    init : function(containers) {
                        this.containers = containers
                        this.containers.progressbar()
                        return this
                    }
                }.init(containers)
            },

            bindEvents : function() {
                this.runButton.click(function(){
                    var data = {}

                    $.ajax({
                        type: 'POST',
                        url: '${createLink(action: 'run')}',
                        data: data
                    }).done(function(){  })
                      .fail(function(){ alert('Error') })

                    return false
                })
            },

            init : function(container) {
                this.container = container
                this.runButton = container.find('#run-button')
                this.progressbarSet = this.progressbarSet(container.find(".progressbar"))

                this.bindEvents()
                return this
            }
        }.init($('#widget'))

        var grailsEvents = new grails.Events("${createLink(uri: '')}", {transport:'sse'})

        grailsEvents.on('progress', function(data) {
            widget.progressbarSet.set(data)
        })

    })
</r:script>

<body>

<div id="widget">
    <div id="run-button"><input type="button" value="Run"/></div>
    <div class="progressbar" id="1"></div>
    <div class="progressbar" id="2"></div>
    <div class="progressbar" id="3"></div>
</div>

</body>
</html>