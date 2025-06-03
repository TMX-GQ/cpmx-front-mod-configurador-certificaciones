package com.cdc.afiliacion.certificaciones.commands.action;

import com.cdc.afiliacion.certificaciones.constants.ConfiguradorCertificacionesPortletKeys;
import com.liferay.portal.kernel.portlet.bridges.mvc.BaseMVCActionCommand;
import com.liferay.portal.kernel.portlet.bridges.mvc.MVCActionCommand;
import org.osgi.service.component.annotations.Component;

import javax.portlet.ActionRequest;
import javax.portlet.ActionResponse;

@Component(
        immediate = true,
        property = {
                "javax.portlet.init-param.copy-request-parameters=true",
                "javax.portlet.name=" + ConfiguradorCertificacionesPortletKeys.CONFIGURADORCERTIFICACIONES,
                "mvc.command.name=/afiliacion/certificaciones/editaCertificacion"
        },
        service = MVCActionCommand.class
)
public class EdicionCertificacionActionCommand extends BaseMVCActionCommand {

    @Override
    protected void doProcessAction(ActionRequest actionRequest, ActionResponse actionResponse)
            throws Exception {

        String clientId = actionRequest.getParameter("clientId");

        actionRequest.setAttribute("clientId", clientId);

        actionResponse.getRenderParameters().setValue("jspPage", "/edicionCertificacion.jsp");
    }
}
