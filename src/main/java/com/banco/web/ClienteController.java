package com.banco.web;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import com.banco.domain.Cliente;
import com.banco.domain.Cuenta;
import com.banco.domain.UsuarioRol;

import org.springframework.roo.addon.web.mvc.controller.scaffold.RooWebScaffold;
import org.springframework.security.authentication.encoding.ShaPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@RequestMapping("/clientes")
@Controller
@RooWebScaffold(path = "clientes", formBackingObject = Cliente.class)
public class ClienteController {
	//
	
	 @RequestMapping(method = RequestMethod.POST, produces = "text/html")
	    public String create(@Valid Cliente cliente, BindingResult bindingResult, Model uiModel, HttpServletRequest httpServletRequest) {
	        if (bindingResult.hasErrors()) {
	            populateEditForm(uiModel, cliente);
	            return "clientes/create";
	        }
	        
	        if(Cliente.findClientesByUsuarioEquals(cliente.getUsuario()).getResultList().size() > 0) {
	        	bindingResult.rejectValue("usuario", "username_already_exists");
	            populateEditForm(uiModel, cliente);
	            return "clientes/create";
	        }
	        
	        uiModel.asMap().clear();
	        cliente.setPassword((new ShaPasswordEncoder(256)).encodePassword(cliente.getPassword(), null));
	        cliente.persist();
	        UsuarioRol ur = new UsuarioRol();
	        ur.setCliente(cliente);
	        ur.setAuthority("ROLE_USER");
	        ur.persist();
	        return "redirect:/clientes/" + encodeUrlPathSegment(cliente.getId().toString(), httpServletRequest);
	    }
	    
	    @RequestMapping(params = "form", produces = "text/html")
	    public String createForm(Model uiModel) {
	        populateEditForm(uiModel, new Cliente());
	        return "clientes/create";
	    }
	    
	    @RequestMapping(value = "/{id}", produces = "text/html")
	    public String show(@PathVariable("id") Long id, Model uiModel) {
	        uiModel.addAttribute("cliente", Cliente.findCliente(id));
	        uiModel.addAttribute("itemId", id);
	        return "clientes/show";
	    }
	    @RequestMapping(method = RequestMethod.PUT, produces = "text/html")
	    public String update(@Valid Cliente cliente, BindingResult bindingResult, Model uiModel, HttpServletRequest httpServletRequest) {
	        if (bindingResult.hasErrors()) {
	            populateEditForm(uiModel, cliente);
	            return "clientes/update";
	        }
	        Cliente oldCliente = Cliente.findCliente(cliente.getId());
	        if(!oldCliente.getUsuario().equals(cliente.getUsuario()) && Cliente.findClientesByUsuarioEquals(cliente.getUsuario()).getResultList().size() > 0) {
	        	bindingResult.rejectValue("usuario", "username_already_exists");
	            populateEditForm(uiModel, cliente);
	            return "clientes/update";
	        }
	        
	        if(cliente.getPassword()!=null && !cliente.getPassword().equals("") && !cliente.getPassword().equals(oldCliente.getPassword())) {
	        	cliente.setPassword((new ShaPasswordEncoder(256)).encodePassword(cliente.getPassword(), null));
	        }
	        else {
	        	cliente.setPassword(oldCliente.getPassword());
	        }
	        uiModel.asMap().clear();
	        cliente.merge();
	        
	        return "redirect:/clientes/" + encodeUrlPathSegment(cliente.getId().toString(), httpServletRequest);
	    }
	    
	    @RequestMapping(value = "/{id}", params = "form", produces = "text/html")
	    public String updateForm(@PathVariable("id") Long id, Model uiModel) {
	        populateEditForm(uiModel, Cliente.findCliente(id));
	        return "clientes/update";
	    }
	    
	    void populateEditForm(Model uiModel, Cliente cliente) {
	        uiModel.addAttribute("cliente", cliente);
	        uiModel.addAttribute("cuentas", Cuenta.findAllCuentas());
	        uiModel.addAttribute("usuariorols", UsuarioRol.findAllUsuarioRols());
	    }
	    
}
