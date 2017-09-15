<html>
    <head>
        <title>Certificate Authority Overview</title>
    </head>

    <body>
        <h1>Certificates</h1>

        <h2>{{CA_HTML_ROOT_TITLE}}</h2>

        <p>
            Root CA: <a href="{{CA_HTML_ROOT_NAME}}.crt">Show</a> (<a href="{{CA_HTML_ROOT_NAME}}.crt" download>Download</a>)<br>
            SHA1 fingerprint: {{CA_HTML_ROOT_HASH}}
        </p>

        <p>
            Revocation list: <a href="{{CA_HTML_ROOT_NAME}}.crl">Show</a> (<a href="{{CA_HTML_ROOT_NAME}}.crl" download>Download</a>)<br>
        </p>


       <h2>{{CA_HTML_SIGN_TITLE}}</h2>

       <p>
            Name   : {{CA_NAME}}   <br/>
            Domain : {{CA_DOMAIN}} <br/>
        </p>

        <p>
            Root CA: <a href="{{CA_HTML_SIGN_NAME}}.crt">Show</a> (<a href="{{CA_HTML_SIGN_NAME}}.crt" download>Download</a>)<br>
            SHA1 fingerprint: {{CA_HTML_SIGN_HASH}}
        </p>

        <p>
            Revocation list: <a href="{{CA_HTML_SIGN_NAME}}.crl">Show</a> (<a href="{{CA_HTML_SIGN_NAME}}.crl" download>Download</a>)<br>
        </p>
    </body>
</html>
