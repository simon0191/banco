// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.banco.domain;

import com.banco.domain.Cliente;
import com.banco.domain.Cuenta;
import com.banco.domain.Movimiento;
import java.math.BigDecimal;
import java.util.Set;

privileged aspect Cuenta_Roo_JavaBean {
    
    public String Cuenta.getNumero() {
        return this.numero;
    }
    
    public void Cuenta.setNumero(String numero) {
        this.numero = numero;
    }
    
    public BigDecimal Cuenta.getSaldo() {
        return this.saldo;
    }
    
    public void Cuenta.setSaldo(BigDecimal saldo) {
        this.saldo = saldo;
    }
    
    public Cliente Cuenta.getCliente() {
        return this.cliente;
    }
    
    public void Cuenta.setCliente(Cliente cliente) {
        this.cliente = cliente;
    }
    
    public Set<Movimiento> Cuenta.getMovimientos() {
        return this.movimientos;
    }
    
    public void Cuenta.setMovimientos(Set<Movimiento> movimientos) {
        this.movimientos = movimientos;
    }
    
}
