package com.cdc.afiliacion.certificaciones.commands.resource;

import com.cdc.afiliacion.ACDPServicesFrontOsgi.api.ConfigCertificacionesService;
import com.cdc.afiliacion.ACDPServicesFrontOsgi.dto.ConfigCertif.CreateCertificacionRequest;
import com.cdc.afiliacion.ACDPServicesFrontOsgi.dto.ConfigCertif.CreateCertificacionResponse;
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

    private static final Log LOGGER = LogFactoryUtil.getLog(GetClientResourceCommand.class);

    @Reference
    ConfigCertificacionesService service;

    @Override
    protected void doServeResource(ResourceRequest resourceRequest, ResourceResponse resourceResponse) throws Exception {

        String clientId = ParamUtil.getString(resourceRequest, "clientId");
        String regimenFiscal = ParamUtil.getString(resourceRequest, "regimenFiscal");
        Integer diasNotificacion = ParamUtil.getInteger(resourceRequest, "diasNotificacion");
        Integer montoCertificacion = ParamUtil.getInteger(resourceRequest, "montoCertificacion");
        Integer clienteProveedor = ParamUtil.getInteger(resourceRequest, "clienteProveedor");
        Integer registoUsuario = ParamUtil.getInteger(resourceRequest, "registoUsuario");

        CreateCertificacionRequest request = new CreateCertificacionRequest();
        Gson gson = new Gson();

        try {
            request.setClienteId(clientId);
            request.setMontoCertificacion(montoCertificacion);
            request.setRegimenFiscal(regimenFiscal);
            request.setDiasNotificacion(diasNotificacion);
            request.setRegistoUsuario(registoUsuario);
            request.setClienteProveedor(clienteProveedor);

            CreateCertificacionResponse response = service.createCertificacion(request);

            String jsonResponse = gson.toJson(response);

            PrintWriter writer = resourceResponse.getWriter();
            writer.write(jsonResponse);
        }
        catch (Exception e) {

        }
    }
}
