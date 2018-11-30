<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>

    </title>
    <meta name="layout" content="main"/>
</head>
<body>
    <div id="conteudo">
    <g:render template="grid"/>
    <g:remoteLink controller="local" action="novo" update="conteudo" role="form">Adicionar Local</g:remoteLink>
</div>
</body>
</html>