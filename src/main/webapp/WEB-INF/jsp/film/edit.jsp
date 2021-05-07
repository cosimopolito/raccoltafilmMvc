<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!doctype html>
<html lang="it">
<head>
    <jsp:include page="../header.jsp"/>
    <title>Ricerca</title>

    <!-- style per le pagine diverse dalla index -->
    <link href="${pageContext.request.contextPath }/assets/css/global.css" rel="stylesheet">

</head>
<body>
<jsp:include page="../navbar.jsp"/>

<main role="main" class="container">

    <div class="alert alert-warning alert-dismissible fade show " role="alert">
        Attenzione!!! Funzionalit� ancora non implementata. Sulla 'Conferma' per il momento parte il 'listAll'
        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
            <span aria-hidden="true">&times;</span>
        </button>
    </div>

    <div class="alert alert-danger alert-dismissible fade show ${errorMessage==null?'d-none': ''}" role="alert">
        ${errorMessage}
        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
            <span aria-hidden="true">&times;</span>
        </button>
    </div>

    <div class='card'>
        <div class='card-header'>
            <h5>Ricerca elementi</h5>
        </div>
        <div class='card-body'>

            <form:form method="post" modelAttribute="edit_film_attr" action="edit" novalidate="novalidate">
                <input type="hidden" name="id" id="filmId" value="${edit_film_attr.id }">

                 <div class="form-row">
                    <div class="form-group col-md-6">
                        <label for="titolo">Titolo</label>
                        <spring:bind path="titolo">
                            <input type="text" name="titolo" id="titolo"
                                   class="form-control ${status.error ? 'is-invalid' : ''}"
                                   placeholder="Inserire il titolo" value="${edit_film_attr.titolo }">
                        </spring:bind>
                        <form:errors path="titolo" cssClass="error_field"/>
                    </div>

                    <div class="form-group col-md-6">
                        <label for="genere">Genere</label>
                        <spring:bind path="genere">
                            <input type="text" name="genere" id="genere"
                                   class="form-control ${status.error ? 'is-invalid' : ''}"
                                   placeholder="Inserire il genere" value="${edit_film_attr.genere }">
                        </spring:bind>
                        <form:errors path="genere" cssClass="error_field"/>
                    </div>
                </div>

                <div class="form-row">
                    <fmt:formatDate pattern='yyyy-MM-dd' var="parsedDate" type='date'
                                    value='${edit_film_attr.dataPubblicazione}'/>
                    <div class="form-group col-md-6">
                        <label for="dataPubblicazione">Data di Pubblicazione</label>
                        <spring:bind path="dataPubblicazione">
                            <input class="form-control ${status.error ? 'is-invalid' : ''}" id="dataPubblicazione"
                                   type="date" placeholder="dd/MM/yy"
                                   title="formato : gg/mm/aaaa" name="dataPubblicazione" value="${parsedDate}">
                        </spring:bind>
                        <form:errors path="dataPubblicazione" cssClass="error_field"/>
                    </div>

                    <div class="form-group col-md-6">
                        <label for="minutiDurata">Durata (minuti)</label>
                        <spring:bind path="minutiDurata">
                            <input type="number" class="form-control ${status.error ? 'is-invalid' : ''}"
                                   name="minutiDurata" id="minutiDurata" placeholder="Inserire la durata"
                                   value="${edit_film_attr.minutiDurata }">
                        </spring:bind>
                        <form:errors path="minutiDurata" cssClass="error_field"/>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group col-md-6">
                        <label for="regista.id">Regista</label>
                        <select class="form-control" id="regista.id"
                                name="regista.id">
                            <option value=""> -- Selezionare una voce --</option>
                            <c:forEach items="${registi_list_attribute }" var="registaItem">
                                <option value="${registaItem.id}" ${edit_film_attr.regista.id == registaItem.id?'selected':''} >${registaItem.nome } ${registaItem.cognome }</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>

                <button type="submit" name="submit" value="submit" id="submit" class="btn btn-primary">Modifica</button>
                <input class="btn btn-outline-warning" type="reset" value="Ripulisci">

            </form:form>

            <!-- end card-body -->
        </div>
    </div>


    <!-- end container -->
</main>
<jsp:include page="../footer.jsp"/>

</body>
</html>
