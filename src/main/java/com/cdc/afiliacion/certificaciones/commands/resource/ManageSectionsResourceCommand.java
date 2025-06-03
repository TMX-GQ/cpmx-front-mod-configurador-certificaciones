package com.cdc.afiliacion.certificaciones.commands.resource;

import com.cdc.afiliacion.ACDPServicesFrontOsgi.api.ConfigCertificacionesService;
import com.cdc.afiliacion.ACDPServicesFrontOsgi.dto.ConfigCertif.DocumentRequest;
import com.cdc.afiliacion.ACDPServicesFrontOsgi.dto.ConfigCertif.DocumentResponse;
import com.cdc.afiliacion.ACDPServicesFrontOsgi.dto.ConfigCertif.SectionRequest;
import com.cdc.afiliacion.ACDPServicesFrontOsgi.dto.ConfigCertif.SectionResponse;
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
                "mvc.command.name=/afiliacion/certificaciones/manageSections"
        },
        service = MVCResourceCommand.class
)
public class ManageSectionsResourceCommand extends BaseMVCResourceCommand {

    private static final Log LOGGER = LogFactoryUtil.getLog(GetClientResourceCommand.class);

    @Reference
    ConfigCertificacionesService service;

    @Override
    protected void doServeResource(ResourceRequest resourceRequest, ResourceResponse resourceResponse) throws Exception {
        Gson gson = new Gson();

        String numeroCertificacion = ParamUtil.getString(resourceRequest, "numeroCertificacion");
        String seccionId = ParamUtil.getString(resourceRequest, "seccionId");
        String accion = ParamUtil.getString(resourceRequest, "accion");

        SectionRequest request = new SectionRequest();
        request.setAccion(accion);
        request.setNumeroCertificacion(numeroCertificacion);
        request.setSeccionId(seccionId);

        SectionResponse listadoDocumentos = service.manageSection(request);

        String jsonResponse = gson.toJson(listadoDocumentos);

        PrintWriter writer = resourceResponse.getWriter();
        writer.write(jsonResponse);
    }
}
