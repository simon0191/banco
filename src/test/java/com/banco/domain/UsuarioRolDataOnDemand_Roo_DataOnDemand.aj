// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.banco.domain;

import com.banco.domain.ClienteDataOnDemand;
import com.banco.domain.UsuarioRol;
import com.banco.domain.UsuarioRolDataOnDemand;
import java.security.SecureRandom;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Random;
import javax.validation.ConstraintViolation;
import javax.validation.ConstraintViolationException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

privileged aspect UsuarioRolDataOnDemand_Roo_DataOnDemand {
    
    declare @type: UsuarioRolDataOnDemand: @Component;
    
    private Random UsuarioRolDataOnDemand.rnd = new SecureRandom();
    
    private List<UsuarioRol> UsuarioRolDataOnDemand.data;
    
    @Autowired
    ClienteDataOnDemand UsuarioRolDataOnDemand.clienteDataOnDemand;
    
    public UsuarioRol UsuarioRolDataOnDemand.getNewTransientUsuarioRol(int index) {
        UsuarioRol obj = new UsuarioRol();
        setAuthority(obj, index);
        return obj;
    }
    
    public void UsuarioRolDataOnDemand.setAuthority(UsuarioRol obj, int index) {
        String authority = "authority_" + index;
        obj.setAuthority(authority);
    }
    
    public UsuarioRol UsuarioRolDataOnDemand.getSpecificUsuarioRol(int index) {
        init();
        if (index < 0) {
            index = 0;
        }
        if (index > (data.size() - 1)) {
            index = data.size() - 1;
        }
        UsuarioRol obj = data.get(index);
        Long id = obj.getId();
        return UsuarioRol.findUsuarioRol(id);
    }
    
    public UsuarioRol UsuarioRolDataOnDemand.getRandomUsuarioRol() {
        init();
        UsuarioRol obj = data.get(rnd.nextInt(data.size()));
        Long id = obj.getId();
        return UsuarioRol.findUsuarioRol(id);
    }
    
    public boolean UsuarioRolDataOnDemand.modifyUsuarioRol(UsuarioRol obj) {
        return false;
    }
    
    public void UsuarioRolDataOnDemand.init() {
        int from = 0;
        int to = 10;
        data = UsuarioRol.findUsuarioRolEntries(from, to);
        if (data == null) {
            throw new IllegalStateException("Find entries implementation for 'UsuarioRol' illegally returned null");
        }
        if (!data.isEmpty()) {
            return;
        }
        
        data = new ArrayList<UsuarioRol>();
        for (int i = 0; i < 10; i++) {
            UsuarioRol obj = getNewTransientUsuarioRol(i);
            try {
                obj.persist();
            } catch (final ConstraintViolationException e) {
                final StringBuilder msg = new StringBuilder();
                for (Iterator<ConstraintViolation<?>> iter = e.getConstraintViolations().iterator(); iter.hasNext();) {
                    final ConstraintViolation<?> cv = iter.next();
                    msg.append("[").append(cv.getRootBean().getClass().getName()).append(".").append(cv.getPropertyPath()).append(": ").append(cv.getMessage()).append(" (invalid value = ").append(cv.getInvalidValue()).append(")").append("]");
                }
                throw new IllegalStateException(msg.toString(), e);
            }
            obj.flush();
            data.add(obj);
        }
    }
    
}
