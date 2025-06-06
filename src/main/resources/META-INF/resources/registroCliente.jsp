<%@ include file="./init.jsp" %>

<portlet:resourceURL id="/afiliacion/certificaciones/manageDocuments" var="manageDocumentsURL" cacheability="FULL"/>
<portlet:resourceURL id="/afiliacion/certificaciones/manageSections" var="manageSectionsURL" cacheability="FULL"/>
<portlet:resourceURL id="/afiliacion/certificaciones/creaCertificacion" var="creaCertificacionURL" cacheability="FULL"/>

<section>
    <div class="row">
        ${clientId}
    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="col-md-6">
                <div class="row">
                    Regimen Fiscal
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="form-inline" style="float: left !important;">
                            <div class="col-lg-6 col-md-6">
                                <div class="">
                                    <input class="" name="regimenFiscal" type="radio" id="regimenMoral" value="Moral">
                                    <label class="form-check-label" for="regimenMoral">
                                        Moral
                                    </label>
                                </div>
                            </div>
                            <div class="col-lg-6 col-md-6">
                                <div class="">
                                    <input class="" name="regimenFiscal" type="radio" id="regimenFisica" value="Fisico">
                                    <label class="form-check-label" for="regimenFisica">
                                        Fisica
                                    </label>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="row">
            Tipo de Pago
        </div>
        <div class="row">
            <div class="col-md-12">
                <div class="form-inline" style="float: left !important;">
                    <div class="col-lg-6 col-md-6">
                        <div class="">
                            <input class="" name="tipoPago" type="radio" id="pagoCliente" value="1">
                            <label class="form-check-label" for="pagoCliente">
                                Cliente
                            </label>
                        </div>
                    </div>
                    <div class="col-lg-6 col-md-6">
                        <div class="">
                            <input class="" name="tipoPago" type="radio" id="pagoProveedor" value="2">
                            <label class="form-check-label" for="pagoProveedor">
                                Proveedor
                            </label>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-6">
            <div class="row">
                Notificaciones
            </div>
            <div class="row">
                <input id="diasNotificacion" />
                <label class="form-check-label" for="diasNotificacion">
                    D&iacute;as de notificacion
                </label>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-6">
            <div class="row">
                <input id="monto" />
                <label class="form-check-label" for="monto">
                    Monto
                </label>
            </div>
        </div>
    </div>
    <div class="row ">
        <div class="col-md-3">
            <button id="guardarCertificacion" class="btn">Guardar</button>
        </div>
    </div>
    <div class="containerDocumentos d-none">
        <div class="header">
            Alta de documentos
        </div>
        <div class="labels">
            <span># Cliente</span>
            <span>Nombre comercial</span>
            <span>Num Cert</span>
            <span>Régimen fiscal</span>
        </div>
        <div class="tables">
            <table id="documentosDisponibles" class="table data-table table-striped table-bordered">
                <thead>
                    <tr>
                        <th># documento</th>
                        <th>Nombre documento</th>
                    </tr>
                </thead>
                <tbody>
                    <!-- Current documents will be listed here -->
                </tbody>
            </table>
            <div class="buttons">
                <button id="agregaDocumento">Agregar</button>
                <button>Eliminar</button>
            </div>
            <table id="documentosCertificacion" class="table data-table table-striped table-bordered">
                <thead>
                    <tr>
                        <th># documento</th>
                        <th>Nombre documento</th>
                    </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>
        <button class="save-button">Guardar documentos</button>
    </div>
    <div class="containerSecciones d-none">
        <div class="header">
            Alta de Secciones
        </div>
        <div class="tables">
            <table id="seccionesDisponibles" class="table data-table table-striped table-bordered">
                <thead>
                    <tr>
                        <th># seccion</th>
                        <th>Nombre seccion</th>
                    </tr>
                </thead>
                <tbody>
                    <!-- Current documents will be listed here -->
                </tbody>
            </table>
            <div class="buttons">
                <button id="agregaSeccion">Agregar</button>
                <button>Eliminar</button>
            </div>
            <table id="seccionesCertificacion" class="table data-table table-striped table-bordered">
                <thead>
                    <tr>
                        <th># seccion</th>
                        <th>Nombre seccion</th>
                    </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>
        <button class="save-button">Guardar secciones</button>
    </div>
</section>

<script src="<%=request.getContextPath()%>/js/creaCertificacion.js"></script>

<script>
    const manageDocumentsURL = "${manageDocumentsURL}";
    const manageSectionsURL = "${manageSectionsURL}";
    const creaCertificacionURL = "${creaCertificacionURL}";
    const clientId = "${clientId}";
</script>