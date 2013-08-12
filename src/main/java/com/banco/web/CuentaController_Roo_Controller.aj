// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.banco.web;

import com.banco.domain.Cliente;
import com.banco.domain.Cuenta;
import com.banco.domain.Movimiento;
import com.banco.web.CuentaController;
import java.io.UnsupportedEncodingException;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.util.UriUtils;
import org.springframework.web.util.WebUtils;

privileged aspect CuentaController_Roo_Controller {
    
    @RequestMapping(method = RequestMethod.POST, produces = "text/html")
    public String CuentaController.create(@Valid Cuenta cuenta, BindingResult bindingResult, Model uiModel, HttpServletRequest httpServletRequest) {
        if (bindingResult.hasErrors()) {
            populateEditForm(uiModel, cuenta);
            return "cuentas/create";
        }
        uiModel.asMap().clear();
        cuenta.persist();
        return "redirect:/cuentas/" + encodeUrlPathSegment(cuenta.getId().toString(), httpServletRequest);
    }
    
    @RequestMapping(params = "form", produces = "text/html")
    public String CuentaController.createForm(Model uiModel) {
        populateEditForm(uiModel, new Cuenta());
        return "cuentas/create";
    }
    
    @RequestMapping(value = "/{id}", produces = "text/html")
    public String CuentaController.show(@PathVariable("id") Long id, Model uiModel) {
        uiModel.addAttribute("cuenta", Cuenta.findCuenta(id));
        uiModel.addAttribute("itemId", id);
        return "cuentas/show";
    }
    
    @RequestMapping(produces = "text/html")
    public String CuentaController.list(@RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model uiModel) {
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
    }
    
    @RequestMapping(method = RequestMethod.PUT, produces = "text/html")
    public String CuentaController.update(@Valid Cuenta cuenta, BindingResult bindingResult, Model uiModel, HttpServletRequest httpServletRequest) {
        if (bindingResult.hasErrors()) {
            populateEditForm(uiModel, cuenta);
            return "cuentas/update";
        }
        uiModel.asMap().clear();
        cuenta.merge();
        return "redirect:/cuentas/" + encodeUrlPathSegment(cuenta.getId().toString(), httpServletRequest);
    }
    
    @RequestMapping(value = "/{id}", params = "form", produces = "text/html")
    public String CuentaController.updateForm(@PathVariable("id") Long id, Model uiModel) {
        populateEditForm(uiModel, Cuenta.findCuenta(id));
        return "cuentas/update";
    }
    
    @RequestMapping(value = "/{id}", method = RequestMethod.DELETE, produces = "text/html")
    public String CuentaController.delete(@PathVariable("id") Long id, @RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model uiModel) {
        Cuenta cuenta = Cuenta.findCuenta(id);
        cuenta.remove();
        uiModel.asMap().clear();
        uiModel.addAttribute("page", (page == null) ? "1" : page.toString());
        uiModel.addAttribute("size", (size == null) ? "10" : size.toString());
        return "redirect:/cuentas";
    }
    
    void CuentaController.populateEditForm(Model uiModel, Cuenta cuenta) {
        uiModel.addAttribute("cuenta", cuenta);
        uiModel.addAttribute("clientes", Cliente.findAllClientes());
        uiModel.addAttribute("movimientoes", Movimiento.findAllMovimientoes());
    }
    
    String CuentaController.encodeUrlPathSegment(String pathSegment, HttpServletRequest httpServletRequest) {
        String enc = httpServletRequest.getCharacterEncoding();
        if (enc == null) {
            enc = WebUtils.DEFAULT_CHARACTER_ENCODING;
        }
        try {
            pathSegment = UriUtils.encodePathSegment(pathSegment, enc);
        } catch (UnsupportedEncodingException uee) {}
        return pathSegment;
    }
    
}