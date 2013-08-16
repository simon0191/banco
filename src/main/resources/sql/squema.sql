--
-- PostgreSQL database dump
--

-- Dumped from database version 9.1.9
-- Dumped by pg_dump version 9.1.9
-- Started on 2013-08-16 03:12:03 COT

SET statement_timeout = 0;
SET client_encoding = 'SQL_ASCII';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 169 (class 3079 OID 11681)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 1936 (class 0 OID 0)
-- Dependencies: 169
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 161 (class 1259 OID 17822)
-- Dependencies: 5
-- Name: cliente; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cliente (
    id bigint NOT NULL,
    direccion character varying(50) NOT NULL,
    nombre character varying(30),
    password character varying(70) NOT NULL,
    telefone character varying(255) NOT NULL,
    usuario character varying(70) NOT NULL,
    version integer
);


ALTER TABLE public.cliente OWNER TO postgres;

--
-- TOC entry 165 (class 1259 OID 17861)
-- Dependencies: 5
-- Name: cliente_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE cliente_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cliente_seq OWNER TO postgres;

--
-- TOC entry 162 (class 1259 OID 17827)
-- Dependencies: 1906 5
-- Name: cuenta; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cuenta (
    id bigint NOT NULL,
    numero character varying(255),
    saldo numeric(19,2) NOT NULL,
    version integer,
    cliente bigint,
    CONSTRAINT cuenta_saldo_check CHECK ((saldo >= (0)::numeric))
);


ALTER TABLE public.cuenta OWNER TO postgres;

--
-- TOC entry 166 (class 1259 OID 17863)
-- Dependencies: 5
-- Name: cuenta_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE cuenta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cuenta_seq OWNER TO postgres;

--
-- TOC entry 167 (class 1259 OID 17865)
-- Dependencies: 5
-- Name: mov_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE mov_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.mov_seq OWNER TO postgres;

--
-- TOC entry 163 (class 1259 OID 17833)
-- Dependencies: 1907 5
-- Name: movimiento; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE movimiento (
    id bigint NOT NULL,
    fecha timestamp without time zone NOT NULL,
    tipo integer NOT NULL,
    valor numeric(19,2) NOT NULL,
    version integer,
    cuenta bigint,
    CONSTRAINT movimiento_valor_check CHECK ((valor >= (0)::numeric))
);


ALTER TABLE public.movimiento OWNER TO postgres;

--
-- TOC entry 164 (class 1259 OID 17839)
-- Dependencies: 5
-- Name: usuario_rol; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE usuario_rol (
    id bigint NOT NULL,
    authority character varying(255),
    version integer,
    cliente bigint
);


ALTER TABLE public.usuario_rol OWNER TO postgres;

--
-- TOC entry 168 (class 1259 OID 17867)
-- Dependencies: 5
-- Name: usuario_rol_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE usuario_rol_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.usuario_rol_seq OWNER TO postgres;

--
-- TOC entry 1921 (class 0 OID 17822)
-- Dependencies: 161 1929
-- Data for Name: cliente; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY cliente (id, direccion, nombre, password, telefone, usuario, version) FROM stdin;
1	-	admin	8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918	123456	admin	\N
2	-	user1	0a041b9462caa4a31bac3567e0b6e6fd9100787db2ab433d96f6d178cabfce90	123456	user1	\N
3	-	user2	6025d18fe48abd45168528f18a82e265dd98d421a7084aa09f61b341703901a3	123456	user2	\N
\.


--
-- TOC entry 1937 (class 0 OID 0)
-- Dependencies: 165
-- Name: cliente_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('cliente_seq', 1, false);


--
-- TOC entry 1922 (class 0 OID 17827)
-- Dependencies: 162 1929
-- Data for Name: cuenta; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY cuenta (id, numero, saldo, version, cliente) FROM stdin;
4	1341234	1231.00	0	2
5	54634646	134.00	0	2
6	234	23.00	0	2
1	1234	0.00	2	2
2	24	1236.00	2	3
\.


