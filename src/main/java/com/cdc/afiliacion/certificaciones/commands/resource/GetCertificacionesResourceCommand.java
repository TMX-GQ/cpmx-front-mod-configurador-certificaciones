package com.cdc.afiliacion.certificaciones.commands.resource;

import com.cdc.afiliacion.ACDPServicesFrontOsgi.api.ConfigCertificacionesService;
import com.cdc.afiliacion.ACDPServicesFrontOsgi.dto.ConfigCertif.CertificacionDTO;
import com.cdc.afiliacion.ACDPServicesFrontOsgi.dto.ConfigCertif.GetClientRequest;
import com.cdc.afiliacion.ACDPServicesFrontOsgi.dto.ConfigCertif.GetClientResponse;
import com.cdc.afiliacion.certificaciones.constants.ConfiguradorCertificacionesPortletKeys;
import com.google.gson.Gson;
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
                "mvc.command.name=/afiliacion/certificaciones/getCertificaciones"
        },
        service = MVCResourceCommand.class
)
public class GetCertificacionesResourceCommand extends BaseMVCResourceCommand {

    private static final Log LOGGER = LogFactoryUtil.getLog(GetClientResourceCommand.class);

    @Reference
    ConfigCertificacionesService service;

    @Override
    protected void doServeResource(ResourceRequest resourceRequest, ResourceResponse resourceResponse) throws Exception {

        Gson gson = new Gson();

        LOGGER.info("Entrando a Resource Command");

        String clientId = ParamUtil.getString(resourceRequest, "clientId");

        GetClientRequest request = new GetClientRequest();
        request.setClienteId(clientId);

        try {

            List<CertificacionDTO> responseCertif = service.getCertificaciones(request);

            if(!responseCertif.isEmpty()) {

                String jsonResponse = gson.toJson(responseCertif);

                PrintWriter writer = resourceResponse.getWriter();
                writer.write(jsonResponse);
            }
        }
        catch(Exception e) {

        }
    }
}
