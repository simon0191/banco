package com.banco.web;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import com.banco.domain.Cliente;
import com.banco.domain.Cuenta;
import com.banco.domain.Movimiento;
import com.banco.reference.TipoMovimiento;

import org.springframework.roo.addon.web.mvc.controller.scaffold.RooWebScaffold;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@RequestMapping("/movimientoes")
@Controller
@RooWebScaffold(path = "movimientoes", 
	formBackingObject = Movimiento.class,
	delete=false,
	update=false
	)
public class MovimientoController {
	@RequestMapping(produces = "text/html")
    public String list(@RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model uiModel) {
		if(isAdmin()) {
			if (page != null || size != null) {
	            int sizeNo = size == null ? 10 : size.intValue();
	            final int firstResult = page == null ? 0 : (page.intValue() - 1) * sizeNo;
	            uiModel.addAttribute("movimientoes", Movimiento.findMovimientoEntries(firstResult, sizeNo));
	            float nrOfPages = (float) Movimiento.countMovimientoes() / sizeNo;
	            uiModel.addAttribute("maxPages", (int) ((nrOfPages > (int) nrOfPages || nrOfPages == 0.0) ? nrOfPages + 1 : nrOfPages));
	        } else {
	            uiModel.addAttribute("movimientoes", Movimiento.findAllMovimientoes());
	        }
	        addDateTimeFormatPatterns(uiModel);
	        return "movimientoes/list";
		}
		else {
			List<Movimiento> movs = getMovimientosByCliente(getLoggedCliente());
			uiModel.addAttribute("cuentas", movs);
			addDateTimeFormatPatterns(uiModel);
	        return "movimientoes/list";
		}
        
    }
	@RequestMapping(method = RequestMethod.POST, produces = "text/html")
    public String create(@Valid Movimiento movimiento, BindingResult bindingResult, Model uiModel, HttpServletRequest httpServletRequest) {
        if (bindingResult.hasErrors()) {
            populateEditForm(uiModel, movimiento);
            return "movimientoes/create";
        }
        if(movimiento.getTipo().equals(TipoMovimiento.CREDITO) && (movimiento.getCuenta().getSaldo().compareTo(movimiento.getValor()) < 0)) {
        	bindingResult.rejectValue("valor", "account_negative_value");
        	populateEditForm(uiModel, movimiento);
            return "movimientoes/create";
        }
        uiModel.asMap().clear();
        
        Cuenta c = movimiento.getCuenta();
        if(movimiento.getTipo().equals(TipoMovimiento.CREDITO)) {
        	c.setSaldo(c.getSaldo().subtract(movimiento.getValor()));
        }
        else {
        	c.setSaldo(c.getSaldo().add(movimiento.getValor()));
        }
        c.merge();
        movimiento.persist();
        return "redirect:/movimientoes/" + encodeUrlPathSegment(movimiento.getId().toString(), httpServletRequest);
    }
	private List<Movimiento> getMovimientosByCliente(Cliente cliente) {
		List<Cuenta> resultList = Cuenta.findCuentasByCliente(cliente)
				.getResultList();
		List<Movimiento> movs = Movimiento.findMovimientoesByCuenta(resultList.get(0)).getResultList();
		for(int i = 1;i<resultList.size();++i) {
			movs.addAll(Movimiento.findMovimientoesByCuenta(resultList.get(i)).getResultList());
		}
		return movs;
	}

	void populateEditForm(Model uiModel, Movimiento movimiento) {
        uiModel.addAttribute("movimiento", movimiento);
        addDateTimeFormatPatterns(uiModel);
        uiModel.addAttribute("cuentas", Cuenta.findCuentasByCliente(getLoggedCliente()).getResultList());
        uiModel.addAttribute("tipomovimientoes", Arrays.asList(TipoMovimiento.values()));
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
	private Cliente getLoggedCliente() {
		return Cliente.findClientesByUsuarioEquals(SecurityContextHolder.getContext().getAuthentication()
		.getName()).getSingleResult();
	}
}
