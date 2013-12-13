package com.banco.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import com.banco.domain.Cliente;
import com.banco.domain.Cuenta;
import com.banco.domain.Movimiento;
import com.banco.domain.UsuarioRol;

import org.springframework.roo.addon.web.mvc.controller.scaffold.RooWebScaffold;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.servletapi.SecurityContextHolderAwareRequestWrapper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@RequestMapping("/cuentas")
@Controller
@RooWebScaffold(path = "cuentas", formBackingObject = Cuenta.class)
public class CuentaController {

	@RequestMapping(produces = "text/html")
	public String list(
			@RequestParam(value = "page", required = false) Integer page,
			@RequestParam(value = "size", required = false) Integer size,
			Model uiModel) {

		boolean is_admin = isAdmin();
		Cliente cliente = getLoggedCliente();
		if (is_admin && (page != null || size != null)) {
			int sizeNo = size == null ? 10 : size.intValue();
			final int firstResult = page == null ? 0 : (page.intValue() - 1)
					* sizeNo;
			uiModel.addAttribute("cuentas",
					Cuenta.findCuentaEntries(firstResult, sizeNo));
			float nrOfPages = (float) Cuenta.countCuentas() / sizeNo;
			uiModel.addAttribute(
					"maxPages",
					(int) ((nrOfPages > (int) nrOfPages || nrOfPages == 0.0) ? nrOfPages + 1
							: nrOfPages));
		} else if (!is_admin) {
			List<Cuenta> resultList = Cuenta.findCuentasByCliente(cliente)
					.getResultList();
			uiModel.addAttribute("cuentas", resultList);
		} else {
			uiModel.addAttribute("cuentas", Cuenta.findAllCuentas());
		}
		return "cuentas/list";
	}

	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@RequestMapping(method = RequestMethod.POST, produces = "text/html")
	public String create(@Valid Cuenta cuenta, BindingResult bindingResult,
			Model uiModel, HttpServletRequest httpServletRequest) {
		
		if (bindingResult.hasErrors()) {
			populateEditForm(uiModel, cuenta);
			return "cuentas/create";
		}
		
		if(!Cuenta.findCuentasByNumeroEquals(cuenta.getNumero()).getResultList().isEmpty()) {
			bindingResult.rejectValue("numero", "account_already_exists");
            populateEditForm(uiModel, cuenta);
            return "cuentas/create";
		}
		
		uiModel.asMap().clear();
		if(!isAdmin()) {
			Cliente c = getLoggedCliente();
			cuenta.setCliente(c);
		}
		cuenta.persist();
		return "redirect:/cuentas/"
				+ encodeUrlPathSegment(cuenta.getId().toString(),
						httpServletRequest);
	}

	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@RequestMapping(params = "form", produces = "text/html")
	public String createForm(Model uiModel) {
		populateEditForm(uiModel, new Cuenta());
		return "cuentas/create";
	}

	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@RequestMapping(method = RequestMethod.PUT, produces = "text/html")
	public String update(@Valid Cuenta cuenta, BindingResult bindingResult,
			Model uiModel, HttpServletRequest httpServletRequest) {
		boolean is_admin = isAdmin();		
			if (bindingResult.hasErrors()) {
				populateEditForm(uiModel, cuenta);
				return "cuentas/update";
			}
			Cuenta oldAccount = Cuenta.findCuenta(cuenta.getId());
			if(!oldAccount.getNumero().equals(cuenta.getNumero()) && !Cuenta.findCuentasByNumeroEquals(cuenta.getNumero()).getResultList().isEmpty()) {
				bindingResult.rejectValue("numero", "account_already_exists");
	            populateEditForm(uiModel, cuenta);
	            return "cuentas/update";
			}
			uiModel.asMap().clear();
			if(!isAdmin()) {
				Cliente c = getLoggedCliente();
				cuenta.setCliente(c);
			}
			cuenta.merge();
			return "redirect:/cuentas/"
					+ encodeUrlPathSegment(cuenta.getId().toString(),
							httpServletRequest);	
	}

	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@RequestMapping(value = "/{id}", params = "form", produces = "text/html")
	public String updateForm(@PathVariable("id") Long id, Model uiModel) {
		populateEditForm(uiModel, Cuenta.findCuenta(id));
		return "cuentas/update";	
	}

	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@RequestMapping(value = "/{id}", method = RequestMethod.DELETE, produces = "text/html")
	public String delete(@PathVariable("id") Long id,
			@RequestParam(value = "page", required = false) Integer page,
			@RequestParam(value = "size", required = false) Integer size,
			Model uiModel) {
			Cuenta cuenta = Cuenta.findCuenta(id);
			cuenta.remove();
			uiModel.asMap().clear();
			uiModel.addAttribute("page", (page == null) ? "1" : page.toString());
			uiModel.addAttribute("size", (size == null) ? "10" : size.toString());
			return "redirect:/cuentas";	
	}

	private boolean isAdmin() {
		for (GrantedAuthority ga : SecurityContextHolder.getContext()
				.getAuthentication().getAuthorities()) {
			if (ga.getAuthority().equals("ROLE_ADMIN")) {
				return true;
			}
		}
		return false;
	}
	void populateEditForm(Model uiModel, Cuenta cuenta) {
        uiModel.addAttribute("cuenta", cuenta);
        if(isAdmin()){
        	uiModel.addAttribute("clientes", Cliente.findAllClientes());
        }
        uiModel.addAttribute("movimientoes", Movimiento.findAllMovimientoes());
    }
	private Cliente getLoggedCliente() {
		return Cliente.findClientesByUsuarioEquals(SecurityContextHolder.getContext().getAuthentication()
		.getName()).getSingleResult();
	}
}
