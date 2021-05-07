<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!doctype html>
<html lang="it">
<head>
    <jsp:include page="../header.jsp" />
    <title>Visualizza elemento</title>

    <!-- style per le pagine diverse dalla index -->
    <link href="${pageContext.request.contextPath }/assets/css/global.css" rel="stylesheet">

</head>
<body>
<jsp:include page="../navbar.jsp" />

<main role="main" class="container">

    <div class='card'>
        <div class='card-header'>
            Visualizza dettaglio
        </div>

        <div class='card-body'>

            <dl class="row">
                <dt class="col-sm-3 text-right">Titolo:</dt>
                <dd class="col-sm-9">${delete_film_attr.titolo}</dd>
            </dl>

            <dl class="row">
                <dt class="col-sm-3 text-right">Genere:</dt>
                <dd class="col-sm-9">${delete_film_attr.genere}</dd>
            </dl>

            <dl class="row">
                <dt class="col-sm-3 text-right">Data Pubblicazione:</dt>
                <dd class="col-sm-9"><fmt:formatDate type = "date" value = "${delete_film_attr.dataPubblicazione}" /></dd>
            </dl>

            <dl class="row">
                <dt class="col-sm-3 text-right">Durata (min.):</dt>
                <dd class="col-sm-9">${delete_film_attr.minutiDurata}</dd>
            </dl>

            <!-- info Regista -->
            <p>
                <a class="btn btn-primary btn-sm" data-toggle="collapse" href="#collapseExample" role="button" aria-expanded="false" aria-controls="collapseExample">
                    Info Regista
                </a>
            </p>
            <div class="collapse" id="collapseExample">
                <div class="card card-body">
                    <dl class="row">
                        <dt class="col-sm-3 text-right">Nome:</dt>
                        <dd class="col-sm-9">${delete_film_attr.regista.nome}</dd>
                    </dl>
                    <dl class="row">
                        <dt class="col-sm-3 text-right">Cognome:</dt>
                        <dd class="col-sm-9">${delete_film_attr.regista.cognome}</dd>
                    </dl>
                    <dl class="row">
                        <dt class="col-sm-3 text-right">Nickname:</dt>
                        <dd class="col-sm-9">${delete_film_attr.regista.nickName}</dd>
                    </dl>
                    <dl class="row">
                        <dt class="col-sm-3 text-right">Sesso:</dt>
                        <dd class="col-sm-9">${delete_film_attr.regista.sesso}</dd>
                    </dl>

                </div>
            </div>
            <!-- end info Regista -->
            <form:form modelAttribute="delete_film_attr" method="post" action="execute"   >
                <spring:bind path="id">
                    <input type="hidden" name="id" id="id" class="form-control ${status.error ? 'is-invalid' : ''}" value="${delete_film_attr.id }" required>
                </spring:bind>
                <button type="submit" name="submit" value="submit" id="submit" class="btn btn-primary">Elimina</button>
            </form:form>
        </div>

        <div class='card-footer'>
            <a href="${pageContext.request.contextPath }/film/" class='btn btn-outline-secondary' style='width:80px'>
                <i class='fa fa-chevron-left'></i> Back
            </a>

         </div>
    </div>



    <!-- end main container -->
</main>
<jsp:include page="../footer.jsp" />

</body>
</html>