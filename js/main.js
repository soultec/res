require.config({
    baseUrl: 'assets/js/',
    paths: {
        jquery: 'lib/jquery-3.1.1.min',
        jqwait: 'lib/jquery.wait'
    },
    shim: {
        'jqwait': {
            deps: ['jquery']
        }
    }
});

require(["jquery"], function() {
    $(document).ready(function() {

    });
});