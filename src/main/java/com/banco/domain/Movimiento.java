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
@RooJpaActiveRecord(sequenceName = "MOV_SEQ", finders = { "findMovimientoesByCuenta", "findMovimientoesByFechaBetween" })
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
    
    public static TypedQuery<Movimiento> findMovimientoesByFechaBetween(Date minFecha, Date maxFecha, Cliente cliente) {
        if (minFecha == null) throw new IllegalArgumentException("The minFecha argument is required");
        if (maxFecha == null) throw new IllegalArgumentException("The maxFecha argument is required");
        if (cliente == null ) throw new IllegalArgumentException("The cliente argument is required");
        EntityManager em = Movimiento.entityManager();
        TypedQuery<Movimiento> q = em.createQuery("SELECT o FROM Movimiento AS o WHERE o.cuenta.cliente = :cliente AND o.fecha BETWEEN :minFecha AND :maxFecha", Movimiento.class);
        //TypedQuery<Movimiento> q = em.createQuery("SELECT o FROM Movimiento AS o WHERE o.fecha BETWEEN :minFecha AND :maxFecha", Movimiento.class);
        q.setParameter("minFecha", minFecha);
        q.setParameter("maxFecha", maxFecha);
        q.setParameter("cliente", cliente);
        return q;
    }
}
