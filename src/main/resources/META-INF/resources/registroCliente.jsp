<%@ include file="./init.jsp" %>

<portlet:resourceURL id="/afiliacion/certificaciones/manageDocuments" var="manageDocumentsURL" cacheability="FULL"/>
<portlet:resourceURL id="/afiliacion/certificaciones/manageSections" var="manageSectionsURL" cacheability="FULL"/>
<portlet:resourceURL id="/afiliacion/certificaciones/creaCertificacion" var="creaCertificacionURL" cacheability="FULL"/>

<style>
    .registro_cliente {
        input[type="radio"]:checked {
            accent-color: #439341;
        }

        tr.selected {
            background-color: lightblue;
        }

        .table-green thead {
            background-color: #e8f5e9;
        }

        .table-green tbody tr:nth-child(odd) {
            background-color: #c8e6c9;
        }

        .table-green tbody tr:nth-child(even) {
            background-color: #f1f8f2;
        }

        .table-green tbody tr:hover {
            background-color: #81c784;
            cursor: pointer;
        }

        .buttons button,
        .save-button {
            background-color: #4caf50;
            color: white;
            border: none;
            padding: 8px 16px;
            margin: 5px;
            border-radius: 4px;
            font-weight: bold;
            transition: background-color 0.3s ease;
        }

        .buttons button:hover,
        .save-button:hover {
            background-color: #388e3c;
        }

        .header h1 {
            color: #2e7d32;
            font-size: 24px;
            margin-top: 20px;
        }

        .labels span {
            margin-right: 20px;
            font-weight: bold;
            color: #33691e;
        }

        .containerDocumentos,
        .containerSecciones {
            margin: 20px 0;
            padding: 20px;
            border: 1px solid #c8e6c9;
            border-radius: 8px;
            background-color: #f9fef9;
        }

        .form-section {
            margin-top: 20px;
        }

        .form-section label {
            font-weight: bold;
            display: block;
            margin-bottom: 5px;
        }

        .form-inline .form-check {
            margin-bottom: 10px;
        }
    }
</style>

<div class="registro_cliente">
    <section class="form-section">
        <div class="row">
            ${clientId}
            <!-- Notificaciones -->
            <div class="col-md-3">
                <label>Notificaciones</label>
                <input type="number" class="form-control" name="diasNotificacion"
                       placeholder="D&iacute;as de notificaci&oacute;n">
            </div>

            <!-- Regimen Fiscal -->
            <div class="col-md-3">
                <label>Regimen Fiscal</label>
                <div class="form-inline">
                    <div class="form-check col-6">
                        <input class="form-check-input" name="regimenFiscal" type="radio" id="regimenMoral" value="1">
                        <label class="form-check-label" for="regimenMoral">Moral</label>
                    </div>
                    <div class="form-check col-6">
                        <input class="form-check-input" name="regimenFiscal" type="radio" id="regimenFisica" value="2">
                        <label class="form-check-label" for="regimenFisica">Fisica</label>
                    </div>
                </div>
            </div>

            <!-- Tipo de Pago -->
            <div class="col-md-3">
                <label>Tipo de Pago</label>
                <div class="form-inline">
                    <div class="form-check col-6">
                        <input class="form-check-input" name="tipoPago" type="radio" id="tipoCliente" value="1">
                        <label class="form-check-label" for="tipoCliente">Cliente</label>
                    </div>
                    <div class="form-check col-6">
                        <input class="form-check-input" name="tipoPago" type="radio" id="tipoProveedor" value="2">
                        <label class="form-check-label" for="tipoProveedor">Proveedor</label>
                    </div>
                </div>
            </div>

            <!-- Monto -->
            <div class="col-md-3">
                <label>Monto</label>
                <input type="text" class="form-control" name="monto" placeholder="$0.00">
            </div>
        </div>
    </section>

    <!-- Sección de Documentos -->
    <div class="containerDocumentos">
        <div class="header">
            <h1>Alta de documentos</h1>
        </div>
        <div class="labels">
            <span># Cliente</span>
            <span>Nombre comercial</span>
            <span>Num Cert</span>
            <span>R&eacute;gimen fiscal</span>
        </div>
        <div class="tables">
            <table id="documentosDisponibles" class="table data-table table-striped table-bordered table-green">
                <thead>
                <tr>
                    <th># documento</th>
                    <th>Nombre documento</th>
                </tr>
                </thead>
                <tbody></tbody>
            </table>
            <div class="buttons">
                <button id="agregaDocumento">Agregar</button>
                <button>Eliminar</button>
            </div>
            <table id="documentosCertificacion" class="table data-table table-striped table-bordered table-green">
                <thead>
                <tr>
                    <th># documento</th>
                    <th>Nombre documento</th>
                </tr>
                </thead>
                <tbody></tbody>
            </table>
        </div>
        <button class="save-button">Guardar documentos</button>
    </div>

    <!-- Sección de Secciones -->
    <div class="containerSecciones">
        <div class="header">
            <h1>Alta de Secciones</h1>
        </div>
        <div class="tables">
            <table id="seccionesDisponibles" class="table data-table table-striped table-bordered table-green">
                <thead>
                <tr>
                    <th># secci&oacute;n</th>
                    <th>Nombre secci&oacute;n</th>
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
            <table id="seccionesCertificacion" class="table data-table table-striped table-bordered table-green">
                <thead>
                <tr>
                    <th># secci&oacute;n</th>
                    <th>Nombre secci&oacute;n</th>
                </tr>
                </thead>
                <tbody></tbody>
            </table>
        </div>
        <button class="save-button">Guardar</button>
    </div>
</div>

<script src="https://cdn.datatables.net/1.10.21/js/jquery.dataTables.min.js"></script>
<script src="<%=request.getContextPath()%>/js/creaCertificacion.js"></script>

<script>
    const manageDocumentsURL = "${manageDocumentsURL}";
    const manageSectionsURL = "${manageSectionsURL}";
    const creaCertificacionURL = "${creaCertificacionURL}";
    const clientId = "${clientId}";
</script>
