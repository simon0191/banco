package com.banco.web;
import com.banco.domain.Cuenta;
import org.springframework.roo.addon.web.mvc.controller.scaffold.RooWebScaffold;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/cuentas")
@Controller
@RooWebScaffold(path = "cuentas", formBackingObject = Cuenta.class)
public class CuentaController {
}
