// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.banco.domain;

import com.banco.domain.Cliente;
import com.banco.domain.UsuarioRol;

privileged aspect UsuarioRol_Roo_JavaBean {
    
    public String UsuarioRol.getAuthority() {
        return this.authority;
    }
    
    public void UsuarioRol.setAuthority(String authority) {
        this.authority = authority;
    }
    
    public Cliente UsuarioRol.getCliente() {
        return this.cliente;
    }
    
    public void UsuarioRol.setCliente(Cliente cliente) {
        this.cliente = cliente;
    }
    
}