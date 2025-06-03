<%@ include file="/init.jsp" %>

<portlet:actionURL var="registroCliente" name="/afiliacion/certificaciones/registroCliente" />
<portlet:actionURL var="editaCertificacion" name="/afiliacion/certificaciones/editaCertificacion" />

<portlet:resourceURL id="/afiliacion/certificaciones/getClient" var="getClientURL" cacheability="FULL"/>

<section>
    <div class="row">
        <div class="col-md-3">
        </div>
        <div class="col-md-6">
            <div class="row">
                <div class="md-form form-group">
                    <input id="idCliente" type="text" name="idCliente" class="form-control">
                    <label for="idCliente" >ID Cliente</label>
                </div>
            </div>
            <div class="row">
                <div class="md-form form-group">
                    <input id="nombreCliente" type="text" name="nombreCliente" class="form-control">
                    <label for="nombreCliente" >Nombre Cliente</label>
                </div>
                <div class="md-form form-group">
                    <button id="btnBuscar" class="btn btn-pink float-right">
                        Buscar
                    </button>
                </div>
            </div>
        </div>
        <div class="col-md-3">
        </div>
    </div>
    <div class="row">
        <table id="clientTable" class="table data-table table-striped table-bordered">
            <thead>
                <tr>
                    <th>ID Cliente</th>
                    <th>Nombre Comercial</th>
                    <th>Razon Social</th>
                    <th>RFC</th>
                    <th></th>
                </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
    </div>
</section>

<!--div class="modal" id="modalAlertaCliente" tabindex="-1" role="dialog" aria-labelledby="clienteNoEncontrado" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="clienteNoEncontrado">Cliente no encontrado</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-12">
                        ¿Desea registrarlo?
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
</div-->

<form id="registraClienteForm" action="${registroCliente}" method="post">
</form>

<form id="editaCertificacionForm" action="${editaCertificacion}" method="post">
    <input type="hidden" id="clientId" name="clientId" />
</form>

<script src="https://cdn.datatables.net/1.10.21/js/jquery.dataTables.min.js"></script>
<script src="<%=request.getContextPath()%>/js/main.js"></script>

<script>
    const getClientURL = "${getClientURL}";
</script>