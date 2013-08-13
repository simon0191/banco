package com.banco.web;
import com.banco.domain.Movimiento;
import org.springframework.roo.addon.web.mvc.controller.scaffold.RooWebScaffold;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/movimientoes")
@Controller
@RooWebScaffold(path = "movimientoes", 
	formBackingObject = Movimiento.class,
	delete=false,
	update=false
	)
public class MovimientoController {
}
