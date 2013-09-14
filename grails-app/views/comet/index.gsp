<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main" />
    <style type="text/css">
        #widget {
            overflow: hidden; /* clearfix */
        }
        #run-button {
            float: left;
            height: 37px;
            margin-right: 6px;
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
            progressbar : function(container) {
                return {
                    set : function(progress) {
                        this.container.progressbar('value', progress)
                    },
                    init : function(container) {
                        this.container = container
                        this.container.progressbar()
                        return this
                    }
                }.init(container)
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
                this.progressbar = this.progressbar(container.find('#progressbar'))

                this.bindEvents()
                return this
            }
        }.init($('#widget'))

        var grailsEvents = new grails.Events("${createLink(uri: '')}", {transport:'sse'})

        grailsEvents.on('progress', function(data) {
            widget.progressbar.set(data.progress)
        })

    })
</r:script>

<body>

<div id="widget">
    <div id="run-button"><input type="button" value="Run"/></div>
    <div id="progressbar"></div>
</div>

</body>
</html>