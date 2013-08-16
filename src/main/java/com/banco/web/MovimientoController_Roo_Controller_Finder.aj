// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.banco.web;

import com.banco.domain.Cuenta;
import com.banco.domain.Movimiento;
import com.banco.web.MovimientoController;
import java.util.Date;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

privileged aspect MovimientoController_Roo_Controller_Finder {
    
    @RequestMapping(params = { "find=ByCuenta", "form" }, method = RequestMethod.GET)
    public String MovimientoController.findMovimientoesByCuentaForm(Model uiModel) {
        uiModel.addAttribute("cuentas", Cuenta.findAllCuentas());
        return "movimientoes/findMovimientoesByCuenta";
    }
    
    @RequestMapping(params = "find=ByCuenta", method = RequestMethod.GET)
    public String MovimientoController.findMovimientoesByCuenta(@RequestParam("cuenta") Cuenta cuenta, Model uiModel) {
        uiModel.addAttribute("movimientoes", Movimiento.findMovimientoesByCuenta(cuenta).getResultList());
        return "movimientoes/list";
    }

}