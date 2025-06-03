<%@ include file="./init.jsp" %>

<portlet:resourceURL id="/afiliacion/certificaciones/manageDocuments" var="manageDocumentsURL" cacheability="FULL"/>
<portlet:resourceURL id="/afiliacion/certificaciones/manageSections" var="manageSectionsURL" cacheability="FULL"/>

<style>
    tr.selected {
        background-color: lightblue;
    }
</style>

<section>
    <div class="row">
        Regimen Fiscal
    </div>
    <div class="col-md-3">
        <div class="form-inline" style="float: left !important;">
            <div class="col-lg-6 col-md-6">
                <div class="">
                    <input class="" name="regimenFiscal" type="radio" id="regimenMoral" value="1">
                    <label class="form-check-label" for="regimenMoral">
                        Moral
                    </label>
                </div>
            </div>
            <div class="col-lg-6 col-md-6">
                <div class="">
                    <input class="" name="regimenFiscal" type="radio" id="regimenFisica" value="2">
                    <label class="form-check-label" for="regimenFisica">
                        Fisica
                    </label>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        Tipo de Pago
    </div>
    <div class="col-md-3">
        <div class="form-inline" style="float: left !important;">
            <div class="col-lg-6 col-md-6">
                <div class="form-check">
                    <input class="" name="regimenFiscal" type="radio" id="regimenMoral" value="1">
                    <label class="form-check-label" for="regimenMoral">
                        Cliente
                    </label>
                </div>
            </div>
            <div class="col-lg-6 col-md-6">
                <div class="form-check">
                    <input class="" name="regimenFiscal" type="radio" id="regimenFisica" value="2">
                    <label class="form-check-label" for="regimenFisica">
                        Proveedor
                    </label>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        Monto
    </div>
    <div class="containerDocumentos">
        <div class="header">
            <h1>Alta de documentos</h1>
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
        <button class="save-button">Guardar</button>
    </div>
    <div class="containerSecciones">
        <div class="header">
            <h1>Alta de Secciones</h1>
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
        <button class="save-button">Guardar</button>
    </div>
</section>

<script src="https://cdn.datatables.net/1.10.21/js/jquery.dataTables.min.js"></script>
<script src="<%=request.getContextPath()%>/js/creaCertificacion.js"></script>

<script>
    const manageDocumentsURL = "${manageDocumentsURL}";
    const manageSectionsURL = "${manageSectionsURL}";
</script>