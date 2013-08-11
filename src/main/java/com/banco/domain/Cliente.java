package com.banco.domain;
import org.springframework.roo.addon.javabean.RooJavaBean;
import org.springframework.roo.addon.jpa.activerecord.RooJpaActiveRecord;
import org.springframework.roo.addon.tostring.RooToString;
import javax.validation.constraints.Size;
import javax.validation.constraints.NotNull;
import java.util.HashSet;
import java.util.Set;
import javax.persistence.CascadeType;
import javax.persistence.OneToMany;

@RooJavaBean
@RooToString
@RooJpaActiveRecord(sequenceName = "CLIENTE_SEQ")
public class Cliente {

    /**
     */
    @Size(min = 3, max = 30)
    private String nombre;

    /**
     */
    @NotNull
    @Size(min = 1, max = 50)
    private String direccion;

    /**
     */
    @NotNull
    private String telefone;

    /**
     */
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "cliente")
    private Set<Cuenta> cuentas = new HashSet<Cuenta>();
}
