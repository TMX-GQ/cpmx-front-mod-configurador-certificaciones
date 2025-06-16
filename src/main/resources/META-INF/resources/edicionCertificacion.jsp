<%@ include file="./init.jsp" %>

<portlet:actionURL var="registroCliente" name="/afiliacion/certificaciones/registroCliente" />

<portlet:resourceURL id="/afiliacion/certificaciones/getCertificaciones" var="getCertificacionesURL" cacheability="FULL"/>
<portlet:resourceURL id="/afiliacion/certificaciones/manageDocuments" var="manageDocumentsURL" cacheability="FULL"/>
<portlet:resourceURL id="/afiliacion/certificaciones/manageSections" var="manageSectionsURL" cacheability="FULL"/>

<script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
<style>
    .boton_afiliacion_primario {
        background-color: #019d01 !important;
        color: white !important;
        max-height: 40px !important;
    }
</style>

<section>
    <div class="row">
        <div class="col-md-6">
            ID Cliente: ${clientId}
        </div>
        <div class="col-md-6">
            Nombre Cliente:
        </div>
    </div>
    <div class="row mt-4">
        <table id="certificationsTable" class="tabla-verde table data-table table-striped table-bordered">
            <thead>
                <tr>
                    <th>ID Certificaci&oacute;n</th>
                    <th>R&eacute;gimen Fiscal</th>
                    <th># de Documentos</th>
                    <th># de Secciones</th>
                    <th>D&iacute;as de Notificaci&oacute;n</th>
                    <th># de Proveedores</th>
                    <th>Detalles</th>
                </tr>
            </thead>
            <tbody></tbody>
        </table>
    </div>
    <div class="row">
        <div class="md-form form-group">
            <button id="btnNueva" class="btn btn-pink float-right boton_afiliacion_primario">
                Nueva Certificacion
            </button>
        </div>
    </div>
</section>

<div class="modal" id="modalDetalles" tabindex="-1" role="dialog" aria-labelledby="tituloDetalle" aria-hidden="true">
     <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable" role="document">
         <div class="modal-content">
             <div class="modal-header">
                 <h5 class="modal-title" id="tituloDetalle">Detalles</h5>
                 <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                     <span aria-hidden="true">&times;</span>
                 </button>
             </div>
             <div class="modal-body">
                <ul class="nav nav-tabs" id="tabsDetalles">
                    <li class="nav-item">
                        <a class="nav-link active" data-bs-toggle="tab" href="#documentos">Documentos</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" data-bs-toggle="tab" href="#secciones">Secciones</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" data-bs-toggle="tab" href="#otros">Otros</a>
                    </li>
                </ul>
                <div class="tab-content mt-3">
                    <div class="tab-pane fade show active" id="documentos">
                         <div class="row">
                            <div class="containerDocumentos">
                                <div class="header">
                                    Alta de documentos
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
                                        <button id="eliminaDocumento">Eliminar</button>
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
                                <button class="save-button" id="sendDocuments">Guardar documentos</button>
                            </div>
                         </div>
                    </div>
                    <div class="tab-pane fade" id="secciones">
                        <div class="containerSecciones">
                            <div class="header">
                                Secciones
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
                                    <button id="eliminaSeccion">Eliminar</button>
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
                            <button class="save-button" id="sendSecciones">Guardar secciones</button>
                        </div>
                    </div>
                 </div>
             </div>
             <div class="modal-footer">
                 <button id="registrarCliente">
                     Continuar
                 </button>
                 <button id="cancelar">
                     Cancelar
                 </button>
             </div>
         </div>
     </div>
 </div>

 <form id="registraClienteForm" action="${registroCliente}" method="post">
     <input type="hidden" id="clientIdNuevo" name="clientId" value="${clientId}"/>
 </form>

<script src="https://cdn.datatables.net/1.10.21/js/jquery.dataTables.min.js"></script>
<script src="<%=request.getContextPath()%>/js/editaCertificacion.js"></script>

<script>
    const clientID = "${clientId}";
    const getCertificacionesURL = "${getCertificacionesURL}";
    const manageDocumentsURL = "${manageDocumentsURL}";
    const manageSectionsURL = "${manageSectionsURL}";
    var documentosActuales;
    var seccionesActuales;

    var certificacion;
    var datosCertificaciones;
</script>

<style>
    tr.selected {
        background-color: #d4edda !important;
        color: #155724;
        font-weight: bold;
    }
</style>