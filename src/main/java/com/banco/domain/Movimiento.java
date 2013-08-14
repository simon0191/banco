package com.banco.domain;
import org.springframework.roo.addon.javabean.RooJavaBean;
import org.springframework.roo.addon.jpa.activerecord.RooJpaActiveRecord;
import org.springframework.roo.addon.tostring.RooToString;

import java.util.Date;

import javax.persistence.EntityManager;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.TypedQuery;
import javax.validation.constraints.NotNull;

import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.ManyToOne;

import java.math.BigDecimal;

import javax.validation.constraints.Min;

import com.banco.reference.TipoMovimiento;

import javax.persistence.Enumerated;

@RooJavaBean
@RooToString
@RooJpaActiveRecord(sequenceName = "MOV_SEQ", finders = { "findMovimientoesByCuenta" })
public class Movimiento {

    /**
     */
    @NotNull
    @Temporal(TemporalType.TIMESTAMP)
    @DateTimeFormat(style = "M-")
    private Date fecha;

    /**
     */
    @ManyToOne
    private Cuenta cuenta;

    /**
     */
    @NotNull
    @Min(0L)
    private BigDecimal valor;

    /**
     */
    @NotNull
    @Enumerated
    private TipoMovimiento tipo;
    
}
