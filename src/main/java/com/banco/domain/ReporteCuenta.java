package com.banco.domain;

import java.math.BigDecimal;

import com.banco.reference.TipoMovimiento;

public class ReporteCuenta {
	private Cuenta cuenta;
	private BigDecimal creditos;
	private BigDecimal debitos;
	public ReporteCuenta(Cuenta cuenta, BigDecimal creditos, BigDecimal debitos) {
		super();
		this.cuenta = cuenta;
		this.creditos = creditos;
		this.debitos = debitos;
	}
	public ReporteCuenta() {
		super();
	}
	public Cuenta getCuenta() {
		return cuenta;
	}
	public void setCuenta(Cuenta cuenta) {
		this.cuenta = cuenta;
	}
	public BigDecimal getCreditos() {
		return creditos;
	}
	public void setCreditos(BigDecimal creditos) {
		this.creditos = creditos;
	}
	public BigDecimal getDebitos() {
		return debitos;
	}
	public void setDebitos(BigDecimal debitos) {
		this.debitos = debitos;
	}
	public void addCreditos(BigDecimal n) {
		creditos = this.creditos.add(n);
	}
	public void addDebitos(BigDecimal n) {
		debitos = this.debitos.add(n);
	}
	public void add(TipoMovimiento tipo,BigDecimal n) {
		switch(tipo) {
			case CREDITO:
				addCreditos(n);
				break;
			case DEBITO:
				addDebitos(n);
				break;
		}
	}
}
