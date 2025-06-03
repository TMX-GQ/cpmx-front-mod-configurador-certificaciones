package com.cdc.afiliacion.certificaciones.commands.resource;

import com.cdc.afiliacion.ACDPServicesFrontOsgi.api.ConfigCertificacionesService;
import com.cdc.afiliacion.ACDPServicesFrontOsgi.dto.ConfigCertif.CertificacionDTO;
import com.cdc.afiliacion.ACDPServicesFrontOsgi.dto.ConfigCertif.GetClientRequest;
import com.cdc.afiliacion.ACDPServicesFrontOsgi.dto.ConfigCertif.GetClientResponse;
import com.cdc.afiliacion.certificaciones.constants.ConfiguradorCertificacionesPortletKeys;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.liferay.portal.kernel.log.Log;
import com.liferay.portal.kernel.log.LogFactoryUtil;
import com.liferay.portal.kernel.portlet.bridges.mvc.BaseMVCResourceCommand;
import com.liferay.portal.kernel.portlet.bridges.mvc.MVCResourceCommand;
import com.liferay.portal.kernel.util.ParamUtil;
import org.osgi.service.component.annotations.Component;
import org.osgi.service.component.annotations.Reference;

import javax.portlet.ResourceRequest;
import javax.portlet.ResourceResponse;
import java.io.PrintWriter;
import java.util.List;

@Component(
        immediate = true,
        property = {
                "javax.portlet.init-param.copy-request-parameters=true",
                "javax.portlet.name=" + ConfiguradorCertificacionesPortletKeys.CONFIGURADORCERTIFICACIONES,
                "mvc.command.name=/afiliacion/certificaciones/getClient"
        },
        service = MVCResourceCommand.class
)
public class GetClientResourceCommand extends BaseMVCResourceCommand {

    private static final Log LOGGER = LogFactoryUtil.getLog(GetClientResourceCommand.class);

    @Reference
    ConfigCertificacionesService service;

    @Override
    protected void doServeResource(ResourceRequest resourceRequest, ResourceResponse resourceResponse) throws Exception {

        Gson gson = new Gson();

        String clientId = ParamUtil.getString(resourceRequest, "clientId");
        String clientName = ParamUtil.getString(resourceRequest, "clientName");

        GetClientRequest request = new GetClientRequest();
        request.setClienteId(clientId);
        request.setClienteNombre(clientName);

        try {
            GetClientResponse response = service.getClient(request);

            LOGGER.info("Client ID: " + response.getClienteId());

            request.setClienteId(response.getClienteId());
            List<CertificacionDTO> responseCertif = service.getCertificaciones(request);

            if(!responseCertif.isEmpty()) {
                response.setCertificaciones(true);
            }

            String jsonResponse = gson.toJson(response);

            PrintWriter writer = resourceResponse.getWriter();
            writer.write(jsonResponse);
        }
        catch(Exception e) {
            LOGGER.info("Manejando Excepcion");

            JsonObject responseObjectError = new JsonObject();
            responseObjectError.addProperty("error", true);

            String jsonResponse = gson.toJson(responseObjectError);

            PrintWriter writer = resourceResponse.getWriter();
            writer.write(jsonResponse);
        }
    }
}
