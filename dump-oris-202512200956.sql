--
-- PostgreSQL database dump
--

\restrict SfZjmf7UkXFhdLB7h3f4OQoohNN8UEvI7PNk2N5ijuZsJLDU55hgIhtakrSPOxw

-- Dumped from database version 16.10
-- Dumped by pg_dump version 16.10

-- Started on 2025-12-20 09:56:39

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 4902 (class 1262 OID 25515)
-- Name: oris; Type: DATABASE; Schema: -; Owner: user_owner
--

CREATE DATABASE oris WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Russian_Russia.1251';


ALTER DATABASE oris OWNER TO user_owner;

\unrestrict SfZjmf7UkXFhdLB7h3f4OQoohNN8UEvI7PNk2N5ijuZsJLDU55hgIhtakrSPOxw
\connect oris
\restrict SfZjmf7UkXFhdLB7h3f4OQoohNN8UEvI7PNk2N5ijuZsJLDU55hgIhtakrSPOxw

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 218 (class 1259 OID 25709)
-- Name: sessions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sessions (
    id integer NOT NULL,
    userid integer NOT NULL,
    expiresat timestamp without time zone NOT NULL
);


ALTER TABLE public.sessions OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 25728)
-- Name: sessions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.sessions ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.sessions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 215 (class 1259 OID 25669)
-- Name: tours; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tours (
    id integer NOT NULL,
    name character varying,
    origin character varying,
    status character varying,
    cost real,
    img character varying,
    tags character varying,
    datestart timestamp with time zone,
    dateend timestamp with time zone,
    destination character varying
);


ALTER TABLE public.tours OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 25689)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    login character varying NOT NULL,
    password bytea NOT NULL,
    salt bytea NOT NULL,
    isadmin boolean
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 25708)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.users ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 4895 (class 0 OID 25709)
-- Dependencies: 218
-- Data for Name: sessions; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.sessions OVERRIDING SYSTEM VALUE VALUES (13, 2, '2025-11-29 09:59:12.595727');
INSERT INTO public.sessions OVERRIDING SYSTEM VALUE VALUES (14, 2, '2025-11-29 11:26:10.532537');
INSERT INTO public.sessions OVERRIDING SYSTEM VALUE VALUES (15, 4, '2025-11-29 11:27:02.967482');
INSERT INTO public.sessions OVERRIDING SYSTEM VALUE VALUES (16, 2, '2025-12-04 01:44:49.889191');
INSERT INTO public.sessions OVERRIDING SYSTEM VALUE VALUES (18, 2, '2025-12-04 02:00:29.539654');
INSERT INTO public.sessions OVERRIDING SYSTEM VALUE VALUES (19, 2, '2025-12-04 06:30:10.29312');
INSERT INTO public.sessions OVERRIDING SYSTEM VALUE VALUES (20, 2, '2025-12-04 06:49:44.541065');
INSERT INTO public.sessions OVERRIDING SYSTEM VALUE VALUES (21, 2, '2025-12-05 05:55:02.057728');
INSERT INTO public.sessions OVERRIDING SYSTEM VALUE VALUES (24, 2, '2025-12-05 14:20:53.120836');
INSERT INTO public.sessions OVERRIDING SYSTEM VALUE VALUES (25, 2, '2025-12-06 03:41:31.917951');
INSERT INTO public.sessions OVERRIDING SYSTEM VALUE VALUES (26, 2, '2025-12-06 05:15:29.353165');
INSERT INTO public.sessions OVERRIDING SYSTEM VALUE VALUES (27, 2, '2025-12-06 06:14:45.940583');
INSERT INTO public.sessions OVERRIDING SYSTEM VALUE VALUES (28, 2, '2025-12-06 06:23:13.965037');
INSERT INTO public.sessions OVERRIDING SYSTEM VALUE VALUES (29, 2, '2025-12-11 16:35:04.846181');
INSERT INTO public.sessions OVERRIDING SYSTEM VALUE VALUES (30, 2, '2025-12-13 11:33:27.915419');


--
-- TOC entry 4892 (class 0 OID 25669)
-- Dependencies: 215
-- Data for Name: tours; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.tours VALUES (1, 'Réveillon 2026', 'Curitiba', 'Confirmada', 236.5, 'https://www.sescpr.com.br/wp-content/uploads/2019/12/bentogon%C3%A7alves-vnicola-rio-720x406.jpg', '["Feriados", "Lazer", "Viaja+ Família"]', '2026-03-12 11:00:00+03', '2026-03-12 11:00:00+03', 'Bento Gonçalves-RS');
INSERT INTO public.tours VALUES (3, 'sadaqwadasds', 'Curitiba', 'Confirmada', 12, 'https://www.sescpr.com.br/wp-content/uploads/2019/09/Colombo-Circ-Italiano-720x406.jpg', '["Feriados",
"Histórico cultural",
"Lazer",
"Passeio",
"Viaja+ Família",
"Viaje pelo Paraná!"]', '2026-03-27 14:00:00+03', '2026-03-27 14:00:00+03', NULL);
INSERT INTO public.tours VALUES (2, 'Buraco do Paddaad<div><br></div>', 'Perudo', 'Non', 214, 'https://www.sescpr.com.br/wp-content/uploads/2019/08/passeio-de-trem-foto-serra-verde-express-1508x706_c.jpg', NULL, '2026-03-27 14:00:00+03', '2026-03-27 14:00:00+03', 'Curitiba-PR');


--
-- TOC entry 4893 (class 0 OID 25689)
-- Dependencies: 216
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.users OVERRIDING SYSTEM VALUE VALUES (1, '123', '\xaa422434c5e43a715498368c246c47824be0372bb20c8c2f4349af91266cdd79', '\x0222b38fd4d35629eb0a88c3a3ce329f', true);
INSERT INTO public.users OVERRIDING SYSTEM VALUE VALUES (2, '12', '\x42ec7cc2f893ea8264c3d6dddf79bb9e5b2426ee57656941b891147a846172f6', '\x023136f33bed34ea739197aae039d6af', true);
INSERT INTO public.users OVERRIDING SYSTEM VALUE VALUES (3, '23', '\x9310a93ce660f4b7692d76e8117a35ad1e3f0b6f690f145053c358d7616a8079', '\xc7d2e358e315c30f170b193d9f0c2a15', false);
INSERT INTO public.users OVERRIDING SYSTEM VALUE VALUES (4, '1', '\x89b0941c6f4a1d4b20cc860820647fd9fb8c9aa41a5f0f32e01d1710a8243841', '\xbcc6864bc7dd46a221cb84f9545a06fd', false);


--
-- TOC entry 4903 (class 0 OID 0)
-- Dependencies: 219
-- Name: sessions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sessions_id_seq', 30, true);


--
-- TOC entry 4904 (class 0 OID 0)
-- Dependencies: 217
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 4, true);


--
-- TOC entry 4747 (class 2606 OID 25723)
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- TOC entry 4745 (class 2606 OID 25695)
-- Name: users users_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pk PRIMARY KEY (id);


--
-- TOC entry 4748 (class 2606 OID 25716)
-- Name: sessions sessions_userid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_userid_fkey FOREIGN KEY (userid) REFERENCES public.users(id);


-- Completed on 2025-12-20 09:56:39

--
-- PostgreSQL database dump complete
--

\unrestrict SfZjmf7UkXFhdLB7h3f4OQoohNN8UEvI7PNk2N5ijuZsJLDU55hgIhtakrSPOxw

