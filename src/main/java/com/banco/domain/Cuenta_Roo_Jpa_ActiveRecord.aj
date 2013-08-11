// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.banco.domain;

import com.banco.domain.Cuenta;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import org.springframework.transaction.annotation.Transactional;

privileged aspect Cuenta_Roo_Jpa_ActiveRecord {
    
    @PersistenceContext
    transient EntityManager Cuenta.entityManager;
    
    public static final EntityManager Cuenta.entityManager() {
        EntityManager em = new Cuenta().entityManager;
        if (em == null) throw new IllegalStateException("Entity manager has not been injected (is the Spring Aspects JAR configured as an AJC/AJDT aspects library?)");
        return em;
    }
    
    public static long Cuenta.countCuentas() {
        return entityManager().createQuery("SELECT COUNT(o) FROM Cuenta o", Long.class).getSingleResult();
    }
    
    public static List<Cuenta> Cuenta.findAllCuentas() {
        return entityManager().createQuery("SELECT o FROM Cuenta o", Cuenta.class).getResultList();
    }
    
    public static Cuenta Cuenta.findCuenta(Long id) {
        if (id == null) return null;
        return entityManager().find(Cuenta.class, id);
    }
    
    public static List<Cuenta> Cuenta.findCuentaEntries(int firstResult, int maxResults) {
        return entityManager().createQuery("SELECT o FROM Cuenta o", Cuenta.class).setFirstResult(firstResult).setMaxResults(maxResults).getResultList();
    }
    
    @Transactional
    public void Cuenta.persist() {
        if (this.entityManager == null) this.entityManager = entityManager();
        this.entityManager.persist(this);
    }
    
    @Transactional
    public void Cuenta.remove() {
        if (this.entityManager == null) this.entityManager = entityManager();
        if (this.entityManager.contains(this)) {
            this.entityManager.remove(this);
        } else {
            Cuenta attached = Cuenta.findCuenta(this.id);
            this.entityManager.remove(attached);
        }
    }
    
    @Transactional
    public void Cuenta.flush() {
        if (this.entityManager == null) this.entityManager = entityManager();
        this.entityManager.flush();
    }
    
    @Transactional
    public void Cuenta.clear() {
        if (this.entityManager == null) this.entityManager = entityManager();
        this.entityManager.clear();
    }
    
    @Transactional
    public Cuenta Cuenta.merge() {
        if (this.entityManager == null) this.entityManager = entityManager();
        Cuenta merged = this.entityManager.merge(this);
        this.entityManager.flush();
        return merged;
    }
    
}
