package com.cdc.afiliacion.certificaciones.portlet;

import com.cdc.afiliacion.certificaciones.constants.ConfiguradorCertificacionesPortletKeys;

import com.liferay.portal.kernel.portlet.bridges.mvc.MVCPortlet;

import javax.portlet.Portlet;
import javax.portlet.PortletException;
import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;

import org.osgi.service.component.annotations.Component;

import java.io.IOException;

/**
 * @author urielflores
 */
@Component(
	property = {
		"com.liferay.portlet.display-category=category.sample",
		"com.liferay.portlet.header-portlet-css=/css/main.css",
		"com.liferay.portlet.instanceable=true",
		"javax.portlet.display-name=ConfiguradorCertificaciones",
		"javax.portlet.init-param.template-path=/",
		"javax.portlet.init-param.view-template=/view.jsp",
		"javax.portlet.name=" + ConfiguradorCertificacionesPortletKeys.CONFIGURADORCERTIFICACIONES,
		"javax.portlet.resource-bundle=content.Language",
		"javax.portlet.security-role-ref=power-user,user",
		"com.liferay.portlet.private-session-attributes=false",
		"com.liferay.portlet.requires-namespaced-parameters=false",
		"com.liferay.portlet.private-request-attributes=false"
	},
	service = Portlet.class
)
public class ConfiguradorCertificacionesPortlet extends MVCPortlet {

	@Override
	public void doView(RenderRequest renderRequest, RenderResponse renderResponse)
			throws IOException, PortletException {

		super.doView(renderRequest, renderResponse);
	}
}