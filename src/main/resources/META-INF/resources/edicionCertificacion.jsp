<%@ include file="./init.jsp" %>

<portlet:resourceURL id="/afiliacion/certificaciones/getCertificaciones" var="getCertificacionesURL" cacheability="FULL"/>

<section>
    <div class="row">
        <div class="col-md-6">
            ID Cliente: ${clientId}
        </div>
        <div class="col-md-6">
            Nombre Cliente:
        </div>
    </div>
    <div class="row">
        <table id="certificationsTable" class="table data-table table-striped table-bordered">
            <thead>
                <tr>
                    <th>ID Certificación</th>
                    <th>Régimen Fiscal</th>
                    <th># de Documentos</th>
                    <th># de Secciones</th>
                    <th>Días de Notificación</th>
                    <th># de Proveedores</th>
                    <th>Detalles</th>
                </tr>
            </thead>
            <tbody></tbody>
        </table>
    </div>
</section>

<script src="https://cdn.datatables.net/1.10.21/js/jquery.dataTables.min.js"></script>
<script src="<%=request.getContextPath()%>/js/editaCertificacion.js"></script>

<script>
    const clientID = "${clientId}";
    const getCertificacionesURL = "${getCertificacionesURL}";
</script>