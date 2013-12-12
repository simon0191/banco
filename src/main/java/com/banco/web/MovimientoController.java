package com.banco.web;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import com.banco.domain.Cliente;
import com.banco.domain.Cuenta;
import com.banco.domain.Movimiento;
import com.banco.domain.ReporteCuenta;
import com.banco.reference.TipoMovimiento;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.roo.addon.web.mvc.controller.scaffold.RooWebScaffold;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.roo.addon.web.mvc.controller.finder.RooWebFinder;

@RequestMapping("/movimientoes")
@Controller
@RooWebScaffold(path = "movimientoes", formBackingObject = Movimiento.class, delete = false, update = false)
@RooWebFinder
public class MovimientoController {

    @RequestMapping(produces = "text/html")
    public String list(@RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model uiModel) {
    	uiModel.addAttribute("consolidado",false);
        if (isAdmin()) {
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
        } else {
            List<Movimiento> movs = getMovimientosByCliente(getLoggedCliente());
            uiModel.addAttribute("movimientoes", movs);
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
        if (movimiento.getTipo().equals(TipoMovimiento.CREDITO) && (movimiento.getCuenta().getSaldo().compareTo(movimiento.getValor()) < 0)) {
            bindingResult.rejectValue("valor", "account_negative_value");
            populateEditForm(uiModel, movimiento);
            return "movimientoes/create";
        }
        uiModel.asMap().clear();
        Cuenta c = movimiento.getCuenta();
        if (movimiento.getTipo().equals(TipoMovimiento.CREDITO)) {
            c.setSaldo(c.getSaldo().subtract(movimiento.getValor()));
        } else {
            c.setSaldo(c.getSaldo().add(movimiento.getValor()));
        }
        c.merge();
        movimiento.persist();
        return "redirect:/movimientoes/" + encodeUrlPathSegment(movimiento.getId().toString(), httpServletRequest);
    }

    private List<Movimiento> getMovimientosByCliente(Cliente cliente) {
        List<Cuenta> resultList = Cuenta.findCuentasByCliente(cliente).getResultList();
        List<Movimiento> movs = new ArrayList<Movimiento>();
        for (Cuenta c : resultList) {
            movs.addAll(Movimiento.findMovimientoesByCuenta(c).getResultList());
        }
        return movs;
    }

    void populateEditForm(Model uiModel, Movimiento movimiento) {
        uiModel.addAttribute("movimiento", movimiento);
        addDateTimeFormatPatterns(uiModel);
        if(isAdmin()){
        	uiModel.addAttribute("cuentas", Cuenta.findAllCuentas());
        }
        else{
        	uiModel.addAttribute("cuentas", Cuenta.findCuentasByCliente(getLoggedCliente()).getResultList());
        }
        uiModel.addAttribute("tipomovimientoes", Arrays.asList(TipoMovimiento.values()));
    }

    @RequestMapping(params = { "find=ByFechaBetween", "form" }, method = RequestMethod.GET)
    public String findMovimientoesByFechaBetweenForm(Model uiModel) {
    	uiModel.addAttribute("clientes", Cliente.findAllClientes());
        addDateTimeFormatPatterns(uiModel);
        return "movimientoes/findMovimientoesByFechaBetween";
    }
    
    @RequestMapping(params = "find=ByFechaBetween", method = RequestMethod.GET)
    public String findMovimientoesByFechaBetween(@RequestParam("minFecha") @DateTimeFormat(style = "M-") Date minFecha, @RequestParam("maxFecha") @DateTimeFormat(style = "M-") Date maxFecha, 
    		@ModelAttribute("cliente") @RequestParam("cliente") Cliente cliente, Model uiModel) {
    	//cliente = Cliente.findClientesByUsuarioEquals("user1").getSingleResult();
    	
    	List<Movimiento> movimientos = Movimiento.findMovimientoesByFechaBetween(minFecha, maxFecha,cliente).getResultList();
    	
    	
    	Map<String,ReporteCuenta> mapa = new HashMap<String,ReporteCuenta>();
    	for(Cuenta c:cliente.getCuentas()) {
    		mapa.put(c.getNumero(), new ReporteCuenta(c,BigDecimal.ZERO,BigDecimal.ZERO));
    	}
    	
    	for(Movimiento m:movimientos) {
    		mapa.get(m.getCuenta().getNumero()).add(m.getTipo(),m.getValor());
    	}
    	List<ReporteCuenta> movimientosConsolidado = new ArrayList<ReporteCuenta>();
    	for(String numeroCuenta:mapa.keySet()) {
    		movimientosConsolidado.add(mapa.get(numeroCuenta));
    	}
    	
    	
    	uiModel.addAttribute("consolidado",true);
    	uiModel.addAttribute("movimientos_consolidado",movimientosConsolidado);
    	
        uiModel.addAttribute("movimientoes", movimientos);
        addDateTimeFormatPatterns(uiModel);
        return "movimientoes/list";
    }
    
    private boolean isAdmin() {
        for (GrantedAuthority ga : SecurityContextHolder.getContext().getAuthentication().getAuthorities()) {
            if (ga.getAuthority().equals("ROLE_ADMIN")) {
                return true;
            }
        }
        return false;
    }

    private Cliente getLoggedCliente() {
        return Cliente.findClientesByUsuarioEquals(SecurityContextHolder.getContext().getAuthentication().getName()).getSingleResult();
    }
}
