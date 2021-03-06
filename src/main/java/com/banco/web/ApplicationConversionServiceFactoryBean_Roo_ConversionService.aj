// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.banco.web;

import com.banco.domain.Cliente;
import com.banco.domain.Cuenta;
import com.banco.domain.Movimiento;
import com.banco.domain.UsuarioRol;
import com.banco.web.ApplicationConversionServiceFactoryBean;
import org.springframework.beans.factory.annotation.Configurable;
import org.springframework.core.convert.converter.Converter;
import org.springframework.format.FormatterRegistry;

privileged aspect ApplicationConversionServiceFactoryBean_Roo_ConversionService {
    
    declare @type: ApplicationConversionServiceFactoryBean: @Configurable;
    
    public Converter<Cliente, String> ApplicationConversionServiceFactoryBean.getClienteToStringConverter() {
        return new org.springframework.core.convert.converter.Converter<com.banco.domain.Cliente, java.lang.String>() {
            public String convert(Cliente cliente) {
                return new StringBuilder().append(cliente.getNombre()).append(' ').append(cliente.getDireccion()).append(' ').append(cliente.getTelefone()).append(' ').append(cliente.getUsuario()).toString();
            }
        };
    }
    
    public Converter<Long, Cliente> ApplicationConversionServiceFactoryBean.getIdToClienteConverter() {
        return new org.springframework.core.convert.converter.Converter<java.lang.Long, com.banco.domain.Cliente>() {
            public com.banco.domain.Cliente convert(java.lang.Long id) {
                return Cliente.findCliente(id);
            }
        };
    }
    
    public Converter<String, Cliente> ApplicationConversionServiceFactoryBean.getStringToClienteConverter() {
        return new org.springframework.core.convert.converter.Converter<java.lang.String, com.banco.domain.Cliente>() {
            public com.banco.domain.Cliente convert(String id) {
                return getObject().convert(getObject().convert(id, Long.class), Cliente.class);
            }
        };
    }
    
    public Converter<Cuenta, String> ApplicationConversionServiceFactoryBean.getCuentaToStringConverter() {
        return new org.springframework.core.convert.converter.Converter<com.banco.domain.Cuenta, java.lang.String>() {
            public String convert(Cuenta cuenta) {
                return new StringBuilder().append(cuenta.getNumero()).append(' ').append(cuenta.getSaldo()).toString();
            }
        };
    }
    
    public Converter<Long, Cuenta> ApplicationConversionServiceFactoryBean.getIdToCuentaConverter() {
        return new org.springframework.core.convert.converter.Converter<java.lang.Long, com.banco.domain.Cuenta>() {
            public com.banco.domain.Cuenta convert(java.lang.Long id) {
                return Cuenta.findCuenta(id);
            }
        };
    }
    
    public Converter<String, Cuenta> ApplicationConversionServiceFactoryBean.getStringToCuentaConverter() {
        return new org.springframework.core.convert.converter.Converter<java.lang.String, com.banco.domain.Cuenta>() {
            public com.banco.domain.Cuenta convert(String id) {
                return getObject().convert(getObject().convert(id, Long.class), Cuenta.class);
            }
        };
    }
    
    public Converter<Movimiento, String> ApplicationConversionServiceFactoryBean.getMovimientoToStringConverter() {
        return new org.springframework.core.convert.converter.Converter<com.banco.domain.Movimiento, java.lang.String>() {
            public String convert(Movimiento movimiento) {
                return new StringBuilder().append(movimiento.getFecha()).append(' ').append(movimiento.getValor()).toString();
            }
        };
    }
    
    public Converter<Long, Movimiento> ApplicationConversionServiceFactoryBean.getIdToMovimientoConverter() {
        return new org.springframework.core.convert.converter.Converter<java.lang.Long, com.banco.domain.Movimiento>() {
            public com.banco.domain.Movimiento convert(java.lang.Long id) {
                return Movimiento.findMovimiento(id);
            }
        };
    }
    
    public Converter<String, Movimiento> ApplicationConversionServiceFactoryBean.getStringToMovimientoConverter() {
        return new org.springframework.core.convert.converter.Converter<java.lang.String, com.banco.domain.Movimiento>() {
            public com.banco.domain.Movimiento convert(String id) {
                return getObject().convert(getObject().convert(id, Long.class), Movimiento.class);
            }
        };
    }
    
    public Converter<UsuarioRol, String> ApplicationConversionServiceFactoryBean.getUsuarioRolToStringConverter() {
        return new org.springframework.core.convert.converter.Converter<com.banco.domain.UsuarioRol, java.lang.String>() {
            public String convert(UsuarioRol usuarioRol) {
                return new StringBuilder().append(usuarioRol.getAuthority()).toString();
            }
        };
    }
    
    public Converter<Long, UsuarioRol> ApplicationConversionServiceFactoryBean.getIdToUsuarioRolConverter() {
        return new org.springframework.core.convert.converter.Converter<java.lang.Long, com.banco.domain.UsuarioRol>() {
            public com.banco.domain.UsuarioRol convert(java.lang.Long id) {
                return UsuarioRol.findUsuarioRol(id);
            }
        };
    }
    
    public Converter<String, UsuarioRol> ApplicationConversionServiceFactoryBean.getStringToUsuarioRolConverter() {
        return new org.springframework.core.convert.converter.Converter<java.lang.String, com.banco.domain.UsuarioRol>() {
            public com.banco.domain.UsuarioRol convert(String id) {
                return getObject().convert(getObject().convert(id, Long.class), UsuarioRol.class);
            }
        };
    }
    
    public void ApplicationConversionServiceFactoryBean.installLabelConverters(FormatterRegistry registry) {
        registry.addConverter(getClienteToStringConverter());
        registry.addConverter(getIdToClienteConverter());
        registry.addConverter(getStringToClienteConverter());
        registry.addConverter(getCuentaToStringConverter());
        registry.addConverter(getIdToCuentaConverter());
        registry.addConverter(getStringToCuentaConverter());
        registry.addConverter(getMovimientoToStringConverter());
        registry.addConverter(getIdToMovimientoConverter());
        registry.addConverter(getStringToMovimientoConverter());
        registry.addConverter(getUsuarioRolToStringConverter());
        registry.addConverter(getIdToUsuarioRolConverter());
        registry.addConverter(getStringToUsuarioRolConverter());
    }
    
    public void ApplicationConversionServiceFactoryBean.afterPropertiesSet() {
        super.afterPropertiesSet();
        installLabelConverters(getObject());
    }
    
}
