INSERT INTO cliente (id,direccion,nombre,password,telefone,usuario)
values (1,'-','admin','8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918','123456','admin');

INSERT INTO cliente (id,direccion,nombre,password,telefone,usuario)
values (2,'-','user1','0a041b9462caa4a31bac3567e0b6e6fd9100787db2ab433d96f6d178cabfce90','123456','user1');

INSERT INTO cliente (id,direccion,nombre,password,telefone,usuario)
values (3,'-','user2','6025d18fe48abd45168528f18a82e265dd98d421a7084aa09f61b341703901a3','123456','user2');

INSERT INTO usuario_rol (id,authority,cliente)
values (1,'ROLE_ADMIN',1);
INSERT INTO usuario_rol (id,authority,cliente)
values (2,'ROL_USER',2);
INSERT INTO usuario_rol (id,authority,cliente)
values (3,'ROL_USER',3);
