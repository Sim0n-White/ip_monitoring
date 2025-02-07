--
-- PostgreSQL database dump
--

-- Dumped from database version 15.10 (Debian 15.10-1.pgdg120+1)
-- Dumped by pg_dump version 15.10 (Debian 15.10-0+deb12u1)

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
-- Name: ip_checks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ip_checks (
    id integer NOT NULL,
    ip_id integer NOT NULL,
    rtt double precision,
    checked_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: ip_checks_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.ip_checks ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.ip_checks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: ips; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ips (
    id integer NOT NULL,
    ip inet NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: ips_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.ips ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.ips_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    filename text NOT NULL
);


--
-- Name: ip_checks ip_checks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ip_checks
    ADD CONSTRAINT ip_checks_pkey PRIMARY KEY (id);


--
-- Name: ips ips_ip_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ips
    ADD CONSTRAINT ips_ip_key UNIQUE (ip);


--
-- Name: ips ips_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ips
    ADD CONSTRAINT ips_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (filename);


--
-- Name: ips_ip_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ips_ip_index ON public.ips USING gist (ip inet_ops);


--
-- Name: ip_checks ip_checks_ip_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ip_checks
    ADD CONSTRAINT ip_checks_ip_id_fkey FOREIGN KEY (ip_id) REFERENCES public.ips(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO schema_migrations (filename) VALUES
('20250125223722_create_ips.rb'),
('20250126161100_ip_checks.rb');
