$(document).ready(function() {

    var tableDocumentos = $('#documentosDisponibles').DataTable();
    var tableCertificacion = $('#documentosCertificacion').DataTable();

    var tableSecciones = $('#seccionesDisponibles').DataTable();
    var tableSeccionesCert = $('#seccionesCertificacion').DataTable();

    $("#documentosDisponibles tbody").on("click", "tr", function() {
        $(this).toggleClass("selected");
    });

    $("#documentosCertificacion tbody").on("click", "tr", function() {
        $(this).toggleClass("selected");
    });

    $("#seccionesDisponibles tbody").on("click", "tr", function() {
        $(this).toggleClass("selected");
    });

    $("#seccionesCertificacion tbody").on("click", "tr", function() {
        $(this).toggleClass("selected");
    });

    $('#agregaDocumento').click(function(){
        $('#documentosDisponibles tbody tr.selected').each(function(){
            var rowData = tableDocumentos.row(this).data(); // Get row data
            tableCertificacion.row.add(rowData).draw(); // Add row to second table
            tableDocumentos.row(this).remove().draw(); // Remove row from first table
        });
    });

    $('#agregaSeccion').click(function(){
            $('#seccionesDisponibles tbody tr.selected').each(function(){
                var rowData = tableSecciones.row(this).data(); // Get row data
                tableSeccionesCert.row.add(rowData).draw(); // Add row to second table
                tableSecciones.row(this).remove().draw(); // Remove row from first table
            });
        });

    $.post(manageDocumentsURL, {
        numeroCertificacion: 1,
        documentoId: "",
        accion: ""
    }).done(function(data) {

        var response = JSON.parse(data);

        tableDocumentos.clear(); // Clear previous data

        response.documentosDisponibles.forEach(item => {
            tableDocumentos.row.add([
                item.idDocumento,
                item.nombreDocumento
            ]);
         });

        tableDocumentos.draw();
    });

    $.post(manageSectionsURL, {
            numeroCertificacion: 1,
            seccionId: "",
            accion: ""
        }).done(function(data) {

            var response = JSON.parse(data);

            console.log(response);

            tableSecciones.clear(); // Clear previous data

            response.seccionesDisponibles.forEach(item => {
                tableSecciones.row.add([
                    item.idSeccion,
                    item.nombreSeccion
                ]);
             });

            tableSecciones.draw();
        });
});