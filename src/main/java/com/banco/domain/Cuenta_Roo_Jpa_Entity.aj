// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.banco.domain;

import com.banco.domain.Cuenta;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Version;

privileged aspect Cuenta_Roo_Jpa_Entity {
    
    declare @type: Cuenta: @Entity;
    
    @Id
    @SequenceGenerator(name = "cuentaGen", sequenceName = "CUENTA_SEQ")
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "cuentaGen")
    @Column(name = "id")
    private Long Cuenta.id;
    
    @Version
    @Column(name = "version")
    private Integer Cuenta.version;
    
    public Long Cuenta.getId() {
        return this.id;
    }
    
    public void Cuenta.setId(Long id) {
        this.id = id;
    }
    
    public Integer Cuenta.getVersion() {
        return this.version;
    }
    
    public void Cuenta.setVersion(Integer version) {
        this.version = version;
    }
    
}