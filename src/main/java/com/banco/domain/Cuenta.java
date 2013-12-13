package com.banco.domain;
import org.springframework.roo.addon.javabean.RooJavaBean;
import org.springframework.roo.addon.jpa.activerecord.RooJpaActiveRecord;
import org.springframework.roo.addon.tostring.RooToString;

import javax.persistence.Column;

import java.math.BigDecimal;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;
import javax.persistence.ManyToOne;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.OneToMany;

@RooJavaBean
@RooToString
@RooJpaActiveRecord(sequenceName = "CUENTA_SEQ", finders = { "findCuentasByCliente", "findCuentasByNumeroEquals" })
public class Cuenta {

    /**
     */
    @Column(unique = true)
    private String numero;

    /**
     */
    @NotNull
    @Min(0L)
    private BigDecimal saldo;

    /**
     */
    @ManyToOne
    private Cliente cliente;

    /**
     */
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "cuenta")
    private Set<Movimiento> movimientos = new HashSet<Movimiento>();
    
}
