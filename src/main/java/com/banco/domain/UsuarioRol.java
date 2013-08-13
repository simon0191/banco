package com.banco.domain;
import org.springframework.roo.addon.javabean.RooJavaBean;
import org.springframework.roo.addon.jpa.activerecord.RooJpaActiveRecord;
import org.springframework.roo.addon.tostring.RooToString;
import javax.persistence.ManyToOne;

@RooJavaBean
@RooToString
@RooJpaActiveRecord(sequenceName = "USUARIO_ROL_SEQ")
public class UsuarioRol {

    /**
     */
    private String authority;

    /**
     */
    @ManyToOne
    private Cliente cliente;
}
