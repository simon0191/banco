// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.banco.web;

import com.banco.domain.Cuenta;
import com.banco.domain.Movimiento;
import com.banco.reference.TipoMovimiento;
import com.banco.web.MovimientoController;
import java.io.UnsupportedEncodingException;
import java.util.Arrays;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import org.joda.time.format.DateTimeFormat;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.util.UriUtils;
import org.springframework.web.util.WebUtils;

privileged aspect MovimientoController_Roo_Controller {
    
    @RequestMapping(method = RequestMethod.POST, produces = "text/html")
    public String MovimientoController.create(@Valid Movimiento movimiento, BindingResult bindingResult, Model uiModel, HttpServletRequest httpServletRequest) {
        if (bindingResult.hasErrors()) {
            populateEditForm(uiModel, movimiento);
            return "movimientoes/create";
        }
        uiModel.asMap().clear();
        movimiento.persist();
        return "redirect:/movimientoes/" + encodeUrlPathSegment(movimiento.getId().toString(), httpServletRequest);
    }
    
    @RequestMapping(params = "form", produces = "text/html")
    public String MovimientoController.createForm(Model uiModel) {
        populateEditForm(uiModel, new Movimiento());
        return "movimientoes/create";
    }
    
    @RequestMapping(value = "/{id}", produces = "text/html")
    public String MovimientoController.show(@PathVariable("id") Long id, Model uiModel) {
        addDateTimeFormatPatterns(uiModel);
        uiModel.addAttribute("movimiento", Movimiento.findMovimiento(id));
        uiModel.addAttribute("itemId", id);
        return "movimientoes/show";
    }
    
    @RequestMapping(produces = "text/html")
    public String MovimientoController.list(@RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model uiModel) {
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
    
    void MovimientoController.addDateTimeFormatPatterns(Model uiModel) {
        uiModel.addAttribute("movimiento_fecha_date_format", DateTimeFormat.patternForStyle("M-", LocaleContextHolder.getLocale()));
    }
    
    void MovimientoController.populateEditForm(Model uiModel, Movimiento movimiento) {
        uiModel.addAttribute("movimiento", movimiento);
        addDateTimeFormatPatterns(uiModel);
        uiModel.addAttribute("cuentas", Cuenta.findAllCuentas());
        uiModel.addAttribute("tipomovimientoes", Arrays.asList(TipoMovimiento.values()));
    }
    
    String MovimientoController.encodeUrlPathSegment(String pathSegment, HttpServletRequest httpServletRequest) {
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
