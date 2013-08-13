package com.banco.web;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import com.banco.domain.Cliente;
import com.banco.domain.Cuenta;

import org.springframework.roo.addon.web.mvc.controller.scaffold.RooWebScaffold;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@RequestMapping("/cuentas")
@Controller
@RooWebScaffold(path = "cuentas", formBackingObject = Cuenta.class)
public class CuentaController {
	
	@RequestMapping(produces = "text/html")
    public String list(@RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model uiModel) {
		
		String usuario = SecurityContextHolder.getContext().getAuthentication().getName();
		List<Cliente> clienteList = Cliente.findClientesByUsuarioEquals(usuario).getResultList();
		/*
        if (page != null || size != null) {
            int sizeNo = size == null ? 10 : size.intValue();
            final int firstResult = page == null ? 0 : (page.intValue() - 1) * sizeNo;
            uiModel.addAttribute("cuentas", Cuenta.findCuentaEntries(firstResult, sizeNo));
            float nrOfPages = (float) Cuenta.countCuentas() / sizeNo;
            uiModel.addAttribute("maxPages", (int) ((nrOfPages > (int) nrOfPages || nrOfPages == 0.0) ? nrOfPages + 1 : nrOfPages));
        } else {
            uiModel.addAttribute("cuentas", Cuenta.findAllCuentas());
        }
        return "cuentas/list";
        */
        
        
        
        if(!clienteList.isEmpty()) {
            Cliente cliente = clienteList.get(0);
            List<Cuenta> resultList = Cuenta.findCuentasByCliente(cliente).getResultList();
            uiModel.addAttribute("cuentas",resultList);
         }
         
         return "cuentas/list";
    }
	
	@RequestMapping(method = RequestMethod.POST, produces = "text/html")
    public String create(@Valid Cuenta cuenta, BindingResult bindingResult, Model uiModel, HttpServletRequest httpServletRequest) {
        if (bindingResult.hasErrors()) {
            populateEditForm(uiModel, cuenta);
            return "cuentas/create";
        }
        
        String username = SecurityContextHolder.getContext().getAuthentication().getName();
        List<Cliente> logUserList = Cliente.findClientesByUsuarioEquals(username).getResultList();
        if(!logUserList.isEmpty()) {
            Cliente cliente = logUserList.get(0);
            cuenta.setCliente(cliente);
        }
        uiModel.asMap().clear();
        cuenta.persist();
        return "redirect:/cuentas/" + encodeUrlPathSegment(cuenta.getId().toString(), httpServletRequest);
        
        /*
        uiModel.asMap().clear();
        cuenta.persist();
        return "redirect:/cuentas/" + encodeUrlPathSegment(cuenta.getId().toString(), httpServletRequest);
        */
    }
	
}