--
-- TOC entry 1938 (class 0 OID 0)
-- Dependencies: 166
-- Name: cuenta_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('cuenta_seq', 6, true);


--
-- TOC entry 1939 (class 0 OID 0)
-- Dependencies: 167
-- Name: mov_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('mov_seq', 4, true);


--
-- TOC entry 1923 (class 0 OID 17833)
-- Dependencies: 163 1929
-- Data for Name: movimiento; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY movimiento (id, fecha, tipo, valor, version, cuenta) FROM stdin;
1	2013-08-13 00:00:00	0	2.00	0	1
2	2013-08-20 00:00:00	1	1.00	0	1
3	2013-08-22 00:00:00	0	12.00	0	1
4	2013-08-22 00:00:00	1	1234.00	0	2
\.


--
-- TOC entry 1924 (class 0 OID 17839)
-- Dependencies: 164 1929
-- Data for Name: usuario_rol; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY usuario_rol (id, authority, version, cliente) FROM stdin;
1	ROLE_ADMIN	\N	1
2	ROLE_USER	\N	2
3	ROLE_USER	\N	3
\.


--
-- TOC entry 1940 (class 0 OID 0)
-- Dependencies: 168
-- Name: usuario_rol_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('usuario_rol_seq', 1, false);


--
-- TOC entry 1909 (class 2606 OID 17826)
-- Dependencies: 161 161 1930
-- Name: cliente_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cliente
    ADD CONSTRAINT cliente_pkey PRIMARY KEY (id);


--
-- TOC entry 1911 (class 2606 OID 17832)
-- Dependencies: 162 162 1930
-- Name: cuenta_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cuenta
    ADD CONSTRAINT cuenta_pkey PRIMARY KEY (id);


--
-- TOC entry 1915 (class 2606 OID 17838)
-- Dependencies: 163 163 1930
-- Name: movimiento_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY movimiento
    ADD CONSTRAINT movimiento_pkey PRIMARY KEY (id);


--
-- TOC entry 1913 (class 2606 OID 17845)
-- Dependencies: 162 162 1930
-- Name: uk_hsp0g5b3ckv9kgikc6e85l1jb; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cuenta
    ADD CONSTRAINT uk_hsp0g5b3ckv9kgikc6e85l1jb UNIQUE (numero);


--
-- TOC entry 1917 (class 2606 OID 17843)
-- Dependencies: 164 164 1930
-- Name: usuario_rol_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY usuario_rol
    ADD CONSTRAINT usuario_rol_pkey PRIMARY KEY (id);


--
-- TOC entry 1918 (class 2606 OID 17846)
-- Dependencies: 1908 161 162 1930
-- Name: fk_2rroqx1jsp17a3x46shjtotqo; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cuenta
    ADD CONSTRAINT fk_2rroqx1jsp17a3x46shjtotqo FOREIGN KEY (cliente) REFERENCES cliente(id);


--
-- TOC entry 1920 (class 2606 OID 17856)
-- Dependencies: 161 1908 164 1930
-- Name: fk_anov4t0xy9nbli64yvk3cuy7g; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY usuario_rol
    ADD CONSTRAINT fk_anov4t0xy9nbli64yvk3cuy7g FOREIGN KEY (cliente) REFERENCES cliente(id);


--
-- TOC entry 1919 (class 2606 OID 17851)
-- Dependencies: 162 1910 163 1930
-- Name: fk_b0xw4jnhl6mv3slxxvrllpqad; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY movimiento
    ADD CONSTRAINT fk_b0xw4jnhl6mv3slxxvrllpqad FOREIGN KEY (cuenta) REFERENCES cuenta(id);


--
-- TOC entry 1935 (class 0 OID 0)
-- Dependencies: 5
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2013-08-16 03:12:04 COT

--
-- PostgreSQL database dump complete
--

