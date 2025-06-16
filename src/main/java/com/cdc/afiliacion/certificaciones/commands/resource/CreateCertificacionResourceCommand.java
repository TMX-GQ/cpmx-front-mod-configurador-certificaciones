package com.cdc.afiliacion.certificaciones.commands.resource;

import com.cdc.afiliacion.certificaciones.constants.ConfiguradorCertificacionesPortletKeys;
import com.google.gson.Gson;
import com.liferay.portal.kernel.log.Log;
import com.liferay.portal.kernel.log.LogFactoryUtil;
import com.liferay.portal.kernel.portlet.bridges.mvc.BaseMVCResourceCommand;
import com.liferay.portal.kernel.portlet.bridges.mvc.MVCResourceCommand;
import com.liferay.portal.kernel.util.ParamUtil;
import org.osgi.service.component.annotations.Component;

import javax.portlet.ResourceRequest;
import javax.portlet.ResourceResponse;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.Map;

@Component(
        immediate = true,
        property = {
                "javax.portlet.init-param.copy-request-parameters=true",
                "javax.portlet.name=" + ConfiguradorCertificacionesPortletKeys.CONFIGURADORCERTIFICACIONES,
                "mvc.command.name=/afiliacion/certificaciones/creaCertificacion"
        },
        service = MVCResourceCommand.class
)
public class CreateCertificacionResourceCommand extends BaseMVCResourceCommand {

    private static final Log LOGGER = LogFactoryUtil.getLog(CreateCertificacionResourceCommand.class);

    @Override
    protected void doServeResource(ResourceRequest resourceRequest, ResourceResponse resourceResponse) throws Exception {
        resourceResponse.setContentType("application/json");
        PrintWriter writer = resourceResponse.getWriter();
        Gson gson = new Gson();

        try {
            LOGGER.info("Entró a crear certificación vía consumo directo");

            // Todos los parámetros como String
            String clientId = ParamUtil.getString(resourceRequest, "clientId");
            String regimenFiscal = ParamUtil.getString(resourceRequest, "regimenFiscal");
            String diasNotificacion = ParamUtil.getString(resourceRequest, "diasNotificacion");
            String montoCertificacion = ParamUtil.getString(resourceRequest, "montoCertificacion");
            String clienteProveedor = ParamUtil.getString(resourceRequest, "clienteProveedor");
            String registoUsuario = ParamUtil.getString(resourceRequest, "registoUsuario");

            // Validación básica
            if (clientId == null || clientId.isEmpty()) {
                writer.write("{\"error\": \"clientId es requerido\"}");
                return;
            }

            // Crear body en formato JSON
            Map<String, Object> body = new HashMap<>();
            body.put("clienteId", clientId);
            body.put("regimenFiscal", regimenFiscal);
            body.put("diasNotificacion", Integer.parseInt(diasNotificacion));
            body.put("montoCertificacion", Integer.parseInt(montoCertificacion));
            body.put("clienteProveedor", Integer.parseInt(clienteProveedor));
            body.put("registoUsuario", Integer.parseInt(registoUsuario));

            String jsonRequest = gson.toJson(body);

            // Llamada a API externa
            URL url = new URL("https://plataforma-proveedores-qa.circuloapps.com/configurador/certificaciones/nuevaCertificacion");
            HttpURLConnection con = (HttpURLConnection) url.openConnection();
            con.setRequestMethod("POST");
            con.setRequestProperty("Content-Type", "application/json");
            con.setRequestProperty("User-Agent", "Mozilla/5.0");
            con.setRequestProperty("Authorization", "Bearer TU_TOKEN_AQUI");
            con.setDoOutput(true);

            try (OutputStream os = con.getOutputStream()) {
                byte[] input = jsonRequest.getBytes(StandardCharsets.UTF_8);
                os.write(input, 0, input.length);
            }

            int responseCode = con.getResponseCode();
            BufferedReader br = new BufferedReader(
                    new InputStreamReader(con.getInputStream(), StandardCharsets.UTF_8)
            );

            StringBuilder response = new StringBuilder();
            String responseLine;

            while ((responseLine = br.readLine()) != null) {
                response.append(responseLine.trim());
            }

            LOGGER.info("Respuesta de la API: " + response);
            writer.write(response.toString());

        } catch (Exception e) {
            LOGGER.error("Error al consumir API de certificación", e);
            writer.write("{\"error\": \"Error al consumir la API: " + e.getMessage() + "\"}");
        } finally {
            writer.close();
        }
    }
}
