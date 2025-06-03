$(document).ready(function() {

    var table = $('#certificationsTable').DataTable();

    $.post(getCertificacionesURL, {
        clientId: clientID
    })
        .done(function (data) {
            var response = JSON.parse(data);
            console.log('Respuesta:', response);

            table.clear(); // Clear previous data

            response.forEach(item => {
                table.row.add([
                    item.cveCertification,
                    '',
                    item.numeroDocumentos,
                    item.numeroSecciones,
                    item.numNotifDays,
                    '',
                    `<button class="edit-btn" data-client-id="${item.clienteId}">Ver</button>`
                ]);
             });

            table.draw();
        });
});