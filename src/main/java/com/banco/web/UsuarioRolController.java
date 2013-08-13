package com.banco.web;
import com.banco.domain.UsuarioRol;
import org.springframework.roo.addon.web.mvc.controller.scaffold.RooWebScaffold;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/usuariorols")
@Controller
@RooWebScaffold(path = "usuariorols", formBackingObject = UsuarioRol.class)
public class UsuarioRolController {
}
