<%--
  Created by IntelliJ IDEA.
  User: Giacomo
  Date: 5/7/2021
  Time: 12:03 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!doctype html>
<html lang="it">
<head>
    <jsp:include page="../header.jsp"/>
    <title>Inserisci nuovo</title>

    <!-- style per le pagine diverse dalla index -->
    <link href="${pageContext.request.contextPath }/assets/css/global.css" rel="stylesheet">
    <style>
        .error_field {
            color: red;
        }
    </style>
</head>
<body>
<jsp:include page="../navbar.jsp"/>

<main role="main" class="container">

    <%-- se l'attributo in request ha errori --%>
    <spring:hasBindErrors name="edit_regista_attribute">
        <%-- alert errori --%>
        <div class="alert alert-danger " role="alert">
            Attenzione!! Sono presenti errori di validazione
        </div>
    </spring:hasBindErrors>

    <div class="alert alert-danger alert-dismissible fade show ${errorMessage==null?'d-none': ''}" role="alert">
        ${errorMessage}
        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
            <span aria-hidden="true">&times;</span>
        </button>
    </div>

    <div class='card'>
        <div class='card-header'>
            <h5>Modifica elemento</h5>
        </div>
        <div class='card-body'>

            <h6 class="card-title">I campi con <span class="text-danger">*</span> sono obbligatori</h6>

            <form:form modelAttribute="edit_regista_attribute" method="post" action="update"
                       novalidate="novalidate">

                <div class="form-row">
                    <div class="form-group col-md-6">
                        <label>Nome <span class="text-danger">*</span></label>
                        <spring:bind path="nome">
                            <input type="text" name="nome" id="nome"
                                   class="form-control ${status.error ? 'is-invalid' : ''}"
                                   placeholder="Inserire il nome" value="${edit_regista_attribute.nome }" required>
                            <spring:bind path="id">
                                <input type="hidden" name="id" id="id"
                                       class="form-control ${status.error ? 'is-invalid' : ''}"
                                       value="${edit_regista_attribute.id }" required>
                            </spring:bind>
                        </spring:bind>
                        <form:errors path="nome" cssClass="error_field"/>
                    </div>

                    <div class="form-group col-md-6">
                        <label>Cognome <span class="text-danger">*</span></label>
                        <spring:bind path="cognome">
                            <input type="text" name="cognome" id="cognome"
                                   class="form-control ${status.error ? 'is-invalid' : ''}"
                                   placeholder="Inserire il cognome" value="${edit_regista_attribute.cognome }"
                                   required>
                        </spring:bind>
                        <form:errors path="cognome" cssClass="error_field"/>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group col-md-6">
                        <label>Nickname <span class="text-danger">*</span></label>
                        <spring:bind path="nickName">
                            <input type="text" class="form-control ${status.error ? 'is-invalid' : ''}" name="nickName"
                                   id="nickName" placeholder="Inserire il nickname"
                                   value="${edit_regista_attribute.nickName }" required>
                        </spring:bind>
                        <form:errors path="nickName" cssClass="error_field"/>
                    </div>

                    <fmt:formatDate pattern='yyyy-MM-dd' var="parsedDate" type='date'
                                    value='${edit_regista_attribute.dataDiNascita}'/>
                    <div class="form-group col-md-3">
                        <label>Data di Nascita <span class="text-danger">*</span></label>
                        <spring:bind path="dataDiNascita">
                            <input class="form-control ${status.error ? 'is-invalid' : ''}" id="dataDiNascita"
                                   type="date" placeholder="dd/MM/yy"
                                   title="formato : gg/mm/aaaa" name="dataDiNascita" required
                                   value="${parsedDate}">
                        </spring:bind>
                        <form:errors path="dataDiNascita" cssClass="error_field"/>
                    </div>

                    <div class="form-group col-md-3">
                        <label for="sesso">Sesso <span class="text-danger">*</span></label>
                        <spring:bind path="sesso">
                            <select class="form-control ${status.error ? 'is-invalid' : ''}" id="sesso" name="sesso"
                                    required>
                                <option value="" selected> - Selezionare -</option>
                                <option value="MASCHIO" ${edit_regista_attribute.sesso == 'MASCHIO'?'selected':''} >M
                                </option>
                                <option value="FEMMINA" ${edit_regista_attribute.sesso == 'FEMMINA'?'selected':''} >F
                                </option>
                            </select>
                        </spring:bind>
                        <form:errors path="sesso" cssClass="error_field"/>
                    </div>

                </div>

                <button type="submit" name="submit" value="submit" id="submit" class="btn btn-primary">Conferma</button>

            </form:form>

            <!-- end card-body -->
        </div>
    </div>

    <!-- end container -->
</main>
<jsp:include page="../footer.jsp"/>

</body>
</html>
