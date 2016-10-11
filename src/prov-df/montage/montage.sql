--
-- PostgreSQL database dump
--

-- Dumped from database version 9.3.5
-- Dumped by pg_dump version 9.3.1
-- Started on 2016-10-11 11:04:04 BRT

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 7 (class 2615 OID 960560)
-- Name: montage; Type: SCHEMA; Schema: -; Owner: chiron
--

CREATE SCHEMA montage;


ALTER SCHEMA montage OWNER TO chiron;

--
-- TOC entry 237 (class 3079 OID 12018)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2705 (class 0 OID 0)
-- Dependencies: 237
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- TOC entry 250 (class 1255 OID 959286)
-- Name: f_activation(integer, integer, integer, integer, integer, character varying, character varying, character varying, integer, text, text, timestamp with time zone, timestamp with time zone, character varying, timestamp with time zone, timestamp with time zone, timestamp with time zone, timestamp with time zone, timestamp with time zone, timestamp with time zone, timestamp with time zone, timestamp with time zone); Type: FUNCTION; Schema: public; Owner: vitor
--

CREATE FUNCTION f_activation(v_taskid integer, v_actid integer, v_machineid integer, v_processor integer, v_exitstatus integer, v_commandline character varying, v_folder character varying, v_subfolder character varying, v_failure_tries integer, v_terr text, v_tout text, v_starttime timestamp with time zone, v_endtime timestamp with time zone, v_status character varying, v_inststarttime timestamp with time zone, v_instendtime timestamp with time zone, v_compstarttime timestamp with time zone, v_compendtime timestamp with time zone, v_extstarttime timestamp with time zone, v_extendtime timestamp with time zone, v_loadingstarttime timestamp with time zone, v_loadingendtime timestamp with time zone) RETURNS integer
    LANGUAGE plpgsql
    AS $$
declare d_taskid integer;
begin
    select v_taskid into d_taskid;
 if (coalesce(d_taskid, 0) = 0) then
	select nextval('taskid_seq') into d_taskid;
        insert into eactivation(taskid, actid, machineid, processor, exitstatus, commandline, folder, subfolder, failure_tries, terr, tout, starttime, endtime, 
            status, instrumentationstarttime, instrumentationendtime, computingstarttime, computingendtime, extractorstarttime, extractorendtime, dataloadingstarttime, dataloadingendtime) 
        values(d_taskid, v_actid, v_machineid, v_processor, v_exitstatus, v_commandline, v_folder, v_subfolder, v_failure_tries, v_terr, v_tout, v_starttime, v_endtime, v_status, 
            v_inststarttime, v_instendtime, v_compstarttime, v_compendtime, v_extstarttime, v_extendtime, v_loadingstarttime, v_loadingendtime);
else
    update eactivation set actid = v_actid, machineid = v_machineid, processor = v_processor, exitstatus = v_exitstatus, commandline = v_commandline, folder = v_folder, 
        subfolder = v_subfolder, failure_tries = v_failure_tries, terr = v_terr, tout = v_tout, starttime = v_starttime, endtime = v_endtime, status = v_status, 
        instrumentationstarttime = v_inststarttime, instrumentationendtime = v_instendtime, computingstarttime = v_compstarttime, computingendtime = v_compendtime, 
        extractorstarttime = v_extstarttime, extractorendtime = v_extendtime, dataloadingstarttime = v_loadingstarttime, dataloadingendtime = v_loadingendtime where taskid = d_taskid;
end if;
 return d_taskid;
end;
$$;


ALTER FUNCTION public.f_activation(v_taskid integer, v_actid integer, v_machineid integer, v_processor integer, v_exitstatus integer, v_commandline character varying, v_folder character varying, v_subfolder character varying, v_failure_tries integer, v_terr text, v_tout text, v_starttime timestamp with time zone, v_endtime timestamp with time zone, v_status character varying, v_inststarttime timestamp with time zone, v_instendtime timestamp with time zone, v_compstarttime timestamp with time zone, v_compendtime timestamp with time zone, v_extstarttime timestamp with time zone, v_extendtime timestamp with time zone, v_loadingstarttime timestamp with time zone, v_loadingendtime timestamp with time zone) OWNER TO vitor;

--
-- TOC entry 251 (class 1255 OID 959287)
-- Name: f_activity(integer, integer, character varying, character varying, timestamp with time zone, timestamp with time zone, integer, character varying, character varying); Type: FUNCTION; Schema: public; Owner: vitor
--

CREATE FUNCTION f_activity(v_actid integer, v_wkfid integer, v_tag character varying, v_status character varying, v_starttime timestamp with time zone, v_endtime timestamp with time zone, v_cactid integer, v_templatedir character varying, v_constrained character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$
declare d_actid integer;
begin
 select v_actid into d_actid;
 if (coalesce(d_actid, 0) = 0) then
   select nextval('actid_seq') into d_actid;
   insert into eactivity(actid, wkfid, tag, status, starttime, endtime, cactid, templatedir, constrained) values(d_actid, v_wkfid, v_tag, v_status, v_starttime, v_endtime, v_cactid, v_templatedir, v_constrained);
 else 
   update eactivity set status = v_status, starttime = v_starttime, endtime = v_endtime, templatedir = v_templatedir, constrained = v_constrained where actid = d_actid;
 end if;
 return d_actid;
end;
$$;


ALTER FUNCTION public.f_activity(v_actid integer, v_wkfid integer, v_tag character varying, v_status character varying, v_starttime timestamp with time zone, v_endtime timestamp with time zone, v_cactid integer, v_templatedir character varying, v_constrained character varying) OWNER TO vitor;

--
-- TOC entry 252 (class 1255 OID 959288)
-- Name: f_cactivity(integer, integer, character varying, character varying, character varying, character varying, text, character varying); Type: FUNCTION; Schema: public; Owner: vitor
--

CREATE FUNCTION f_cactivity(v_actid integer, v_wkfid integer, v_tag character varying, v_atype character varying, v_description character varying, v_activation character varying, v_templatedir text, v_constrained character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$
declare d_actid integer;
begin
 select v_actid into d_actid;
 if (coalesce(d_actid, 0) = 0) then
   select nextval('actid_seq') into d_actid;
   insert into cactivity(actid, wkfid, tag, atype, description, activation, templatedir, constrained) values(d_actid, v_wkfid, v_tag, v_atype, v_description, v_activation, v_templatedir, v_constrained);
 else 
   update cactivity set atype = v_atype, description = v_description, templatedir = v_templatedir, activation = v_activation, constrained = v_constrained where actid = d_actid;
 end if;
 return d_actid;
end;
$$;


ALTER FUNCTION public.f_cactivity(v_actid integer, v_wkfid integer, v_tag character varying, v_atype character varying, v_description character varying, v_activation character varying, v_templatedir text, v_constrained character varying) OWNER TO vitor;

--
-- TOC entry 253 (class 1255 OID 959289)
-- Name: f_cextractor(integer, integer, character varying, character varying, character varying, character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: vitor
--

CREATE FUNCTION f_cextractor(v_extid integer, v_wkfid integer, v_name character varying, v_type character varying, v_cartridge character varying, v_search character varying, v_invocation character varying, v_delimiter character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$
declare d_extid integer;
begin
 select v_extid into d_extid;
 if (coalesce(d_extid, 0) = 0) then
   select nextval('extid_seq') into d_extid;
   insert into cextractor(extid, wkfid, name, type, cartridge, search, invocation, delimiter) 
	   values(d_extid, v_wkfid, v_name, v_type, v_cartridge, v_search, v_invocation, v_delimiter);
 else 
   update cextractor set name = v_name, type = v_type, cartridge = v_cartridge, search = v_search, 
	   invocation = v_invocation, delimiter = v_delimiter where extid = d_extid;
 end if;
 return d_extid;
end;
$$;


ALTER FUNCTION public.f_cextractor(v_extid integer, v_wkfid integer, v_name character varying, v_type character varying, v_cartridge character varying, v_search character varying, v_invocation character varying, v_delimiter character varying) OWNER TO vitor;

--
-- TOC entry 262 (class 1255 OID 959397)
-- Name: f_cmapping(integer, integer, integer); Type: FUNCTION; Schema: public; Owner: chiron
--

CREATE FUNCTION f_cmapping(v_relid integer, v_previousid integer, v_nextid integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
declare d_cmapid integer;
begin
select nextval('wkfid_seq') into d_cmapid;
 insert into cmapping(cmapid, crelid,previousid, nextid) values(d_cmapid, v_relid,v_previousid,v_nextid);
 return d_cmapid;
end;
$$;


ALTER FUNCTION public.f_cmapping(v_relid integer, v_previousid integer, v_nextid integer) OWNER TO chiron;

--
-- TOC entry 254 (class 1255 OID 959290)
-- Name: f_crelation(integer, character varying, character varying); Type: FUNCTION; Schema: public; Owner: vitor
--

CREATE FUNCTION f_crelation(v_wkfid integer, v_rtype character varying, v_rname character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$
declare d_relid integer;
begin
 select nextval('relid_seq') into d_relid;
 insert into crelation(wkfid,relid, rtype, rname) values(v_wkfid,d_relid, v_rtype, v_rname);
 return d_relid;
end;
$$;


ALTER FUNCTION public.f_crelation(v_wkfid integer, v_rtype character varying, v_rname character varying) OWNER TO vitor;

--
-- TOC entry 255 (class 1255 OID 959291)
-- Name: f_cworkflow(integer, character varying, character varying); Type: FUNCTION; Schema: public; Owner: vitor
--

CREATE FUNCTION f_cworkflow(v_wkfid integer, v_tag character varying, v_description character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$
declare d_wkfid integer;
begin
 select v_wkfid into d_wkfid;
 if (coalesce(d_wkfid, 0) = 0) then
   select nextval('wkfid_seq') into d_wkfid;
   insert into cworkflow(wkfid, tag, description) values(d_wkfid, v_tag, v_description);
 end if;
 return d_wkfid;
end;
$$;


ALTER FUNCTION public.f_cworkflow(v_wkfid integer, v_tag character varying, v_description character varying) OWNER TO vitor;

--
-- TOC entry 256 (class 1255 OID 959292)
-- Name: f_del_workflow(character varying); Type: FUNCTION; Schema: public; Owner: vitor
--

CREATE FUNCTION f_del_workflow(v_tagexec character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$
begin
    update eworkflow set tag = 'lixo' where tagexec = v_tagexec;
 return 0;
end;
$$;


ALTER FUNCTION public.f_del_workflow(v_tagexec character varying) OWNER TO vitor;

--
-- TOC entry 257 (class 1255 OID 959293)
-- Name: f_del_workflows(character varying); Type: FUNCTION; Schema: public; Owner: vitor
--

CREATE FUNCTION f_del_workflows(v_tag character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$
begin
	delete from efile where exists (
		select * from eactivity a, eworkflow w where a.actid = efile.actid	and a.wkfid = w.wkfid	and w.tag = v_tag	
	);

	delete from eactivation where actid in 
	(
		select a.actid	from eactivity a, eworkflow w where a.wkfid = w.wkfid and w.tag = v_tag
	);

	delete from efield where actid in (	
		select actid from eactivity a, eworkflow w where a.wkfid = w.wkfid and w.tag = v_tag
	);

	delete from erelation where actid in (
		select actid from eactivity a, eworkflow w where a.wkfid = w.wkfid and w.tag = v_tag );

	delete from eactivity where wkfid in (
		select w.wkfid	from eworkflow w where w.tag = v_tag);

	delete from eworkflow where tag = v_tag;
 return 0;
end;
$$;


ALTER FUNCTION public.f_del_workflows(v_tag character varying) OWNER TO vitor;

--
-- TOC entry 258 (class 1255 OID 959294)
-- Name: f_emachine(integer, character varying, character varying, double precision, character varying, double precision); Type: FUNCTION; Schema: public; Owner: vitor
--

CREATE FUNCTION f_emachine(v_machineid integer, v_hostname character varying, v_address character varying, v_mflopspersecond double precision, v_type character varying, v_financial_cost double precision) RETURNS integer
    LANGUAGE plpgsql
    AS $$
declare d_machineid integer;
begin
    select v_machineid into d_machineid;
 if (coalesce(d_machineid, 0) = 0) then
select nextval('machineid_seq') into d_machineid;
        insert into emachine(machineid, hostname, address, mflopspersecond, type, financial_cost) values(d_machineid, v_hostname, v_address, v_mflopspersecond, v_type, v_financial_cost);
else
    update emachine set hostname = v_hostname, address = v_address, mflopspersecond = v_mflopspersecond, type = v_type, financial_cost = v_financial_cost where machineid = d_machineid;
end if;
 return d_machineid;
end;
$$;


ALTER FUNCTION public.f_emachine(v_machineid integer, v_hostname character varying, v_address character varying, v_mflopspersecond double precision, v_type character varying, v_financial_cost double precision) OWNER TO vitor;

--
-- TOC entry 259 (class 1255 OID 959295)
-- Name: f_file(integer, integer, integer, character varying, character varying, character varying, character varying, integer, timestamp with time zone, character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: vitor
--

CREATE FUNCTION f_file(v_fileid integer, v_actid integer, v_taskid integer, v_ftemplate character varying, v_finstrumented character varying, v_fdir character varying, v_fname character varying, v_fsize integer, v_fdata timestamp with time zone, v_foper character varying, v_fieldname character varying, v_indexed character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$
declare d_fileid integer;
begin
    select v_fileid into d_fileid;
if (coalesce(d_fileid, 0) = 0) then
select nextval('fileid_seq') into d_fileid;
insert into efile(fileid, actid, taskid, fdir, fname, fsize, fdata, ftemplate, finstrumented, foper, fieldname, indexed) values(d_fileid, v_actid, v_taskid, v_fdir, v_fname, v_fsize, v_fdata, v_ftemplate, v_finstrumented, v_foper, v_fieldname, v_indexed);
else 
update efile set ftemplate = v_ftemplate, finstrumented = v_finstrumented, fdir = v_fdir, fname = v_fname, fsize = v_fsize, fdata = v_fdata, indexed = v_indexed where d_fileid = fileid;
end if;
return d_fileid;
end;
$$;


ALTER FUNCTION public.f_file(v_fileid integer, v_actid integer, v_taskid integer, v_ftemplate character varying, v_finstrumented character varying, v_fdir character varying, v_fname character varying, v_fsize integer, v_fdata timestamp with time zone, v_foper character varying, v_fieldname character varying, v_indexed character varying) OWNER TO vitor;

--
-- TOC entry 260 (class 1255 OID 959296)
-- Name: f_relation(integer, integer, character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: vitor
--

CREATE FUNCTION f_relation(v_relid integer, v_actid integer, v_rtype character varying, v_rname character varying, v_filename character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$
declare d_relid integer;
begin
 select v_relid into d_relid;
 if (d_relid is null) then
   select nextval('relid_seq') into d_relid;
   insert into erelation(relid, actid, rtype, rname, filename) values(d_relid, v_actid, v_rtype, v_rname, v_filename);
 end if;
 return d_relid;
end;
$$;


ALTER FUNCTION public.f_relation(v_relid integer, v_actid integer, v_rtype character varying, v_rname character varying, v_filename character varying) OWNER TO vitor;

--
-- TOC entry 261 (class 1255 OID 959297)
-- Name: f_workflow(integer, character varying, character varying, character varying, character varying, integer, character varying, double precision, character varying); Type: FUNCTION; Schema: public; Owner: vitor
--

CREATE FUNCTION f_workflow(v_wkfid integer, v_tag character varying, v_tagexec character varying, v_expdir character varying, v_wfdir character varying, v_maximumfailures integer, v_userinteraction character varying, v_reliability double precision, v_redundancy character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$
declare d_wkfid integer;
begin
 select v_wkfid into d_wkfid;
 if (coalesce(d_wkfid, 0) = 0) then
   select nextval('wkfid_seq') into d_wkfid;
   insert into eworkflow(ewkfid, tag, tagexec, expdir, wfdir, maximumfailures, userinteraction, reliability, redundancy) values(d_wkfid, v_tag, v_tagexec, v_expdir, v_wfdir, v_maximumfailures, v_userinteraction, v_reliability, v_redundancy);
 end if;
 return d_wkfid;
end;
$$;


ALTER FUNCTION public.f_workflow(v_wkfid integer, v_tag character varying, v_tagexec character varying, v_expdir character varying, v_wfdir character varying, v_maximumfailures integer, v_userinteraction character varying, v_reliability double precision, v_redundancy character varying) OWNER TO vitor;

SET search_path = montage, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 227 (class 1259 OID 960904)
-- Name: dlcalculatedifference; Type: TABLE; Schema: montage; Owner: chiron; Tablespace: 
--

CREATE TABLE dlcalculatedifference (
    ewkfid integer NOT NULL,
    taskid integer NOT NULL,
    id integer NOT NULL,
    rid integer DEFAULT nextval(('montage.dlcalculatedifference_seq'::text)::regclass) NOT NULL,
    diff_fits character varying(250),
    diff_area character varying(250)
);


ALTER TABLE montage.dlcalculatedifference OWNER TO chiron;

--
-- TOC entry 226 (class 1259 OID 960902)
-- Name: dlcalculatedifference_seq; Type: SEQUENCE; Schema: montage; Owner: chiron
--

CREATE SEQUENCE dlcalculatedifference_seq
    START WITH 0
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE montage.dlcalculatedifference_seq OWNER TO chiron;

--
-- TOC entry 219 (class 1259 OID 960794)
-- Name: dlcalculateoverlaps; Type: TABLE; Schema: montage; Owner: chiron; Tablespace: 
--

CREATE TABLE dlcalculateoverlaps (
    ewkfid integer NOT NULL,
    taskid integer NOT NULL,
    id integer NOT NULL,
    rid integer DEFAULT nextval(('montage.dlcalculateoverlaps_seq'::text)::regclass) NOT NULL,
    diffs_tbl character varying(250),
    diffs_path character varying(250)
);


ALTER TABLE montage.dlcalculateoverlaps OWNER TO chiron;

--
-- TOC entry 218 (class 1259 OID 960792)
-- Name: dlcalculateoverlaps_seq; Type: SEQUENCE; Schema: montage; Owner: chiron
--

CREATE SEQUENCE dlcalculateoverlaps_seq
    START WITH 0
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE montage.dlcalculateoverlaps_seq OWNER TO chiron;

--
-- TOC entry 235 (class 1259 OID 961024)
-- Name: dlcreatemosaic; Type: TABLE; Schema: montage; Owner: chiron; Tablespace: 
--

CREATE TABLE dlcreatemosaic (
    ewkfid integer NOT NULL,
    taskid integer NOT NULL,
    id integer NOT NULL,
    rid integer DEFAULT nextval(('montage.dlcreatemosaic_seq'::text)::regclass) NOT NULL,
    images_tbl character varying(250),
    mosaic_fits character varying(250),
    mosaic_area character varying(250),
    mosaic_jpg character varying(250)
);


ALTER TABLE montage.dlcreatemosaic OWNER TO chiron;

--
-- TOC entry 234 (class 1259 OID 961022)
-- Name: dlcreatemosaic_seq; Type: SEQUENCE; Schema: montage; Owner: chiron
--

CREATE SEQUENCE dlcreatemosaic_seq
    START WITH 0
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE montage.dlcreatemosaic_seq OWNER TO chiron;

--
-- TOC entry 215 (class 1259 OID 960752)
-- Name: dlcreateumosaic; Type: TABLE; Schema: montage; Owner: chiron; Tablespace: 
--

CREATE TABLE dlcreateumosaic (
    ewkfid integer NOT NULL,
    taskid integer NOT NULL,
    id integer NOT NULL,
    rid integer DEFAULT nextval(('montage.dlcreateumosaic_seq'::text)::regclass) NOT NULL,
    mosaic_jpg character varying(250)
);


ALTER TABLE montage.dlcreateumosaic OWNER TO chiron;

--
-- TOC entry 214 (class 1259 OID 960750)
-- Name: dlcreateumosaic_seq; Type: SEQUENCE; Schema: montage; Owner: chiron
--

CREATE SEQUENCE dlcreateumosaic_seq
    START WITH 0
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE montage.dlcreateumosaic_seq OWNER TO chiron;

--
-- TOC entry 223 (class 1259 OID 960849)
-- Name: dlextractdifferences; Type: TABLE; Schema: montage; Owner: chiron; Tablespace: 
--

CREATE TABLE dlextractdifferences (
    ewkfid integer NOT NULL,
    taskid integer NOT NULL,
    id integer NOT NULL,
    rid integer DEFAULT nextval(('montage.dlextractdifferences_seq'::text)::regclass) NOT NULL,
    cntr1 double precision,
    cntr2 double precision,
    plus character varying(250),
    plus_area character varying(250),
    minus character varying(250),
    minus_area character varying(250),
    diff character varying(250)
);


ALTER TABLE montage.dlextractdifferences OWNER TO chiron;

--
-- TOC entry 222 (class 1259 OID 960847)
-- Name: dlextractdifferences_seq; Type: SEQUENCE; Schema: montage; Owner: chiron
--

CREATE SEQUENCE dlextractdifferences_seq
    START WITH 0
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE montage.dlextractdifferences_seq OWNER TO chiron;

--
-- TOC entry 231 (class 1259 OID 960964)
-- Name: dlfitplane; Type: TABLE; Schema: montage; Owner: chiron; Tablespace: 
--

CREATE TABLE dlfitplane (
    ewkfid integer NOT NULL,
    taskid integer NOT NULL,
    id integer NOT NULL,
    rid integer DEFAULT nextval(('montage.dlfitplane_seq'::text)::regclass) NOT NULL,
    fa character varying(250),
    fb character varying(250),
    fc character varying(250),
    fcrpix1 double precision,
    fcrpix2 double precision,
    fxmin double precision,
    fxmax double precision,
    fymin double precision,
    fymax double precision,
    fxcenter double precision,
    fycenter double precision,
    fnpixel double precision,
    frms double precision,
    fboxx double precision,
    fboxy double precision,
    fboxwidth double precision,
    fboxheight double precision,
    fboxang double precision
);


ALTER TABLE montage.dlfitplane OWNER TO chiron;

--
-- TOC entry 230 (class 1259 OID 960962)
-- Name: dlfitplane_seq; Type: SEQUENCE; Schema: montage; Owner: chiron
--

CREATE SEQUENCE dlfitplane_seq
    START WITH 0
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE montage.dlfitplane_seq OWNER TO chiron;

--
-- TOC entry 203 (class 1259 OID 960582)
-- Name: dllistfits; Type: TABLE; Schema: montage; Owner: chiron; Tablespace: 
--

CREATE TABLE dllistfits (
    ewkfid integer NOT NULL,
    taskid integer NOT NULL,
    id integer NOT NULL,
    rid integer DEFAULT nextval(('montage.dllistfits_seq'::text)::regclass) NOT NULL,
    cntr double precision,
    ra double precision,
    "dec" double precision,
    cra character varying(250),
    cdec character varying(250),
    naxis1 double precision,
    naxis2 double precision,
    ctype1 character varying(250),
    ctype2 character varying(250),
    crpix1 double precision,
    crpix2 double precision,
    crval1 double precision,
    crval2 double precision,
    cdelt1 character varying(250),
    cdelt2 character varying(250),
    crota2 double precision,
    equinox double precision,
    size double precision,
    hdu double precision,
    fname character varying(250)
);


ALTER TABLE montage.dllistfits OWNER TO chiron;

--
-- TOC entry 202 (class 1259 OID 960580)
-- Name: dllistfits_seq; Type: SEQUENCE; Schema: montage; Owner: chiron
--

CREATE SEQUENCE dllistfits_seq
    START WITH 0
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE montage.dllistfits_seq OWNER TO chiron;

--
-- TOC entry 207 (class 1259 OID 960637)
-- Name: dlprojection; Type: TABLE; Schema: montage; Owner: chiron; Tablespace: 
--

CREATE TABLE dlprojection (
    ewkfid integer NOT NULL,
    taskid integer NOT NULL,
    id integer NOT NULL,
    rid integer DEFAULT nextval(('montage.dlprojection_seq'::text)::regclass) NOT NULL,
    hdu_area character varying(250),
    hdu_file character varying(250)
);


ALTER TABLE montage.dlprojection OWNER TO chiron;

--
-- TOC entry 206 (class 1259 OID 960635)
-- Name: dlprojection_seq; Type: SEQUENCE; Schema: montage; Owner: chiron
--

CREATE SEQUENCE dlprojection_seq
    START WITH 0
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE montage.dlprojection_seq OWNER TO chiron;

--
-- TOC entry 211 (class 1259 OID 960697)
-- Name: dlselectprojections; Type: TABLE; Schema: montage; Owner: chiron; Tablespace: 
--

CREATE TABLE dlselectprojections (
    ewkfid integer NOT NULL,
    taskid integer NOT NULL,
    id integer NOT NULL,
    rid integer DEFAULT nextval(('montage.dlselectprojections_seq'::text)::regclass) NOT NULL,
    mosaic_fits character varying(250),
    mosaic_area character varying(250)
);


ALTER TABLE montage.dlselectprojections OWNER TO chiron;

--
-- TOC entry 210 (class 1259 OID 960695)
-- Name: dlselectprojections_seq; Type: SEQUENCE; Schema: montage; Owner: chiron
--

CREATE SEQUENCE dlselectprojections_seq
    START WITH 0
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE montage.dlselectprojections_seq OWNER TO chiron;

--
-- TOC entry 200 (class 1259 OID 960563)
-- Name: ilistfits; Type: TABLE; Schema: montage; Owner: chiron; Tablespace: 
--

CREATE TABLE ilistfits (
    ewkfid integer NOT NULL,
    key integer DEFAULT nextval(('montage.ilistfits_seq'::text)::regclass) NOT NULL,
    taskid integer,
    mosaic_id double precision,
    region character varying(250),
    degrees double precision,
    header character varying(250)
);


ALTER TABLE montage.ilistfits OWNER TO chiron;

--
-- TOC entry 199 (class 1259 OID 960561)
-- Name: ilistfits_seq; Type: SEQUENCE; Schema: montage; Owner: chiron
--

CREATE SEQUENCE ilistfits_seq
    START WITH 0
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE montage.ilistfits_seq OWNER TO chiron;

--
-- TOC entry 228 (class 1259 OID 960923)
-- Name: ocalculatedifference; Type: TABLE; Schema: montage; Owner: chiron; Tablespace: 
--

CREATE TABLE ocalculatedifference (
    ewkfid integer NOT NULL,
    key integer DEFAULT nextval(('montage.ocalculatedifference_seq'::text)::regclass) NOT NULL,
    previousactid integer,
    nextactid integer,
    previoustaskid integer,
    nexttaskid integer,
    mosaic_id double precision,
    header character varying(250),
    dlextractdifferencesid integer,
    dlcalculatedifferenceid integer
);


ALTER TABLE montage.ocalculatedifference OWNER TO chiron;

--
-- TOC entry 225 (class 1259 OID 960900)
-- Name: ocalculatedifference_seq; Type: SEQUENCE; Schema: montage; Owner: chiron
--

CREATE SEQUENCE ocalculatedifference_seq
    START WITH 0
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE montage.ocalculatedifference_seq OWNER TO chiron;

--
-- TOC entry 220 (class 1259 OID 960813)
-- Name: ocalculateoverlaps; Type: TABLE; Schema: montage; Owner: chiron; Tablespace: 
--

CREATE TABLE ocalculateoverlaps (
    ewkfid integer NOT NULL,
    key integer DEFAULT nextval(('montage.ocalculateoverlaps_seq'::text)::regclass) NOT NULL,
    previousactid integer,
    nextactid integer,
    previoustaskid integer,
    nexttaskid integer,
    mosaic_id double precision,
    header character varying(250),
    dlcalculateoverlapsid integer
);


ALTER TABLE montage.ocalculateoverlaps OWNER TO chiron;

--
-- TOC entry 217 (class 1259 OID 960790)
-- Name: ocalculateoverlaps_seq; Type: SEQUENCE; Schema: montage; Owner: chiron
--

CREATE SEQUENCE ocalculateoverlaps_seq
    START WITH 0
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE montage.ocalculateoverlaps_seq OWNER TO chiron;

--
-- TOC entry 236 (class 1259 OID 961043)
-- Name: ocreatemosaic; Type: TABLE; Schema: montage; Owner: chiron; Tablespace: 
--

CREATE TABLE ocreatemosaic (
    ewkfid integer NOT NULL,
    key integer DEFAULT nextval(('montage.ocreatemosaic_seq'::text)::regclass) NOT NULL,
    taskid integer,
    mosaic_id double precision,
    header character varying(250),
    dlcreatemosaicid integer
);


ALTER TABLE montage.ocreatemosaic OWNER TO chiron;

--
-- TOC entry 233 (class 1259 OID 961020)
-- Name: ocreatemosaic_seq; Type: SEQUENCE; Schema: montage; Owner: chiron
--

CREATE SEQUENCE ocreatemosaic_seq
    START WITH 0
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE montage.ocreatemosaic_seq OWNER TO chiron;

--
-- TOC entry 216 (class 1259 OID 960768)
-- Name: ocreateumosaic; Type: TABLE; Schema: montage; Owner: chiron; Tablespace: 
--

CREATE TABLE ocreateumosaic (
    ewkfid integer NOT NULL,
    key integer DEFAULT nextval(('montage.ocreateumosaic_seq'::text)::regclass) NOT NULL,
    taskid integer,
    mosaic_id double precision,
    header character varying(250),
    dlcreateumosaicid integer
);


ALTER TABLE montage.ocreateumosaic OWNER TO chiron;

--
-- TOC entry 213 (class 1259 OID 960748)
-- Name: ocreateumosaic_seq; Type: SEQUENCE; Schema: montage; Owner: chiron
--

CREATE SEQUENCE ocreateumosaic_seq
    START WITH 0
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE montage.ocreateumosaic_seq OWNER TO chiron;

--
-- TOC entry 224 (class 1259 OID 960868)
-- Name: oextractdifferences; Type: TABLE; Schema: montage; Owner: chiron; Tablespace: 
--

CREATE TABLE oextractdifferences (
    ewkfid integer NOT NULL,
    key integer DEFAULT nextval(('montage.oextractdifferences_seq'::text)::regclass) NOT NULL,
    previousactid integer,
    nextactid integer,
    previoustaskid integer,
    nexttaskid integer,
    mosaic_id double precision,
    header character varying(250),
    dlextractdifferencesid integer
);


ALTER TABLE montage.oextractdifferences OWNER TO chiron;

--
-- TOC entry 221 (class 1259 OID 960845)
-- Name: oextractdifferences_seq; Type: SEQUENCE; Schema: montage; Owner: chiron
--

CREATE SEQUENCE oextractdifferences_seq
    START WITH 0
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE montage.oextractdifferences_seq OWNER TO chiron;

--
-- TOC entry 232 (class 1259 OID 960983)
-- Name: ofitplane; Type: TABLE; Schema: montage; Owner: chiron; Tablespace: 
--

CREATE TABLE ofitplane (
    ewkfid integer NOT NULL,
    key integer DEFAULT nextval(('montage.ofitplane_seq'::text)::regclass) NOT NULL,
    previousactid integer,
    nextactid integer,
    previoustaskid integer,
    nexttaskid integer,
    mosaic_id double precision,
    header character varying(250),
    dlextractdifferencesid integer,
    dlfitplaneid integer
);


ALTER TABLE montage.ofitplane OWNER TO chiron;

--
-- TOC entry 229 (class 1259 OID 960960)
-- Name: ofitplane_seq; Type: SEQUENCE; Schema: montage; Owner: chiron
--

CREATE SEQUENCE ofitplane_seq
    START WITH 0
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE montage.ofitplane_seq OWNER TO chiron;

--
-- TOC entry 204 (class 1259 OID 960601)
-- Name: olistfits; Type: TABLE; Schema: montage; Owner: chiron; Tablespace: 
--

CREATE TABLE olistfits (
    ewkfid integer NOT NULL,
    key integer DEFAULT nextval(('montage.olistfits_seq'::text)::regclass) NOT NULL,
    previousactid integer,
    nextactid integer,
    previoustaskid integer,
    nexttaskid integer,
    mosaic_id double precision,
    header character varying(250),
    dllistfitsid integer
);


ALTER TABLE montage.olistfits OWNER TO chiron;

--
-- TOC entry 201 (class 1259 OID 960578)
-- Name: olistfits_seq; Type: SEQUENCE; Schema: montage; Owner: chiron
--

CREATE SEQUENCE olistfits_seq
    START WITH 0
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE montage.olistfits_seq OWNER TO chiron;

--
-- TOC entry 208 (class 1259 OID 960656)
-- Name: oprojection; Type: TABLE; Schema: montage; Owner: chiron; Tablespace: 
--

CREATE TABLE oprojection (
    ewkfid integer NOT NULL,
    key integer DEFAULT nextval(('montage.oprojection_seq'::text)::regclass) NOT NULL,
    previousactid integer,
    nextactid integer,
    previoustaskid integer,
    nexttaskid integer,
    mosaic_id double precision,
    header character varying(250),
    dllistfitsid integer,
    dlprojectionid integer
);


ALTER TABLE montage.oprojection OWNER TO chiron;

--
-- TOC entry 205 (class 1259 OID 960633)
-- Name: oprojection_seq; Type: SEQUENCE; Schema: montage; Owner: chiron
--

CREATE SEQUENCE oprojection_seq
    START WITH 0
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE montage.oprojection_seq OWNER TO chiron;

--
-- TOC entry 212 (class 1259 OID 960716)
-- Name: oselectprojections; Type: TABLE; Schema: montage; Owner: chiron; Tablespace: 
--

CREATE TABLE oselectprojections (
    ewkfid integer NOT NULL,
    key integer DEFAULT nextval(('montage.oselectprojections_seq'::text)::regclass) NOT NULL,
    previousactid integer,
    nextactid integer,
    previoustaskid integer,
    nexttaskid integer,
    mosaic_id double precision,
    header character varying(250),
    dlselectprojectionsid integer
);


ALTER TABLE montage.oselectprojections OWNER TO chiron;

--
-- TOC entry 209 (class 1259 OID 960693)
-- Name: oselectprojections_seq; Type: SEQUENCE; Schema: montage; Owner: chiron
--

CREATE SEQUENCE oselectprojections_seq
    START WITH 0
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE montage.oselectprojections_seq OWNER TO chiron;

SET search_path = public, pg_catalog;

--
-- TOC entry 171 (class 1259 OID 959298)
-- Name: actid_seq; Type: SEQUENCE; Schema: public; Owner: vitor
--

CREATE SEQUENCE actid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.actid_seq OWNER TO vitor;

--
-- TOC entry 172 (class 1259 OID 959300)
-- Name: cactid_seq; Type: SEQUENCE; Schema: public; Owner: vitor
--

CREATE SEQUENCE cactid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cactid_seq OWNER TO vitor;

--
-- TOC entry 173 (class 1259 OID 959302)
-- Name: cactivity; Type: TABLE; Schema: public; Owner: vitor; Tablespace: 
--

CREATE TABLE cactivity (
    actid integer DEFAULT nextval(('cactid_seq'::text)::regclass) NOT NULL,
    wkfid integer NOT NULL,
    tag character varying(50) NOT NULL,
    atype character varying(25) NOT NULL,
    description character varying(250),
    activation text,
    constrained character varying(1),
    templatedir text
);


ALTER TABLE public.cactivity OWNER TO vitor;

--
-- TOC entry 174 (class 1259 OID 959309)
-- Name: cextractor; Type: TABLE; Schema: public; Owner: vitor; Tablespace: 
--

CREATE TABLE cextractor (
    extid integer DEFAULT nextval(('cextid_seq'::text)::regclass) NOT NULL,
    wkfid integer NOT NULL,
    name character varying(50) NOT NULL,
    type character varying(25) NOT NULL,
    cartridge character varying(20),
    search character varying(200),
    invocation text,
    delimiter character varying(20)
);


ALTER TABLE public.cextractor OWNER TO vitor;

--
-- TOC entry 176 (class 1259 OID 959319)
-- Name: cfield; Type: TABLE; Schema: public; Owner: vitor; Tablespace: 
--

CREATE TABLE cfield (
    fname character varying(40) NOT NULL,
    relid integer NOT NULL,
    ftype character varying(10) NOT NULL,
    decimalplaces integer,
    fileoperation character varying(20),
    instrumented character varying(5),
    extid integer
);


ALTER TABLE public.cfield OWNER TO vitor;

--
-- TOC entry 175 (class 1259 OID 959316)
-- Name: cjoin; Type: TABLE; Schema: public; Owner: vitor; Tablespace: 
--

CREATE TABLE cjoin (
    relid integer NOT NULL,
    innerextid integer NOT NULL,
    outerextid integer NOT NULL,
    fields character varying(200)
);


ALTER TABLE public.cjoin OWNER TO vitor;

--
-- TOC entry 191 (class 1259 OID 959398)
-- Name: cmapid_seq; Type: SEQUENCE; Schema: public; Owner: vitor
--

CREATE SEQUENCE cmapid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cmapid_seq OWNER TO vitor;

--
-- TOC entry 190 (class 1259 OID 959393)
-- Name: cmapping; Type: TABLE; Schema: public; Owner: vitor; Tablespace: 
--

CREATE TABLE cmapping (
    cmapid integer DEFAULT nextval(('cmapid_seq'::text)::regclass) NOT NULL,
    crelid integer NOT NULL,
    previousid integer,
    nextid integer
);


ALTER TABLE public.cmapping OWNER TO vitor;

--
-- TOC entry 177 (class 1259 OID 959322)
-- Name: coperand; Type: TABLE; Schema: public; Owner: vitor; Tablespace: 
--

CREATE TABLE coperand (
    opid integer DEFAULT nextval(('copid_seq'::text)::regclass) NOT NULL,
    actid integer NOT NULL,
    oname character varying(100),
    numericvalue double precision,
    textvalue character varying(100)
);


ALTER TABLE public.coperand OWNER TO vitor;

--
-- TOC entry 178 (class 1259 OID 959326)
-- Name: copid_seq; Type: SEQUENCE; Schema: public; Owner: vitor
--

CREATE SEQUENCE copid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.copid_seq OWNER TO vitor;

--
-- TOC entry 179 (class 1259 OID 959328)
-- Name: crelation; Type: TABLE; Schema: public; Owner: vitor; Tablespace: 
--

CREATE TABLE crelation (
    wkfid integer NOT NULL,
    relid integer DEFAULT nextval(('relid_seq'::text)::regclass) NOT NULL,
    rtype character varying(100),
    rname character varying(30)
);


ALTER TABLE public.crelation OWNER TO vitor;

--
-- TOC entry 180 (class 1259 OID 959332)
-- Name: cwkfid_seq; Type: SEQUENCE; Schema: public; Owner: vitor
--

CREATE SEQUENCE cwkfid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cwkfid_seq OWNER TO vitor;

--
-- TOC entry 181 (class 1259 OID 959334)
-- Name: cworkflow; Type: TABLE; Schema: public; Owner: vitor; Tablespace: 
--

CREATE TABLE cworkflow (
    wkfid integer DEFAULT nextval(('cwkfid_seq'::text)::regclass) NOT NULL,
    tag character varying(200) NOT NULL,
    description character varying(100)
);


ALTER TABLE public.cworkflow OWNER TO vitor;

--
-- TOC entry 182 (class 1259 OID 959338)
-- Name: eactivation; Type: TABLE; Schema: public; Owner: vitor; Tablespace: 
--

CREATE TABLE eactivation (
    taskid integer NOT NULL,
    actid integer NOT NULL,
    machineid integer,
    processor integer,
    exitstatus integer,
    commandline text,
    folder character varying(150),
    subfolder character varying(50),
    failure_tries integer,
    terr text,
    tout text,
    starttime timestamp with time zone,
    endtime timestamp with time zone,
    status character varying(25),
    instrumentationstarttime timestamp with time zone,
    instrumentationendtime timestamp with time zone,
    computingstarttime timestamp with time zone,
    computingendtime timestamp with time zone,
    extractorstarttime timestamp with time zone,
    extractorendtime timestamp with time zone,
    dataloadingstarttime timestamp with time zone,
    dataloadingendtime timestamp with time zone
);


ALTER TABLE public.eactivation OWNER TO vitor;

--
-- TOC entry 183 (class 1259 OID 959344)
-- Name: eactivity; Type: TABLE; Schema: public; Owner: vitor; Tablespace: 
--

CREATE TABLE eactivity (
    actid integer DEFAULT nextval(('cwkfid_seq'::text)::regclass) NOT NULL,
    wkfid integer NOT NULL,
    tag character varying(50) NOT NULL,
    status character varying(25),
    starttime timestamp with time zone,
    endtime timestamp with time zone,
    cactid integer,
    templatedir text,
    constrained character(1) DEFAULT 'F'::bpchar
);


ALTER TABLE public.eactivity OWNER TO vitor;

--
-- TOC entry 188 (class 1259 OID 959378)
-- Name: ecommperf; Type: TABLE; Schema: public; Owner: vitor; Tablespace: 
--

CREATE TABLE ecommperf (
    "time" real,
    sender integer,
    receiver integer,
    ewkfid integer,
    message text
);


ALTER TABLE public.ecommperf OWNER TO vitor;

--
-- TOC entry 187 (class 1259 OID 959375)
-- Name: ecompperf; Type: TABLE; Schema: public; Owner: vitor; Tablespace: 
--

CREATE TABLE ecompperf (
    "time" real,
    machineid integer,
    processor integer,
    ewkfid integer,
    taskid integer
);


ALTER TABLE public.ecompperf OWNER TO vitor;

--
-- TOC entry 184 (class 1259 OID 959352)
-- Name: efile; Type: TABLE; Schema: public; Owner: vitor; Tablespace: 
--

CREATE TABLE efile (
    fileid integer DEFAULT nextval(('fileid_seq'::text)::regclass) NOT NULL,
    actid integer NOT NULL,
    taskid integer,
    ftemplate character(1) DEFAULT 'F'::bpchar,
    finstrumented character(1) DEFAULT 'F'::bpchar,
    fdir character varying(500),
    fname character varying(500),
    fsize bigint,
    fdata timestamp with time zone,
    foper character varying(20),
    fieldname character varying(30),
    indexed character(1) DEFAULT 'F'::bpchar
);


ALTER TABLE public.efile OWNER TO vitor;

--
-- TOC entry 185 (class 1259 OID 959362)
-- Name: emachine; Type: TABLE; Schema: public; Owner: vitor; Tablespace: 
--

CREATE TABLE emachine (
    machineid integer DEFAULT nextval(('machineid_seq'::text)::regclass) NOT NULL,
    hostname character varying(250) NOT NULL,
    address character varying(250),
    mflopspersecond double precision,
    type character varying(250),
    financial_cost double precision
);


ALTER TABLE public.emachine OWNER TO vitor;

--
-- TOC entry 186 (class 1259 OID 959369)
-- Name: eprovperf; Type: TABLE; Schema: public; Owner: vitor; Tablespace: 
--

CREATE TABLE eprovperf (
    "time" real,
    machineid integer,
    ewkfid integer,
    function text
);


ALTER TABLE public.eprovperf OWNER TO vitor;

--
-- TOC entry 189 (class 1259 OID 959384)
-- Name: eworkflow; Type: TABLE; Schema: public; Owner: vitor; Tablespace: 
--

CREATE TABLE eworkflow (
    ewkfid integer DEFAULT nextval(('wkfid_seq'::text)::regclass) NOT NULL,
    tagexec character varying(200) NOT NULL,
    expdir character varying(150),
    wfdir character varying(200),
    tag character varying(200) NOT NULL,
    maximumfailures integer,
    userinteraction character(1) DEFAULT 'F'::bpchar,
    reliability double precision,
    redundancy character(1) DEFAULT 'F'::bpchar
);


ALTER TABLE public.eworkflow OWNER TO vitor;

--
-- TOC entry 192 (class 1259 OID 959400)
-- Name: extid_seq; Type: SEQUENCE; Schema: public; Owner: vitor
--

CREATE SEQUENCE extid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.extid_seq OWNER TO vitor;

--
-- TOC entry 193 (class 1259 OID 959402)
-- Name: fieldid_seq; Type: SEQUENCE; Schema: public; Owner: vitor
--

CREATE SEQUENCE fieldid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.fieldid_seq OWNER TO vitor;

--
-- TOC entry 194 (class 1259 OID 959404)
-- Name: fileid_seq; Type: SEQUENCE; Schema: public; Owner: vitor
--

CREATE SEQUENCE fileid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.fileid_seq OWNER TO vitor;

--
-- TOC entry 195 (class 1259 OID 959406)
-- Name: machineid_seq; Type: SEQUENCE; Schema: public; Owner: vitor
--

CREATE SEQUENCE machineid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.machineid_seq OWNER TO vitor;

--
-- TOC entry 196 (class 1259 OID 959408)
-- Name: relid_seq; Type: SEQUENCE; Schema: public; Owner: vitor
--

CREATE SEQUENCE relid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.relid_seq OWNER TO vitor;

--
-- TOC entry 197 (class 1259 OID 959410)
-- Name: taskid_seq; Type: SEQUENCE; Schema: public; Owner: vitor
--

CREATE SEQUENCE taskid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.taskid_seq OWNER TO vitor;

--
-- TOC entry 198 (class 1259 OID 959412)
-- Name: wkfid_seq; Type: SEQUENCE; Schema: public; Owner: vitor
--

CREATE SEQUENCE wkfid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wkfid_seq OWNER TO vitor;

SET search_path = montage, pg_catalog;

--
-- TOC entry 2688 (class 0 OID 960904)
-- Dependencies: 227
-- Data for Name: dlcalculatedifference; Type: TABLE DATA; Schema: montage; Owner: chiron
--

COPY dlcalculatedifference (ewkfid, taskid, id, rid, diff_fits, diff_area) FROM stdin;
39	17	10	1	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/142/281/192/0/diff.000000.000001.fits	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/142/281/192/0/diff.000000.000001_area.fits
39	18	10	3	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/250/193/1/diff.000000.000002.fits	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/250/193/1/diff.000000.000002_area.fits
39	19	10	5	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/249/808/2/diff.000000.000003.fits	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/249/808/2/diff.000000.000003_area.fits
39	20	10	7	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/157/657/3/diff.000001.000002.fits	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/157/657/3/diff.000001.000002_area.fits
39	21	10	9	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/157/382/4/diff.000002.000003.fits	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/157/382/4/diff.000002.000003_area.fits
39	22	10	11	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/065/293/5/diff.000002.000004.fits	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/065/293/5/diff.000002.000004_area.fits
39	24	10	13	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/064/629/7/diff.000003.000004.fits	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/064/629/7/diff.000003.000004_area.fits
39	23	10	15	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/064/909/6/diff.000002.000005.fits	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/064/909/6/diff.000002.000005_area.fits
39	25	10	17	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/973/038/8/diff.000004.000005.fits	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/973/038/8/diff.000004.000005_area.fits
39	26	10	19	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/972/848/9/diff.000004.000006.fits	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/972/848/9/diff.000004.000006_area.fits
39	27	10	21	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/880/223/10/diff.000004.000007.fits	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/880/223/10/diff.000004.000007_area.fits
39	28	10	23	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/787/685/11/diff.000005.000006.fits	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/787/685/11/diff.000005.000006_area.fits
39	29	10	25	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/695/606/12/diff.000006.000007.fits	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/695/606/12/diff.000006.000007_area.fits
39	30	10	27	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/695/410/13/diff.000006.000008.fits	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/695/410/13/diff.000006.000008_area.fits
39	31	10	29	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/603/056/14/diff.000006.000009.fits	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/603/056/14/diff.000006.000009_area.fits
39	32	10	31	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/511/372/15/diff.000007.000008.fits	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/511/372/15/diff.000007.000008_area.fits
39	33	10	33	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/511/181/16/diff.000008.000009.fits	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/511/181/16/diff.000008.000009_area.fits
\.


--
-- TOC entry 2718 (class 0 OID 0)
-- Dependencies: 226
-- Name: dlcalculatedifference_seq; Type: SEQUENCE SET; Schema: montage; Owner: chiron
--

SELECT pg_catalog.setval('dlcalculatedifference_seq', 35, false);


--
-- TOC entry 2680 (class 0 OID 960794)
-- Dependencies: 219
-- Data for Name: dlcalculateoverlaps; Type: TABLE DATA; Schema: montage; Owner: chiron
--

COPY dlcalculateoverlaps (ewkfid, taskid, id, rid, diffs_tbl, diffs_path) FROM stdin;
39	14	3	1	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateOverlaps/142/651/065/0/diffs.tbl	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateOverlaps/142/651/065/0
\.


--
-- TOC entry 2719 (class 0 OID 0)
-- Dependencies: 218
-- Name: dlcalculateoverlaps_seq; Type: SEQUENCE SET; Schema: montage; Owner: chiron
--

SELECT pg_catalog.setval('dlcalculateoverlaps_seq', 3, false);


--
-- TOC entry 2696 (class 0 OID 961024)
-- Dependencies: 235
-- Data for Name: dlcreatemosaic; Type: TABLE DATA; Schema: montage; Owner: chiron
--

COPY dlcreatemosaic (ewkfid, taskid, id, rid, images_tbl, mosaic_fits, mosaic_area, mosaic_jpg) FROM stdin;
39	51	5	1	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/images.tbl	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/mosaic_corrected.fits	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/mosaic_corrected_area.fits	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/mosaic_corrected.jpg
\.


--
-- TOC entry 2720 (class 0 OID 0)
-- Dependencies: 234
-- Name: dlcreatemosaic_seq; Type: SEQUENCE SET; Schema: montage; Owner: chiron
--

SELECT pg_catalog.setval('dlcreatemosaic_seq', 3, false);


--
-- TOC entry 2676 (class 0 OID 960752)
-- Dependencies: 215
-- Data for Name: dlcreateumosaic; Type: TABLE DATA; Schema: montage; Owner: chiron
--

COPY dlcreateumosaic (ewkfid, taskid, id, rid, mosaic_jpg) FROM stdin;
39	15	2	1	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateUncorrectedMosaic/142/650/960/0/mosaic_uncorrected.jpg
\.


--
-- TOC entry 2721 (class 0 OID 0)
-- Dependencies: 214
-- Name: dlcreateumosaic_seq; Type: SEQUENCE SET; Schema: montage; Owner: chiron
--

SELECT pg_catalog.setval('dlcreateumosaic_seq', 3, false);


--
-- TOC entry 2684 (class 0 OID 960849)
-- Dependencies: 223
-- Data for Name: dlextractdifferences; Type: TABLE DATA; Schema: montage; Owner: chiron
--

COPY dlextractdifferences (ewkfid, taskid, id, rid, cntr1, cntr2, plus, plus_area, minus, minus_area, diff) FROM stdin;
39	16	8	1	0	1	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/hdu0_2mass-atlas-990214n-j1100244.fits	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/hdu0_2mass-atlas-990214n-j1100244_area.fits	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/hdu0_2mass-atlas-990214n-j1100256.fits	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/hdu0_2mass-atlas-990214n-j1100256_area.fits	diff.000000.000001.fits
39	16	16	2	0	2	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/hdu0_2mass-atlas-990214n-j1100244.fits	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/hdu0_2mass-atlas-990214n-j1100244_area.fits	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/hdu0_2mass-atlas-990214n-j1110021.fits	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/hdu0_2mass-atlas-990214n-j1110021_area.fits	diff.000000.000002.fits
39	16	24	3	0	3	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/hdu0_2mass-atlas-990214n-j1100244.fits	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/hdu0_2mass-atlas-990214n-j1100244_area.fits	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/hdu0_2mass-atlas-990214n-j1110032.fits	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/hdu0_2mass-atlas-990214n-j1110032_area.fits	diff.000000.000003.fits
39	16	32	4	1	2	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/hdu0_2mass-atlas-990214n-j1100256.fits	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/hdu0_2mass-atlas-990214n-j1100256_area.fits	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/hdu0_2mass-atlas-990214n-j1110021.fits	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/hdu0_2mass-atlas-990214n-j1110021_area.fits	diff.000001.000002.fits
39	16	40	5	2	3	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/hdu0_2mass-atlas-990214n-j1110021.fits	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/hdu0_2mass-atlas-990214n-j1110021_area.fits	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/hdu0_2mass-atlas-990214n-j1110032.fits	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/hdu0_2mass-atlas-990214n-j1110032_area.fits	diff.000002.000003.fits
39	16	48	6	2	4	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/hdu0_2mass-atlas-990214n-j1110021.fits	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/hdu0_2mass-atlas-990214n-j1110021_area.fits	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/hdu0_2mass-atlas-990214n-j1180244.fits	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/hdu0_2mass-atlas-990214n-j1180244_area.fits	diff.000002.000004.fits
39	16	56	7	2	5	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/hdu0_2mass-atlas-990214n-j1110021.fits	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/hdu0_2mass-atlas-990214n-j1110021_area.fits	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/hdu0_2mass-atlas-990214n-j1180256.fits	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/hdu0_2mass-atlas-990214n-j1180256_area.fits	diff.000002.000005.fits
39	16	64	8	3	4	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/hdu0_2mass-atlas-990214n-j1110032.fits	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/hdu0_2mass-atlas-990214n-j1110032_area.fits	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/hdu0_2mass-atlas-990214n-j1180244.fits	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/hdu0_2mass-atlas-990214n-j1180244_area.fits	diff.000003.000004.fits
39	16	72	9	4	5	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/hdu0_2mass-atlas-990214n-j1180244.fits	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/hdu0_2mass-atlas-990214n-j1180244_area.fits	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/hdu0_2mass-atlas-990214n-j1180256.fits	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/hdu0_2mass-atlas-990214n-j1180256_area.fits	diff.000004.000005.fits
39	16	80	10	4	6	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/hdu0_2mass-atlas-990214n-j1180244.fits	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/hdu0_2mass-atlas-990214n-j1180244_area.fits	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/hdu0_2mass-atlas-990214n-j1190021.fits	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/hdu0_2mass-atlas-990214n-j1190021_area.fits	diff.000004.000006.fits
39	16	88	11	4	7	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/hdu0_2mass-atlas-990214n-j1180244.fits	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/hdu0_2mass-atlas-990214n-j1180244_area.fits	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/hdu0_2mass-atlas-990214n-j1190032.fits	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/hdu0_2mass-atlas-990214n-j1190032_area.fits	diff.000004.000007.fits
39	16	96	12	5	6	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/hdu0_2mass-atlas-990214n-j1180256.fits	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/hdu0_2mass-atlas-990214n-j1180256_area.fits	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/hdu0_2mass-atlas-990214n-j1190021.fits	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/hdu0_2mass-atlas-990214n-j1190021_area.fits	diff.000005.000006.fits
39	16	104	13	6	7	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/hdu0_2mass-atlas-990214n-j1190021.fits	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/hdu0_2mass-atlas-990214n-j1190021_area.fits	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/hdu0_2mass-atlas-990214n-j1190032.fits	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/hdu0_2mass-atlas-990214n-j1190032_area.fits	diff.000006.000007.fits
39	16	112	14	6	8	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/hdu0_2mass-atlas-990214n-j1190021.fits	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/hdu0_2mass-atlas-990214n-j1190021_area.fits	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/hdu0_2mass-atlas-990214n-j1200244.fits	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/hdu0_2mass-atlas-990214n-j1200244_area.fits	diff.000006.000008.fits
39	16	120	15	6	9	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/hdu0_2mass-atlas-990214n-j1190021.fits	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/hdu0_2mass-atlas-990214n-j1190021_area.fits	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/hdu0_2mass-atlas-990214n-j1200256.fits	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/hdu0_2mass-atlas-990214n-j1200256_area.fits	diff.000006.000009.fits
39	16	128	16	7	8	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/hdu0_2mass-atlas-990214n-j1190032.fits	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/hdu0_2mass-atlas-990214n-j1190032_area.fits	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/hdu0_2mass-atlas-990214n-j1200244.fits	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/hdu0_2mass-atlas-990214n-j1200244_area.fits	diff.000007.000008.fits
39	16	136	17	8	9	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/hdu0_2mass-atlas-990214n-j1200244.fits	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/hdu0_2mass-atlas-990214n-j1200244_area.fits	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/hdu0_2mass-atlas-990214n-j1200256.fits	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/hdu0_2mass-atlas-990214n-j1200256_area.fits	diff.000008.000009.fits
\.


--
-- TOC entry 2722 (class 0 OID 0)
-- Dependencies: 222
-- Name: dlextractdifferences_seq; Type: SEQUENCE SET; Schema: montage; Owner: chiron
--

SELECT pg_catalog.setval('dlextractdifferences_seq', 19, false);


--
-- TOC entry 2692 (class 0 OID 960964)
-- Dependencies: 231
-- Data for Name: dlfitplane; Type: TABLE DATA; Schema: montage; Owner: chiron
--

COPY dlfitplane (ewkfid, taskid, id, rid, fa, fb, fc, fcrpix1, fcrpix2, fxmin, fxmax, fymin, fymax, fxcenter, fycenter, fnpixel, frms, fboxx, fboxy, fboxwidth, fboxheight, fboxang) FROM stdin;
39	35	25	1	0.00213027	-0.000615025	3.87724	-614	124	614	685	-124	126	648.846000000000004	1.48641000000000001	14861	0.520731999999999973	650	1.5	251	72	90
39	34	25	3	6.50671e-08	1.63239e-06	6.8477e-05	-615	124	615	1120	-124	-69	868.120999999999981	-96.332800000000006	24600	0.00393876000000000035	867.5	-96	56	505	90
39	36	25	5	0.000987035	-0.000330065	4.5589	-610	-74	610	684	74	899	647.225999999999999	487.704999999999984	49692	0.528750999999999971	647.5	486.5	825	75	90
39	38	25	7	-1.50126e-07	-5.20262e-07	0.000135533	-179	-73	180	683	73	126	432.557999999999993	99.9599000000000046	24708	0.00371888999999999987	431	100	54	504	90
39	37	25	9	-0.000102652	8.62256e-05	5.37755	-614	896	615	686	-896	-71	650.687000000000012	-479.875	47439	0.532302000000000053	650.5	-483.5	825	73	90
39	39	25	11	-0.000157252	-0.000439582	1.32152	-178	129	179	253	-129	126	215.090000000000003	-0.330805000000000016	15689	0.539683000000000024	216	-1.5	255	76	90
39	40	25	13	0.000448046	9.96959e-06	1.04942	-177	-73	177	254	73	894	215.12299999999999	485.444999999999993	51199	0.521795000000000009	215.5	483.5	821	77	90
39	41	25	15	-0.000873928	0.000288798	1.42894	-179	897	179	253	-897	-76	215.832999999999998	-486.333000000000027	49180	0.538727999999999985	216	-486.5	821	74	90
39	42	25	17	4.61908e-07	2.62075e-06	0.000295785	253	129	-253	252	-129	-76	-2.53503999999999996	-102.003	24712	0.00379372999999999993	0	-102	54	506	90
39	43	25	19	0.000624353	-0.000340073	4.36633	253	129	-252	-181	-128	125	-217.342999999999989	-1.32139999999999991	15357	0.499234000000000011	-216.5	-2	254	73	90
39	44	25	21	0.00067979	0.000288485	4.30856	254	-72	-253	-178	72	894	-216.244	485.48399999999998	50244	0.497041000000000011	-215	483.5	823	78	90
39	45	25	23	0.000926855	-0.00112872	4.22587	254	898	-253	-182	-898	-76	-218.628999999999991	-484.223000000000013	48835	0.516368000000000049	-217.5	-486.5	823	73	90
39	46	25	25	-8.58607e-09	-9.55297e-07	0.00010021	686	-72	-686	-181	72	126	-434.678999999999974	99.4590000000000032	24730	0.00346252000000000018	-433.5	99.5	55	505	90
39	47	25	27	0.00115409	-0.000596721	-3.95474	687	124	-687	-612	-123	126	-649.918000000000006	1.17060999999999993	15485	0.497321999999999986	-649	1.5	251	76	90
39	48	25	29	-0.000686467	0.000475295	-5.10481	690	897	-690	-614	-896	-71	-652.719000000000051	-480.548000000000002	49537	0.489680000000000004	-651.5	-483.5	827	77	90
39	50	25	31	7.21129e-08	1.83438e-07	0.000105624	1119	124	-1119	-614	-123	-68	-865.458999999999946	-95.6847999999999956	24736	0.0036845799999999998	-866	-95.5	57	506	90
39	49	25	33	-0.000847073	0.00038928	-5.22045	686	-73	-686	-607	74	899	-647.322000000000003	488.922000000000025	52760	0.515654999999999974	-646	486.5	827	80	90
\.


--
-- TOC entry 2723 (class 0 OID 0)
-- Dependencies: 230
-- Name: dlfitplane_seq; Type: SEQUENCE SET; Schema: montage; Owner: chiron
--

SELECT pg_catalog.setval('dlfitplane_seq', 35, false);


--
-- TOC entry 2664 (class 0 OID 960582)
-- Dependencies: 203
-- Data for Name: dllistfits; Type: TABLE DATA; Schema: montage; Owner: chiron
--

COPY dllistfits (ewkfid, taskid, id, rid, cntr, ra, "dec", cra, cdec, naxis1, naxis2, ctype1, ctype2, crpix1, crpix2, crval1, crval2, cdelt1, cdelt2, crota2, equinox, size, hdu, fname) FROM stdin;
39	2	21	1	0	210.422085100000004	54.4751806000000016	14h_01m_41.30s	+54d_28m_30.7s	512	1024	RA---SIN	DEC--SIN	256.5	512.5	210.42184610000001	54.4753194999999977	-2.7777778450e-04	2.7777778450e-04	359.995694000000015	2000	2111040	0	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ListFits/251/286/114/0/2mass-atlas-990214n-j1100244.fits
39	2	42	2	1	210.422048899999993	54.2057361000000029	14h_01m_41.29s	+54d_12m_20.7s	512	1024	RA---SIN	DEC--SIN	256.5	512.5	210.42181149999999	54.2058749999999989	-2.7777778450e-04	2.7777778450e-04	359.995722199999989	2000	2111040	0	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ListFits/251/286/114/0/2mass-atlas-990214n-j1100256.fits
39	2	63	3	2	210.629465199999999	54.2606840999999989	14h_02m_31.07s	+54d_15m_38.5s	512	1024	RA---SIN	DEC--SIN	256.5	512.5	210.629227399999991	54.260823000000002	-2.7777778450e-04	2.7777778450e-04	0.00257660000000000007	2000	2111040	0	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ListFits/251/286/114/0/2mass-atlas-990214n-j1110021.fits
39	2	84	4	3	210.629446000000002	54.5301285999999976	14h_02m_31.07s	+54d_31m_48.5s	512	1024	RA---SIN	DEC--SIN	256.5	512.5	210.629206600000003	54.5302673999999996	-2.7777778450e-04	2.7777778450e-04	0.00259360000000000016	2000	2111040	0	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ListFits/251/286/114/0/2mass-atlas-990214n-j1110032.fits
39	2	105	5	4	210.835550799999993	54.4740195999999983	14h_03m_20.53s	+54d_28m_26.5s	512	1024	RA---SIN	DEC--SIN	256.5	512.5	210.835311799999999	54.4741585000000015	-2.7777778450e-04	2.7777778450e-04	0.00406489999999999976	2000	2111040	0	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ListFits/251/286/114/0/2mass-atlas-990214n-j1180244.fits
39	2	126	6	5	210.835581999999988	54.2045750999999996	14h_03m_20.54s	+54d_12m_16.5s	512	1024	RA---SIN	DEC--SIN	256.5	512.5	210.835344499999991	54.2047140000000027	-2.7777778450e-04	2.7777778450e-04	0.00403840000000000015	2000	2111040	0	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ListFits/251/286/114/0/2mass-atlas-990214n-j1180256.fits
39	2	147	7	6	211.041955900000005	54.2603063000000034	14h_04m_10.07s	+54d_15m_37.1s	512	1024	RA---SIN	DEC--SIN	256.5	512.5	211.041718099999997	54.2604451999999995	-2.7777778450e-04	2.7777778450e-04	0.00685499999999999998	2000	2111040	0	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ListFits/251/286/114/0/2mass-atlas-990214n-j1190021.fits
39	2	168	8	7	211.041901999999993	54.5297508000000022	14h_04m_10.06s	+54d_31m_47.1s	512	1024	RA---SIN	DEC--SIN	256.5	512.5	211.041662599999995	54.5298896999999982	-2.7777778450e-04	2.7777778450e-04	0.00690010000000000016	2000	2111040	0	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ListFits/251/286/114/0/2mass-atlas-990214n-j1190032.fits
39	2	189	9	8	211.247842300000002	54.4749127999999985	14h_04m_59.48s	+54d_28m_29.7s	512	1024	RA---SIN	DEC--SIN	256.5	512.5	211.247603300000009	54.4750517000000016	-2.7777778450e-04	2.7777778450e-04	0.0052490999999999996	2000	2111040	0	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ListFits/251/286/114/0/2mass-atlas-990214n-j1200244.fits
39	2	210	10	9	211.247883000000002	54.2054684000000009	14h_04m_59.49s	+54d_12m_19.7s	512	1024	RA---SIN	DEC--SIN	256.5	512.5	211.247645500000004	54.2056072000000029	-2.7777778450e-04	2.7777778450e-04	0.00521480000000000034	2000	2111040	0	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ListFits/251/286/114/0/2mass-atlas-990214n-j1200256.fits
\.


--
-- TOC entry 2724 (class 0 OID 0)
-- Dependencies: 202
-- Name: dllistfits_seq; Type: SEQUENCE SET; Schema: montage; Owner: chiron
--

SELECT pg_catalog.setval('dllistfits_seq', 12, false);


--
-- TOC entry 2668 (class 0 OID 960637)
-- Dependencies: 207
-- Data for Name: dlprojection; Type: TABLE DATA; Schema: montage; Owner: chiron
--

COPY dlprojection (ewkfid, taskid, id, rid, hdu_area, hdu_file) FROM stdin;
39	5	23	1	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/209/599/2/hdu0_2mass-atlas-990214n-j1110021.fits	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/209/599/2/hdu0_2mass-atlas-990214n-j1110021_area.fits
39	3	23	3	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/209/505/0/hdu0_2mass-atlas-990214n-j1100244.fits	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/209/505/0/hdu0_2mass-atlas-990214n-j1100244_area.fits
39	4	23	5	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/209/541/1/hdu0_2mass-atlas-990214n-j1100256.fits	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/209/541/1/hdu0_2mass-atlas-990214n-j1100256_area.fits
39	6	23	7	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/209/635/3/hdu0_2mass-atlas-990214n-j1110032.fits	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/209/635/3/hdu0_2mass-atlas-990214n-j1110032_area.fits
39	7	23	9	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/210/346/4/hdu0_2mass-atlas-990214n-j1180244.fits	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/210/346/4/hdu0_2mass-atlas-990214n-j1180244_area.fits
39	8	23	11	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/211/580/5/hdu0_2mass-atlas-990214n-j1180256.fits	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/211/580/5/hdu0_2mass-atlas-990214n-j1180256_area.fits
39	10	23	13	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/212/325/7/hdu0_2mass-atlas-990214n-j1190032.fits	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/212/325/7/hdu0_2mass-atlas-990214n-j1190032_area.fits
39	9	23	15	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/212/265/6/hdu0_2mass-atlas-990214n-j1190021.fits	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/212/265/6/hdu0_2mass-atlas-990214n-j1190021_area.fits
39	11	23	17	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/212/359/8/hdu0_2mass-atlas-990214n-j1200244.fits	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/212/359/8/hdu0_2mass-atlas-990214n-j1200244_area.fits
39	12	23	19	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/212/418/9/hdu0_2mass-atlas-990214n-j1200256.fits	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/212/418/9/hdu0_2mass-atlas-990214n-j1200256_area.fits
\.


--
-- TOC entry 2725 (class 0 OID 0)
-- Dependencies: 206
-- Name: dlprojection_seq; Type: SEQUENCE SET; Schema: montage; Owner: chiron
--

SELECT pg_catalog.setval('dlprojection_seq', 21, false);


--
-- TOC entry 2672 (class 0 OID 960697)
-- Dependencies: 211
-- Data for Name: dlselectprojections; Type: TABLE DATA; Schema: montage; Owner: chiron
--

COPY dlselectprojections (ewkfid, taskid, id, rid, mosaic_fits, mosaic_area) FROM stdin;
39	13	3	1	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/SelectProjections/145/236/741/0/m101_uncorrected.fits	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/SelectProjections/145/236/741/0/m101_uncorrected_area.fits
\.


--
-- TOC entry 2726 (class 0 OID 0)
-- Dependencies: 210
-- Name: dlselectprojections_seq; Type: SEQUENCE SET; Schema: montage; Owner: chiron
--

SELECT pg_catalog.setval('dlselectprojections_seq', 3, false);


--
-- TOC entry 2661 (class 0 OID 960563)
-- Dependencies: 200
-- Data for Name: ilistfits; Type: TABLE DATA; Schema: montage; Owner: chiron
--

COPY ilistfits (ewkfid, key, taskid, mosaic_id, region, degrees, header) FROM stdin;
39	1	2	1	m101	1	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/template/template_m101_1.00d.hdr
\.


--
-- TOC entry 2727 (class 0 OID 0)
-- Dependencies: 199
-- Name: ilistfits_seq; Type: SEQUENCE SET; Schema: montage; Owner: chiron
--

SELECT pg_catalog.setval('ilistfits_seq', 1, true);


--
-- TOC entry 2689 (class 0 OID 960923)
-- Dependencies: 228
-- Data for Name: ocalculatedifference; Type: TABLE DATA; Schema: montage; Owner: chiron
--

COPY ocalculatedifference (ewkfid, key, previousactid, nextactid, previoustaskid, nexttaskid, mosaic_id, header, dlextractdifferencesid, dlcalculatedifferenceid) FROM stdin;
39	1	52	53	17	34	1	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/142/281/192/0/template_m101_1.00d.hdr	1	1
39	2	52	53	18	35	1	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/250/193/1/template_m101_1.00d.hdr	2	3
39	3	52	53	19	36	1	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/249/808/2/template_m101_1.00d.hdr	3	5
39	4	52	53	20	37	1	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/157/657/3/template_m101_1.00d.hdr	4	7
39	5	52	53	21	38	1	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/157/382/4/template_m101_1.00d.hdr	5	9
39	6	52	53	22	39	1	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/065/293/5/template_m101_1.00d.hdr	6	11
39	7	52	53	24	40	1	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/064/629/7/template_m101_1.00d.hdr	8	13
39	8	52	53	23	41	1	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/064/909/6/template_m101_1.00d.hdr	7	15
39	9	52	53	25	42	1	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/973/038/8/template_m101_1.00d.hdr	9	17
39	10	52	53	26	43	1	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/972/848/9/template_m101_1.00d.hdr	10	19
39	11	52	53	27	44	1	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/880/223/10/template_m101_1.00d.hdr	11	21
39	12	52	53	28	45	1	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/787/685/11/template_m101_1.00d.hdr	12	23
39	13	52	53	29	46	1	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/695/606/12/template_m101_1.00d.hdr	13	25
39	14	52	53	30	47	1	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/695/410/13/template_m101_1.00d.hdr	14	27
39	15	52	53	31	48	1	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/603/056/14/template_m101_1.00d.hdr	15	29
39	16	52	53	32	49	1	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/511/372/15/template_m101_1.00d.hdr	16	31
39	17	52	53	33	50	1	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/511/181/16/template_m101_1.00d.hdr	17	33
\.


--
-- TOC entry 2728 (class 0 OID 0)
-- Dependencies: 225
-- Name: ocalculatedifference_seq; Type: SEQUENCE SET; Schema: montage; Owner: chiron
--

SELECT pg_catalog.setval('ocalculatedifference_seq', 17, true);


--
-- TOC entry 2681 (class 0 OID 960813)
-- Dependencies: 220
-- Data for Name: ocalculateoverlaps; Type: TABLE DATA; Schema: montage; Owner: chiron
--

COPY ocalculateoverlaps (ewkfid, key, previousactid, nextactid, previoustaskid, nexttaskid, mosaic_id, header, dlcalculateoverlapsid) FROM stdin;
39	1	50	51	14	16	1	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateOverlaps/142/651/065/0/template_m101_1.00d.hdr	1
\.


--
-- TOC entry 2729 (class 0 OID 0)
-- Dependencies: 217
-- Name: ocalculateoverlaps_seq; Type: SEQUENCE SET; Schema: montage; Owner: chiron
--

SELECT pg_catalog.setval('ocalculateoverlaps_seq', 1, true);


--
-- TOC entry 2697 (class 0 OID 961043)
-- Dependencies: 236
-- Data for Name: ocreatemosaic; Type: TABLE DATA; Schema: montage; Owner: chiron
--

COPY ocreatemosaic (ewkfid, key, taskid, mosaic_id, header, dlcreatemosaicid) FROM stdin;
39	1	51	1	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/template_m101_1.00d.hdr	1
\.


--
-- TOC entry 2730 (class 0 OID 0)
-- Dependencies: 233
-- Name: ocreatemosaic_seq; Type: SEQUENCE SET; Schema: montage; Owner: chiron
--

SELECT pg_catalog.setval('ocreatemosaic_seq', 1, true);


--
-- TOC entry 2677 (class 0 OID 960768)
-- Dependencies: 216
-- Data for Name: ocreateumosaic; Type: TABLE DATA; Schema: montage; Owner: chiron
--

COPY ocreateumosaic (ewkfid, key, taskid, mosaic_id, header, dlcreateumosaicid) FROM stdin;
39	1	15	1	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateUncorrectedMosaic/142/650/960/0/template_m101_1.00d.hdr	1
\.


--
-- TOC entry 2731 (class 0 OID 0)
-- Dependencies: 213
-- Name: ocreateumosaic_seq; Type: SEQUENCE SET; Schema: montage; Owner: chiron
--

SELECT pg_catalog.setval('ocreateumosaic_seq', 1, true);


--
-- TOC entry 2685 (class 0 OID 960868)
-- Dependencies: 224
-- Data for Name: oextractdifferences; Type: TABLE DATA; Schema: montage; Owner: chiron
--

COPY oextractdifferences (ewkfid, key, previousactid, nextactid, previoustaskid, nexttaskid, mosaic_id, header, dlextractdifferencesid) FROM stdin;
39	1	51	52	16	17	1	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/template_m101_1.00d.hdr	1
39	2	51	52	16	18	1	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/template_m101_1.00d.hdr	2
39	3	51	52	16	19	1	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/template_m101_1.00d.hdr	3
39	4	51	52	16	20	1	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/template_m101_1.00d.hdr	4
39	5	51	52	16	21	1	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/template_m101_1.00d.hdr	5
39	6	51	52	16	22	1	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/template_m101_1.00d.hdr	6
39	7	51	52	16	23	1	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/template_m101_1.00d.hdr	7
39	8	51	52	16	24	1	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/template_m101_1.00d.hdr	8
39	9	51	52	16	25	1	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/template_m101_1.00d.hdr	9
39	10	51	52	16	26	1	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/template_m101_1.00d.hdr	10
39	11	51	52	16	27	1	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/template_m101_1.00d.hdr	11
39	12	51	52	16	28	1	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/template_m101_1.00d.hdr	12
39	13	51	52	16	29	1	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/template_m101_1.00d.hdr	13
39	14	51	52	16	30	1	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/template_m101_1.00d.hdr	14
39	15	51	52	16	31	1	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/template_m101_1.00d.hdr	15
39	16	51	52	16	32	1	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/template_m101_1.00d.hdr	16
39	17	51	52	16	33	1	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/template_m101_1.00d.hdr	17
\.


--
-- TOC entry 2732 (class 0 OID 0)
-- Dependencies: 221
-- Name: oextractdifferences_seq; Type: SEQUENCE SET; Schema: montage; Owner: chiron
--

SELECT pg_catalog.setval('oextractdifferences_seq', 17, true);


--
-- TOC entry 2693 (class 0 OID 960983)
-- Dependencies: 232
-- Data for Name: ofitplane; Type: TABLE DATA; Schema: montage; Owner: chiron
--

COPY ofitplane (ewkfid, key, previousactid, nextactid, previoustaskid, nexttaskid, mosaic_id, header, dlextractdifferencesid, dlfitplaneid) FROM stdin;
39	1	53	54	35	51	1	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/139/418/159/1/template_m101_1.00d.hdr	2	1
39	2	53	54	34	51	1	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/139/418/165/0/template_m101_1.00d.hdr	1	3
39	3	53	54	36	51	1	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/139/418/153/2/template_m101_1.00d.hdr	3	5
39	4	53	54	38	51	1	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/807/4/template_m101_1.00d.hdr	5	7
39	5	53	54	37	51	1	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/387/290/3/template_m101_1.00d.hdr	4	9
39	6	53	54	39	51	1	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/797/5/template_m101_1.00d.hdr	6	11
39	7	53	54	40	51	1	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/723/6/template_m101_1.00d.hdr	8	13
39	8	53	54	41	51	1	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/716/7/template_m101_1.00d.hdr	7	15
39	9	53	54	42	51	1	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/710/8/template_m101_1.00d.hdr	9	17
39	10	53	54	43	51	1	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/617/9/template_m101_1.00d.hdr	10	19
39	11	53	54	44	51	1	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/611/10/template_m101_1.00d.hdr	11	21
39	12	53	54	45	51	1	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/525/11/template_m101_1.00d.hdr	12	23
39	13	53	54	46	51	1	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/512/12/template_m101_1.00d.hdr	13	25
39	14	53	54	47	51	1	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/506/13/template_m101_1.00d.hdr	14	27
39	15	53	54	48	51	1	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/435/14/template_m101_1.00d.hdr	15	29
39	16	53	54	50	51	1	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/418/16/template_m101_1.00d.hdr	17	31
39	17	53	54	49	51	1	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/422/15/template_m101_1.00d.hdr	16	33
\.


--
-- TOC entry 2733 (class 0 OID 0)
-- Dependencies: 229
-- Name: ofitplane_seq; Type: SEQUENCE SET; Schema: montage; Owner: chiron
--

SELECT pg_catalog.setval('ofitplane_seq', 17, true);


--
-- TOC entry 2665 (class 0 OID 960601)
-- Dependencies: 204
-- Data for Name: olistfits; Type: TABLE DATA; Schema: montage; Owner: chiron
--

COPY olistfits (ewkfid, key, previousactid, nextactid, previoustaskid, nexttaskid, mosaic_id, header, dllistfitsid) FROM stdin;
39	1	46	47	2	3	1	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ListFits/251/286/114/0/template_m101_1.00d.hdr	1
39	2	46	47	2	4	1	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ListFits/251/286/114/0/template_m101_1.00d.hdr	2
39	3	46	47	2	5	1	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ListFits/251/286/114/0/template_m101_1.00d.hdr	3
39	4	46	47	2	6	1	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ListFits/251/286/114/0/template_m101_1.00d.hdr	4
39	5	46	47	2	7	1	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ListFits/251/286/114/0/template_m101_1.00d.hdr	5
39	6	46	47	2	8	1	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ListFits/251/286/114/0/template_m101_1.00d.hdr	6
39	7	46	47	2	9	1	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ListFits/251/286/114/0/template_m101_1.00d.hdr	7
39	8	46	47	2	10	1	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ListFits/251/286/114/0/template_m101_1.00d.hdr	8
39	9	46	47	2	11	1	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ListFits/251/286/114/0/template_m101_1.00d.hdr	9
39	10	46	47	2	12	1	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ListFits/251/286/114/0/template_m101_1.00d.hdr	10
\.


--
-- TOC entry 2734 (class 0 OID 0)
-- Dependencies: 201
-- Name: olistfits_seq; Type: SEQUENCE SET; Schema: montage; Owner: chiron
--

SELECT pg_catalog.setval('olistfits_seq', 10, true);


--
-- TOC entry 2669 (class 0 OID 960656)
-- Dependencies: 208
-- Data for Name: oprojection; Type: TABLE DATA; Schema: montage; Owner: chiron
--

COPY oprojection (ewkfid, key, previousactid, nextactid, previoustaskid, nexttaskid, mosaic_id, header, dllistfitsid, dlprojectionid) FROM stdin;
39	1	47	48	5	13	1	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/209/599/2/template_m101_1.00d.hdr	3	1
39	3	47	48	3	13	1	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/209/505/0/template_m101_1.00d.hdr	1	3
39	5	47	48	4	13	1	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/209/541/1/template_m101_1.00d.hdr	2	5
39	7	47	48	6	13	1	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/209/635/3/template_m101_1.00d.hdr	4	7
39	9	47	48	7	13	1	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/210/346/4/template_m101_1.00d.hdr	5	9
39	11	47	48	8	13	1	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/211/580/5/template_m101_1.00d.hdr	6	11
39	13	47	48	10	13	1	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/212/325/7/template_m101_1.00d.hdr	8	13
39	15	47	48	9	13	1	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/212/265/6/template_m101_1.00d.hdr	7	15
39	17	47	48	11	13	1	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/212/359/8/template_m101_1.00d.hdr	9	17
39	19	47	48	12	13	1	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/212/418/9/template_m101_1.00d.hdr	10	19
39	2	47	50	5	14	1	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/209/599/2/template_m101_1.00d.hdr	3	1
39	4	47	50	3	14	1	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/209/505/0/template_m101_1.00d.hdr	1	3
39	6	47	50	4	14	1	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/209/541/1/template_m101_1.00d.hdr	2	5
39	8	47	50	6	14	1	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/209/635/3/template_m101_1.00d.hdr	4	7
39	10	47	50	7	14	1	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/210/346/4/template_m101_1.00d.hdr	5	9
39	12	47	50	8	14	1	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/211/580/5/template_m101_1.00d.hdr	6	11
39	14	47	50	10	14	1	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/212/325/7/template_m101_1.00d.hdr	8	13
39	16	47	50	9	14	1	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/212/265/6/template_m101_1.00d.hdr	7	15
39	18	47	50	11	14	1	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/212/359/8/template_m101_1.00d.hdr	9	17
39	20	47	50	12	14	1	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/212/418/9/template_m101_1.00d.hdr	10	19
\.


--
-- TOC entry 2735 (class 0 OID 0)
-- Dependencies: 205
-- Name: oprojection_seq; Type: SEQUENCE SET; Schema: montage; Owner: chiron
--

SELECT pg_catalog.setval('oprojection_seq', 20, true);


--
-- TOC entry 2673 (class 0 OID 960716)
-- Dependencies: 212
-- Data for Name: oselectprojections; Type: TABLE DATA; Schema: montage; Owner: chiron
--

COPY oselectprojections (ewkfid, key, previousactid, nextactid, previoustaskid, nexttaskid, mosaic_id, header, dlselectprojectionsid) FROM stdin;
39	1	48	49	13	15	1	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/SelectProjections/145/236/741/0/template_m101_1.00d.hdr	1
\.


--
-- TOC entry 2736 (class 0 OID 0)
-- Dependencies: 209
-- Name: oselectprojections_seq; Type: SEQUENCE SET; Schema: montage; Owner: chiron
--

SELECT pg_catalog.setval('oselectprojections_seq', 1, true);


SET search_path = public, pg_catalog;

--
-- TOC entry 2737 (class 0 OID 0)
-- Dependencies: 171
-- Name: actid_seq; Type: SEQUENCE SET; Schema: public; Owner: vitor
--

SELECT pg_catalog.setval('actid_seq', 54, true);


--
-- TOC entry 2738 (class 0 OID 0)
-- Dependencies: 172
-- Name: cactid_seq; Type: SEQUENCE SET; Schema: public; Owner: vitor
--

SELECT pg_catalog.setval('cactid_seq', 1, false);


--
-- TOC entry 2634 (class 0 OID 959302)
-- Dependencies: 173
-- Data for Name: cactivity; Type: TABLE DATA; Schema: public; Owner: vitor
--

COPY cactivity (actid, wkfid, tag, atype, description, activation, constrained, templatedir) FROM stdin;
37	27	ListFits	SPLIT_MAP		./experiment.cmd		%=WFDIR%/template_listfits
38	27	Projection	FILTER		./experiment.cmd		%=WFDIR%/template_projection
39	27	SelectProjections	REDUCE		./experiment.cmd		%=WFDIR%/template_selectprojections
40	27	CreateUncorrectedMosaic	MAP		./experiment.cmd		%=WFDIR%/template_createuncorrectedmosaic
41	27	CalculateOverlaps	REDUCE		./experiment.cmd		%=WFDIR%/template_calculateoverlaps
42	27	ExtractDifferences	SPLIT_MAP		./experiment.cmd		%=WFDIR%/template_extractdifferences
43	27	CalculateDifference	MAP		./experiment.cmd		%=WFDIR%/template_calculatedifference
44	27	FitPlane	FILTER		./experiment.cmd		%=WFDIR%/template_fitplane
45	27	CreateMosaic	REDUCE		./experiment.cmd		%=WFDIR%/template_createmosaic
\.


--
-- TOC entry 2635 (class 0 OID 959309)
-- Dependencies: 174
-- Data for Name: cextractor; Type: TABLE DATA; Schema: public; Owner: vitor
--

COPY cextractor (extid, wkfid, name, type, cartridge, search, invocation, delimiter) FROM stdin;
19	27	dllistfits	LOADING	EXTERNAL_PROGRAM		./extractor.cmd	\N
20	27	dlprojection	LOADING	EXTERNAL_PROGRAM		./extractor.cmd	\N
21	27	dlselectprojections	LOADING	EXTERNAL_PROGRAM		./extractor.cmd	\N
22	27	dlcreateumosaic	LOADING	EXTERNAL_PROGRAM		./extractor.cmd	\N
23	27	dlcalculateoverlaps	LOADING	EXTERNAL_PROGRAM		./extractor.cmd	\N
24	27	dlextractdifferences	LOADING	EXTERNAL_PROGRAM		./extractor.cmd	\N
25	27	dlcalculatedifference	LOADING	EXTERNAL_PROGRAM		./extractor.cmd	\N
26	27	dlfitplane	LOADING	EXTERNAL_PROGRAM		./extractor.cmd	\N
27	27	dlcreatemosaic	LOADING	EXTERNAL_PROGRAM		./extractor.cmd	\N
\.


--
-- TOC entry 2637 (class 0 OID 959319)
-- Dependencies: 176
-- Data for Name: cfield; Type: TABLE DATA; Schema: public; Owner: vitor
--

COPY cfield (fname, relid, ftype, decimalplaces, fileoperation, instrumented, extid) FROM stdin;
mosaic_id	21	float	0	LINK	\N	\N
region	21	text	\N	LINK	\N	\N
degrees	21	float	2	LINK	\N	\N
header	21	file	\N	COPY	\N	\N
mosaic_id	22	float	0	LINK	\N	\N
header	22	file	\N	COPY	\N	\N
cntr	22	float	0	LINK	\N	19
ra	22	float	7	LINK	\N	19
dec	22	float	7	LINK	\N	19
cra	22	text	\N	LINK	\N	19
cdec	22	text	\N	LINK	\N	19
naxis1	22	float	0	LINK	\N	19
naxis2	22	float	0	LINK	\N	19
ctype1	22	text	\N	LINK	\N	19
ctype2	22	text	\N	LINK	\N	19
crpix1	22	float	5	LINK	\N	19
crpix2	22	float	5	LINK	\N	19
crval1	22	float	7	LINK	\N	19
crval2	22	float	7	LINK	\N	19
cdelt1	22	text	\N	LINK	\N	19
cdelt2	22	text	\N	LINK	\N	19
crota2	22	float	7	LINK	\N	19
equinox	22	float	2	LINK	\N	19
size	22	float	0	LINK	\N	19
hdu	22	float	0	LINK	\N	19
fname	22	file	\N	LINK	\N	19
mosaic_id	23	float	0	LINK	\N	\N
header	23	file	\N	COPY	\N	\N
cntr	23	float	0	LINK	\N	19
ra	23	float	7	LINK	\N	19
dec	23	float	7	LINK	\N	19
cra	23	text	\N	LINK	\N	19
cdec	23	text	\N	LINK	\N	19
naxis1	23	float	0	LINK	\N	19
naxis2	23	float	0	LINK	\N	19
ctype1	23	text	\N	LINK	\N	19
ctype2	23	text	\N	LINK	\N	19
crpix1	23	float	5	LINK	\N	19
crpix2	23	float	5	LINK	\N	19
crval1	23	float	7	LINK	\N	19
crval2	23	float	7	LINK	\N	19
cdelt1	23	text	\N	LINK	\N	19
cdelt2	23	text	\N	LINK	\N	19
crota2	23	float	7	LINK	\N	19
equinox	23	float	2	LINK	\N	19
size	23	float	0	LINK	\N	19
hdu	23	float	0	LINK	\N	19
hdu_area	23	file	\N	COPY	\N	20
hdu_file	23	file	\N	COPY	\N	20
mosaic_id	24	float	0	LINK	\N	\N
header	24	file	\N	COPY	\N	\N
mosaic_fits	24	file	\N	COPY	\N	21
mosaic_area	24	file	\N	COPY	\N	21
mosaic_id	25	float	0	LINK	\N	\N
header	25	file	\N	COPY	\N	\N
mosaic_jpg	25	file	\N	LINK	\N	22
mosaic_id	26	float	0	LINK	\N	\N
header	26	file	\N	COPY	\N	\N
diffs_tbl	26	file	\N	COPY	\N	23
diffs_path	26	text	\N	LINK	\N	23
mosaic_id	27	float	0	LINK	\N	\N
header	27	file	\N	COPY	\N	\N
cntr1	27	float	0	LINK	\N	24
cntr2	27	float	0	LINK	\N	24
plus	27	file	\N	COPY	\N	24
plus_area	27	file	\N	COPY	\N	24
minus	27	file	\N	COPY	\N	24
minus_area	27	file	\N	COPY	\N	24
diff	27	text	\N	LINK	\N	24
mosaic_id	28	float	0	LINK	\N	\N
header	28	file	\N	COPY	\N	\N
cntr1	28	float	0	LINK	\N	24
cntr2	28	float	0	LINK	\N	24
plus	28	file	\N	COPY	\N	24
plus_area	28	file	\N	COPY	\N	24
minus	28	file	\N	COPY	\N	24
minus_area	28	file	\N	COPY	\N	24
diff_fits	28	file	\N	COPY	\N	25
diff_area	28	file	\N	COPY	\N	25
mosaic_id	29	float	0	LINK	\N	\N
header	29	file	\N	COPY	\N	\N
cntr1	29	float	0	LINK	\N	24
cntr2	29	float	0	LINK	\N	24
plus	29	file	\N	COPY	\N	24
plus_area	29	file	\N	COPY	\N	24
minus	29	file	\N	COPY	\N	24
minus_area	29	file	\N	COPY	\N	24
fa	29	text	\N	LINK	\N	26
fb	29	text	\N	LINK	\N	26
fc	29	text	\N	LINK	\N	26
fcrpix1	29	float	2	LINK	\N	26
fcrpix2	29	float	2	LINK	\N	26
fxmin	29	float	0	LINK	\N	26
fxmax	29	float	0	LINK	\N	26
fymin	29	float	0	LINK	\N	26
fymax	29	float	0	LINK	\N	26
fxcenter	29	float	2	LINK	\N	26
fycenter	29	float	2	LINK	\N	26
fnpixel	29	float	0	LINK	\N	26
frms	29	float	5	LINK	\N	26
fboxx	29	float	1	LINK	\N	26
fboxy	29	float	1	LINK	\N	26
fboxwidth	29	float	1	LINK	\N	26
fboxheight	29	float	1	LINK	\N	26
fboxang	29	float	1	LINK	\N	26
mosaic_id	30	float	0	LINK	\N	\N
header	30	file	\N	COPY	\N	\N
images_tbl	30	file	\N	LINK	\N	27
mosaic_fits	30	file	\N	LINK	\N	27
mosaic_area	30	file	\N	LINK	\N	27
mosaic_jpg	30	file	\N	LINK	\N	27
\.


--
-- TOC entry 2636 (class 0 OID 959316)
-- Dependencies: 175
-- Data for Name: cjoin; Type: TABLE DATA; Schema: public; Owner: vitor
--

COPY cjoin (relid, innerextid, outerextid, fields) FROM stdin;
\.


--
-- TOC entry 2739 (class 0 OID 0)
-- Dependencies: 191
-- Name: cmapid_seq; Type: SEQUENCE SET; Schema: public; Owner: vitor
--

SELECT pg_catalog.setval('cmapid_seq', 1, false);


--
-- TOC entry 2651 (class 0 OID 959393)
-- Dependencies: 190
-- Data for Name: cmapping; Type: TABLE DATA; Schema: public; Owner: vitor
--

COPY cmapping (cmapid, crelid, previousid, nextid) FROM stdin;
28	21	\N	37
29	22	37	38
30	23	38	39
31	24	39	40
32	25	40	\N
33	23	38	41
34	26	41	42
35	27	42	43
36	28	43	44
37	29	44	45
38	30	45	\N
\.


--
-- TOC entry 2638 (class 0 OID 959322)
-- Dependencies: 177
-- Data for Name: coperand; Type: TABLE DATA; Schema: public; Owner: vitor
--

COPY coperand (opid, actid, oname, numericvalue, textvalue) FROM stdin;
7	39	AGREG_FIELD	0	MOSAIC_ID
8	41	AGREG_FIELD	0	MOSAIC_ID
9	45	AGREG_FIELD	0	MOSAIC_ID
\.


--
-- TOC entry 2740 (class 0 OID 0)
-- Dependencies: 178
-- Name: copid_seq; Type: SEQUENCE SET; Schema: public; Owner: vitor
--

SELECT pg_catalog.setval('copid_seq', 9, true);


--
-- TOC entry 2640 (class 0 OID 959328)
-- Dependencies: 179
-- Data for Name: crelation; Type: TABLE DATA; Schema: public; Owner: vitor
--

COPY crelation (wkfid, relid, rtype, rname) FROM stdin;
27	21	INPUT	ilistfits
27	22	INTERMEDIARY	olistfits
27	23	INTERMEDIARY	oprojection
27	24	INTERMEDIARY	oselectprojections
27	25	OUTPUT	ocreateumosaic
27	26	INTERMEDIARY	ocalculateoverlaps
27	27	INTERMEDIARY	oextractdifferences
27	28	INTERMEDIARY	ocalculatedifference
27	29	INTERMEDIARY	ofitplane
27	30	OUTPUT	ocreatemosaic
\.


--
-- TOC entry 2741 (class 0 OID 0)
-- Dependencies: 180
-- Name: cwkfid_seq; Type: SEQUENCE SET; Schema: public; Owner: vitor
--

SELECT pg_catalog.setval('cwkfid_seq', 1, false);


--
-- TOC entry 2642 (class 0 OID 959334)
-- Dependencies: 181
-- Data for Name: cworkflow; Type: TABLE DATA; Schema: public; Owner: vitor
--

COPY cworkflow (wkfid, tag, description) FROM stdin;
27	montage	
\.


--
-- TOC entry 2643 (class 0 OID 959338)
-- Dependencies: 182
-- Data for Name: eactivation; Type: TABLE DATA; Schema: public; Owner: vitor
--

COPY eactivation (taskid, actid, machineid, processor, exitstatus, commandline, folder, subfolder, failure_tries, terr, tout, starttime, endtime, status, instrumentationstarttime, instrumentationendtime, computingstarttime, computingendtime, extractorstarttime, extractorendtime, dataloadingstarttime, dataloadingendtime) FROM stdin;
9	47	1	3	0	./experiment.cmd\n./extractor.cmd	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/	252/212/265/6/	0		[struct stat="OK", time=58]\n	2016-10-11 10:57:22.732-03	2016-10-11 10:58:20.33-03	FINISHED	2016-10-11 10:57:22.732-03	2016-10-11 10:57:22.828-03	2016-10-11 10:57:22.828-03	2016-10-11 10:58:20.02-03	2016-10-11 10:58:20.02-03	2016-10-11 10:58:20.316-03	2016-10-11 10:58:20.342-03	2016-10-11 10:58:20.367-03
11	47	1	2	0	./experiment.cmd\n./extractor.cmd	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/	252/212/359/8/	0		[struct stat="OK", time=57]\n	2016-10-11 10:57:25.657-03	2016-10-11 10:58:22.474-03	FINISHED	2016-10-11 10:57:25.657-03	2016-10-11 10:57:25.717-03	2016-10-11 10:57:25.717-03	2016-10-11 10:58:22.225-03	2016-10-11 10:58:22.225-03	2016-10-11 10:58:22.46-03	2016-10-11 10:58:22.478-03	2016-10-11 10:58:22.504-03
2	46	1	1	0	./experiment.cmd\n./extractor.cmd	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ListFits/	251/286/114/0/	0		[struct stat="OK", count=10, badfits=0, badwcs=0]\n	2016-10-11 10:55:37.387-03	2016-10-11 10:55:38.007-03	FINISHED	2016-10-11 10:55:37.387-03	2016-10-11 10:55:37.419-03	2016-10-11 10:55:37.419-03	2016-10-11 10:55:37.607-03	2016-10-11 10:55:37.607-03	2016-10-11 10:55:37.934-03	2016-10-11 10:55:38.017-03	2016-10-11 10:55:38.053-03
12	47	1	1	0	./experiment.cmd\n./extractor.cmd	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/	252/212/418/9/	0		[struct stat="OK", time=48]\n	2016-10-11 10:58:19.283-03	2016-10-11 10:59:08.223-03	FINISHED	2016-10-11 10:58:19.283-03	2016-10-11 10:58:19.346-03	2016-10-11 10:58:19.346-03	2016-10-11 10:59:07.915-03	2016-10-11 10:59:07.915-03	2016-10-11 10:59:08.207-03	2016-10-11 10:59:08.229-03	2016-10-11 10:59:08.26-03
13	48	1	1	0	./experiment.cmd\n./extractor.cmd	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/SelectProjections/	145/236/741/0/	0		[struct stat="OK", count=10, badfits=0, badwcs=0]\n[struct stat="OK", time=2]\n	2016-10-11 10:59:08.609-03	2016-10-11 10:59:14.984-03	FINISHED	2016-10-11 10:59:08.609-03	2016-10-11 10:59:09.893-03	2016-10-11 10:59:09.893-03	2016-10-11 10:59:14.701-03	2016-10-11 10:59:14.701-03	2016-10-11 10:59:14.968-03	2016-10-11 10:59:14.995-03	2016-10-11 10:59:15.045-03
5	47	1	3	0	./experiment.cmd\n./extractor.cmd	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/	252/209/599/2/	0		[struct stat="OK", time=51]\n	2016-10-11 10:55:38.224-03	2016-10-11 10:56:30.233-03	FINISHED	2016-10-11 10:55:38.224-03	2016-10-11 10:55:38.285-03	2016-10-11 10:55:38.285-03	2016-10-11 10:56:29.868-03	2016-10-11 10:56:29.868-03	2016-10-11 10:56:30.213-03	2016-10-11 10:56:30.241-03	2016-10-11 10:56:30.322-03
3	47	1	1	0	./experiment.cmd\n./extractor.cmd	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/	252/209/505/0/	0		[struct stat="OK", time=52]\n	2016-10-11 10:55:38.195-03	2016-10-11 10:56:30.592-03	FINISHED	2016-10-11 10:55:38.195-03	2016-10-11 10:55:38.28-03	2016-10-11 10:55:38.28-03	2016-10-11 10:56:30.19-03	2016-10-11 10:56:30.19-03	2016-10-11 10:56:30.577-03	2016-10-11 10:56:30.603-03	2016-10-11 10:56:30.631-03
4	47	1	2	0	./experiment.cmd\n./extractor.cmd	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/	252/209/541/1/	0		[struct stat="OK", time=53]\n	2016-10-11 10:55:38.217-03	2016-10-11 10:56:31.695-03	FINISHED	2016-10-11 10:55:38.217-03	2016-10-11 10:55:38.285-03	2016-10-11 10:55:38.285-03	2016-10-11 10:56:31.474-03	2016-10-11 10:56:31.474-03	2016-10-11 10:56:31.68-03	2016-10-11 10:56:31.703-03	2016-10-11 10:56:31.732-03
6	47	1	3	0	./experiment.cmd\n./extractor.cmd	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/	252/209/635/3/	0		[struct stat="OK", time=52]\n	2016-10-11 10:56:30.262-03	2016-10-11 10:57:22.7-03	FINISHED	2016-10-11 10:56:30.262-03	2016-10-11 10:56:30.364-03	2016-10-11 10:56:30.364-03	2016-10-11 10:57:22.406-03	2016-10-11 10:57:22.406-03	2016-10-11 10:57:22.684-03	2016-10-11 10:57:22.704-03	2016-10-11 10:57:22.772-03
7	47	1	1	0	./experiment.cmd\n./extractor.cmd	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/	252/210/346/4/	0		[struct stat="OK", time=52]\n	2016-10-11 10:56:30.613-03	2016-10-11 10:57:22.903-03	FINISHED	2016-10-11 10:56:30.613-03	2016-10-11 10:56:30.682-03	2016-10-11 10:56:30.682-03	2016-10-11 10:57:22.591-03	2016-10-11 10:57:22.591-03	2016-10-11 10:57:22.848-03	2016-10-11 10:57:22.907-03	2016-10-11 10:57:23.116-03
26	52	1	2	0	./experiment.cmd\n./extractor.cmd	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/	139/972/848/9/	0		[struct stat="OK"]\n	2016-10-11 10:59:24.776-03	2016-10-11 10:59:26.299-03	FINISHED	2016-10-11 10:59:24.776-03	2016-10-11 10:59:25.049-03	2016-10-11 10:59:25.049-03	2016-10-11 10:59:25.37-03	2016-10-11 10:59:25.37-03	2016-10-11 10:59:25.899-03	2016-10-11 10:59:27.634-03	2016-10-11 10:59:27.73-03
8	47	1	2	0	./experiment.cmd\n./extractor.cmd	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/	252/211/580/5/	0		[struct stat="OK", time=54]\n	2016-10-11 10:56:31.707-03	2016-10-11 10:57:25.642-03	FINISHED	2016-10-11 10:56:31.707-03	2016-10-11 10:56:31.794-03	2016-10-11 10:56:31.794-03	2016-10-11 10:57:25.4-03	2016-10-11 10:57:25.4-03	2016-10-11 10:57:25.629-03	2016-10-11 10:57:25.646-03	2016-10-11 10:57:25.676-03
17	52	1	2	0	./experiment.cmd\n./extractor.cmd	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/	142/281/192/0/	0		[struct stat="OK"]\n	2016-10-11 10:59:20.09-03	2016-10-11 10:59:21.236-03	FINISHED	2016-10-11 10:59:20.09-03	2016-10-11 10:59:20.198-03	2016-10-11 10:59:20.198-03	2016-10-11 10:59:20.463-03	2016-10-11 10:59:20.463-03	2016-10-11 10:59:21.16-03	2016-10-11 10:59:21.248-03	2016-10-11 10:59:21.324-03
10	47	1	1	0	./experiment.cmd\n./extractor.cmd	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/	252/212/325/7/	0		[struct stat="OK", time=55]\n	2016-10-11 10:57:22.924-03	2016-10-11 10:58:19.268-03	FINISHED	2016-10-11 10:57:22.924-03	2016-10-11 10:57:23.145-03	2016-10-11 10:57:23.145-03	2016-10-11 10:58:18.785-03	2016-10-11 10:58:18.785-03	2016-10-11 10:58:19.254-03	2016-10-11 10:58:19.274-03	2016-10-11 10:58:19.304-03
14	50	1	1	0	./experiment.cmd\n./extractor.cmd	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateOverlaps/	142/651/065/0/	0		[struct stat="OK", count=10, badfits=0, badwcs=0]\n[struct stat="OK", count=17]\n	2016-10-11 10:59:15.486-03	2016-10-11 10:59:17.912-03	FINISHED	2016-10-11 10:59:15.486-03	2016-10-11 10:59:17.445-03	2016-10-11 10:59:17.445-03	2016-10-11 10:59:17.6-03	2016-10-11 10:59:17.6-03	2016-10-11 10:59:17.896-03	2016-10-11 10:59:17.926-03	2016-10-11 10:59:17.977-03
16	51	1	1	0	./experiment.cmd\n./extractor.cmd	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/	142/374/295/0/	0			2016-10-11 10:59:18.136-03	2016-10-11 10:59:19.568-03	FINISHED	2016-10-11 10:59:18.136-03	2016-10-11 10:59:18.18-03	2016-10-11 10:59:18.18-03	2016-10-11 10:59:19.198-03	2016-10-11 10:59:19.198-03	2016-10-11 10:59:19.547-03	2016-10-11 10:59:19.569-03	2016-10-11 10:59:19.63-03
19	52	1	2	0	./experiment.cmd\n./extractor.cmd	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/	140/249/808/2/	0		[struct stat="OK"]\n	2016-10-11 10:59:21.286-03	2016-10-11 10:59:22.243-03	FINISHED	2016-10-11 10:59:21.286-03	2016-10-11 10:59:21.411-03	2016-10-11 10:59:21.411-03	2016-10-11 10:59:21.578-03	2016-10-11 10:59:21.578-03	2016-10-11 10:59:22.046-03	2016-10-11 10:59:22.529-03	2016-10-11 10:59:22.668-03
15	49	1	2	0	./experiment.cmd\n./extractor.cmd	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateUncorrectedMosaic/	142/650/960/0/	0		[struct stat="OK", min=78.7184, minpercent=20.00, max=170.379, maxpercent=99.98]\n	2016-10-11 10:59:17.526-03	2016-10-11 10:59:20.054-03	FINISHED	2016-10-11 10:59:17.526-03	2016-10-11 10:59:17.595-03	2016-10-11 10:59:17.595-03	2016-10-11 10:59:19.473-03	2016-10-11 10:59:19.473-03	2016-10-11 10:59:20.037-03	2016-10-11 10:59:20.074-03	2016-10-11 10:59:20.414-03
18	52	1	1	0	./experiment.cmd\n./extractor.cmd	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/	140/250/193/1/	0		[struct stat="OK"]\n	2016-10-11 10:59:20.586-03	2016-10-11 10:59:21.699-03	FINISHED	2016-10-11 10:59:20.586-03	2016-10-11 10:59:20.829-03	2016-10-11 10:59:20.829-03	2016-10-11 10:59:21.025-03	2016-10-11 10:59:21.025-03	2016-10-11 10:59:21.596-03	2016-10-11 10:59:21.7-03	2016-10-11 10:59:22.267-03
20	52	1	3	0	./experiment.cmd\n./extractor.cmd	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/	140/157/657/3/	0		[struct stat="OK"]\n	2016-10-11 10:59:21.523-03	2016-10-11 10:59:22.559-03	FINISHED	2016-10-11 10:59:21.523-03	2016-10-11 10:59:21.638-03	2016-10-11 10:59:21.638-03	2016-10-11 10:59:22.107-03	2016-10-11 10:59:22.107-03	2016-10-11 10:59:22.491-03	2016-10-11 10:59:22.768-03	2016-10-11 10:59:22.954-03
21	52	1	2	0	./experiment.cmd\n./extractor.cmd	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/	140/157/382/4/	0		[struct stat="OK"]\n	2016-10-11 10:59:22.322-03	2016-10-11 10:59:23.362-03	FINISHED	2016-10-11 10:59:22.322-03	2016-10-11 10:59:22.517-03	2016-10-11 10:59:22.517-03	2016-10-11 10:59:22.613-03	2016-10-11 10:59:22.613-03	2016-10-11 10:59:23.345-03	2016-10-11 10:59:23.373-03	2016-10-11 10:59:23.786-03
27	52	1	1	0	./experiment.cmd\n./extractor.cmd	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/	139/880/223/10/	0		[struct stat="OK"]\n	2016-10-11 10:59:25.873-03	2016-10-11 10:59:27.608-03	FINISHED	2016-10-11 10:59:25.873-03	2016-10-11 10:59:26.3-03	2016-10-11 10:59:26.3-03	2016-10-11 10:59:26.431-03	2016-10-11 10:59:26.431-03	2016-10-11 10:59:26.95-03	2016-10-11 10:59:27.888-03	2016-10-11 10:59:27.999-03
22	52	1	1	0	./experiment.cmd\n./extractor.cmd	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/	140/065/293/5/	0		[struct stat="OK"]\n	2016-10-11 10:59:22.763-03	2016-10-11 10:59:23.922-03	FINISHED	2016-10-11 10:59:22.763-03	2016-10-11 10:59:22.863-03	2016-10-11 10:59:22.863-03	2016-10-11 10:59:22.955-03	2016-10-11 10:59:22.955-03	2016-10-11 10:59:23.606-03	2016-10-11 10:59:24.692-03	2016-10-11 10:59:25.35-03
23	52	1	3	0	./experiment.cmd\n./extractor.cmd	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/	140/064/909/6/	0		[struct stat="OK"]\n	2016-10-11 10:59:22.997-03	2016-10-11 10:59:24.302-03	FINISHED	2016-10-11 10:59:22.997-03	2016-10-11 10:59:23.089-03	2016-10-11 10:59:23.089-03	2016-10-11 10:59:23.177-03	2016-10-11 10:59:23.177-03	2016-10-11 10:59:23.846-03	2016-10-11 10:59:26.441-03	2016-10-11 10:59:26.537-03
24	52	1	2	0	./experiment.cmd\n./extractor.cmd	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/	140/064/629/7/	0		[struct stat="OK"]\n	2016-10-11 10:59:23.604-03	2016-10-11 10:59:24.609-03	FINISHED	2016-10-11 10:59:23.604-03	2016-10-11 10:59:23.786-03	2016-10-11 10:59:23.786-03	2016-10-11 10:59:24.148-03	2016-10-11 10:59:24.148-03	2016-10-11 10:59:24.457-03	2016-10-11 10:59:25.816-03	2016-10-11 10:59:25.843-03
25	52	1	1	0	./experiment.cmd\n./extractor.cmd	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/	139/973/038/8/	0		[struct stat="OK"]\n	2016-10-11 10:59:24.621-03	2016-10-11 10:59:25.783-03	FINISHED	2016-10-11 10:59:24.621-03	2016-10-11 10:59:24.775-03	2016-10-11 10:59:24.775-03	2016-10-11 10:59:25.143-03	2016-10-11 10:59:25.143-03	2016-10-11 10:59:25.45-03	2016-10-11 10:59:26.573-03	2016-10-11 10:59:26.737-03
28	52	1	2	0	./experiment.cmd\n./extractor.cmd	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/	139/787/685/11/	0		[struct stat="OK"]\n	2016-10-11 10:59:26.725-03	2016-10-11 10:59:28.302-03	FINISHED	2016-10-11 10:59:26.725-03	2016-10-11 10:59:27.082-03	2016-10-11 10:59:27.082-03	2016-10-11 10:59:27.708-03	2016-10-11 10:59:27.708-03	2016-10-11 10:59:28.287-03	2016-10-11 10:59:28.308-03	2016-10-11 10:59:28.456-03
29	52	1	3	0	./experiment.cmd\n./extractor.cmd	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/	139/695/606/12/	0		[struct stat="OK"]\n	2016-10-11 10:59:27.609-03	2016-10-11 10:59:28.764-03	FINISHED	2016-10-11 10:59:27.609-03	2016-10-11 10:59:27.721-03	2016-10-11 10:59:27.721-03	2016-10-11 10:59:27.839-03	2016-10-11 10:59:27.839-03	2016-10-11 10:59:28.579-03	2016-10-11 10:59:29.055-03	2016-10-11 10:59:29.085-03
30	52	1	1	0	./experiment.cmd\n./extractor.cmd	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/	139/695/410/13/	0		[struct stat="OK"]\n	2016-10-11 10:59:27.887-03	2016-10-11 10:59:28.996-03	FINISHED	2016-10-11 10:59:27.887-03	2016-10-11 10:59:27.969-03	2016-10-11 10:59:27.969-03	2016-10-11 10:59:28.04-03	2016-10-11 10:59:28.04-03	2016-10-11 10:59:28.741-03	2016-10-11 10:59:29.144-03	2016-10-11 10:59:29.363-03
31	52	1	2	0	./experiment.cmd\n./extractor.cmd	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/	139/603/056/14/	0		[struct stat="OK"]\n	2016-10-11 10:59:28.32-03	2016-10-11 10:59:29.545-03	FINISHED	2016-10-11 10:59:28.32-03	2016-10-11 10:59:28.457-03	2016-10-11 10:59:28.457-03	2016-10-11 10:59:28.913-03	2016-10-11 10:59:28.913-03	2016-10-11 10:59:29.53-03	2016-10-11 10:59:29.549-03	2016-10-11 10:59:29.578-03
32	52	1	3	0	./experiment.cmd\n./extractor.cmd	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/	139/511/372/15/	0		[struct stat="OK"]\n	2016-10-11 10:59:29.003-03	2016-10-11 10:59:29.766-03	FINISHED	2016-10-11 10:59:29.003-03	2016-10-11 10:59:29.087-03	2016-10-11 10:59:29.087-03	2016-10-11 10:59:29.327-03	2016-10-11 10:59:29.327-03	2016-10-11 10:59:29.751-03	2016-10-11 10:59:29.777-03	2016-10-11 10:59:29.805-03
33	52	1	1	0	./experiment.cmd\n./extractor.cmd	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/	139/511/181/16/	0		[struct stat="OK"]\n	2016-10-11 10:59:29.098-03	2016-10-11 10:59:29.8-03	FINISHED	2016-10-11 10:59:29.098-03	2016-10-11 10:59:29.182-03	2016-10-11 10:59:29.182-03	2016-10-11 10:59:29.404-03	2016-10-11 10:59:29.404-03	2016-10-11 10:59:29.785-03	2016-10-11 10:59:29.854-03	2016-10-11 10:59:29.885-03
36	53	1	3	0	./experiment.cmd\n./extractor.cmd	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/	139/418/153/2/	0		[struct stat="OK", a=0.000987035, b=-0.000330065, c=4.5589, crpix1=-610, crpix2=-74, xmin=610, xmax=684, ymin=74, ymax=899, xcenter=647.226, ycenter=487.705, npixel=49692, rms=0.528751, boxx=647.5, boxy=486.5, boxwidth=825, boxheight=75, boxang=90]\n	2016-10-11 10:59:30.225-03	2016-10-11 10:59:31.263-03	FINISHED	2016-10-11 10:59:30.225-03	2016-10-11 10:59:30.509-03	2016-10-11 10:59:30.509-03	2016-10-11 10:59:30.766-03	2016-10-11 10:59:30.766-03	2016-10-11 10:59:31.246-03	2016-10-11 10:59:31.636-03	2016-10-11 10:59:31.727-03
38	53	1	1	0	./experiment.cmd\n./extractor.cmd	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/	137/386/807/4/	0		[struct stat="OK", a=-1.50126e-07, b=-5.20262e-07, c=0.000135533, crpix1=-179, crpix2=-73, xmin=180, xmax=683, ymin=73, ymax=126, xcenter=432.558, ycenter=99.9599, npixel=24708, rms=0.00371889, boxx=431, boxy=100, boxwidth=54, boxheight=504, boxang=90]\n	2016-10-11 10:59:31.264-03	2016-10-11 10:59:32.032-03	FINISHED	2016-10-11 10:59:31.264-03	2016-10-11 10:59:31.499-03	2016-10-11 10:59:31.499-03	2016-10-11 10:59:31.577-03	2016-10-11 10:59:31.577-03	2016-10-11 10:59:32.017-03	2016-10-11 10:59:32.04-03	2016-10-11 10:59:32.072-03
50	53	1	2	0	./experiment.cmd\n./extractor.cmd	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/	137/386/418/16/	0		[struct stat="OK", a=7.21129e-08, b=1.83438e-07, c=0.000105624, crpix1=1119, crpix2=124, xmin=-1119, xmax=-614, ymin=-123, ymax=-68, xcenter=-865.459, ycenter=-95.6848, npixel=24736, rms=0.00368458, boxx=-866, boxy=-95.5, boxwidth=57, boxheight=506, boxang=90]\n	2016-10-11 10:59:39.627-03	2016-10-11 10:59:40.583-03	FINISHED	2016-10-11 10:59:39.627-03	2016-10-11 10:59:39.859-03	2016-10-11 10:59:39.859-03	2016-10-11 10:59:39.934-03	2016-10-11 10:59:39.934-03	2016-10-11 10:59:40.569-03	2016-10-11 10:59:40.594-03	2016-10-11 10:59:40.625-03
35	53	1	2	0	./experiment.cmd\n./extractor.cmd	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/	139/418/159/1/	0		[struct stat="OK", a=0.00213027, b=-0.000615025, c=3.87724, crpix1=-614, crpix2=124, xmin=614, xmax=685, ymin=-124, ymax=126, xcenter=648.846, ycenter=1.48641, npixel=14861, rms=0.520732, boxx=650, boxy=1.5, boxwidth=251, boxheight=72, boxang=90]\n	2016-10-11 10:59:30.104-03	2016-10-11 10:59:31.102-03	FINISHED	2016-10-11 10:59:30.104-03	2016-10-11 10:59:30.368-03	2016-10-11 10:59:30.368-03	2016-10-11 10:59:30.552-03	2016-10-11 10:59:30.552-03	2016-10-11 10:59:31.087-03	2016-10-11 10:59:31.109-03	2016-10-11 10:59:31.189-03
34	53	1	1	0	./experiment.cmd\n./extractor.cmd	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/	139/418/165/0/	0		[struct stat="OK", a=6.50671e-08, b=1.63239e-06, c=6.8477e-05, crpix1=-615, crpix2=124, xmin=615, xmax=1120, ymin=-124, ymax=-69, xcenter=868.121, ycenter=-96.3328, npixel=24600, rms=0.00393876, boxx=867.5, boxy=-96, boxwidth=56, boxheight=505, boxang=90]\n	2016-10-11 10:59:29.98-03	2016-10-11 10:59:31.161-03	FINISHED	2016-10-11 10:59:29.98-03	2016-10-11 10:59:30.241-03	2016-10-11 10:59:30.241-03	2016-10-11 10:59:30.598-03	2016-10-11 10:59:30.598-03	2016-10-11 10:59:31.145-03	2016-10-11 10:59:31.498-03	2016-10-11 10:59:31.557-03
37	53	1	2	0	./experiment.cmd\n./extractor.cmd	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/	137/387/290/3/	0		[struct stat="OK", a=-0.000102652, b=8.62256e-05, c=5.37755, crpix1=-614, crpix2=896, xmin=615, xmax=686, ymin=-896, ymax=-71, xcenter=650.687, ycenter=-479.875, npixel=47439, rms=0.532302, boxx=650.5, boxy=-483.5, boxwidth=825, boxheight=73, boxang=90]\n	2016-10-11 10:59:31.109-03	2016-10-11 10:59:32.044-03	FINISHED	2016-10-11 10:59:31.109-03	2016-10-11 10:59:31.375-03	2016-10-11 10:59:31.375-03	2016-10-11 10:59:31.678-03	2016-10-11 10:59:31.678-03	2016-10-11 10:59:32.029-03	2016-10-11 10:59:32.127-03	2016-10-11 10:59:33.506-03
40	53	1	1	0	./experiment.cmd\n./extractor.cmd	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/	137/386/723/6/	0		[struct stat="OK", a=0.000448046, b=9.96959e-06, c=1.04942, crpix1=-177, crpix2=-73, xmin=177, xmax=254, ymin=73, ymax=894, xcenter=215.123, ycenter=485.445, npixel=51199, rms=0.521795, boxx=215.5, boxy=483.5, boxwidth=821, boxheight=77, boxang=90]\n	2016-10-11 10:59:32.074-03	2016-10-11 10:59:34.713-03	FINISHED	2016-10-11 10:59:32.074-03	2016-10-11 10:59:33.674-03	2016-10-11 10:59:33.674-03	2016-10-11 10:59:34.157-03	2016-10-11 10:59:34.157-03	2016-10-11 10:59:34.699-03	2016-10-11 10:59:34.722-03	2016-10-11 10:59:34.748-03
43	53	1	1	0	./experiment.cmd\n./extractor.cmd	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/	137/386/617/9/	0		[struct stat="OK", a=0.000624353, b=-0.000340073, c=4.36633, crpix1=253, crpix2=129, xmin=-252, xmax=-181, ymin=-128, ymax=125, xcenter=-217.343, ycenter=-1.3214, npixel=15357, rms=0.499234, boxx=-216.5, boxy=-2, boxwidth=254, boxheight=73, boxang=90]\n	2016-10-11 10:59:34.726-03	2016-10-11 10:59:35.61-03	FINISHED	2016-10-11 10:59:34.726-03	2016-10-11 10:59:34.965-03	2016-10-11 10:59:34.965-03	2016-10-11 10:59:35.049-03	2016-10-11 10:59:35.049-03	2016-10-11 10:59:35.596-03	2016-10-11 10:59:35.621-03	2016-10-11 10:59:35.656-03
46	53	1	1	0	./experiment.cmd\n./extractor.cmd	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/	137/386/512/12/	0		[struct stat="OK", a=-8.58607e-09, b=-9.55297e-07, c=0.00010021, crpix1=686, crpix2=-72, xmin=-686, xmax=-181, ymin=72, ymax=126, xcenter=-434.679, ycenter=99.459, npixel=24730, rms=0.00346252, boxx=-433.5, boxy=99.5, boxwidth=55, boxheight=505, boxang=90]\n	2016-10-11 10:59:35.623-03	2016-10-11 10:59:37.978-03	FINISHED	2016-10-11 10:59:35.623-03	2016-10-11 10:59:36.2-03	2016-10-11 10:59:36.2-03	2016-10-11 10:59:36.526-03	2016-10-11 10:59:36.526-03	2016-10-11 10:59:37.227-03	2016-10-11 10:59:39.651-03	2016-10-11 10:59:39.694-03
39	53	1	3	0	./experiment.cmd\n./extractor.cmd	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/	137/386/797/5/	0		[struct stat="OK", a=-0.000157252, b=-0.000439582, c=1.32152, crpix1=-178, crpix2=129, xmin=179, xmax=253, ymin=-129, ymax=126, xcenter=215.09, ycenter=-0.330805, npixel=15689, rms=0.539683, boxx=216, boxy=-1.5, boxwidth=255, boxheight=76, boxang=90]\n	2016-10-11 10:59:31.412-03	2016-10-11 10:59:32.685-03	FINISHED	2016-10-11 10:59:31.412-03	2016-10-11 10:59:31.604-03	2016-10-11 10:59:31.604-03	2016-10-11 10:59:31.665-03	2016-10-11 10:59:31.665-03	2016-10-11 10:59:32.181-03	2016-10-11 10:59:33.629-03	2016-10-11 10:59:33.762-03
41	53	1	2	0	./experiment.cmd\n./extractor.cmd	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/	137/386/716/7/	0		[struct stat="OK", a=-0.000873928, b=0.000288798, c=1.42894, crpix1=-179, crpix2=897, xmin=179, xmax=253, ymin=-897, ymax=-76, xcenter=215.833, ycenter=-486.333, npixel=49180, rms=0.538728, boxx=216, boxy=-486.5, boxwidth=821, boxheight=74, boxang=90]\n	2016-10-11 10:59:32.087-03	2016-10-11 10:59:34.809-03	FINISHED	2016-10-11 10:59:32.087-03	2016-10-11 10:59:33.567-03	2016-10-11 10:59:33.567-03	2016-10-11 10:59:34.158-03	2016-10-11 10:59:34.158-03	2016-10-11 10:59:34.787-03	2016-10-11 10:59:34.816-03	2016-10-11 10:59:34.933-03
42	53	1	3	0	./experiment.cmd\n./extractor.cmd	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/	137/386/710/8/	0		[struct stat="OK", a=4.61908e-07, b=2.62075e-06, c=0.000295785, crpix1=253, crpix2=129, xmin=-253, xmax=252, ymin=-129, ymax=-76, xcenter=-2.53504, ycenter=-102.003, npixel=24712, rms=0.00379373, boxx=0, boxy=-102, boxwidth=54, boxheight=506, boxang=90]\n	2016-10-11 10:59:33.571-03	2016-10-11 10:59:35.229-03	FINISHED	2016-10-11 10:59:33.571-03	2016-10-11 10:59:34.537-03	2016-10-11 10:59:34.537-03	2016-10-11 10:59:34.605-03	2016-10-11 10:59:34.605-03	2016-10-11 10:59:35.215-03	2016-10-11 10:59:35.23-03	2016-10-11 10:59:35.258-03
44	53	1	2	0	./experiment.cmd\n./extractor.cmd	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/	137/386/611/10/	0		[struct stat="OK", a=0.00067979, b=0.000288485, c=4.30856, crpix1=254, crpix2=-72, xmin=-253, xmax=-178, ymin=72, ymax=894, xcenter=-216.244, ycenter=485.484, npixel=50244, rms=0.497041, boxx=-215, boxy=483.5, boxwidth=823, boxheight=78, boxang=90]\n	2016-10-11 10:59:34.829-03	2016-10-11 10:59:36.119-03	FINISHED	2016-10-11 10:59:34.829-03	2016-10-11 10:59:35.06-03	2016-10-11 10:59:35.06-03	2016-10-11 10:59:35.327-03	2016-10-11 10:59:35.327-03	2016-10-11 10:59:35.853-03	2016-10-11 10:59:36.197-03	2016-10-11 10:59:36.295-03
45	53	1	3	0	./experiment.cmd\n./extractor.cmd	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/	137/386/525/11/	0		[struct stat="OK", a=0.000926855, b=-0.00112872, c=4.22587, crpix1=254, crpix2=898, xmin=-253, xmax=-182, ymin=-898, ymax=-76, xcenter=-218.629, ycenter=-484.223, npixel=48835, rms=0.516368, boxx=-217.5, boxy=-486.5, boxwidth=823, boxheight=73, boxang=90]\n	2016-10-11 10:59:35.244-03	2016-10-11 10:59:36.119-03	FINISHED	2016-10-11 10:59:35.244-03	2016-10-11 10:59:35.444-03	2016-10-11 10:59:35.444-03	2016-10-11 10:59:35.572-03	2016-10-11 10:59:35.572-03	2016-10-11 10:59:35.978-03	2016-10-11 10:59:38.159-03	2016-10-11 10:59:38.322-03
47	53	1	2	0	./experiment.cmd\n./extractor.cmd	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/	137/386/506/13/	0		[struct stat="OK", a=0.00115409, b=-0.000596721, c=-3.95474, crpix1=687, crpix2=124, xmin=-687, xmax=-612, ymin=-123, ymax=126, xcenter=-649.918, ycenter=1.17061, npixel=15485, rms=0.497322, boxx=-649, boxy=1.5, boxwidth=251, boxheight=76, boxang=90]\n	2016-10-11 10:59:36.194-03	2016-10-11 10:59:39.459-03	FINISHED	2016-10-11 10:59:36.194-03	2016-10-11 10:59:37.979-03	2016-10-11 10:59:37.979-03	2016-10-11 10:59:38.502-03	2016-10-11 10:59:38.502-03	2016-10-11 10:59:38.826-03	2016-10-11 10:59:39.814-03	2016-10-11 10:59:40.067-03
48	53	1	3	0	./experiment.cmd\n./extractor.cmd	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/	137/386/435/14/	0		[struct stat="OK", a=-0.000686467, b=0.000475295, c=-5.10481, crpix1=690, crpix2=897, xmin=-690, xmax=-614, ymin=-896, ymax=-71, xcenter=-652.719, ycenter=-480.548, npixel=49537, rms=0.48968, boxx=-651.5, boxy=-483.5, boxwidth=827, boxheight=77, boxang=90]\n	2016-10-11 10:59:36.209-03	2016-10-11 10:59:39.659-03	FINISHED	2016-10-11 10:59:36.209-03	2016-10-11 10:59:38.098-03	2016-10-11 10:59:38.098-03	2016-10-11 10:59:38.982-03	2016-10-11 10:59:38.982-03	2016-10-11 10:59:39.382-03	2016-10-11 10:59:40.116-03	2016-10-11 10:59:40.192-03
49	53	1	1	0	./experiment.cmd\n./extractor.cmd	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/	137/386/422/15/	0		[struct stat="OK", a=-0.000847073, b=0.00038928, c=-5.22045, crpix1=686, crpix2=-73, xmin=-686, xmax=-607, ymin=74, ymax=899, xcenter=-647.322, ycenter=488.922, npixel=52760, rms=0.515655, boxx=-646, boxy=486.5, boxwidth=827, boxheight=80, boxang=90]\n	2016-10-11 10:59:38.135-03	2016-10-11 10:59:40.699-03	FINISHED	2016-10-11 10:59:38.135-03	2016-10-11 10:59:39.689-03	2016-10-11 10:59:39.689-03	2016-10-11 10:59:40.143-03	2016-10-11 10:59:40.143-03	2016-10-11 10:59:40.684-03	2016-10-11 10:59:40.701-03	2016-10-11 10:59:40.733-03
51	54	1	1	0	./experiment.cmd\n./extractor.cmd	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/	134/431/821/0/	0		[struct stat="OK", count=10, badfits=0, badwcs=0]\n[struct stat="OK"]\n[struct stat="OK", count=1, nocorrection=0, failed=0]\n[struct stat="OK", time=4]\n[struct stat="OK", min=83.064, minpercent=50.00, max=9629.44, maxpercent=100.00]\n	2016-10-11 10:59:41.551-03	2016-10-11 10:59:59.281-03	FINISHED	2016-10-11 10:59:41.551-03	2016-10-11 10:59:49.897-03	2016-10-11 10:59:49.897-03	2016-10-11 10:59:59.036-03	2016-10-11 10:59:59.036-03	2016-10-11 10:59:59.265-03	2016-10-11 10:59:59.284-03	2016-10-11 10:59:59.322-03
\.


--
-- TOC entry 2644 (class 0 OID 959344)
-- Dependencies: 183
-- Data for Name: eactivity; Type: TABLE DATA; Schema: public; Owner: vitor
--

COPY eactivity (actid, wkfid, tag, status, starttime, endtime, cactid, templatedir, constrained) FROM stdin;
46	39	ListFits	FINISHED	2016-10-11 10:55:37.144-03	2016-10-11 10:55:38.083-03	37	%=WFDIR%/template_listfits	F
47	39	Projection	FINISHED	2016-10-11 10:55:38.09-03	2016-10-11 10:59:08.268-03	38	%=WFDIR%/template_projection	F
48	39	SelectProjections	FINISHED	2016-10-11 10:59:08.272-03	2016-10-11 10:59:15.088-03	39	%=WFDIR%/template_selectprojections	F
50	39	CalculateOverlaps	FINISHED	2016-10-11 10:59:15.091-03	2016-10-11 10:59:17.999-03	41	%=WFDIR%/template_calculateoverlaps	F
51	39	ExtractDifferences	FINISHED	2016-10-11 10:59:18.018-03	2016-10-11 10:59:19.652-03	42	%=WFDIR%/template_extractdifferences	F
49	39	CreateUncorrectedMosaic	FINISHED	2016-10-11 10:59:15.097-03	2016-10-11 10:59:20.444-03	40	%=WFDIR%/template_createuncorrectedmosaic	F
52	39	CalculateDifference	FINISHED	2016-10-11 10:59:19.743-03	2016-10-11 10:59:29.923-03	43	%=WFDIR%/template_calculatedifference	F
53	39	FitPlane	FINISHED	2016-10-11 10:59:29.926-03	2016-10-11 10:59:40.778-03	44	%=WFDIR%/template_fitplane	F
54	39	CreateMosaic	FINISHED	2016-10-11 10:59:40.781-03	2016-10-11 10:59:59.328-03	45	%=WFDIR%/template_createmosaic	F
\.


--
-- TOC entry 2649 (class 0 OID 959378)
-- Dependencies: 188
-- Data for Name: ecommperf; Type: TABLE DATA; Schema: public; Owner: vitor
--

COPY ecommperf ("time", sender, receiver, ewkfid, message) FROM stdin;
\.


--
-- TOC entry 2648 (class 0 OID 959375)
-- Dependencies: 187
-- Data for Name: ecompperf; Type: TABLE DATA; Schema: public; Owner: vitor
--

COPY ecompperf ("time", machineid, processor, ewkfid, taskid) FROM stdin;
\.


--
-- TOC entry 2645 (class 0 OID 959352)
-- Dependencies: 184
-- Data for Name: efile; Type: TABLE DATA; Schema: public; Owner: vitor
--

COPY efile (fileid, actid, taskid, ftemplate, finstrumented, fdir, fname, fsize, fdata, foper, fieldname, indexed) FROM stdin;
4	46	2	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ListFits/251/286/114/0/	\N	0	\N	LINK	FNAME	F
3	46	2	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ListFits/251/286/114/0/	template_m101_1.00d.hdr	318	2016-10-11 10:55:37-03	COPY	HEADER	F
5	46	2	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ListFits/251/286/114/0/	2mass-atlas-990214n-j1100244.fits	2111040	2016-10-11 10:55:37-03	COPY		F
6	46	2	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ListFits/251/286/114/0/	2mass-atlas-990214n-j1100256.fits	2111040	2016-10-11 10:55:37-03	COPY		F
7	46	2	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ListFits/251/286/114/0/	2mass-atlas-990214n-j1110021.fits	2111040	2016-10-11 10:55:37-03	COPY		F
8	46	2	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ListFits/251/286/114/0/	2mass-atlas-990214n-j1110032.fits	2111040	2016-10-11 10:55:37-03	COPY		F
9	46	2	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ListFits/251/286/114/0/	2mass-atlas-990214n-j1180244.fits	2111040	2016-10-11 10:55:37-03	COPY		F
10	46	2	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ListFits/251/286/114/0/	2mass-atlas-990214n-j1180256.fits	2111040	2016-10-11 10:55:37-03	COPY		F
11	46	2	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ListFits/251/286/114/0/	2mass-atlas-990214n-j1190021.fits	2111040	2016-10-11 10:55:37-03	COPY		F
12	46	2	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ListFits/251/286/114/0/	2mass-atlas-990214n-j1190032.fits	2111040	2016-10-11 10:55:37-03	COPY		F
13	46	2	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ListFits/251/286/114/0/	2mass-atlas-990214n-j1200244.fits	2111040	2016-10-11 10:55:37-03	COPY		F
14	46	2	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ListFits/251/286/114/0/	2mass-atlas-990214n-j1200256.fits	2111040	2016-10-11 10:55:37-03	COPY		F
15	46	2	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ListFits/251/286/114/0/	EErr.txt	0	2016-10-11 10:55:37-03	COPY		F
16	46	2	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ListFits/251/286/114/0/	ERelation.txt	4582	2016-10-11 10:55:37-03	COPY		F
17	46	2	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ListFits/251/286/114/0/	EResult.txt	50	2016-10-11 10:55:37-03	COPY		F
18	46	2	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ListFits/251/286/114/0/	dllistfits.data	4582	2016-10-11 10:55:37-03	COPY		F
19	46	2	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ListFits/251/286/114/0/	experiment.cmd	228	2016-10-11 10:55:37-03	COPY		F
20	46	2	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ListFits/251/286/114/0/	extractor.cmd	250	2016-10-11 10:55:37-03	COPY		F
21	46	2	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ListFits/251/286/114/0/	images-rawdir.tbl	3284	2016-10-11 10:55:37-03	COPY		F
32	47	5	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/209/599/2/	\N	0	\N	COPY	HDU_AREA	F
30	47	5	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/209/599/2/	template_m101_1.00d.hdr	318	2016-10-11 10:55:38-03	COPY	HEADER	F
25	47	3	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/209/505/0/	\N	0	\N	COPY	HDU_FILE	F
24	47	3	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/209/505/0/	\N	0	\N	COPY	HDU_AREA	F
23	47	3	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/209/505/0/	2mass-atlas-990214n-j1100244.fits	2111040	2016-10-11 10:55:38-03	COPY	FNAME	F
22	47	3	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/209/505/0/	template_m101_1.00d.hdr	318	2016-10-11 10:55:38-03	COPY	HEADER	F
29	47	4	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/209/541/1/	\N	0	\N	COPY	HDU_FILE	F
28	47	4	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/209/541/1/	\N	0	\N	COPY	HDU_AREA	F
27	47	4	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/209/541/1/	2mass-atlas-990214n-j1100256.fits	2111040	2016-10-11 10:55:38-03	COPY	FNAME	F
26	47	4	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/209/541/1/	template_m101_1.00d.hdr	318	2016-10-11 10:55:38-03	COPY	HEADER	F
37	47	6	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/209/635/3/	\N	0	\N	COPY	HDU_FILE	F
36	47	6	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/209/635/3/	\N	0	\N	COPY	HDU_AREA	F
35	47	6	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/209/635/3/	2mass-atlas-990214n-j1110032.fits	2111040	2016-10-11 10:56:30-03	COPY	FNAME	F
34	47	6	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/209/635/3/	template_m101_1.00d.hdr	318	2016-10-11 10:56:30-03	COPY	HEADER	F
41	47	7	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/210/346/4/	\N	0	\N	COPY	HDU_FILE	F
40	47	7	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/210/346/4/	\N	0	\N	COPY	HDU_AREA	F
39	47	7	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/210/346/4/	2mass-atlas-990214n-j1180244.fits	2111040	2016-10-11 10:56:30-03	COPY	FNAME	F
38	47	7	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/210/346/4/	template_m101_1.00d.hdr	318	2016-10-11 10:56:30-03	COPY	HEADER	F
44	47	8	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/211/580/5/	\N	0	\N	COPY	HDU_AREA	F
43	47	8	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/211/580/5/	2mass-atlas-990214n-j1180256.fits	2111040	2016-10-11 10:56:31-03	COPY	FNAME	F
42	47	8	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/211/580/5/	template_m101_1.00d.hdr	318	2016-10-11 10:56:31-03	COPY	HEADER	F
33	47	5	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/209/599/2/	\N	0	\N	COPY	HDU_FILE	F
31	47	5	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/209/599/2/	2mass-atlas-990214n-j1110021.fits	2111040	2016-10-11 10:55:38-03	COPY	FNAME	F
62	47	5	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/209/599/2/	EErr.txt	0	2016-10-11 10:55:38-03	COPY		F
63	47	5	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/209/599/2/	ERelation.txt	444	2016-10-11 10:56:30-03	COPY		F
64	47	5	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/209/599/2/	EResult.txt	28	2016-10-11 10:56:29-03	COPY		F
65	47	5	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/209/599/2/	dlprojection.data	444	2016-10-11 10:56:30-03	COPY		F
66	47	5	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/209/599/2/	experiment.cmd	443	2016-10-11 10:55:38-03	COPY		F
67	47	5	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/209/599/2/	extractor.cmd	234	2016-10-11 10:55:38-03	COPY		F
68	47	5	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/209/599/2/	hdu0_2mass-atlas-990214n-j1110021.fits	4199040	2016-10-11 10:56:29-03	COPY		F
69	47	5	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/209/599/2/	hdu0_2mass-atlas-990214n-j1110021_area.fits	4199040	2016-10-11 10:56:29-03	COPY		F
70	47	3	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/209/505/0/	EErr.txt	0	2016-10-11 10:55:38-03	COPY		F
71	47	3	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/209/505/0/	ERelation.txt	444	2016-10-11 10:56:30-03	COPY		F
72	47	3	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/209/505/0/	EResult.txt	28	2016-10-11 10:56:30-03	COPY		F
73	47	3	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/209/505/0/	dlprojection.data	444	2016-10-11 10:56:30-03	COPY		F
74	47	3	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/209/505/0/	experiment.cmd	443	2016-10-11 10:55:38-03	COPY		F
75	47	3	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/209/505/0/	extractor.cmd	234	2016-10-11 10:55:38-03	COPY		F
76	47	3	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/209/505/0/	hdu0_2mass-atlas-990214n-j1100244.fits	4230720	2016-10-11 10:56:30-03	COPY		F
77	47	3	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/209/505/0/	hdu0_2mass-atlas-990214n-j1100244_area.fits	4230720	2016-10-11 10:56:30-03	COPY		F
78	47	4	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/209/541/1/	EErr.txt	0	2016-10-11 10:55:38-03	COPY		F
79	47	4	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/209/541/1/	ERelation.txt	444	2016-10-11 10:56:31-03	COPY		F
80	47	4	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/209/541/1/	EResult.txt	28	2016-10-11 10:56:31-03	COPY		F
81	47	4	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/209/541/1/	dlprojection.data	444	2016-10-11 10:56:31-03	COPY		F
82	47	4	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/209/541/1/	experiment.cmd	443	2016-10-11 10:55:38-03	COPY		F
83	47	4	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/209/541/1/	extractor.cmd	234	2016-10-11 10:55:38-03	COPY		F
84	47	4	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/209/541/1/	hdu0_2mass-atlas-990214n-j1100256.fits	4222080	2016-10-11 10:56:31-03	COPY		F
53	47	10	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/212/325/7/	\N	0	\N	COPY	HDU_FILE	F
52	47	10	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/212/325/7/	\N	0	\N	COPY	HDU_AREA	F
51	47	10	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/212/325/7/	2mass-atlas-990214n-j1190032.fits	2111040	2016-10-11 10:57:22-03	COPY	FNAME	F
50	47	10	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/212/325/7/	template_m101_1.00d.hdr	318	2016-10-11 10:57:23-03	COPY	HEADER	F
49	47	9	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/212/265/6/	\N	0	\N	COPY	HDU_FILE	F
48	47	9	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/212/265/6/	\N	0	\N	COPY	HDU_AREA	F
47	47	9	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/212/265/6/	2mass-atlas-990214n-j1190021.fits	2111040	2016-10-11 10:57:22-03	COPY	FNAME	F
46	47	9	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/212/265/6/	template_m101_1.00d.hdr	318	2016-10-11 10:57:22-03	COPY	HEADER	F
57	47	11	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/212/359/8/	\N	0	\N	COPY	HDU_FILE	F
56	47	11	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/212/359/8/	\N	0	\N	COPY	HDU_AREA	F
54	47	11	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/212/359/8/	template_m101_1.00d.hdr	318	2016-10-11 10:57:25-03	COPY	HEADER	F
58	47	12	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/212/418/9/	template_m101_1.00d.hdr	318	2016-10-11 10:58:19-03	COPY	HEADER	F
59	47	12	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/212/418/9/	2mass-atlas-990214n-j1200256.fits	2111040	2016-10-11 10:58:19-03	COPY	FNAME	F
60	47	12	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/212/418/9/	\N	0	\N	COPY	HDU_AREA	F
61	47	12	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/212/418/9/	\N	0	\N	COPY	HDU_FILE	F
85	47	4	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/209/541/1/	hdu0_2mass-atlas-990214n-j1100256_area.fits	4222080	2016-10-11 10:56:31-03	COPY		F
86	47	6	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/209/635/3/	EErr.txt	0	2016-10-11 10:56:30-03	COPY		F
87	47	6	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/209/635/3/	ERelation.txt	444	2016-10-11 10:57:22-03	COPY		F
88	47	6	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/209/635/3/	EResult.txt	28	2016-10-11 10:57:22-03	COPY		F
89	47	6	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/209/635/3/	dlprojection.data	444	2016-10-11 10:57:22-03	COPY		F
90	47	6	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/209/635/3/	experiment.cmd	443	2016-10-11 10:56:30-03	COPY		F
91	47	6	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/209/635/3/	extractor.cmd	234	2016-10-11 10:56:30-03	COPY		F
92	47	6	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/209/635/3/	hdu0_2mass-atlas-990214n-j1110032.fits	4199040	2016-10-11 10:57:22-03	COPY		F
93	47	6	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/209/635/3/	hdu0_2mass-atlas-990214n-j1110032_area.fits	4199040	2016-10-11 10:57:22-03	COPY		F
94	47	7	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/210/346/4/	EErr.txt	0	2016-10-11 10:56:30-03	COPY		F
95	47	7	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/210/346/4/	ERelation.txt	444	2016-10-11 10:57:22-03	COPY		F
96	47	7	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/210/346/4/	EResult.txt	28	2016-10-11 10:57:22-03	COPY		F
97	47	7	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/210/346/4/	dlprojection.data	444	2016-10-11 10:57:22-03	COPY		F
98	47	7	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/210/346/4/	experiment.cmd	443	2016-10-11 10:56:30-03	COPY		F
99	47	7	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/210/346/4/	extractor.cmd	234	2016-10-11 10:56:30-03	COPY		F
100	47	7	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/210/346/4/	hdu0_2mass-atlas-990214n-j1180244.fits	4190400	2016-10-11 10:57:22-03	COPY		F
101	47	7	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/210/346/4/	hdu0_2mass-atlas-990214n-j1180244_area.fits	4190400	2016-10-11 10:57:22-03	COPY		F
45	47	8	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/211/580/5/	\N	0	\N	COPY	HDU_FILE	F
102	47	8	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/211/580/5/	EErr.txt	0	2016-10-11 10:56:31-03	COPY		F
103	47	8	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/211/580/5/	ERelation.txt	444	2016-10-11 10:57:25-03	COPY		F
104	47	8	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/211/580/5/	EResult.txt	28	2016-10-11 10:57:25-03	COPY		F
105	47	8	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/211/580/5/	dlprojection.data	444	2016-10-11 10:57:25-03	COPY		F
106	47	8	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/211/580/5/	experiment.cmd	443	2016-10-11 10:56:31-03	COPY		F
107	47	8	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/211/580/5/	extractor.cmd	234	2016-10-11 10:56:31-03	COPY		F
108	47	8	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/211/580/5/	hdu0_2mass-atlas-990214n-j1180256.fits	4181760	2016-10-11 10:57:25-03	COPY		F
109	47	8	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/211/580/5/	hdu0_2mass-atlas-990214n-j1180256_area.fits	4181760	2016-10-11 10:57:25-03	COPY		F
110	47	10	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/212/325/7/	EErr.txt	0	2016-10-11 10:57:23-03	COPY		F
111	47	10	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/212/325/7/	ERelation.txt	444	2016-10-11 10:58:19-03	COPY		F
112	47	10	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/212/325/7/	EResult.txt	28	2016-10-11 10:58:18-03	COPY		F
113	47	10	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/212/325/7/	dlprojection.data	444	2016-10-11 10:58:19-03	COPY		F
114	47	10	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/212/325/7/	experiment.cmd	443	2016-10-11 10:57:23-03	COPY		F
115	47	10	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/212/325/7/	extractor.cmd	234	2016-10-11 10:57:23-03	COPY		F
116	47	10	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/212/325/7/	hdu0_2mass-atlas-990214n-j1190032.fits	4210560	2016-10-11 10:58:18-03	COPY		F
117	47	10	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/212/325/7/	hdu0_2mass-atlas-990214n-j1190032_area.fits	4210560	2016-10-11 10:58:18-03	COPY		F
118	47	9	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/212/265/6/	EErr.txt	0	2016-10-11 10:57:22-03	COPY		F
119	47	9	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/212/265/6/	ERelation.txt	444	2016-10-11 10:58:20-03	COPY		F
120	47	9	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/212/265/6/	EResult.txt	28	2016-10-11 10:58:20-03	COPY		F
121	47	9	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/212/265/6/	dlprojection.data	444	2016-10-11 10:58:20-03	COPY		F
122	47	9	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/212/265/6/	experiment.cmd	443	2016-10-11 10:57:22-03	COPY		F
123	47	9	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/212/265/6/	extractor.cmd	234	2016-10-11 10:57:22-03	COPY		F
124	47	9	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/212/265/6/	hdu0_2mass-atlas-990214n-j1190021.fits	4210560	2016-10-11 10:58:19-03	COPY		F
125	47	9	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/212/265/6/	hdu0_2mass-atlas-990214n-j1190021_area.fits	4210560	2016-10-11 10:58:19-03	COPY		F
55	47	11	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/212/359/8/	2mass-atlas-990214n-j1200244.fits	2111040	2016-10-11 10:57:25-03	COPY	FNAME	F
126	47	11	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/212/359/8/	EErr.txt	0	2016-10-11 10:57:25-03	COPY		F
127	47	11	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/212/359/8/	ERelation.txt	444	2016-10-11 10:58:22-03	COPY		F
128	47	11	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/212/359/8/	EResult.txt	28	2016-10-11 10:58:22-03	COPY		F
129	47	11	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/212/359/8/	dlprojection.data	444	2016-10-11 10:58:22-03	COPY		F
130	47	11	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/212/359/8/	experiment.cmd	443	2016-10-11 10:57:25-03	COPY		F
131	47	11	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/212/359/8/	extractor.cmd	234	2016-10-11 10:57:25-03	COPY		F
132	47	11	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/212/359/8/	hdu0_2mass-atlas-990214n-j1200244.fits	4239360	2016-10-11 10:58:22-03	COPY		F
133	47	11	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/212/359/8/	hdu0_2mass-atlas-990214n-j1200244_area.fits	4239360	2016-10-11 10:58:22-03	COPY		F
134	47	12	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/212/418/9/	EErr.txt	0	2016-10-11 10:58:19-03	COPY		F
135	47	12	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/212/418/9/	ERelation.txt	444	2016-10-11 10:59:08-03	COPY		F
136	47	12	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/212/418/9/	EResult.txt	28	2016-10-11 10:59:07-03	COPY		F
137	47	12	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/212/418/9/	dlprojection.data	444	2016-10-11 10:59:08-03	COPY		F
138	47	12	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/212/418/9/	experiment.cmd	443	2016-10-11 10:58:19-03	COPY		F
139	47	12	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/212/418/9/	extractor.cmd	234	2016-10-11 10:58:19-03	COPY		F
140	47	12	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/212/418/9/	hdu0_2mass-atlas-990214n-j1200256.fits	4222080	2016-10-11 10:59:07-03	COPY		F
141	47	12	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/Projection/252/212/418/9/	hdu0_2mass-atlas-990214n-j1200256_area.fits	4222080	2016-10-11 10:59:07-03	COPY		F
143	48	13	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/SelectProjections/145/236/741/0/	hdu0_2mass-atlas-990214n-j1110021.fits	4199040	2016-10-11 10:59:08-03	COPY	HDU_AREA	F
144	48	13	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/SelectProjections/145/236/741/0/	hdu0_2mass-atlas-990214n-j1110021_area.fits	4199040	2016-10-11 10:59:08-03	COPY	HDU_FILE	F
145	48	13	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/SelectProjections/145/236/741/0/	template_m101_1.00d.hdr	318	2016-10-11 10:59:09-03	COPY	HEADER	F
146	48	13	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/SelectProjections/145/236/741/0/	hdu0_2mass-atlas-990214n-j1100244.fits	4230720	2016-10-11 10:59:08-03	COPY	HDU_AREA	F
147	48	13	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/SelectProjections/145/236/741/0/	hdu0_2mass-atlas-990214n-j1100244_area.fits	4230720	2016-10-11 10:59:08-03	COPY	HDU_FILE	F
148	48	13	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/SelectProjections/145/236/741/0/	template_m101_1.00d.hdr	318	2016-10-11 10:59:09-03	COPY	HEADER	F
149	48	13	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/SelectProjections/145/236/741/0/	hdu0_2mass-atlas-990214n-j1100256.fits	4222080	2016-10-11 10:59:08-03	COPY	HDU_AREA	F
151	48	13	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/SelectProjections/145/236/741/0/	template_m101_1.00d.hdr	318	2016-10-11 10:59:09-03	COPY	HEADER	F
152	48	13	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/SelectProjections/145/236/741/0/	hdu0_2mass-atlas-990214n-j1110032.fits	4199040	2016-10-11 10:59:09-03	COPY	HDU_AREA	F
153	48	13	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/SelectProjections/145/236/741/0/	hdu0_2mass-atlas-990214n-j1110032_area.fits	4199040	2016-10-11 10:59:09-03	COPY	HDU_FILE	F
154	48	13	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/SelectProjections/145/236/741/0/	template_m101_1.00d.hdr	318	2016-10-11 10:59:09-03	COPY	HEADER	F
155	48	13	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/SelectProjections/145/236/741/0/	hdu0_2mass-atlas-990214n-j1180244.fits	4190400	2016-10-11 10:59:09-03	COPY	HDU_AREA	F
156	48	13	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/SelectProjections/145/236/741/0/	hdu0_2mass-atlas-990214n-j1180244_area.fits	4190400	2016-10-11 10:59:09-03	COPY	HDU_FILE	F
157	48	13	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/SelectProjections/145/236/741/0/	template_m101_1.00d.hdr	318	2016-10-11 10:59:09-03	COPY	HEADER	F
158	48	13	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/SelectProjections/145/236/741/0/	hdu0_2mass-atlas-990214n-j1180256.fits	4181760	2016-10-11 10:59:09-03	COPY	HDU_AREA	F
159	48	13	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/SelectProjections/145/236/741/0/	hdu0_2mass-atlas-990214n-j1180256_area.fits	4181760	2016-10-11 10:59:09-03	COPY	HDU_FILE	F
160	48	13	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/SelectProjections/145/236/741/0/	template_m101_1.00d.hdr	318	2016-10-11 10:59:09-03	COPY	HEADER	F
161	48	13	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/SelectProjections/145/236/741/0/	hdu0_2mass-atlas-990214n-j1190032.fits	4210560	2016-10-11 10:59:09-03	COPY	HDU_AREA	F
162	48	13	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/SelectProjections/145/236/741/0/	hdu0_2mass-atlas-990214n-j1190032_area.fits	4210560	2016-10-11 10:59:09-03	COPY	HDU_FILE	F
163	48	13	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/SelectProjections/145/236/741/0/	template_m101_1.00d.hdr	318	2016-10-11 10:59:09-03	COPY	HEADER	F
142	48	13	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/SelectProjections/145/236/741/0/	template_m101_1.00d.hdr	318	2016-10-11 10:59:09-03	COPY	HEADER	F
150	48	13	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/SelectProjections/145/236/741/0/	hdu0_2mass-atlas-990214n-j1100256_area.fits	4222080	2016-10-11 10:59:08-03	COPY	HDU_FILE	F
164	48	13	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/SelectProjections/145/236/741/0/	hdu0_2mass-atlas-990214n-j1190021.fits	4210560	2016-10-11 10:59:09-03	COPY	HDU_AREA	F
165	48	13	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/SelectProjections/145/236/741/0/	hdu0_2mass-atlas-990214n-j1190021_area.fits	4210560	2016-10-11 10:59:09-03	COPY	HDU_FILE	F
166	48	13	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/SelectProjections/145/236/741/0/	template_m101_1.00d.hdr	318	2016-10-11 10:59:09-03	COPY	HEADER	F
167	48	13	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/SelectProjections/145/236/741/0/	hdu0_2mass-atlas-990214n-j1200244.fits	4239360	2016-10-11 10:59:09-03	COPY	HDU_AREA	F
168	48	13	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/SelectProjections/145/236/741/0/	hdu0_2mass-atlas-990214n-j1200244_area.fits	4239360	2016-10-11 10:59:09-03	COPY	HDU_FILE	F
169	48	13	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/SelectProjections/145/236/741/0/	template_m101_1.00d.hdr	318	2016-10-11 10:59:09-03	COPY	HEADER	F
170	48	13	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/SelectProjections/145/236/741/0/	hdu0_2mass-atlas-990214n-j1200256.fits	4222080	2016-10-11 10:59:09-03	COPY	HDU_AREA	F
171	48	13	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/SelectProjections/145/236/741/0/	hdu0_2mass-atlas-990214n-j1200256_area.fits	4222080	2016-10-11 10:59:09-03	COPY	HDU_FILE	F
172	48	13	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/SelectProjections/145/236/741/0/	\N	0	\N	COPY	MOSAIC_FITS	F
173	48	13	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/SelectProjections/145/236/741/0/	\N	0	\N	COPY	MOSAIC_AREA	F
174	48	13	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/SelectProjections/145/236/741/0/	EErr.txt	0	2016-10-11 10:59:09-03	COPY		F
175	48	13	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/SelectProjections/145/236/741/0/	ERelation.txt	437	2016-10-11 10:59:14-03	COPY		F
176	48	13	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/SelectProjections/145/236/741/0/	EResult.txt	77	2016-10-11 10:59:14-03	COPY		F
177	48	13	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/SelectProjections/145/236/741/0/	dlselectprojections.data	437	2016-10-11 10:59:14-03	COPY		F
178	48	13	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/SelectProjections/145/236/741/0/	experiment.cmd	243	2016-10-11 10:59:09-03	COPY		F
179	48	13	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/SelectProjections/145/236/741/0/	extractor.cmd	241	2016-10-11 10:59:09-03	COPY		F
180	48	13	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/SelectProjections/145/236/741/0/	images.tbl	3344	2016-10-11 10:59:09-03	COPY		F
181	48	13	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/SelectProjections/145/236/741/0/	m101_uncorrected.fits	39602880	2016-10-11 10:59:11-03	COPY		F
182	48	13	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/SelectProjections/145/236/741/0/	m101_uncorrected_area.fits	39602880	2016-10-11 10:59:11-03	COPY		F
183	48	13	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/SelectProjections/145/236/741/0/	oprojection.hfrag	6124	2016-10-11 10:59:08-03	COPY		F
189	50	14	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateOverlaps/142/651/065/0/	hdu0_2mass-atlas-990214n-j1100244_area.fits	4230720	2016-10-11 10:59:16-03	COPY	HDU_FILE	F
188	50	14	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateOverlaps/142/651/065/0/	hdu0_2mass-atlas-990214n-j1100244.fits	4230720	2016-10-11 10:59:16-03	COPY	HDU_AREA	F
187	50	14	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateOverlaps/142/651/065/0/	template_m101_1.00d.hdr	318	2016-10-11 10:59:16-03	COPY	HEADER	F
186	50	14	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateOverlaps/142/651/065/0/	hdu0_2mass-atlas-990214n-j1110021_area.fits	4199040	2016-10-11 10:59:16-03	COPY	HDU_FILE	F
185	50	14	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateOverlaps/142/651/065/0/	hdu0_2mass-atlas-990214n-j1110021.fits	4199040	2016-10-11 10:59:16-03	COPY	HDU_AREA	F
184	50	14	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateOverlaps/142/651/065/0/	template_m101_1.00d.hdr	318	2016-10-11 10:59:16-03	COPY	HEADER	F
214	50	14	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateOverlaps/142/651/065/0/	\N	0	\N	COPY	DIFFS_TBL	F
213	50	14	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateOverlaps/142/651/065/0/	hdu0_2mass-atlas-990214n-j1200256_area.fits	4222080	2016-10-11 10:59:15-03	COPY	HDU_FILE	F
212	50	14	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateOverlaps/142/651/065/0/	hdu0_2mass-atlas-990214n-j1200256.fits	4222080	2016-10-11 10:59:15-03	COPY	HDU_AREA	F
211	50	14	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateOverlaps/142/651/065/0/	template_m101_1.00d.hdr	318	2016-10-11 10:59:16-03	COPY	HEADER	F
210	50	14	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateOverlaps/142/651/065/0/	hdu0_2mass-atlas-990214n-j1200244_area.fits	4239360	2016-10-11 10:59:15-03	COPY	HDU_FILE	F
209	50	14	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateOverlaps/142/651/065/0/	hdu0_2mass-atlas-990214n-j1200244.fits	4239360	2016-10-11 10:59:15-03	COPY	HDU_AREA	F
208	50	14	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateOverlaps/142/651/065/0/	template_m101_1.00d.hdr	318	2016-10-11 10:59:16-03	COPY	HEADER	F
207	50	14	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateOverlaps/142/651/065/0/	hdu0_2mass-atlas-990214n-j1190021_area.fits	4210560	2016-10-11 10:59:15-03	COPY	HDU_FILE	F
206	50	14	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateOverlaps/142/651/065/0/	hdu0_2mass-atlas-990214n-j1190021.fits	4210560	2016-10-11 10:59:15-03	COPY	HDU_AREA	F
205	50	14	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateOverlaps/142/651/065/0/	template_m101_1.00d.hdr	318	2016-10-11 10:59:16-03	COPY	HEADER	F
204	50	14	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateOverlaps/142/651/065/0/	hdu0_2mass-atlas-990214n-j1190032_area.fits	4210560	2016-10-11 10:59:15-03	COPY	HDU_FILE	F
203	50	14	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateOverlaps/142/651/065/0/	hdu0_2mass-atlas-990214n-j1190032.fits	4210560	2016-10-11 10:59:15-03	COPY	HDU_AREA	F
202	50	14	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateOverlaps/142/651/065/0/	template_m101_1.00d.hdr	318	2016-10-11 10:59:16-03	COPY	HEADER	F
201	50	14	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateOverlaps/142/651/065/0/	hdu0_2mass-atlas-990214n-j1180256_area.fits	4181760	2016-10-11 10:59:16-03	COPY	HDU_FILE	F
200	50	14	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateOverlaps/142/651/065/0/	hdu0_2mass-atlas-990214n-j1180256.fits	4181760	2016-10-11 10:59:16-03	COPY	HDU_AREA	F
199	50	14	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateOverlaps/142/651/065/0/	template_m101_1.00d.hdr	318	2016-10-11 10:59:16-03	COPY	HEADER	F
198	50	14	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateOverlaps/142/651/065/0/	hdu0_2mass-atlas-990214n-j1180244_area.fits	4190400	2016-10-11 10:59:16-03	COPY	HDU_FILE	F
197	50	14	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateOverlaps/142/651/065/0/	hdu0_2mass-atlas-990214n-j1180244.fits	4190400	2016-10-11 10:59:16-03	COPY	HDU_AREA	F
196	50	14	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateOverlaps/142/651/065/0/	template_m101_1.00d.hdr	318	2016-10-11 10:59:16-03	COPY	HEADER	F
195	50	14	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateOverlaps/142/651/065/0/	hdu0_2mass-atlas-990214n-j1110032_area.fits	4199040	2016-10-11 10:59:16-03	COPY	HDU_FILE	F
194	50	14	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateOverlaps/142/651/065/0/	hdu0_2mass-atlas-990214n-j1110032.fits	4199040	2016-10-11 10:59:16-03	COPY	HDU_AREA	F
193	50	14	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateOverlaps/142/651/065/0/	template_m101_1.00d.hdr	318	2016-10-11 10:59:16-03	COPY	HEADER	F
192	50	14	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateOverlaps/142/651/065/0/	hdu0_2mass-atlas-990214n-j1100256_area.fits	4222080	2016-10-11 10:59:16-03	COPY	HDU_FILE	F
191	50	14	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateOverlaps/142/651/065/0/	hdu0_2mass-atlas-990214n-j1100256.fits	4222080	2016-10-11 10:59:16-03	COPY	HDU_AREA	F
190	50	14	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateOverlaps/142/651/065/0/	template_m101_1.00d.hdr	318	2016-10-11 10:59:16-03	COPY	HEADER	F
219	50	14	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateOverlaps/142/651/065/0/	EErr.txt	0	2016-10-11 10:59:17-03	COPY		F
220	50	14	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateOverlaps/142/651/065/0/	ERelation.txt	394	2016-10-11 10:59:17-03	COPY		F
221	50	14	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateOverlaps/142/651/065/0/	EResult.txt	79	2016-10-11 10:59:17-03	COPY		F
222	50	14	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateOverlaps/142/651/065/0/	diffs.tbl	2307	2016-10-11 10:59:17-03	COPY		F
218	49	15	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateUncorrectedMosaic/142/650/960/0/	\N	0	\N	LINK	MOSAIC_JPG	F
217	49	15	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateUncorrectedMosaic/142/650/960/0/	m101_uncorrected_area.fits	39602880	2016-10-11 10:59:16-03	COPY	MOSAIC_AREA	F
216	49	15	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateUncorrectedMosaic/142/650/960/0/	m101_uncorrected.fits	39602880	2016-10-11 10:59:16-03	COPY	MOSAIC_FITS	F
215	49	15	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateUncorrectedMosaic/142/650/960/0/	template_m101_1.00d.hdr	318	2016-10-11 10:59:15-03	COPY	HEADER	F
223	50	14	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateOverlaps/142/651/065/0/	dlcalculateoverlaps.data	394	2016-10-11 10:59:17-03	COPY		F
224	50	14	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateOverlaps/142/651/065/0/	experiment.cmd	91	2016-10-11 10:59:17-03	COPY		F
225	50	14	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateOverlaps/142/651/065/0/	extractor.cmd	242	2016-10-11 10:59:17-03	COPY		F
226	50	14	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateOverlaps/142/651/065/0/	images.tbl	3344	2016-10-11 10:59:17-03	COPY		F
227	50	14	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateOverlaps/142/651/065/0/	oprojection.hfrag	6198	2016-10-11 10:59:15-03	COPY		F
233	51	16	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/	\N	0	\N	COPY	MINUS_AREA	F
232	51	16	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/	\N	0	\N	COPY	MINUS	F
231	51	16	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/	\N	0	\N	COPY	PLUS_AREA	F
230	51	16	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/	\N	0	\N	COPY	PLUS	F
229	51	16	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/	diffs.tbl	2307	2016-10-11 10:59:18-03	COPY	DIFFS_TBL	F
228	51	16	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/	template_m101_1.00d.hdr	318	2016-10-11 10:59:18-03	COPY	HEADER	F
234	51	16	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/	EErr.txt	0	2016-10-11 10:59:18-03	COPY		F
235	51	16	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/	ERelation.txt	12986	2016-10-11 10:59:19-03	COPY		F
236	51	16	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/	EResult.txt	0	2016-10-11 10:59:18-03	COPY		F
237	51	16	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/	dlextractdifferences.data	12986	2016-10-11 10:59:19-03	COPY		F
238	51	16	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/	experiment.cmd	132	2016-10-11 10:59:18-03	COPY		F
239	51	16	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/	extractor.cmd	254	2016-10-11 10:59:18-03	COPY		F
240	51	16	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/	hdu0_2mass-atlas-990214n-j1100244.fits	4230720	2016-10-11 10:59:18-03	COPY		F
241	51	16	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/	hdu0_2mass-atlas-990214n-j1100244_area.fits	4230720	2016-10-11 10:59:18-03	COPY		F
242	51	16	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/	hdu0_2mass-atlas-990214n-j1100256.fits	4222080	2016-10-11 10:59:18-03	COPY		F
243	51	16	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/	hdu0_2mass-atlas-990214n-j1100256_area.fits	4222080	2016-10-11 10:59:18-03	COPY		F
244	51	16	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/	hdu0_2mass-atlas-990214n-j1110021.fits	4199040	2016-10-11 10:59:18-03	COPY		F
245	51	16	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/	hdu0_2mass-atlas-990214n-j1110021_area.fits	4199040	2016-10-11 10:59:18-03	COPY		F
246	51	16	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/	hdu0_2mass-atlas-990214n-j1110032.fits	4199040	2016-10-11 10:59:18-03	COPY		F
247	51	16	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/	hdu0_2mass-atlas-990214n-j1110032_area.fits	4199040	2016-10-11 10:59:18-03	COPY		F
248	51	16	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/	hdu0_2mass-atlas-990214n-j1180244.fits	4190400	2016-10-11 10:59:18-03	COPY		F
249	51	16	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/	hdu0_2mass-atlas-990214n-j1180244_area.fits	4190400	2016-10-11 10:59:18-03	COPY		F
250	51	16	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/	hdu0_2mass-atlas-990214n-j1180256.fits	4181760	2016-10-11 10:59:18-03	COPY		F
251	51	16	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/	hdu0_2mass-atlas-990214n-j1180256_area.fits	4181760	2016-10-11 10:59:19-03	COPY		F
252	51	16	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/	hdu0_2mass-atlas-990214n-j1190021.fits	4210560	2016-10-11 10:59:19-03	COPY		F
253	51	16	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/	hdu0_2mass-atlas-990214n-j1190021_area.fits	4210560	2016-10-11 10:59:19-03	COPY		F
254	51	16	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/	hdu0_2mass-atlas-990214n-j1190032.fits	4210560	2016-10-11 10:59:19-03	COPY		F
255	51	16	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/	hdu0_2mass-atlas-990214n-j1190032_area.fits	4210560	2016-10-11 10:59:19-03	COPY		F
256	51	16	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/	hdu0_2mass-atlas-990214n-j1200244.fits	4239360	2016-10-11 10:59:19-03	COPY		F
257	51	16	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/	hdu0_2mass-atlas-990214n-j1200244_area.fits	4239360	2016-10-11 10:59:19-03	COPY		F
258	51	16	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/	hdu0_2mass-atlas-990214n-j1200256.fits	4222080	2016-10-11 10:59:19-03	COPY		F
259	51	16	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/ExtractDifferences/142/374/295/0/	hdu0_2mass-atlas-990214n-j1200256_area.fits	4222080	2016-10-11 10:59:19-03	COPY		F
268	49	15	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateUncorrectedMosaic/142/650/960/0/	EErr.txt	0	2016-10-11 10:59:17-03	COPY		F
270	49	15	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateUncorrectedMosaic/142/650/960/0/	ERelation.txt	303	2016-10-11 10:59:20-03	COPY		F
271	49	15	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateUncorrectedMosaic/142/650/960/0/	EResult.txt	81	2016-10-11 10:59:19-03	COPY		F
273	49	15	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateUncorrectedMosaic/142/650/960/0/	dlcreateumosaic.data	303	2016-10-11 10:59:20-03	COPY		F
274	49	15	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateUncorrectedMosaic/142/650/960/0/	experiment.cmd	216	2016-10-11 10:59:17-03	COPY		F
276	49	15	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateUncorrectedMosaic/142/650/960/0/	extractor.cmd	247	2016-10-11 10:59:17-03	COPY		F
277	49	15	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateUncorrectedMosaic/142/650/960/0/	mosaic_uncorrected.jpg	766467	2016-10-11 10:59:19-03	COPY		F
266	52	17	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/142/281/192/0/	\N	0	\N	COPY	DIFF_AREA	F
265	52	17	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/142/281/192/0/	\N	0	\N	COPY	DIFF_FITS	F
264	52	17	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/142/281/192/0/	hdu0_2mass-atlas-990214n-j1100256_area.fits	4222080	2016-10-11 10:59:19-03	COPY	MINUS_AREA	F
263	52	17	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/142/281/192/0/	hdu0_2mass-atlas-990214n-j1100256.fits	4222080	2016-10-11 10:59:19-03	COPY	MINUS	F
262	52	17	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/142/281/192/0/	hdu0_2mass-atlas-990214n-j1100244_area.fits	4230720	2016-10-11 10:59:19-03	COPY	PLUS_AREA	F
261	52	17	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/142/281/192/0/	hdu0_2mass-atlas-990214n-j1100244.fits	4230720	2016-10-11 10:59:19-03	COPY	PLUS	F
260	52	17	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/142/281/192/0/	template_m101_1.00d.hdr	318	2016-10-11 10:59:19-03	COPY	HEADER	F
288	52	17	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/142/281/192/0/	EErr.txt	0	2016-10-11 10:59:20-03	COPY		F
289	52	17	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/142/281/192/0/	ERelation.txt	1528	2016-10-11 10:59:21-03	COPY		F
290	52	17	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/142/281/192/0/	EResult.txt	19	2016-10-11 10:59:20-03	COPY		F
280	52	18	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/250/193/1/	\N	0	\N	COPY	DIFF_AREA	F
279	52	18	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/250/193/1/	\N	0	\N	COPY	DIFF_FITS	F
278	52	18	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/250/193/1/	hdu0_2mass-atlas-990214n-j1110021_area.fits	4199040	2016-10-11 10:59:20-03	COPY	MINUS_AREA	F
275	52	18	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/250/193/1/	hdu0_2mass-atlas-990214n-j1110021.fits	4199040	2016-10-11 10:59:20-03	COPY	MINUS	F
272	52	18	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/250/193/1/	hdu0_2mass-atlas-990214n-j1100244_area.fits	4230720	2016-10-11 10:59:20-03	COPY	PLUS_AREA	F
269	52	18	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/250/193/1/	hdu0_2mass-atlas-990214n-j1100244.fits	4230720	2016-10-11 10:59:20-03	COPY	PLUS	F
267	52	18	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/250/193/1/	template_m101_1.00d.hdr	318	2016-10-11 10:59:20-03	COPY	HEADER	F
287	52	19	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/249/808/2/	\N	0	\N	COPY	DIFF_AREA	F
286	52	19	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/249/808/2/	\N	0	\N	COPY	DIFF_FITS	F
285	52	19	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/249/808/2/	hdu0_2mass-atlas-990214n-j1110032_area.fits	4199040	2016-10-11 10:59:20-03	COPY	MINUS_AREA	F
284	52	19	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/249/808/2/	hdu0_2mass-atlas-990214n-j1110032.fits	4199040	2016-10-11 10:59:20-03	COPY	MINUS	F
283	52	19	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/249/808/2/	hdu0_2mass-atlas-990214n-j1100244_area.fits	4230720	2016-10-11 10:59:20-03	COPY	PLUS_AREA	F
282	52	19	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/249/808/2/	hdu0_2mass-atlas-990214n-j1100244.fits	4230720	2016-10-11 10:59:20-03	COPY	PLUS	F
281	52	19	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/249/808/2/	template_m101_1.00d.hdr	318	2016-10-11 10:59:20-03	COPY	HEADER	F
291	52	20	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/157/657/3/	template_m101_1.00d.hdr	318	2016-10-11 10:59:21-03	COPY	HEADER	F
292	52	17	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/142/281/192/0/	diff.000000.000001.fits	236160	2016-10-11 10:59:20-03	COPY		F
294	52	17	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/142/281/192/0/	diff.000000.000001_area.fits	236160	2016-10-11 10:59:20-03	COPY		F
296	52	17	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/142/281/192/0/	dlcalculatedifference.data	1528	2016-10-11 10:59:21-03	COPY		F
298	52	17	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/142/281/192/0/	experiment.cmd	485	2016-10-11 10:59:20-03	COPY		F
300	52	17	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/142/281/192/0/	extractor.cmd	641	2016-10-11 10:59:20-03	COPY		F
310	52	18	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/250/193/1/	EErr.txt	0	2016-10-11 10:59:20-03	COPY		F
311	52	18	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/250/193/1/	ERelation.txt	1528	2016-10-11 10:59:21-03	COPY		F
312	52	18	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/250/193/1/	EResult.txt	19	2016-10-11 10:59:20-03	COPY		F
313	52	18	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/250/193/1/	diff.000000.000002.fits	152640	2016-10-11 10:59:20-03	COPY		F
314	52	18	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/250/193/1/	diff.000000.000002_area.fits	152640	2016-10-11 10:59:20-03	COPY		F
315	52	18	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/250/193/1/	dlcalculatedifference.data	1528	2016-10-11 10:59:21-03	COPY		F
316	52	18	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/250/193/1/	experiment.cmd	485	2016-10-11 10:59:20-03	COPY		F
317	52	18	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/250/193/1/	extractor.cmd	641	2016-10-11 10:59:20-03	COPY		F
325	52	19	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/249/808/2/	EErr.txt	0	2016-10-11 10:59:21-03	COPY		F
326	52	19	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/249/808/2/	ERelation.txt	1528	2016-10-11 10:59:22-03	COPY		F
327	52	19	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/249/808/2/	EResult.txt	19	2016-10-11 10:59:21-03	COPY		F
328	52	19	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/249/808/2/	diff.000000.000003.fits	506880	2016-10-11 10:59:21-03	COPY		F
329	52	19	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/249/808/2/	diff.000000.000003_area.fits	506880	2016-10-11 10:59:21-03	COPY		F
330	52	19	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/249/808/2/	dlcalculatedifference.data	1528	2016-10-11 10:59:22-03	COPY		F
299	52	20	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/157/657/3/	hdu0_2mass-atlas-990214n-j1110021_area.fits	4199040	2016-10-11 10:59:21-03	COPY	MINUS_AREA	F
297	52	20	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/157/657/3/	hdu0_2mass-atlas-990214n-j1110021.fits	4199040	2016-10-11 10:59:21-03	COPY	MINUS	F
295	52	20	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/157/657/3/	hdu0_2mass-atlas-990214n-j1100256_area.fits	4222080	2016-10-11 10:59:21-03	COPY	PLUS_AREA	F
293	52	20	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/157/657/3/	hdu0_2mass-atlas-990214n-j1100256.fits	4222080	2016-10-11 10:59:21-03	COPY	PLUS	F
309	52	21	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/157/382/4/	\N	0	\N	COPY	DIFF_AREA	F
308	52	21	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/157/382/4/	\N	0	\N	COPY	DIFF_FITS	F
307	52	21	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/157/382/4/	hdu0_2mass-atlas-990214n-j1110032_area.fits	4199040	2016-10-11 10:59:21-03	COPY	MINUS_AREA	F
306	52	21	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/157/382/4/	hdu0_2mass-atlas-990214n-j1110032.fits	4199040	2016-10-11 10:59:21-03	COPY	MINUS	F
305	52	21	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/157/382/4/	hdu0_2mass-atlas-990214n-j1110021_area.fits	4199040	2016-10-11 10:59:21-03	COPY	PLUS_AREA	F
304	52	21	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/157/382/4/	hdu0_2mass-atlas-990214n-j1110021.fits	4199040	2016-10-11 10:59:21-03	COPY	PLUS	F
303	52	21	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/157/382/4/	template_m101_1.00d.hdr	318	2016-10-11 10:59:21-03	COPY	HEADER	F
324	52	22	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/065/293/5/	\N	0	\N	COPY	DIFF_AREA	F
323	52	22	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/065/293/5/	\N	0	\N	COPY	DIFF_FITS	F
321	52	22	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/065/293/5/	hdu0_2mass-atlas-990214n-j1180244.fits	4190400	2016-10-11 10:59:22-03	COPY	MINUS	F
320	52	22	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/065/293/5/	hdu0_2mass-atlas-990214n-j1110021_area.fits	4199040	2016-10-11 10:59:22-03	COPY	PLUS_AREA	F
319	52	22	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/065/293/5/	hdu0_2mass-atlas-990214n-j1110021.fits	4199040	2016-10-11 10:59:22-03	COPY	PLUS	F
318	52	22	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/065/293/5/	template_m101_1.00d.hdr	318	2016-10-11 10:59:22-03	COPY	HEADER	F
331	52	19	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/249/808/2/	experiment.cmd	485	2016-10-11 10:59:21-03	COPY		F
332	52	19	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/249/808/2/	extractor.cmd	641	2016-10-11 10:59:21-03	COPY		F
302	52	20	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/157/657/3/	\N	0	\N	COPY	DIFF_AREA	F
301	52	20	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/157/657/3/	\N	0	\N	COPY	DIFF_FITS	F
340	52	20	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/157/657/3/	EErr.txt	0	2016-10-11 10:59:21-03	COPY		F
341	52	20	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/157/657/3/	ERelation.txt	1528	2016-10-11 10:59:22-03	COPY		F
342	52	20	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/157/657/3/	EResult.txt	19	2016-10-11 10:59:21-03	COPY		F
343	52	20	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/157/657/3/	diff.000001.000002.fits	492480	2016-10-11 10:59:21-03	COPY		F
344	52	20	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/157/657/3/	diff.000001.000002_area.fits	492480	2016-10-11 10:59:21-03	COPY		F
345	52	20	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/157/657/3/	dlcalculatedifference.data	1528	2016-10-11 10:59:22-03	COPY		F
346	52	20	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/157/657/3/	experiment.cmd	485	2016-10-11 10:59:21-03	COPY		F
347	52	20	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/157/657/3/	extractor.cmd	641	2016-10-11 10:59:21-03	COPY		F
353	52	24	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/064/629/7/	\N	0	\N	COPY	DIFF_FITS	F
351	52	24	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/064/629/7/	hdu0_2mass-atlas-990214n-j1180244.fits	4190400	2016-10-11 10:59:23-03	COPY	MINUS	F
350	52	24	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/064/629/7/	hdu0_2mass-atlas-990214n-j1110032_area.fits	4199040	2016-10-11 10:59:23-03	COPY	PLUS_AREA	F
349	52	24	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/064/629/7/	hdu0_2mass-atlas-990214n-j1110032.fits	4199040	2016-10-11 10:59:23-03	COPY	PLUS	F
348	52	24	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/064/629/7/	template_m101_1.00d.hdr	318	2016-10-11 10:59:22-03	COPY	HEADER	F
339	52	23	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/064/909/6/	\N	0	\N	COPY	DIFF_AREA	F
338	52	23	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/064/909/6/	\N	0	\N	COPY	DIFF_FITS	F
337	52	23	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/064/909/6/	hdu0_2mass-atlas-990214n-j1180256_area.fits	4181760	2016-10-11 10:59:22-03	COPY	MINUS_AREA	F
336	52	23	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/064/909/6/	hdu0_2mass-atlas-990214n-j1180256.fits	4181760	2016-10-11 10:59:22-03	COPY	MINUS	F
335	52	23	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/064/909/6/	hdu0_2mass-atlas-990214n-j1110021_area.fits	4199040	2016-10-11 10:59:22-03	COPY	PLUS_AREA	F
334	52	23	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/064/909/6/	hdu0_2mass-atlas-990214n-j1110021.fits	4199040	2016-10-11 10:59:22-03	COPY	PLUS	F
333	52	23	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/064/909/6/	template_m101_1.00d.hdr	318	2016-10-11 10:59:22-03	COPY	HEADER	F
361	52	25	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/973/038/8/	\N	0	\N	COPY	DIFF_AREA	F
360	52	25	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/973/038/8/	\N	0	\N	COPY	DIFF_FITS	F
359	52	25	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/973/038/8/	hdu0_2mass-atlas-990214n-j1180256_area.fits	4181760	2016-10-11 10:59:23-03	COPY	MINUS_AREA	F
358	52	25	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/973/038/8/	hdu0_2mass-atlas-990214n-j1180256.fits	4181760	2016-10-11 10:59:23-03	COPY	MINUS	F
357	52	25	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/973/038/8/	hdu0_2mass-atlas-990214n-j1180244_area.fits	4190400	2016-10-11 10:59:23-03	COPY	PLUS_AREA	F
356	52	25	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/973/038/8/	hdu0_2mass-atlas-990214n-j1180244.fits	4190400	2016-10-11 10:59:23-03	COPY	PLUS	F
355	52	25	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/973/038/8/	template_m101_1.00d.hdr	318	2016-10-11 10:59:23-03	COPY	HEADER	F
366	52	26	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/972/848/9/	hdu0_2mass-atlas-990214n-j1190021_area.fits	4210560	2016-10-11 10:59:24-03	COPY	MINUS_AREA	F
365	52	26	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/972/848/9/	hdu0_2mass-atlas-990214n-j1190021.fits	4210560	2016-10-11 10:59:23-03	COPY	MINUS	F
364	52	26	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/972/848/9/	hdu0_2mass-atlas-990214n-j1180244_area.fits	4190400	2016-10-11 10:59:23-03	COPY	PLUS_AREA	F
363	52	26	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/972/848/9/	hdu0_2mass-atlas-990214n-j1180244.fits	4190400	2016-10-11 10:59:23-03	COPY	PLUS	F
362	52	26	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/972/848/9/	template_m101_1.00d.hdr	318	2016-10-11 10:59:23-03	COPY	HEADER	F
369	52	21	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/157/382/4/	EErr.txt	0	2016-10-11 10:59:22-03	COPY		F
370	52	21	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/157/382/4/	ERelation.txt	1528	2016-10-11 10:59:23-03	COPY		F
371	52	21	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/157/382/4/	EResult.txt	19	2016-10-11 10:59:22-03	COPY		F
372	52	21	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/157/382/4/	diff.000002.000003.fits	227520	2016-10-11 10:59:22-03	COPY		F
373	52	21	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/157/382/4/	diff.000002.000003_area.fits	227520	2016-10-11 10:59:22-03	COPY		F
374	52	21	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/157/382/4/	dlcalculatedifference.data	1528	2016-10-11 10:59:23-03	COPY		F
375	52	21	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/157/382/4/	experiment.cmd	485	2016-10-11 10:59:22-03	COPY		F
376	52	21	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/157/382/4/	extractor.cmd	641	2016-10-11 10:59:22-03	COPY		F
322	52	22	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/065/293/5/	hdu0_2mass-atlas-990214n-j1180244_area.fits	4190400	2016-10-11 10:59:22-03	COPY	MINUS_AREA	F
382	52	22	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/065/293/5/	EErr.txt	0	2016-10-11 10:59:22-03	COPY		F
384	52	22	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/065/293/5/	ERelation.txt	1528	2016-10-11 10:59:23-03	COPY		F
386	52	22	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/065/293/5/	EResult.txt	19	2016-10-11 10:59:22-03	COPY		F
387	52	22	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/065/293/5/	diff.000002.000004.fits	161280	2016-10-11 10:59:22-03	COPY		F
388	52	22	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/065/293/5/	diff.000002.000004_area.fits	161280	2016-10-11 10:59:22-03	COPY		F
389	52	22	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/065/293/5/	dlcalculatedifference.data	1528	2016-10-11 10:59:23-03	COPY		F
390	52	22	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/065/293/5/	experiment.cmd	485	2016-10-11 10:59:22-03	COPY		F
391	52	22	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/065/293/5/	extractor.cmd	641	2016-10-11 10:59:22-03	COPY		F
354	52	24	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/064/629/7/	\N	0	\N	COPY	DIFF_AREA	F
352	52	24	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/064/629/7/	hdu0_2mass-atlas-990214n-j1180244_area.fits	4190400	2016-10-11 10:59:23-03	COPY	MINUS_AREA	F
392	52	24	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/064/629/7/	EErr.txt	0	2016-10-11 10:59:23-03	COPY		F
393	52	24	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/064/629/7/	ERelation.txt	1528	2016-10-11 10:59:24-03	COPY		F
394	52	24	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/064/629/7/	EResult.txt	19	2016-10-11 10:59:23-03	COPY		F
395	52	24	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/064/629/7/	diff.000003.000004.fits	518400	2016-10-11 10:59:23-03	COPY		F
396	52	24	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/064/629/7/	diff.000003.000004_area.fits	518400	2016-10-11 10:59:23-03	COPY		F
397	52	24	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/064/629/7/	dlcalculatedifference.data	1528	2016-10-11 10:59:24-03	COPY		F
398	52	24	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/064/629/7/	experiment.cmd	485	2016-10-11 10:59:23-03	COPY		F
399	52	24	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/064/629/7/	extractor.cmd	641	2016-10-11 10:59:23-03	COPY		F
367	52	26	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/972/848/9/	\N	0	\N	COPY	DIFF_FITS	F
385	52	27	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/880/223/10/	\N	0	\N	COPY	DIFF_AREA	F
383	52	27	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/880/223/10/	\N	0	\N	COPY	DIFF_FITS	F
380	52	27	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/880/223/10/	hdu0_2mass-atlas-990214n-j1190032.fits	4210560	2016-10-11 10:59:25-03	COPY	MINUS	F
379	52	27	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/880/223/10/	hdu0_2mass-atlas-990214n-j1180244_area.fits	4190400	2016-10-11 10:59:24-03	COPY	PLUS_AREA	F
378	52	27	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/880/223/10/	hdu0_2mass-atlas-990214n-j1180244.fits	4190400	2016-10-11 10:59:24-03	COPY	PLUS	F
377	52	27	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/880/223/10/	template_m101_1.00d.hdr	318	2016-10-11 10:59:24-03	COPY	HEADER	F
402	52	28	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/787/685/11/	hdu0_2mass-atlas-990214n-j1180256_area.fits	4181760	2016-10-11 10:59:25-03	COPY	PLUS_AREA	F
401	52	28	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/787/685/11/	hdu0_2mass-atlas-990214n-j1180256.fits	4181760	2016-10-11 10:59:25-03	COPY	PLUS	F
400	52	28	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/787/685/11/	template_m101_1.00d.hdr	318	2016-10-11 10:59:25-03	COPY	HEADER	F
407	52	23	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/064/909/6/	EErr.txt	0	2016-10-11 10:59:23-03	COPY		F
408	52	23	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/064/909/6/	ERelation.txt	1528	2016-10-11 10:59:24-03	COPY		F
409	52	23	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/064/909/6/	EResult.txt	19	2016-10-11 10:59:23-03	COPY		F
410	52	23	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/064/909/6/	diff.000002.000005.fits	498240	2016-10-11 10:59:23-03	COPY		F
411	52	23	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/064/909/6/	diff.000002.000005_area.fits	498240	2016-10-11 10:59:23-03	COPY		F
412	52	23	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/064/909/6/	dlcalculatedifference.data	1528	2016-10-11 10:59:23-03	COPY		F
413	52	23	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/064/909/6/	experiment.cmd	485	2016-10-11 10:59:23-03	COPY		F
414	52	23	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/140/064/909/6/	extractor.cmd	641	2016-10-11 10:59:23-03	COPY		F
422	52	25	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/973/038/8/	EErr.txt	0	2016-10-11 10:59:24-03	COPY		F
423	52	25	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/973/038/8/	ERelation.txt	1528	2016-10-11 10:59:25-03	COPY		F
424	52	25	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/973/038/8/	EResult.txt	19	2016-10-11 10:59:25-03	COPY		F
425	52	25	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/973/038/8/	diff.000004.000005.fits	227520	2016-10-11 10:59:25-03	COPY		F
426	52	25	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/973/038/8/	diff.000004.000005_area.fits	227520	2016-10-11 10:59:25-03	COPY		F
427	52	25	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/973/038/8/	dlcalculatedifference.data	1528	2016-10-11 10:59:25-03	COPY		F
428	52	25	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/973/038/8/	experiment.cmd	485	2016-10-11 10:59:24-03	COPY		F
429	52	25	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/973/038/8/	extractor.cmd	641	2016-10-11 10:59:24-03	COPY		F
368	52	26	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/972/848/9/	\N	0	\N	COPY	DIFF_AREA	F
436	52	26	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/972/848/9/	EErr.txt	0	2016-10-11 10:59:25-03	COPY		F
438	52	26	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/972/848/9/	ERelation.txt	1528	2016-10-11 10:59:26-03	COPY		F
439	52	26	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/972/848/9/	EResult.txt	19	2016-10-11 10:59:25-03	COPY		F
440	52	26	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/972/848/9/	diff.000004.000006.fits	155520	2016-10-11 10:59:25-03	COPY		F
405	52	28	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/787/685/11/	\N	0	\N	COPY	DIFF_FITS	F
404	52	28	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/787/685/11/	hdu0_2mass-atlas-990214n-j1190021_area.fits	4210560	2016-10-11 10:59:26-03	COPY	MINUS_AREA	F
403	52	28	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/787/685/11/	hdu0_2mass-atlas-990214n-j1190021.fits	4210560	2016-10-11 10:59:26-03	COPY	MINUS	F
421	52	29	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/695/606/12/	\N	0	\N	COPY	DIFF_AREA	F
420	52	29	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/695/606/12/	\N	0	\N	COPY	DIFF_FITS	F
418	52	29	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/695/606/12/	hdu0_2mass-atlas-990214n-j1190032.fits	4210560	2016-10-11 10:59:26-03	COPY	MINUS	F
417	52	29	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/695/606/12/	hdu0_2mass-atlas-990214n-j1190021_area.fits	4210560	2016-10-11 10:59:26-03	COPY	PLUS_AREA	F
416	52	29	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/695/606/12/	hdu0_2mass-atlas-990214n-j1190021.fits	4210560	2016-10-11 10:59:26-03	COPY	PLUS	F
415	52	29	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/695/606/12/	template_m101_1.00d.hdr	318	2016-10-11 10:59:26-03	COPY	HEADER	F
437	52	30	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/695/410/13/	\N	0	\N	COPY	DIFF_AREA	F
435	52	30	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/695/410/13/	\N	0	\N	COPY	DIFF_FITS	F
434	52	30	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/695/410/13/	hdu0_2mass-atlas-990214n-j1200244_area.fits	4239360	2016-10-11 10:59:27-03	COPY	MINUS_AREA	F
433	52	30	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/695/410/13/	hdu0_2mass-atlas-990214n-j1200244.fits	4239360	2016-10-11 10:59:27-03	COPY	MINUS	F
432	52	30	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/695/410/13/	hdu0_2mass-atlas-990214n-j1190021_area.fits	4210560	2016-10-11 10:59:27-03	COPY	PLUS_AREA	F
431	52	30	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/695/410/13/	hdu0_2mass-atlas-990214n-j1190021.fits	4210560	2016-10-11 10:59:26-03	COPY	PLUS	F
430	52	30	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/695/410/13/	template_m101_1.00d.hdr	318	2016-10-11 10:59:26-03	COPY	HEADER	F
441	52	26	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/972/848/9/	diff.000004.000006_area.fits	155520	2016-10-11 10:59:25-03	COPY		F
442	52	26	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/972/848/9/	dlcalculatedifference.data	1528	2016-10-11 10:59:25-03	COPY		F
443	52	26	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/972/848/9/	experiment.cmd	485	2016-10-11 10:59:25-03	COPY		F
444	52	26	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/972/848/9/	extractor.cmd	641	2016-10-11 10:59:25-03	COPY		F
381	52	27	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/880/223/10/	hdu0_2mass-atlas-990214n-j1190032_area.fits	4210560	2016-10-11 10:59:25-03	COPY	MINUS_AREA	F
447	52	27	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/880/223/10/	EErr.txt	0	2016-10-11 10:59:26-03	COPY		F
448	52	27	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/880/223/10/	ERelation.txt	1539	2016-10-11 10:59:27-03	COPY		F
449	52	27	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/880/223/10/	EResult.txt	19	2016-10-11 10:59:26-03	COPY		F
451	52	27	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/880/223/10/	diff.000004.000007.fits	524160	2016-10-11 10:59:26-03	COPY		F
452	52	27	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/880/223/10/	diff.000004.000007_area.fits	524160	2016-10-11 10:59:26-03	COPY		F
453	52	27	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/880/223/10/	dlcalculatedifference.data	1539	2016-10-11 10:59:26-03	COPY		F
454	52	27	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/880/223/10/	experiment.cmd	488	2016-10-11 10:59:26-03	COPY		F
457	52	27	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/880/223/10/	extractor.cmd	644	2016-10-11 10:59:26-03	COPY		F
406	52	28	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/787/685/11/	\N	0	\N	COPY	DIFF_AREA	F
474	52	28	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/787/685/11/	EErr.txt	0	2016-10-11 10:59:27-03	COPY		F
475	52	28	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/787/685/11/	ERelation.txt	1539	2016-10-11 10:59:28-03	COPY		F
476	52	28	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/787/685/11/	EResult.txt	19	2016-10-11 10:59:27-03	COPY		F
458	52	31	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/603/056/14/	\N	0	\N	COPY	DIFF_FITS	F
456	52	31	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/603/056/14/	hdu0_2mass-atlas-990214n-j1200256_area.fits	4222080	2016-10-11 10:59:27-03	COPY	MINUS_AREA	F
455	52	31	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/603/056/14/	hdu0_2mass-atlas-990214n-j1200256.fits	4222080	2016-10-11 10:59:27-03	COPY	MINUS	F
450	52	31	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/603/056/14/	hdu0_2mass-atlas-990214n-j1190021_area.fits	4210560	2016-10-11 10:59:27-03	COPY	PLUS_AREA	F
446	52	31	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/603/056/14/	hdu0_2mass-atlas-990214n-j1190021.fits	4210560	2016-10-11 10:59:27-03	COPY	PLUS	F
445	52	31	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/603/056/14/	template_m101_1.00d.hdr	318	2016-10-11 10:59:27-03	COPY	HEADER	F
466	52	32	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/511/372/15/	\N	0	\N	COPY	DIFF_AREA	F
465	52	32	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/511/372/15/	\N	0	\N	COPY	DIFF_FITS	F
464	52	32	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/511/372/15/	hdu0_2mass-atlas-990214n-j1200244_area.fits	4239360	2016-10-11 10:59:28-03	COPY	MINUS_AREA	F
463	52	32	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/511/372/15/	hdu0_2mass-atlas-990214n-j1200244.fits	4239360	2016-10-11 10:59:28-03	COPY	MINUS	F
462	52	32	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/511/372/15/	hdu0_2mass-atlas-990214n-j1190032_area.fits	4210560	2016-10-11 10:59:28-03	COPY	PLUS_AREA	F
461	52	32	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/511/372/15/	hdu0_2mass-atlas-990214n-j1190032.fits	4210560	2016-10-11 10:59:28-03	COPY	PLUS	F
460	52	32	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/511/372/15/	template_m101_1.00d.hdr	318	2016-10-11 10:59:28-03	COPY	HEADER	F
473	52	33	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/511/181/16/	\N	0	\N	COPY	DIFF_AREA	F
472	52	33	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/511/181/16/	\N	0	\N	COPY	DIFF_FITS	F
470	52	33	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/511/181/16/	hdu0_2mass-atlas-990214n-j1200256.fits	4222080	2016-10-11 10:59:28-03	COPY	MINUS	F
469	52	33	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/511/181/16/	hdu0_2mass-atlas-990214n-j1200244_area.fits	4239360	2016-10-11 10:59:28-03	COPY	PLUS_AREA	F
468	52	33	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/511/181/16/	hdu0_2mass-atlas-990214n-j1200244.fits	4239360	2016-10-11 10:59:28-03	COPY	PLUS	F
467	52	33	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/511/181/16/	template_m101_1.00d.hdr	318	2016-10-11 10:59:28-03	COPY	HEADER	F
477	52	28	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/787/685/11/	diff.000005.000006.fits	492480	2016-10-11 10:59:27-03	COPY		F
478	52	28	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/787/685/11/	diff.000005.000006_area.fits	492480	2016-10-11 10:59:27-03	COPY		F
479	52	28	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/787/685/11/	dlcalculatedifference.data	1539	2016-10-11 10:59:28-03	COPY		F
480	52	28	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/787/685/11/	experiment.cmd	488	2016-10-11 10:59:27-03	COPY		F
481	52	28	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/787/685/11/	extractor.cmd	644	2016-10-11 10:59:27-03	COPY		F
419	52	29	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/695/606/12/	hdu0_2mass-atlas-990214n-j1190032_area.fits	4210560	2016-10-11 10:59:26-03	COPY	MINUS_AREA	F
482	52	29	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/695/606/12/	EErr.txt	0	2016-10-11 10:59:27-03	COPY		F
483	52	29	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/695/606/12/	ERelation.txt	1539	2016-10-11 10:59:28-03	COPY		F
484	52	29	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/695/606/12/	EResult.txt	19	2016-10-11 10:59:27-03	COPY		F
485	52	29	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/695/606/12/	diff.000006.000007.fits	230400	2016-10-11 10:59:27-03	COPY		F
486	52	29	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/695/606/12/	diff.000006.000007_area.fits	230400	2016-10-11 10:59:27-03	COPY		F
487	52	29	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/695/606/12/	dlcalculatedifference.data	1539	2016-10-11 10:59:28-03	COPY		F
488	52	29	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/695/606/12/	experiment.cmd	488	2016-10-11 10:59:27-03	COPY		F
489	52	29	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/695/606/12/	extractor.cmd	644	2016-10-11 10:59:27-03	COPY		F
490	52	30	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/695/410/13/	EErr.txt	0	2016-10-11 10:59:27-03	COPY		F
491	52	30	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/695/410/13/	ERelation.txt	1539	2016-10-11 10:59:28-03	COPY		F
492	52	30	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/695/410/13/	EResult.txt	19	2016-10-11 10:59:28-03	COPY		F
493	52	30	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/695/410/13/	diff.000006.000008.fits	158400	2016-10-11 10:59:28-03	COPY		F
494	52	30	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/695/410/13/	diff.000006.000008_area.fits	158400	2016-10-11 10:59:28-03	COPY		F
495	52	30	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/695/410/13/	dlcalculatedifference.data	1539	2016-10-11 10:59:28-03	COPY		F
496	52	30	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/695/410/13/	experiment.cmd	488	2016-10-11 10:59:27-03	COPY		F
497	52	30	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/695/410/13/	extractor.cmd	644	2016-10-11 10:59:27-03	COPY		F
459	52	31	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/603/056/14/	\N	0	\N	COPY	DIFF_AREA	F
498	52	31	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/603/056/14/	EErr.txt	0	2016-10-11 10:59:28-03	COPY		F
499	52	31	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/603/056/14/	ERelation.txt	1539	2016-10-11 10:59:29-03	COPY		F
500	52	31	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/603/056/14/	EResult.txt	19	2016-10-11 10:59:28-03	COPY		F
501	52	31	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/603/056/14/	diff.000006.000009.fits	521280	2016-10-11 10:59:28-03	COPY		F
502	52	31	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/603/056/14/	diff.000006.000009_area.fits	521280	2016-10-11 10:59:28-03	COPY		F
503	52	31	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/603/056/14/	dlcalculatedifference.data	1539	2016-10-11 10:59:29-03	COPY		F
504	52	31	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/603/056/14/	experiment.cmd	488	2016-10-11 10:59:28-03	COPY		F
505	52	31	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/603/056/14/	extractor.cmd	644	2016-10-11 10:59:28-03	COPY		F
506	52	32	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/511/372/15/	EErr.txt	0	2016-10-11 10:59:29-03	COPY		F
507	52	32	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/511/372/15/	ERelation.txt	1539	2016-10-11 10:59:29-03	COPY		F
508	52	32	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/511/372/15/	EResult.txt	19	2016-10-11 10:59:29-03	COPY		F
509	52	32	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/511/372/15/	diff.000007.000008.fits	541440	2016-10-11 10:59:29-03	COPY		F
510	52	32	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/511/372/15/	diff.000007.000008_area.fits	541440	2016-10-11 10:59:29-03	COPY		F
511	52	32	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/511/372/15/	dlcalculatedifference.data	1539	2016-10-11 10:59:29-03	COPY		F
512	52	32	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/511/372/15/	experiment.cmd	488	2016-10-11 10:59:29-03	COPY		F
513	52	32	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/511/372/15/	extractor.cmd	644	2016-10-11 10:59:29-03	COPY		F
471	52	33	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/511/181/16/	hdu0_2mass-atlas-990214n-j1200256_area.fits	4222080	2016-10-11 10:59:28-03	COPY	MINUS_AREA	F
514	52	33	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/511/181/16/	EErr.txt	0	2016-10-11 10:59:29-03	COPY		F
515	52	33	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/511/181/16/	ERelation.txt	1539	2016-10-11 10:59:29-03	COPY		F
516	52	33	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/511/181/16/	EResult.txt	19	2016-10-11 10:59:29-03	COPY		F
517	52	33	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/511/181/16/	diff.000008.000009.fits	239040	2016-10-11 10:59:29-03	COPY		F
518	52	33	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/511/181/16/	diff.000008.000009_area.fits	239040	2016-10-11 10:59:29-03	COPY		F
519	52	33	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/511/181/16/	dlcalculatedifference.data	1539	2016-10-11 10:59:29-03	COPY		F
520	52	33	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/511/181/16/	experiment.cmd	488	2016-10-11 10:59:29-03	COPY		F
521	52	33	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CalculateDifference/139/511/181/16/	extractor.cmd	644	2016-10-11 10:59:29-03	COPY		F
534	53	35	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/139/418/159/1/	diff.000000.000002.fits	152640	2016-10-11 10:59:30-03	COPY	DIFF_FITS	F
533	53	35	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/139/418/159/1/	hdu0_2mass-atlas-990214n-j1110021_area.fits	4199040	2016-10-11 10:59:30-03	COPY	MINUS_AREA	F
532	53	35	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/139/418/159/1/	hdu0_2mass-atlas-990214n-j1110021.fits	4199040	2016-10-11 10:59:30-03	COPY	MINUS	F
531	53	35	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/139/418/159/1/	hdu0_2mass-atlas-990214n-j1100244_area.fits	4230720	2016-10-11 10:59:30-03	COPY	PLUS_AREA	F
530	53	35	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/139/418/159/1/	hdu0_2mass-atlas-990214n-j1100244.fits	4230720	2016-10-11 10:59:30-03	COPY	PLUS	F
529	53	35	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/139/418/159/1/	template_m101_1.00d.hdr	318	2016-10-11 10:59:30-03	COPY	HEADER	F
528	53	34	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/139/418/165/0/	diff.000000.000001_area.fits	236160	2016-10-11 10:59:29-03	COPY	DIFF_AREA	F
527	53	34	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/139/418/165/0/	diff.000000.000001.fits	236160	2016-10-11 10:59:30-03	COPY	DIFF_FITS	F
526	53	34	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/139/418/165/0/	hdu0_2mass-atlas-990214n-j1100256_area.fits	4222080	2016-10-11 10:59:30-03	COPY	MINUS_AREA	F
525	53	34	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/139/418/165/0/	hdu0_2mass-atlas-990214n-j1100256.fits	4222080	2016-10-11 10:59:30-03	COPY	MINUS	F
524	53	34	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/139/418/165/0/	hdu0_2mass-atlas-990214n-j1100244_area.fits	4230720	2016-10-11 10:59:30-03	COPY	PLUS_AREA	F
523	53	34	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/139/418/165/0/	hdu0_2mass-atlas-990214n-j1100244.fits	4230720	2016-10-11 10:59:30-03	COPY	PLUS	F
522	53	34	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/139/418/165/0/	template_m101_1.00d.hdr	318	2016-10-11 10:59:30-03	COPY	HEADER	F
542	53	36	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/139/418/153/2/	diff.000000.000003_area.fits	506880	2016-10-11 10:59:30-03	COPY	DIFF_AREA	F
541	53	36	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/139/418/153/2/	diff.000000.000003.fits	506880	2016-10-11 10:59:30-03	COPY	DIFF_FITS	F
540	53	36	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/139/418/153/2/	hdu0_2mass-atlas-990214n-j1110032_area.fits	4199040	2016-10-11 10:59:30-03	COPY	MINUS_AREA	F
539	53	36	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/139/418/153/2/	hdu0_2mass-atlas-990214n-j1110032.fits	4199040	2016-10-11 10:59:30-03	COPY	MINUS	F
538	53	36	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/139/418/153/2/	hdu0_2mass-atlas-990214n-j1100244_area.fits	4230720	2016-10-11 10:59:30-03	COPY	PLUS_AREA	F
537	53	36	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/139/418/153/2/	hdu0_2mass-atlas-990214n-j1100244.fits	4230720	2016-10-11 10:59:30-03	COPY	PLUS	F
536	53	36	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/139/418/153/2/	template_m101_1.00d.hdr	318	2016-10-11 10:59:30-03	COPY	HEADER	F
549	53	37	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/387/290/3/	diff.000001.000002_area.fits	492480	2016-10-11 10:59:31-03	COPY	DIFF_AREA	F
548	53	37	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/387/290/3/	diff.000001.000002.fits	492480	2016-10-11 10:59:31-03	COPY	DIFF_FITS	F
547	53	37	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/387/290/3/	hdu0_2mass-atlas-990214n-j1110021_area.fits	4199040	2016-10-11 10:59:31-03	COPY	MINUS_AREA	F
546	53	37	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/387/290/3/	hdu0_2mass-atlas-990214n-j1110021.fits	4199040	2016-10-11 10:59:31-03	COPY	MINUS	F
545	53	37	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/387/290/3/	hdu0_2mass-atlas-990214n-j1100256_area.fits	4222080	2016-10-11 10:59:31-03	COPY	PLUS_AREA	F
544	53	37	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/387/290/3/	hdu0_2mass-atlas-990214n-j1100256.fits	4222080	2016-10-11 10:59:31-03	COPY	PLUS	F
543	53	37	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/387/290/3/	template_m101_1.00d.hdr	318	2016-10-11 10:59:31-03	COPY	HEADER	F
555	53	38	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/807/4/	diff.000002.000003.fits	227520	2016-10-11 10:59:31-03	COPY	DIFF_FITS	F
554	53	38	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/807/4/	hdu0_2mass-atlas-990214n-j1110032_area.fits	4199040	2016-10-11 10:59:31-03	COPY	MINUS_AREA	F
553	53	38	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/807/4/	hdu0_2mass-atlas-990214n-j1110032.fits	4199040	2016-10-11 10:59:31-03	COPY	MINUS	F
552	53	38	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/807/4/	hdu0_2mass-atlas-990214n-j1110021_area.fits	4199040	2016-10-11 10:59:31-03	COPY	PLUS_AREA	F
551	53	38	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/807/4/	hdu0_2mass-atlas-990214n-j1110021.fits	4199040	2016-10-11 10:59:31-03	COPY	PLUS	F
550	53	38	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/807/4/	template_m101_1.00d.hdr	318	2016-10-11 10:59:31-03	COPY	HEADER	F
563	53	39	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/797/5/	diff.000002.000004_area.fits	161280	2016-10-11 10:59:31-03	COPY	DIFF_AREA	F
562	53	39	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/797/5/	diff.000002.000004.fits	161280	2016-10-11 10:59:31-03	COPY	DIFF_FITS	F
561	53	39	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/797/5/	hdu0_2mass-atlas-990214n-j1180244_area.fits	4190400	2016-10-11 10:59:31-03	COPY	MINUS_AREA	F
560	53	39	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/797/5/	hdu0_2mass-atlas-990214n-j1180244.fits	4190400	2016-10-11 10:59:31-03	COPY	MINUS	F
559	53	39	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/797/5/	hdu0_2mass-atlas-990214n-j1110021_area.fits	4199040	2016-10-11 10:59:31-03	COPY	PLUS_AREA	F
558	53	39	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/797/5/	hdu0_2mass-atlas-990214n-j1110021.fits	4199040	2016-10-11 10:59:31-03	COPY	PLUS	F
557	53	39	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/797/5/	template_m101_1.00d.hdr	318	2016-10-11 10:59:31-03	COPY	HEADER	F
570	53	40	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/723/6/	diff.000003.000004_area.fits	518400	2016-10-11 10:59:32-03	COPY	DIFF_AREA	F
569	53	40	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/723/6/	diff.000003.000004.fits	518400	2016-10-11 10:59:32-03	COPY	DIFF_FITS	F
568	53	40	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/723/6/	hdu0_2mass-atlas-990214n-j1180244_area.fits	4190400	2016-10-11 10:59:32-03	COPY	MINUS_AREA	F
567	53	40	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/723/6/	hdu0_2mass-atlas-990214n-j1180244.fits	4190400	2016-10-11 10:59:32-03	COPY	MINUS	F
566	53	40	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/723/6/	hdu0_2mass-atlas-990214n-j1110032_area.fits	4199040	2016-10-11 10:59:32-03	COPY	PLUS_AREA	F
565	53	40	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/723/6/	hdu0_2mass-atlas-990214n-j1110032.fits	4199040	2016-10-11 10:59:33-03	COPY	PLUS	F
564	53	40	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/723/6/	template_m101_1.00d.hdr	318	2016-10-11 10:59:33-03	COPY	HEADER	F
577	53	41	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/716/7/	diff.000002.000005_area.fits	498240	2016-10-11 10:59:32-03	COPY	DIFF_AREA	F
576	53	41	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/716/7/	diff.000002.000005.fits	498240	2016-10-11 10:59:32-03	COPY	DIFF_FITS	F
575	53	41	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/716/7/	hdu0_2mass-atlas-990214n-j1180256_area.fits	4181760	2016-10-11 10:59:32-03	COPY	MINUS_AREA	F
574	53	41	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/716/7/	hdu0_2mass-atlas-990214n-j1180256.fits	4181760	2016-10-11 10:59:32-03	COPY	MINUS	F
573	53	41	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/716/7/	hdu0_2mass-atlas-990214n-j1110021_area.fits	4199040	2016-10-11 10:59:32-03	COPY	PLUS_AREA	F
572	53	41	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/716/7/	hdu0_2mass-atlas-990214n-j1110021.fits	4199040	2016-10-11 10:59:33-03	COPY	PLUS	F
571	53	41	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/716/7/	template_m101_1.00d.hdr	318	2016-10-11 10:59:33-03	COPY	HEADER	F
584	53	42	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/710/8/	diff.000004.000005_area.fits	227520	2016-10-11 10:59:33-03	COPY	DIFF_AREA	F
583	53	42	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/710/8/	diff.000004.000005.fits	227520	2016-10-11 10:59:33-03	COPY	DIFF_FITS	F
582	53	42	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/710/8/	hdu0_2mass-atlas-990214n-j1180256_area.fits	4181760	2016-10-11 10:59:33-03	COPY	MINUS_AREA	F
581	53	42	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/710/8/	hdu0_2mass-atlas-990214n-j1180256.fits	4181760	2016-10-11 10:59:33-03	COPY	MINUS	F
580	53	42	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/710/8/	hdu0_2mass-atlas-990214n-j1180244_area.fits	4190400	2016-10-11 10:59:33-03	COPY	PLUS_AREA	F
579	53	42	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/710/8/	hdu0_2mass-atlas-990214n-j1180244.fits	4190400	2016-10-11 10:59:34-03	COPY	PLUS	F
578	53	42	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/710/8/	template_m101_1.00d.hdr	318	2016-10-11 10:59:34-03	COPY	HEADER	F
590	53	43	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/617/9/	diff.000004.000006.fits	155520	2016-10-11 10:59:34-03	COPY	DIFF_FITS	F
589	53	43	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/617/9/	hdu0_2mass-atlas-990214n-j1190021_area.fits	4210560	2016-10-11 10:59:34-03	COPY	MINUS_AREA	F
588	53	43	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/617/9/	hdu0_2mass-atlas-990214n-j1190021.fits	4210560	2016-10-11 10:59:34-03	COPY	MINUS	F
587	53	43	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/617/9/	hdu0_2mass-atlas-990214n-j1180244_area.fits	4190400	2016-10-11 10:59:34-03	COPY	PLUS_AREA	F
586	53	43	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/617/9/	hdu0_2mass-atlas-990214n-j1180244.fits	4190400	2016-10-11 10:59:34-03	COPY	PLUS	F
585	53	43	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/617/9/	template_m101_1.00d.hdr	318	2016-10-11 10:59:34-03	COPY	HEADER	F
598	53	44	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/611/10/	diff.000004.000007_area.fits	524160	2016-10-11 10:59:34-03	COPY	DIFF_AREA	F
597	53	44	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/611/10/	diff.000004.000007.fits	524160	2016-10-11 10:59:34-03	COPY	DIFF_FITS	F
596	53	44	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/611/10/	hdu0_2mass-atlas-990214n-j1190032_area.fits	4210560	2016-10-11 10:59:34-03	COPY	MINUS_AREA	F
595	53	44	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/611/10/	hdu0_2mass-atlas-990214n-j1190032.fits	4210560	2016-10-11 10:59:34-03	COPY	MINUS	F
594	53	44	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/611/10/	hdu0_2mass-atlas-990214n-j1180244_area.fits	4190400	2016-10-11 10:59:34-03	COPY	PLUS_AREA	F
593	53	44	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/611/10/	hdu0_2mass-atlas-990214n-j1180244.fits	4190400	2016-10-11 10:59:35-03	COPY	PLUS	F
592	53	44	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/611/10/	template_m101_1.00d.hdr	318	2016-10-11 10:59:35-03	COPY	HEADER	F
605	53	45	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/525/11/	diff.000005.000006_area.fits	492480	2016-10-11 10:59:35-03	COPY	DIFF_AREA	F
604	53	45	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/525/11/	diff.000005.000006.fits	492480	2016-10-11 10:59:35-03	COPY	DIFF_FITS	F
603	53	45	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/525/11/	hdu0_2mass-atlas-990214n-j1190021_area.fits	4210560	2016-10-11 10:59:35-03	COPY	MINUS_AREA	F
602	53	45	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/525/11/	hdu0_2mass-atlas-990214n-j1190021.fits	4210560	2016-10-11 10:59:35-03	COPY	MINUS	F
601	53	45	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/525/11/	hdu0_2mass-atlas-990214n-j1180256_area.fits	4181760	2016-10-11 10:59:35-03	COPY	PLUS_AREA	F
600	53	45	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/525/11/	hdu0_2mass-atlas-990214n-j1180256.fits	4181760	2016-10-11 10:59:35-03	COPY	PLUS	F
599	53	45	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/525/11/	template_m101_1.00d.hdr	318	2016-10-11 10:59:35-03	COPY	HEADER	F
612	53	46	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/512/12/	diff.000006.000007_area.fits	230400	2016-10-11 10:59:35-03	COPY	DIFF_AREA	F
611	53	46	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/512/12/	diff.000006.000007.fits	230400	2016-10-11 10:59:35-03	COPY	DIFF_FITS	F
610	53	46	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/512/12/	hdu0_2mass-atlas-990214n-j1190032_area.fits	4210560	2016-10-11 10:59:35-03	COPY	MINUS_AREA	F
609	53	46	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/512/12/	hdu0_2mass-atlas-990214n-j1190032.fits	4210560	2016-10-11 10:59:35-03	COPY	MINUS	F
608	53	46	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/512/12/	hdu0_2mass-atlas-990214n-j1190021_area.fits	4210560	2016-10-11 10:59:36-03	COPY	PLUS_AREA	F
607	53	46	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/512/12/	hdu0_2mass-atlas-990214n-j1190021.fits	4210560	2016-10-11 10:59:36-03	COPY	PLUS	F
606	53	46	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/512/12/	template_m101_1.00d.hdr	318	2016-10-11 10:59:36-03	COPY	HEADER	F
619	53	47	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/506/13/	diff.000006.000008_area.fits	158400	2016-10-11 10:59:36-03	COPY	DIFF_AREA	F
618	53	47	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/506/13/	diff.000006.000008.fits	158400	2016-10-11 10:59:36-03	COPY	DIFF_FITS	F
617	53	47	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/506/13/	hdu0_2mass-atlas-990214n-j1200244_area.fits	4239360	2016-10-11 10:59:36-03	COPY	MINUS_AREA	F
616	53	47	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/506/13/	hdu0_2mass-atlas-990214n-j1200244.fits	4239360	2016-10-11 10:59:36-03	COPY	MINUS	F
615	53	47	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/506/13/	hdu0_2mass-atlas-990214n-j1190021_area.fits	4210560	2016-10-11 10:59:36-03	COPY	PLUS_AREA	F
614	53	47	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/506/13/	hdu0_2mass-atlas-990214n-j1190021.fits	4210560	2016-10-11 10:59:37-03	COPY	PLUS	F
613	53	47	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/506/13/	template_m101_1.00d.hdr	318	2016-10-11 10:59:37-03	COPY	HEADER	F
535	53	35	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/139/418/159/1/	diff.000000.000002_area.fits	152640	2016-10-11 10:59:30-03	COPY	DIFF_AREA	F
641	53	35	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/139/418/159/1/	EErr.txt	0	2016-10-11 10:59:30-03	COPY		F
642	53	35	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/139/418/159/1/	ERelation.txt	974	2016-10-11 10:59:31-03	COPY		F
643	53	35	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/139/418/159/1/	EResult.txt	247	2016-10-11 10:59:30-03	COPY		F
644	53	35	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/139/418/159/1/	dlfitplane.data	974	2016-10-11 10:59:31-03	COPY		F
645	53	35	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/139/418/159/1/	experiment.cmd	183	2016-10-11 10:59:30-03	COPY		F
646	53	35	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/139/418/159/1/	extractor.cmd	516	2016-10-11 10:59:30-03	COPY		F
647	53	35	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/139/418/159/1/	fits.txt	247	2016-10-11 10:59:30-03	COPY		F
648	53	34	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/139/418/165/0/	EErr.txt	0	2016-10-11 10:59:30-03	COPY		F
649	53	34	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/139/418/165/0/	ERelation.txt	983	2016-10-11 10:59:31-03	COPY		F
650	53	34	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/139/418/165/0/	EResult.txt	256	2016-10-11 10:59:30-03	COPY		F
651	53	34	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/139/418/165/0/	dlfitplane.data	983	2016-10-11 10:59:31-03	COPY		F
652	53	34	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/139/418/165/0/	experiment.cmd	183	2016-10-11 10:59:30-03	COPY		F
653	53	34	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/139/418/165/0/	extractor.cmd	516	2016-10-11 10:59:30-03	COPY		F
654	53	34	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/139/418/165/0/	fits.txt	256	2016-10-11 10:59:30-03	COPY		F
655	53	36	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/139/418/153/2/	EErr.txt	0	2016-10-11 10:59:30-03	COPY		F
656	53	36	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/139/418/153/2/	ERelation.txt	976	2016-10-11 10:59:31-03	COPY		F
657	53	36	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/139/418/153/2/	EResult.txt	249	2016-10-11 10:59:30-03	COPY		F
625	53	48	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/435/14/	diff.000006.000009.fits	521280	2016-10-11 10:59:36-03	COPY	DIFF_FITS	F
624	53	48	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/435/14/	hdu0_2mass-atlas-990214n-j1200256_area.fits	4222080	2016-10-11 10:59:36-03	COPY	MINUS_AREA	F
623	53	48	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/435/14/	hdu0_2mass-atlas-990214n-j1200256.fits	4222080	2016-10-11 10:59:36-03	COPY	MINUS	F
622	53	48	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/435/14/	hdu0_2mass-atlas-990214n-j1190021_area.fits	4210560	2016-10-11 10:59:36-03	COPY	PLUS_AREA	F
621	53	48	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/435/14/	hdu0_2mass-atlas-990214n-j1190021.fits	4210560	2016-10-11 10:59:37-03	COPY	PLUS	F
620	53	48	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/435/14/	template_m101_1.00d.hdr	318	2016-10-11 10:59:37-03	COPY	HEADER	F
640	53	50	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/418/16/	diff.000008.000009_area.fits	239040	2016-10-11 10:59:39-03	COPY	DIFF_AREA	F
639	53	50	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/418/16/	diff.000008.000009.fits	239040	2016-10-11 10:59:39-03	COPY	DIFF_FITS	F
638	53	50	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/418/16/	hdu0_2mass-atlas-990214n-j1200256_area.fits	4222080	2016-10-11 10:59:39-03	COPY	MINUS_AREA	F
637	53	50	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/418/16/	hdu0_2mass-atlas-990214n-j1200256.fits	4222080	2016-10-11 10:59:39-03	COPY	MINUS	F
636	53	50	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/418/16/	hdu0_2mass-atlas-990214n-j1200244_area.fits	4239360	2016-10-11 10:59:39-03	COPY	PLUS_AREA	F
635	53	50	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/418/16/	hdu0_2mass-atlas-990214n-j1200244.fits	4239360	2016-10-11 10:59:39-03	COPY	PLUS	F
634	53	50	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/418/16/	template_m101_1.00d.hdr	318	2016-10-11 10:59:39-03	COPY	HEADER	F
633	53	49	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/422/15/	diff.000007.000008_area.fits	541440	2016-10-11 10:59:38-03	COPY	DIFF_AREA	F
632	53	49	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/422/15/	diff.000007.000008.fits	541440	2016-10-11 10:59:38-03	COPY	DIFF_FITS	F
631	53	49	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/422/15/	hdu0_2mass-atlas-990214n-j1200244_area.fits	4239360	2016-10-11 10:59:38-03	COPY	MINUS_AREA	F
630	53	49	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/422/15/	hdu0_2mass-atlas-990214n-j1200244.fits	4239360	2016-10-11 10:59:38-03	COPY	MINUS	F
629	53	49	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/422/15/	hdu0_2mass-atlas-990214n-j1190032_area.fits	4210560	2016-10-11 10:59:38-03	COPY	PLUS_AREA	F
628	53	49	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/422/15/	hdu0_2mass-atlas-990214n-j1190032.fits	4210560	2016-10-11 10:59:39-03	COPY	PLUS	F
627	53	49	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/422/15/	template_m101_1.00d.hdr	318	2016-10-11 10:59:39-03	COPY	HEADER	F
658	53	36	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/139/418/153/2/	dlfitplane.data	976	2016-10-11 10:59:31-03	COPY		F
659	53	36	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/139/418/153/2/	experiment.cmd	183	2016-10-11 10:59:30-03	COPY		F
660	53	36	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/139/418/153/2/	extractor.cmd	516	2016-10-11 10:59:30-03	COPY		F
661	53	36	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/139/418/153/2/	fits.txt	249	2016-10-11 10:59:30-03	COPY		F
556	53	38	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/807/4/	diff.000002.000003_area.fits	227520	2016-10-11 10:59:31-03	COPY	DIFF_AREA	F
662	53	38	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/807/4/	EErr.txt	0	2016-10-11 10:59:31-03	COPY		F
663	53	38	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/807/4/	ERelation.txt	980	2016-10-11 10:59:32-03	COPY		F
664	53	38	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/807/4/	EResult.txt	253	2016-10-11 10:59:31-03	COPY		F
665	53	38	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/807/4/	dlfitplane.data	980	2016-10-11 10:59:32-03	COPY		F
666	53	38	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/807/4/	experiment.cmd	183	2016-10-11 10:59:31-03	COPY		F
667	53	38	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/807/4/	extractor.cmd	516	2016-10-11 10:59:31-03	COPY		F
668	53	38	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/807/4/	fits.txt	253	2016-10-11 10:59:31-03	COPY		F
669	53	37	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/387/290/3/	EErr.txt	0	2016-10-11 10:59:31-03	COPY		F
670	53	37	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/387/290/3/	ERelation.txt	981	2016-10-11 10:59:32-03	COPY		F
671	53	37	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/387/290/3/	EResult.txt	254	2016-10-11 10:59:31-03	COPY		F
672	53	37	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/387/290/3/	dlfitplane.data	981	2016-10-11 10:59:32-03	COPY		F
673	53	37	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/387/290/3/	experiment.cmd	183	2016-10-11 10:59:31-03	COPY		F
674	53	37	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/387/290/3/	extractor.cmd	516	2016-10-11 10:59:31-03	COPY		F
675	53	37	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/387/290/3/	fits.txt	254	2016-10-11 10:59:31-03	COPY		F
676	53	39	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/797/5/	EErr.txt	0	2016-10-11 10:59:31-03	COPY		F
677	53	39	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/797/5/	ERelation.txt	978	2016-10-11 10:59:32-03	COPY		F
678	53	39	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/797/5/	EResult.txt	251	2016-10-11 10:59:31-03	COPY		F
679	53	39	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/797/5/	dlfitplane.data	978	2016-10-11 10:59:32-03	COPY		F
680	53	39	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/797/5/	experiment.cmd	183	2016-10-11 10:59:31-03	COPY		F
681	53	39	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/797/5/	extractor.cmd	516	2016-10-11 10:59:31-03	COPY		F
682	53	39	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/797/5/	fits.txt	251	2016-10-11 10:59:31-03	COPY		F
683	53	40	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/723/6/	EErr.txt	0	2016-10-11 10:59:33-03	COPY		F
684	53	40	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/723/6/	ERelation.txt	976	2016-10-11 10:59:34-03	COPY		F
685	53	40	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/723/6/	EResult.txt	249	2016-10-11 10:59:33-03	COPY		F
686	53	40	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/723/6/	dlfitplane.data	976	2016-10-11 10:59:34-03	COPY		F
687	53	40	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/723/6/	experiment.cmd	183	2016-10-11 10:59:33-03	COPY		F
688	53	40	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/723/6/	extractor.cmd	516	2016-10-11 10:59:33-03	COPY		F
689	53	40	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/723/6/	fits.txt	249	2016-10-11 10:59:33-03	COPY		F
690	53	41	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/716/7/	EErr.txt	0	2016-10-11 10:59:33-03	COPY		F
691	53	41	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/716/7/	ERelation.txt	979	2016-10-11 10:59:34-03	COPY		F
692	53	41	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/716/7/	EResult.txt	252	2016-10-11 10:59:33-03	COPY		F
693	53	41	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/716/7/	dlfitplane.data	979	2016-10-11 10:59:34-03	COPY		F
694	53	41	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/716/7/	experiment.cmd	183	2016-10-11 10:59:33-03	COPY		F
695	53	41	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/716/7/	extractor.cmd	516	2016-10-11 10:59:33-03	COPY		F
696	53	41	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/716/7/	fits.txt	252	2016-10-11 10:59:33-03	COPY		F
697	53	42	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/710/8/	EErr.txt	0	2016-10-11 10:59:34-03	COPY		F
698	53	42	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/710/8/	ERelation.txt	981	2016-10-11 10:59:35-03	COPY		F
699	53	42	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/710/8/	EResult.txt	254	2016-10-11 10:59:34-03	COPY		F
700	53	42	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/710/8/	dlfitplane.data	981	2016-10-11 10:59:35-03	COPY		F
701	53	42	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/710/8/	experiment.cmd	183	2016-10-11 10:59:34-03	COPY		F
702	53	42	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/710/8/	extractor.cmd	516	2016-10-11 10:59:34-03	COPY		F
703	53	42	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/710/8/	fits.txt	254	2016-10-11 10:59:34-03	COPY		F
591	53	43	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/617/9/	diff.000004.000006_area.fits	155520	2016-10-11 10:59:34-03	COPY	DIFF_AREA	F
704	53	43	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/617/9/	EErr.txt	0	2016-10-11 10:59:34-03	COPY		F
705	53	43	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/617/9/	ERelation.txt	979	2016-10-11 10:59:35-03	COPY		F
706	53	43	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/617/9/	EResult.txt	252	2016-10-11 10:59:35-03	COPY		F
707	53	43	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/617/9/	dlfitplane.data	979	2016-10-11 10:59:35-03	COPY		F
708	53	43	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/617/9/	experiment.cmd	183	2016-10-11 10:59:34-03	COPY		F
709	53	43	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/617/9/	extractor.cmd	516	2016-10-11 10:59:34-03	COPY		F
710	53	43	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/617/9/	fits.txt	252	2016-10-11 10:59:35-03	COPY		F
711	53	44	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/611/10/	EErr.txt	0	2016-10-11 10:59:35-03	COPY		F
712	53	44	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/611/10/	ERelation.txt	981	2016-10-11 10:59:36-03	COPY		F
713	53	44	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/611/10/	EResult.txt	249	2016-10-11 10:59:35-03	COPY		F
714	53	44	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/611/10/	dlfitplane.data	981	2016-10-11 10:59:35-03	COPY		F
715	53	44	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/611/10/	experiment.cmd	184	2016-10-11 10:59:35-03	COPY		F
716	53	44	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/611/10/	extractor.cmd	519	2016-10-11 10:59:35-03	COPY		F
717	53	44	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/611/10/	fits.txt	249	2016-10-11 10:59:35-03	COPY		F
718	53	45	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/525/11/	EErr.txt	0	2016-10-11 10:59:35-03	COPY		F
719	53	45	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/525/11/	ERelation.txt	988	2016-10-11 10:59:36-03	COPY		F
720	53	45	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/525/11/	EResult.txt	256	2016-10-11 10:59:35-03	COPY		F
721	53	45	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/525/11/	dlfitplane.data	988	2016-10-11 10:59:35-03	COPY		F
722	53	45	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/525/11/	experiment.cmd	184	2016-10-11 10:59:35-03	COPY		F
723	53	45	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/525/11/	extractor.cmd	519	2016-10-11 10:59:35-03	COPY		F
724	53	45	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/525/11/	fits.txt	256	2016-10-11 10:59:35-03	COPY		F
725	53	46	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/512/12/	EErr.txt	0	2016-10-11 10:59:36-03	COPY		F
726	53	46	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/512/12/	ERelation.txt	989	2016-10-11 10:59:37-03	COPY		F
727	53	46	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/512/12/	EResult.txt	257	2016-10-11 10:59:36-03	COPY		F
728	53	46	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/512/12/	dlfitplane.data	989	2016-10-11 10:59:37-03	COPY		F
729	53	46	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/512/12/	experiment.cmd	184	2016-10-11 10:59:36-03	COPY		F
730	53	46	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/512/12/	extractor.cmd	519	2016-10-11 10:59:36-03	COPY		F
731	53	46	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/512/12/	fits.txt	257	2016-10-11 10:59:36-03	COPY		F
732	53	47	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/506/13/	EErr.txt	0	2016-10-11 10:59:37-03	COPY		F
733	53	47	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/506/13/	ERelation.txt	983	2016-10-11 10:59:39-03	COPY		F
734	53	47	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/506/13/	EResult.txt	251	2016-10-11 10:59:38-03	COPY		F
735	53	47	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/506/13/	dlfitplane.data	983	2016-10-11 10:59:38-03	COPY		F
736	53	47	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/506/13/	experiment.cmd	184	2016-10-11 10:59:37-03	COPY		F
737	53	47	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/506/13/	extractor.cmd	519	2016-10-11 10:59:37-03	COPY		F
738	53	47	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/506/13/	fits.txt	251	2016-10-11 10:59:38-03	COPY		F
626	53	48	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/435/14/	diff.000006.000009_area.fits	521280	2016-10-11 10:59:36-03	COPY	DIFF_AREA	F
739	53	48	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/435/14/	EErr.txt	0	2016-10-11 10:59:38-03	COPY		F
740	53	48	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/435/14/	ERelation.txt	989	2016-10-11 10:59:39-03	COPY		F
741	53	48	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/435/14/	EResult.txt	257	2016-10-11 10:59:38-03	COPY		F
742	53	48	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/435/14/	dlfitplane.data	989	2016-10-11 10:59:39-03	COPY		F
743	53	48	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/435/14/	experiment.cmd	184	2016-10-11 10:59:38-03	COPY		F
744	53	48	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/435/14/	extractor.cmd	519	2016-10-11 10:59:38-03	COPY		F
745	53	48	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/435/14/	fits.txt	257	2016-10-11 10:59:38-03	COPY		F
746	53	50	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/418/16/	EErr.txt	0	2016-10-11 10:59:39-03	COPY		F
747	53	50	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/418/16/	ERelation.txt	993	2016-10-11 10:59:40-03	COPY		F
748	53	50	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/418/16/	EResult.txt	261	2016-10-11 10:59:39-03	COPY		F
749	53	50	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/418/16/	dlfitplane.data	993	2016-10-11 10:59:40-03	COPY		F
750	53	50	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/418/16/	experiment.cmd	184	2016-10-11 10:59:39-03	COPY		F
751	53	50	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/418/16/	extractor.cmd	519	2016-10-11 10:59:39-03	COPY		F
752	53	50	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/418/16/	fits.txt	261	2016-10-11 10:59:39-03	COPY		F
753	53	49	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/422/15/	EErr.txt	0	2016-10-11 10:59:39-03	COPY		F
754	53	49	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/422/15/	ERelation.txt	983	2016-10-11 10:59:40-03	COPY		F
755	53	49	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/422/15/	EResult.txt	251	2016-10-11 10:59:40-03	COPY		F
756	53	49	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/422/15/	dlfitplane.data	983	2016-10-11 10:59:40-03	COPY		F
757	53	49	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/422/15/	experiment.cmd	184	2016-10-11 10:59:39-03	COPY		F
758	53	49	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/422/15/	extractor.cmd	519	2016-10-11 10:59:39-03	COPY		F
759	53	49	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/FitPlane/137/386/422/15/	fits.txt	251	2016-10-11 10:59:40-03	COPY		F
779	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	hdu0_2mass-atlas-990214n-j1110032_area.fits	4199040	2016-10-11 10:59:49-03	COPY	MINUS_AREA	F
778	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	hdu0_2mass-atlas-990214n-j1110032.fits	4199040	2016-10-11 10:59:49-03	COPY	MINUS	F
777	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	hdu0_2mass-atlas-990214n-j1110021_area.fits	4199040	2016-10-11 10:59:49-03	COPY	PLUS_AREA	F
776	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	hdu0_2mass-atlas-990214n-j1110021.fits	4199040	2016-10-11 10:59:49-03	COPY	PLUS	F
775	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	template_m101_1.00d.hdr	318	2016-10-11 10:59:49-03	COPY	HEADER	F
774	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	hdu0_2mass-atlas-990214n-j1110032_area.fits	4199040	2016-10-11 10:59:49-03	COPY	MINUS_AREA	F
773	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	hdu0_2mass-atlas-990214n-j1110032.fits	4199040	2016-10-11 10:59:49-03	COPY	MINUS	F
772	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	hdu0_2mass-atlas-990214n-j1100244_area.fits	4230720	2016-10-11 10:59:49-03	COPY	PLUS_AREA	F
771	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	hdu0_2mass-atlas-990214n-j1100244.fits	4230720	2016-10-11 10:59:49-03	COPY	PLUS	F
770	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	template_m101_1.00d.hdr	318	2016-10-11 10:59:49-03	COPY	HEADER	F
769	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	hdu0_2mass-atlas-990214n-j1100256_area.fits	4222080	2016-10-11 10:59:49-03	COPY	MINUS_AREA	F
768	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	hdu0_2mass-atlas-990214n-j1100256.fits	4222080	2016-10-11 10:59:49-03	COPY	MINUS	F
767	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	hdu0_2mass-atlas-990214n-j1100244_area.fits	4230720	2016-10-11 10:59:49-03	COPY	PLUS_AREA	F
766	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	hdu0_2mass-atlas-990214n-j1100244.fits	4230720	2016-10-11 10:59:49-03	COPY	PLUS	F
765	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	template_m101_1.00d.hdr	318	2016-10-11 10:59:49-03	COPY	HEADER	F
764	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	hdu0_2mass-atlas-990214n-j1110021_area.fits	4199040	2016-10-11 10:59:49-03	COPY	MINUS_AREA	F
763	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	hdu0_2mass-atlas-990214n-j1110021.fits	4199040	2016-10-11 10:59:49-03	COPY	MINUS	F
762	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	hdu0_2mass-atlas-990214n-j1100244_area.fits	4230720	2016-10-11 10:59:49-03	COPY	PLUS_AREA	F
761	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	hdu0_2mass-atlas-990214n-j1100244.fits	4230720	2016-10-11 10:59:49-03	COPY	PLUS	F
760	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	template_m101_1.00d.hdr	318	2016-10-11 10:59:49-03	COPY	HEADER	F
814	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	hdu0_2mass-atlas-990214n-j1190032_area.fits	4210560	2016-10-11 10:59:45-03	COPY	MINUS_AREA	F
813	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	hdu0_2mass-atlas-990214n-j1190032.fits	4210560	2016-10-11 10:59:45-03	COPY	MINUS	F
812	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	hdu0_2mass-atlas-990214n-j1180244_area.fits	4190400	2016-10-11 10:59:46-03	COPY	PLUS_AREA	F
811	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	hdu0_2mass-atlas-990214n-j1180244.fits	4190400	2016-10-11 10:59:46-03	COPY	PLUS	F
810	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	template_m101_1.00d.hdr	318	2016-10-11 10:59:49-03	COPY	HEADER	F
809	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	hdu0_2mass-atlas-990214n-j1190021_area.fits	4210560	2016-10-11 10:59:45-03	COPY	MINUS_AREA	F
808	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	hdu0_2mass-atlas-990214n-j1190021.fits	4210560	2016-10-11 10:59:45-03	COPY	MINUS	F
807	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	hdu0_2mass-atlas-990214n-j1180244_area.fits	4190400	2016-10-11 10:59:46-03	COPY	PLUS_AREA	F
806	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	hdu0_2mass-atlas-990214n-j1180244.fits	4190400	2016-10-11 10:59:46-03	COPY	PLUS	F
805	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	template_m101_1.00d.hdr	318	2016-10-11 10:59:49-03	COPY	HEADER	F
804	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	hdu0_2mass-atlas-990214n-j1180256_area.fits	4181760	2016-10-11 10:59:46-03	COPY	MINUS_AREA	F
803	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	hdu0_2mass-atlas-990214n-j1180256.fits	4181760	2016-10-11 10:59:46-03	COPY	MINUS	F
802	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	hdu0_2mass-atlas-990214n-j1180244_area.fits	4190400	2016-10-11 10:59:46-03	COPY	PLUS_AREA	F
801	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	hdu0_2mass-atlas-990214n-j1180244.fits	4190400	2016-10-11 10:59:46-03	COPY	PLUS	F
800	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	template_m101_1.00d.hdr	318	2016-10-11 10:59:49-03	COPY	HEADER	F
799	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	hdu0_2mass-atlas-990214n-j1180256_area.fits	4181760	2016-10-11 10:59:46-03	COPY	MINUS_AREA	F
798	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	hdu0_2mass-atlas-990214n-j1180256.fits	4181760	2016-10-11 10:59:46-03	COPY	MINUS	F
797	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	hdu0_2mass-atlas-990214n-j1110021_area.fits	4199040	2016-10-11 10:59:49-03	COPY	PLUS_AREA	F
796	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	hdu0_2mass-atlas-990214n-j1110021.fits	4199040	2016-10-11 10:59:49-03	COPY	PLUS	F
795	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	template_m101_1.00d.hdr	318	2016-10-11 10:59:49-03	COPY	HEADER	F
794	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	hdu0_2mass-atlas-990214n-j1180244_area.fits	4190400	2016-10-11 10:59:46-03	COPY	MINUS_AREA	F
793	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	hdu0_2mass-atlas-990214n-j1180244.fits	4190400	2016-10-11 10:59:46-03	COPY	MINUS	F
792	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	hdu0_2mass-atlas-990214n-j1110032_area.fits	4199040	2016-10-11 10:59:49-03	COPY	PLUS_AREA	F
791	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	hdu0_2mass-atlas-990214n-j1110032.fits	4199040	2016-10-11 10:59:49-03	COPY	PLUS	F
790	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	template_m101_1.00d.hdr	318	2016-10-11 10:59:49-03	COPY	HEADER	F
789	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	hdu0_2mass-atlas-990214n-j1180244_area.fits	4190400	2016-10-11 10:59:46-03	COPY	MINUS_AREA	F
788	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	hdu0_2mass-atlas-990214n-j1180244.fits	4190400	2016-10-11 10:59:46-03	COPY	MINUS	F
787	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	hdu0_2mass-atlas-990214n-j1110021_area.fits	4199040	2016-10-11 10:59:49-03	COPY	PLUS_AREA	F
786	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	hdu0_2mass-atlas-990214n-j1110021.fits	4199040	2016-10-11 10:59:49-03	COPY	PLUS	F
785	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	template_m101_1.00d.hdr	318	2016-10-11 10:59:49-03	COPY	HEADER	F
784	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	hdu0_2mass-atlas-990214n-j1110021_area.fits	4199040	2016-10-11 10:59:49-03	COPY	MINUS_AREA	F
783	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	hdu0_2mass-atlas-990214n-j1110021.fits	4199040	2016-10-11 10:59:49-03	COPY	MINUS	F
782	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	hdu0_2mass-atlas-990214n-j1100256_area.fits	4222080	2016-10-11 10:59:49-03	COPY	PLUS_AREA	F
781	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	hdu0_2mass-atlas-990214n-j1100256.fits	4222080	2016-10-11 10:59:49-03	COPY	PLUS	F
848	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	\N	0	\N	COPY	MOSAIC_JPG	F
847	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	\N	0	\N	COPY	MOSAIC_AREA	F
846	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	\N	0	\N	COPY	MOSAIC_FITS	F
845	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	\N	0	\N	COPY	IMAGES_TBL	F
844	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	hdu0_2mass-atlas-990214n-j1200244_area.fits	4239360	2016-10-11 10:59:42-03	COPY	MINUS_AREA	F
843	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	hdu0_2mass-atlas-990214n-j1200244.fits	4239360	2016-10-11 10:59:42-03	COPY	MINUS	F
842	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	hdu0_2mass-atlas-990214n-j1190032_area.fits	4210560	2016-10-11 10:59:45-03	COPY	PLUS_AREA	F
841	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	hdu0_2mass-atlas-990214n-j1190032.fits	4210560	2016-10-11 10:59:45-03	COPY	PLUS	F
840	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	template_m101_1.00d.hdr	318	2016-10-11 10:59:49-03	COPY	HEADER	F
839	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	hdu0_2mass-atlas-990214n-j1200256_area.fits	4222080	2016-10-11 10:59:42-03	COPY	MINUS_AREA	F
838	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	hdu0_2mass-atlas-990214n-j1200256.fits	4222080	2016-10-11 10:59:42-03	COPY	MINUS	F
837	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	hdu0_2mass-atlas-990214n-j1200244_area.fits	4239360	2016-10-11 10:59:42-03	COPY	PLUS_AREA	F
836	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	hdu0_2mass-atlas-990214n-j1200244.fits	4239360	2016-10-11 10:59:42-03	COPY	PLUS	F
835	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	template_m101_1.00d.hdr	318	2016-10-11 10:59:49-03	COPY	HEADER	F
834	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	hdu0_2mass-atlas-990214n-j1200256_area.fits	4222080	2016-10-11 10:59:42-03	COPY	MINUS_AREA	F
833	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	hdu0_2mass-atlas-990214n-j1200256.fits	4222080	2016-10-11 10:59:42-03	COPY	MINUS	F
832	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	hdu0_2mass-atlas-990214n-j1190021_area.fits	4210560	2016-10-11 10:59:45-03	COPY	PLUS_AREA	F
831	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	hdu0_2mass-atlas-990214n-j1190021.fits	4210560	2016-10-11 10:59:45-03	COPY	PLUS	F
830	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	template_m101_1.00d.hdr	318	2016-10-11 10:59:49-03	COPY	HEADER	F
829	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	hdu0_2mass-atlas-990214n-j1200244_area.fits	4239360	2016-10-11 10:59:42-03	COPY	MINUS_AREA	F
828	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	hdu0_2mass-atlas-990214n-j1200244.fits	4239360	2016-10-11 10:59:42-03	COPY	MINUS	F
827	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	hdu0_2mass-atlas-990214n-j1190021_area.fits	4210560	2016-10-11 10:59:45-03	COPY	PLUS_AREA	F
826	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	hdu0_2mass-atlas-990214n-j1190021.fits	4210560	2016-10-11 10:59:45-03	COPY	PLUS	F
825	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	template_m101_1.00d.hdr	318	2016-10-11 10:59:49-03	COPY	HEADER	F
824	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	hdu0_2mass-atlas-990214n-j1190032_area.fits	4210560	2016-10-11 10:59:45-03	COPY	MINUS_AREA	F
823	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	hdu0_2mass-atlas-990214n-j1190032.fits	4210560	2016-10-11 10:59:45-03	COPY	MINUS	F
822	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	hdu0_2mass-atlas-990214n-j1190021_area.fits	4210560	2016-10-11 10:59:45-03	COPY	PLUS_AREA	F
821	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	hdu0_2mass-atlas-990214n-j1190021.fits	4210560	2016-10-11 10:59:45-03	COPY	PLUS	F
820	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	template_m101_1.00d.hdr	318	2016-10-11 10:59:49-03	COPY	HEADER	F
819	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	hdu0_2mass-atlas-990214n-j1190021_area.fits	4210560	2016-10-11 10:59:45-03	COPY	MINUS_AREA	F
818	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	hdu0_2mass-atlas-990214n-j1190021.fits	4210560	2016-10-11 10:59:45-03	COPY	MINUS	F
817	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	hdu0_2mass-atlas-990214n-j1180256_area.fits	4181760	2016-10-11 10:59:46-03	COPY	PLUS_AREA	F
816	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	hdu0_2mass-atlas-990214n-j1180256.fits	4181760	2016-10-11 10:59:46-03	COPY	PLUS	F
815	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	template_m101_1.00d.hdr	318	2016-10-11 10:59:49-03	COPY	HEADER	F
780	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	template_m101_1.00d.hdr	318	2016-10-11 10:59:49-03	COPY	HEADER	F
849	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	EErr.txt	0	2016-10-11 10:59:49-03	COPY		F
850	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	ERelation.txt	680	2016-10-11 10:59:59-03	COPY		F
851	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	EResult.txt	231	2016-10-11 10:59:59-03	COPY		F
852	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	hdu0_2mass-atlas-990214n-j1100244.fits	4230720	2016-10-11 10:59:49-03	COPY		F
853	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	hdu0_2mass-atlas-990214n-j1100244_area.fits	4230720	2016-10-11 10:59:49-03	COPY		F
854	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	hdu0_2mass-atlas-990214n-j1100256.fits	4222080	2016-10-11 10:59:49-03	COPY		F
855	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	hdu0_2mass-atlas-990214n-j1100256_area.fits	4222080	2016-10-11 10:59:49-03	COPY		F
856	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	hdu0_2mass-atlas-990214n-j1110021.fits	4199040	2016-10-11 10:59:49-03	COPY		F
857	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	hdu0_2mass-atlas-990214n-j1110021_area.fits	4199040	2016-10-11 10:59:49-03	COPY		F
858	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	hdu0_2mass-atlas-990214n-j1110032.fits	4199040	2016-10-11 10:59:49-03	COPY		F
859	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	hdu0_2mass-atlas-990214n-j1110032_area.fits	4199040	2016-10-11 10:59:49-03	COPY		F
860	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	hdu0_2mass-atlas-990214n-j1180244.fits	4190400	2016-10-11 10:59:46-03	COPY		F
861	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	hdu0_2mass-atlas-990214n-j1180244_area.fits	4190400	2016-10-11 10:59:46-03	COPY		F
862	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	hdu0_2mass-atlas-990214n-j1180256.fits	4181760	2016-10-11 10:59:46-03	COPY		F
863	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	hdu0_2mass-atlas-990214n-j1180256_area.fits	4181760	2016-10-11 10:59:46-03	COPY		F
864	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	hdu0_2mass-atlas-990214n-j1190021.fits	4210560	2016-10-11 10:59:45-03	COPY		F
865	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	hdu0_2mass-atlas-990214n-j1190021_area.fits	4210560	2016-10-11 10:59:45-03	COPY		F
866	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	hdu0_2mass-atlas-990214n-j1190032.fits	4210560	2016-10-11 10:59:45-03	COPY		F
867	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	hdu0_2mass-atlas-990214n-j1190032_area.fits	4210560	2016-10-11 10:59:45-03	COPY		F
868	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	hdu0_2mass-atlas-990214n-j1200244.fits	4239360	2016-10-11 10:59:42-03	COPY		F
869	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	hdu0_2mass-atlas-990214n-j1200244_area.fits	4239360	2016-10-11 10:59:42-03	COPY		F
870	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	hdu0_2mass-atlas-990214n-j1200256.fits	4222080	2016-10-11 10:59:42-03	COPY		F
871	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	hdu0_2mass-atlas-990214n-j1200256_area.fits	4222080	2016-10-11 10:59:42-03	COPY		F
872	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	corrections.tbl	105	2016-10-11 10:59:50-03	COPY		F
873	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	dlcreatemosaic.data	680	2016-10-11 10:59:59-03	COPY		F
874	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	experiment.cmd	615	2016-10-11 10:59:49-03	COPY		F
875	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	extractor.cmd	274	2016-10-11 10:59:49-03	COPY		F
876	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	fits.tbl	8454	2016-10-11 10:59:50-03	COPY		F
877	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	images.tbl	3344	2016-10-11 10:59:49-03	COPY		F
878	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	mosaic_corrected.fits	39602880	2016-10-11 10:59:56-03	COPY		F
879	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	mosaic_corrected.jpg	567224	2016-10-11 10:59:59-03	COPY		F
880	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	mosaic_corrected_area.fits	39602880	2016-10-11 10:59:56-03	COPY		F
881	54	51	F	F	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/CreateMosaic/134/431/821/0/	ofitplane.hfrag	14608	2016-10-11 10:59:41-03	COPY		F
\.


--
-- TOC entry 2646 (class 0 OID 959362)
-- Dependencies: 185
-- Data for Name: emachine; Type: TABLE DATA; Schema: public; Owner: vitor
--

COPY emachine (machineid, hostname, address, mflopspersecond, type, financial_cost) FROM stdin;
1	vitor-2.local	192.168.248.105	786354.645719998749		0
\.


--
-- TOC entry 2647 (class 0 OID 959369)
-- Dependencies: 186
-- Data for Name: eprovperf; Type: TABLE DATA; Schema: public; Owner: vitor
--

COPY eprovperf ("time", machineid, ewkfid, function) FROM stdin;
\.


--
-- TOC entry 2650 (class 0 OID 959384)
-- Dependencies: 189
-- Data for Name: eworkflow; Type: TABLE DATA; Schema: public; Owner: vitor
--

COPY eworkflow (ewkfid, tagexec, expdir, wfdir, tag, maximumfailures, userinteraction, reliability, redundancy) FROM stdin;
39	montage-1	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage/exp/	/Users/vitor/Documents/Repository/Thesis/ARMFUL/src/simulation/montage	montage	5	F	0.100000000000000006	F
\.


--
-- TOC entry 2742 (class 0 OID 0)
-- Dependencies: 192
-- Name: extid_seq; Type: SEQUENCE SET; Schema: public; Owner: vitor
--

SELECT pg_catalog.setval('extid_seq', 27, true);


--
-- TOC entry 2743 (class 0 OID 0)
-- Dependencies: 193
-- Name: fieldid_seq; Type: SEQUENCE SET; Schema: public; Owner: vitor
--

SELECT pg_catalog.setval('fieldid_seq', 1, false);


--
-- TOC entry 2744 (class 0 OID 0)
-- Dependencies: 194
-- Name: fileid_seq; Type: SEQUENCE SET; Schema: public; Owner: vitor
--

SELECT pg_catalog.setval('fileid_seq', 881, true);


--
-- TOC entry 2745 (class 0 OID 0)
-- Dependencies: 195
-- Name: machineid_seq; Type: SEQUENCE SET; Schema: public; Owner: vitor
--

SELECT pg_catalog.setval('machineid_seq', 1, true);


--
-- TOC entry 2746 (class 0 OID 0)
-- Dependencies: 196
-- Name: relid_seq; Type: SEQUENCE SET; Schema: public; Owner: vitor
--

SELECT pg_catalog.setval('relid_seq', 30, true);


--
-- TOC entry 2747 (class 0 OID 0)
-- Dependencies: 197
-- Name: taskid_seq; Type: SEQUENCE SET; Schema: public; Owner: vitor
--

SELECT pg_catalog.setval('taskid_seq', 51, true);


--
-- TOC entry 2748 (class 0 OID 0)
-- Dependencies: 198
-- Name: wkfid_seq; Type: SEQUENCE SET; Schema: public; Owner: vitor
--

SELECT pg_catalog.setval('wkfid_seq', 39, true);


SET search_path = montage, pg_catalog;

--
-- TOC entry 2430 (class 2606 OID 960912)
-- Name: dlcalculatedifference_pkey; Type: CONSTRAINT; Schema: montage; Owner: chiron; Tablespace: 
--

ALTER TABLE ONLY dlcalculatedifference
    ADD CONSTRAINT dlcalculatedifference_pkey PRIMARY KEY (rid);


--
-- TOC entry 2420 (class 2606 OID 960802)
-- Name: dlcalculateoverlaps_pkey; Type: CONSTRAINT; Schema: montage; Owner: chiron; Tablespace: 
--

ALTER TABLE ONLY dlcalculateoverlaps
    ADD CONSTRAINT dlcalculateoverlaps_pkey PRIMARY KEY (rid);


--
-- TOC entry 2440 (class 2606 OID 961032)
-- Name: dlcreatemosaic_pkey; Type: CONSTRAINT; Schema: montage; Owner: chiron; Tablespace: 
--

ALTER TABLE ONLY dlcreatemosaic
    ADD CONSTRAINT dlcreatemosaic_pkey PRIMARY KEY (rid);


--
-- TOC entry 2415 (class 2606 OID 960757)
-- Name: dlcreateumosaic_pkey; Type: CONSTRAINT; Schema: montage; Owner: chiron; Tablespace: 
--

ALTER TABLE ONLY dlcreateumosaic
    ADD CONSTRAINT dlcreateumosaic_pkey PRIMARY KEY (rid);


--
-- TOC entry 2425 (class 2606 OID 960857)
-- Name: dlextractdifferences_pkey; Type: CONSTRAINT; Schema: montage; Owner: chiron; Tablespace: 
--

ALTER TABLE ONLY dlextractdifferences
    ADD CONSTRAINT dlextractdifferences_pkey PRIMARY KEY (rid);


--
-- TOC entry 2435 (class 2606 OID 960972)
-- Name: dlfitplane_pkey; Type: CONSTRAINT; Schema: montage; Owner: chiron; Tablespace: 
--

ALTER TABLE ONLY dlfitplane
    ADD CONSTRAINT dlfitplane_pkey PRIMARY KEY (rid);


--
-- TOC entry 2400 (class 2606 OID 960590)
-- Name: dllistfits_pkey; Type: CONSTRAINT; Schema: montage; Owner: chiron; Tablespace: 
--

ALTER TABLE ONLY dllistfits
    ADD CONSTRAINT dllistfits_pkey PRIMARY KEY (rid);


--
-- TOC entry 2405 (class 2606 OID 960645)
-- Name: dlprojection_pkey; Type: CONSTRAINT; Schema: montage; Owner: chiron; Tablespace: 
--

ALTER TABLE ONLY dlprojection
    ADD CONSTRAINT dlprojection_pkey PRIMARY KEY (rid);


--
-- TOC entry 2410 (class 2606 OID 960705)
-- Name: dlselectprojections_pkey; Type: CONSTRAINT; Schema: montage; Owner: chiron; Tablespace: 
--

ALTER TABLE ONLY dlselectprojections
    ADD CONSTRAINT dlselectprojections_pkey PRIMARY KEY (rid);


--
-- TOC entry 2398 (class 2606 OID 960571)
-- Name: ilistfits_pkey; Type: CONSTRAINT; Schema: montage; Owner: chiron; Tablespace: 
--

ALTER TABLE ONLY ilistfits
    ADD CONSTRAINT ilistfits_pkey PRIMARY KEY (key);

ALTER TABLE ilistfits CLUSTER ON ilistfits_pkey;


--
-- TOC entry 2433 (class 2606 OID 960928)
-- Name: ocalculatedifference_pkey; Type: CONSTRAINT; Schema: montage; Owner: chiron; Tablespace: 
--

ALTER TABLE ONLY ocalculatedifference
    ADD CONSTRAINT ocalculatedifference_pkey PRIMARY KEY (key);

ALTER TABLE ocalculatedifference CLUSTER ON ocalculatedifference_pkey;


--
-- TOC entry 2423 (class 2606 OID 960818)
-- Name: ocalculateoverlaps_pkey; Type: CONSTRAINT; Schema: montage; Owner: chiron; Tablespace: 
--

ALTER TABLE ONLY ocalculateoverlaps
    ADD CONSTRAINT ocalculateoverlaps_pkey PRIMARY KEY (key);

ALTER TABLE ocalculateoverlaps CLUSTER ON ocalculateoverlaps_pkey;


--
-- TOC entry 2443 (class 2606 OID 961048)
-- Name: ocreatemosaic_pkey; Type: CONSTRAINT; Schema: montage; Owner: chiron; Tablespace: 
--

ALTER TABLE ONLY ocreatemosaic
    ADD CONSTRAINT ocreatemosaic_pkey PRIMARY KEY (key);

ALTER TABLE ocreatemosaic CLUSTER ON ocreatemosaic_pkey;


--
-- TOC entry 2418 (class 2606 OID 960773)
-- Name: ocreateumosaic_pkey; Type: CONSTRAINT; Schema: montage; Owner: chiron; Tablespace: 
--

ALTER TABLE ONLY ocreateumosaic
    ADD CONSTRAINT ocreateumosaic_pkey PRIMARY KEY (key);

ALTER TABLE ocreateumosaic CLUSTER ON ocreateumosaic_pkey;


--
-- TOC entry 2428 (class 2606 OID 960873)
-- Name: oextractdifferences_pkey; Type: CONSTRAINT; Schema: montage; Owner: chiron; Tablespace: 
--

ALTER TABLE ONLY oextractdifferences
    ADD CONSTRAINT oextractdifferences_pkey PRIMARY KEY (key);

ALTER TABLE oextractdifferences CLUSTER ON oextractdifferences_pkey;


--
-- TOC entry 2438 (class 2606 OID 960988)
-- Name: ofitplane_pkey; Type: CONSTRAINT; Schema: montage; Owner: chiron; Tablespace: 
--

ALTER TABLE ONLY ofitplane
    ADD CONSTRAINT ofitplane_pkey PRIMARY KEY (key);

ALTER TABLE ofitplane CLUSTER ON ofitplane_pkey;


--
-- TOC entry 2403 (class 2606 OID 960606)
-- Name: olistfits_pkey; Type: CONSTRAINT; Schema: montage; Owner: chiron; Tablespace: 
--

ALTER TABLE ONLY olistfits
    ADD CONSTRAINT olistfits_pkey PRIMARY KEY (key);

ALTER TABLE olistfits CLUSTER ON olistfits_pkey;


--
-- TOC entry 2408 (class 2606 OID 960661)
-- Name: oprojection_pkey; Type: CONSTRAINT; Schema: montage; Owner: chiron; Tablespace: 
--

ALTER TABLE ONLY oprojection
    ADD CONSTRAINT oprojection_pkey PRIMARY KEY (key);

ALTER TABLE oprojection CLUSTER ON oprojection_pkey;


--
-- TOC entry 2413 (class 2606 OID 960721)
-- Name: oselectprojections_pkey; Type: CONSTRAINT; Schema: montage; Owner: chiron; Tablespace: 
--

ALTER TABLE ONLY oselectprojections
    ADD CONSTRAINT oselectprojections_pkey PRIMARY KEY (key);

ALTER TABLE oselectprojections CLUSTER ON oselectprojections_pkey;


SET search_path = public, pg_catalog;

--
-- TOC entry 2355 (class 2606 OID 959415)
-- Name: cactivity_pkey; Type: CONSTRAINT; Schema: public; Owner: vitor; Tablespace: 
--

ALTER TABLE ONLY cactivity
    ADD CONSTRAINT cactivity_pkey PRIMARY KEY (wkfid, actid);


--
-- TOC entry 2359 (class 2606 OID 959417)
-- Name: cextractor_pkey; Type: CONSTRAINT; Schema: public; Owner: vitor; Tablespace: 
--

ALTER TABLE ONLY cextractor
    ADD CONSTRAINT cextractor_pkey PRIMARY KEY (extid, wkfid);


--
-- TOC entry 2366 (class 2606 OID 959421)
-- Name: cfield_pk; Type: CONSTRAINT; Schema: public; Owner: vitor; Tablespace: 
--

ALTER TABLE ONLY cfield
    ADD CONSTRAINT cfield_pk PRIMARY KEY (relid, fname);

ALTER TABLE cfield CLUSTER ON cfield_pk;


--
-- TOC entry 2363 (class 2606 OID 959419)
-- Name: cjoin_pkey; Type: CONSTRAINT; Schema: public; Owner: vitor; Tablespace: 
--

ALTER TABLE ONLY cjoin
    ADD CONSTRAINT cjoin_pkey PRIMARY KEY (relid, innerextid, outerextid);


--
-- TOC entry 2395 (class 2606 OID 959462)
-- Name: cmapping_pk; Type: CONSTRAINT; Schema: public; Owner: vitor; Tablespace: 
--

ALTER TABLE ONLY cmapping
    ADD CONSTRAINT cmapping_pk PRIMARY KEY (cmapid, crelid);


--
-- TOC entry 2369 (class 2606 OID 959423)
-- Name: coperand_pk; Type: CONSTRAINT; Schema: public; Owner: vitor; Tablespace: 
--

ALTER TABLE ONLY coperand
    ADD CONSTRAINT coperand_pk PRIMARY KEY (actid, opid);


--
-- TOC entry 2371 (class 2606 OID 959425)
-- Name: crelation_pk; Type: CONSTRAINT; Schema: public; Owner: vitor; Tablespace: 
--

ALTER TABLE ONLY crelation
    ADD CONSTRAINT crelation_pk PRIMARY KEY (wkfid, relid);


--
-- TOC entry 2376 (class 2606 OID 959427)
-- Name: cworkflow_pk; Type: CONSTRAINT; Schema: public; Owner: vitor; Tablespace: 
--

ALTER TABLE ONLY cworkflow
    ADD CONSTRAINT cworkflow_pk PRIMARY KEY (wkfid);

ALTER TABLE cworkflow CLUSTER ON cworkflow_pk;


--
-- TOC entry 2384 (class 2606 OID 959429)
-- Name: eactivity_pkey; Type: CONSTRAINT; Schema: public; Owner: vitor; Tablespace: 
--

ALTER TABLE ONLY eactivity
    ADD CONSTRAINT eactivity_pkey PRIMARY KEY (wkfid, actid);

ALTER TABLE eactivity CLUSTER ON eactivity_pkey;


--
-- TOC entry 2389 (class 2606 OID 959431)
-- Name: efile_pk; Type: CONSTRAINT; Schema: public; Owner: vitor; Tablespace: 
--

ALTER TABLE ONLY efile
    ADD CONSTRAINT efile_pk PRIMARY KEY (actid, fileid);

ALTER TABLE efile CLUSTER ON efile_pk;


--
-- TOC entry 2391 (class 2606 OID 959433)
-- Name: emachineid_pk; Type: CONSTRAINT; Schema: public; Owner: vitor; Tablespace: 
--

ALTER TABLE ONLY emachine
    ADD CONSTRAINT emachineid_pk PRIMARY KEY (machineid);


--
-- TOC entry 2380 (class 2606 OID 959435)
-- Name: etask_pk; Type: CONSTRAINT; Schema: public; Owner: vitor; Tablespace: 
--

ALTER TABLE ONLY eactivation
    ADD CONSTRAINT etask_pk PRIMARY KEY (actid, taskid);

ALTER TABLE eactivation CLUSTER ON etask_pk;


--
-- TOC entry 2393 (class 2606 OID 959437)
-- Name: eworkflow_pk; Type: CONSTRAINT; Schema: public; Owner: vitor; Tablespace: 
--

ALTER TABLE ONLY eworkflow
    ADD CONSTRAINT eworkflow_pk PRIMARY KEY (ewkfid);

ALTER TABLE eworkflow CLUSTER ON eworkflow_pk;


SET search_path = montage, pg_catalog;

--
-- TOC entry 2396 (class 1259 OID 960577)
-- Name: ilistfits_key_index; Type: INDEX; Schema: montage; Owner: chiron; Tablespace: 
--

CREATE UNIQUE INDEX ilistfits_key_index ON ilistfits USING btree (key);


--
-- TOC entry 2431 (class 1259 OID 960959)
-- Name: ocalculatedifference_key_index; Type: INDEX; Schema: montage; Owner: chiron; Tablespace: 
--

CREATE UNIQUE INDEX ocalculatedifference_key_index ON ocalculatedifference USING btree (key);


--
-- TOC entry 2421 (class 1259 OID 960844)
-- Name: ocalculateoverlaps_key_index; Type: INDEX; Schema: montage; Owner: chiron; Tablespace: 
--

CREATE UNIQUE INDEX ocalculateoverlaps_key_index ON ocalculateoverlaps USING btree (key);


--
-- TOC entry 2441 (class 1259 OID 961064)
-- Name: ocreatemosaic_key_index; Type: INDEX; Schema: montage; Owner: chiron; Tablespace: 
--

CREATE UNIQUE INDEX ocreatemosaic_key_index ON ocreatemosaic USING btree (key);


--
-- TOC entry 2416 (class 1259 OID 960789)
-- Name: ocreateumosaic_key_index; Type: INDEX; Schema: montage; Owner: chiron; Tablespace: 
--

CREATE UNIQUE INDEX ocreateumosaic_key_index ON ocreateumosaic USING btree (key);


--
-- TOC entry 2426 (class 1259 OID 960899)
-- Name: oextractdifferences_key_index; Type: INDEX; Schema: montage; Owner: chiron; Tablespace: 
--

CREATE UNIQUE INDEX oextractdifferences_key_index ON oextractdifferences USING btree (key);


--
-- TOC entry 2436 (class 1259 OID 961019)
-- Name: ofitplane_key_index; Type: INDEX; Schema: montage; Owner: chiron; Tablespace: 
--

CREATE UNIQUE INDEX ofitplane_key_index ON ofitplane USING btree (key);


--
-- TOC entry 2401 (class 1259 OID 960632)
-- Name: olistfits_key_index; Type: INDEX; Schema: montage; Owner: chiron; Tablespace: 
--

CREATE UNIQUE INDEX olistfits_key_index ON olistfits USING btree (key);


--
-- TOC entry 2406 (class 1259 OID 960692)
-- Name: oprojection_key_index; Type: INDEX; Schema: montage; Owner: chiron; Tablespace: 
--

CREATE UNIQUE INDEX oprojection_key_index ON oprojection USING btree (key);


--
-- TOC entry 2411 (class 1259 OID 960747)
-- Name: oselectprojections_key_index; Type: INDEX; Schema: montage; Owner: chiron; Tablespace: 
--

CREATE UNIQUE INDEX oselectprojections_key_index ON oselectprojections USING btree (key);


SET search_path = public, pg_catalog;

--
-- TOC entry 2352 (class 1259 OID 959438)
-- Name: c_activity_wkfid; Type: INDEX; Schema: public; Owner: vitor; Tablespace: 
--

CREATE INDEX c_activity_wkfid ON cactivity USING btree (wkfid);


--
-- TOC entry 2356 (class 1259 OID 959439)
-- Name: c_extractor_wkfid; Type: INDEX; Schema: public; Owner: vitor; Tablespace: 
--

CREATE INDEX c_extractor_wkfid ON cextractor USING btree (wkfid);


--
-- TOC entry 2364 (class 1259 OID 959441)
-- Name: c_field_key; Type: INDEX; Schema: public; Owner: vitor; Tablespace: 
--

CREATE INDEX c_field_key ON cfield USING btree (relid, fname);


--
-- TOC entry 2360 (class 1259 OID 959440)
-- Name: c_join_relid; Type: INDEX; Schema: public; Owner: vitor; Tablespace: 
--

CREATE INDEX c_join_relid ON cjoin USING btree (relid);


--
-- TOC entry 2353 (class 1259 OID 959442)
-- Name: cactivity_actid; Type: INDEX; Schema: public; Owner: vitor; Tablespace: 
--

CREATE UNIQUE INDEX cactivity_actid ON cactivity USING btree (actid);


--
-- TOC entry 2357 (class 1259 OID 959443)
-- Name: cextractor_extid; Type: INDEX; Schema: public; Owner: vitor; Tablespace: 
--

CREATE UNIQUE INDEX cextractor_extid ON cextractor USING btree (extid);


--
-- TOC entry 2361 (class 1259 OID 959444)
-- Name: cjoin_id; Type: INDEX; Schema: public; Owner: vitor; Tablespace: 
--

CREATE UNIQUE INDEX cjoin_id ON cjoin USING btree (relid, innerextid, outerextid);


--
-- TOC entry 2367 (class 1259 OID 959445)
-- Name: coperand_opid; Type: INDEX; Schema: public; Owner: vitor; Tablespace: 
--

CREATE UNIQUE INDEX coperand_opid ON coperand USING btree (opid);


--
-- TOC entry 2372 (class 1259 OID 959446)
-- Name: crelation_relid; Type: INDEX; Schema: public; Owner: vitor; Tablespace: 
--

CREATE UNIQUE INDEX crelation_relid ON crelation USING btree (relid);


--
-- TOC entry 2373 (class 1259 OID 959447)
-- Name: cworkflow_index; Type: INDEX; Schema: public; Owner: vitor; Tablespace: 
--

CREATE UNIQUE INDEX cworkflow_index ON cworkflow USING btree (wkfid);


--
-- TOC entry 2374 (class 1259 OID 959448)
-- Name: cworkflow_index_tag; Type: INDEX; Schema: public; Owner: vitor; Tablespace: 
--

CREATE UNIQUE INDEX cworkflow_index_tag ON cworkflow USING btree (tag);


--
-- TOC entry 2377 (class 1259 OID 959449)
-- Name: e_activation_actid; Type: INDEX; Schema: public; Owner: vitor; Tablespace: 
--

CREATE INDEX e_activation_actid ON eactivation USING btree (actid);


--
-- TOC entry 2381 (class 1259 OID 959450)
-- Name: e_activity_wkfid; Type: INDEX; Schema: public; Owner: vitor; Tablespace: 
--

CREATE INDEX e_activity_wkfid ON eactivity USING btree (wkfid);


--
-- TOC entry 2385 (class 1259 OID 959451)
-- Name: e_file_actid; Type: INDEX; Schema: public; Owner: vitor; Tablespace: 
--

CREATE INDEX e_file_actid ON efile USING btree (actid);


--
-- TOC entry 2386 (class 1259 OID 959452)
-- Name: e_file_taskid; Type: INDEX; Schema: public; Owner: vitor; Tablespace: 
--

CREATE INDEX e_file_taskid ON efile USING btree (taskid);


--
-- TOC entry 2378 (class 1259 OID 959453)
-- Name: eactivation_taskid; Type: INDEX; Schema: public; Owner: vitor; Tablespace: 
--

CREATE UNIQUE INDEX eactivation_taskid ON eactivation USING btree (taskid);


--
-- TOC entry 2382 (class 1259 OID 959454)
-- Name: eactivity_actid; Type: INDEX; Schema: public; Owner: vitor; Tablespace: 
--

CREATE UNIQUE INDEX eactivity_actid ON eactivity USING btree (actid);


--
-- TOC entry 2387 (class 1259 OID 959455)
-- Name: efile_fileid; Type: INDEX; Schema: public; Owner: vitor; Tablespace: 
--

CREATE UNIQUE INDEX efile_fileid ON efile USING btree (fileid);


SET search_path = montage, pg_catalog;

--
-- TOC entry 2507 (class 2606 OID 960934)
-- Name: dlcalculatedifferenceid_fk; Type: FK CONSTRAINT; Schema: montage; Owner: chiron
--

ALTER TABLE ONLY ocalculatedifference
    ADD CONSTRAINT dlcalculatedifferenceid_fk FOREIGN KEY (dlcalculatedifferenceid) REFERENCES dlcalculatedifference(rid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2492 (class 2606 OID 960819)
-- Name: dlcalculateoverlapsid_fk; Type: FK CONSTRAINT; Schema: montage; Owner: chiron
--

ALTER TABLE ONLY ocalculateoverlaps
    ADD CONSTRAINT dlcalculateoverlapsid_fk FOREIGN KEY (dlcalculateoverlapsid) REFERENCES dlcalculateoverlaps(rid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2522 (class 2606 OID 961049)
-- Name: dlcreatemosaicid_fk; Type: FK CONSTRAINT; Schema: montage; Owner: chiron
--

ALTER TABLE ONLY ocreatemosaic
    ADD CONSTRAINT dlcreatemosaicid_fk FOREIGN KEY (dlcreatemosaicid) REFERENCES dlcreatemosaic(rid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2487 (class 2606 OID 960774)
-- Name: dlcreateumosaicid_fk; Type: FK CONSTRAINT; Schema: montage; Owner: chiron
--

ALTER TABLE ONLY ocreateumosaic
    ADD CONSTRAINT dlcreateumosaicid_fk FOREIGN KEY (dlcreateumosaicid) REFERENCES dlcreateumosaic(rid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2499 (class 2606 OID 960874)
-- Name: dlextractdifferencesid_fk; Type: FK CONSTRAINT; Schema: montage; Owner: chiron
--

ALTER TABLE ONLY oextractdifferences
    ADD CONSTRAINT dlextractdifferencesid_fk FOREIGN KEY (dlextractdifferencesid) REFERENCES dlextractdifferences(rid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2506 (class 2606 OID 960929)
-- Name: dlextractdifferencesid_fk; Type: FK CONSTRAINT; Schema: montage; Owner: chiron
--

ALTER TABLE ONLY ocalculatedifference
    ADD CONSTRAINT dlextractdifferencesid_fk FOREIGN KEY (dlextractdifferencesid) REFERENCES dlextractdifferences(rid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2514 (class 2606 OID 960989)
-- Name: dlextractdifferencesid_fk; Type: FK CONSTRAINT; Schema: montage; Owner: chiron
--

ALTER TABLE ONLY ofitplane
    ADD CONSTRAINT dlextractdifferencesid_fk FOREIGN KEY (dlextractdifferencesid) REFERENCES dlextractdifferences(rid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2515 (class 2606 OID 960994)
-- Name: dlfitplaneid_fk; Type: FK CONSTRAINT; Schema: montage; Owner: chiron
--

ALTER TABLE ONLY ofitplane
    ADD CONSTRAINT dlfitplaneid_fk FOREIGN KEY (dlfitplaneid) REFERENCES dlfitplane(rid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2465 (class 2606 OID 960607)
-- Name: dllistfitsid_fk; Type: FK CONSTRAINT; Schema: montage; Owner: chiron
--

ALTER TABLE ONLY olistfits
    ADD CONSTRAINT dllistfitsid_fk FOREIGN KEY (dllistfitsid) REFERENCES dllistfits(rid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2472 (class 2606 OID 960662)
-- Name: dllistfitsid_fk; Type: FK CONSTRAINT; Schema: montage; Owner: chiron
--

ALTER TABLE ONLY oprojection
    ADD CONSTRAINT dllistfitsid_fk FOREIGN KEY (dllistfitsid) REFERENCES dllistfits(rid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2473 (class 2606 OID 960667)
-- Name: dlprojectionid_fk; Type: FK CONSTRAINT; Schema: montage; Owner: chiron
--

ALTER TABLE ONLY oprojection
    ADD CONSTRAINT dlprojectionid_fk FOREIGN KEY (dlprojectionid) REFERENCES dlprojection(rid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2480 (class 2606 OID 960722)
-- Name: dlselectprojectionsid_fk; Type: FK CONSTRAINT; Schema: montage; Owner: chiron
--

ALTER TABLE ONLY oselectprojections
    ADD CONSTRAINT dlselectprojectionsid_fk FOREIGN KEY (dlselectprojectionsid) REFERENCES dlselectprojections(rid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2462 (class 2606 OID 960572)
-- Name: ewkfid_fk; Type: FK CONSTRAINT; Schema: montage; Owner: chiron
--

ALTER TABLE ONLY ilistfits
    ADD CONSTRAINT ewkfid_fk FOREIGN KEY (ewkfid) REFERENCES public.eworkflow(ewkfid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2464 (class 2606 OID 960596)
-- Name: ewkfid_fk; Type: FK CONSTRAINT; Schema: montage; Owner: chiron
--

ALTER TABLE ONLY dllistfits
    ADD CONSTRAINT ewkfid_fk FOREIGN KEY (ewkfid) REFERENCES public.eworkflow(ewkfid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2469 (class 2606 OID 960627)
-- Name: ewkfid_fk; Type: FK CONSTRAINT; Schema: montage; Owner: chiron
--

ALTER TABLE ONLY olistfits
    ADD CONSTRAINT ewkfid_fk FOREIGN KEY (ewkfid) REFERENCES public.eworkflow(ewkfid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2471 (class 2606 OID 960651)
-- Name: ewkfid_fk; Type: FK CONSTRAINT; Schema: montage; Owner: chiron
--

ALTER TABLE ONLY dlprojection
    ADD CONSTRAINT ewkfid_fk FOREIGN KEY (ewkfid) REFERENCES public.eworkflow(ewkfid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2477 (class 2606 OID 960687)
-- Name: ewkfid_fk; Type: FK CONSTRAINT; Schema: montage; Owner: chiron
--

ALTER TABLE ONLY oprojection
    ADD CONSTRAINT ewkfid_fk FOREIGN KEY (ewkfid) REFERENCES public.eworkflow(ewkfid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2479 (class 2606 OID 960711)
-- Name: ewkfid_fk; Type: FK CONSTRAINT; Schema: montage; Owner: chiron
--

ALTER TABLE ONLY dlselectprojections
    ADD CONSTRAINT ewkfid_fk FOREIGN KEY (ewkfid) REFERENCES public.eworkflow(ewkfid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2484 (class 2606 OID 960742)
-- Name: ewkfid_fk; Type: FK CONSTRAINT; Schema: montage; Owner: chiron
--

ALTER TABLE ONLY oselectprojections
    ADD CONSTRAINT ewkfid_fk FOREIGN KEY (ewkfid) REFERENCES public.eworkflow(ewkfid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2486 (class 2606 OID 960763)
-- Name: ewkfid_fk; Type: FK CONSTRAINT; Schema: montage; Owner: chiron
--

ALTER TABLE ONLY dlcreateumosaic
    ADD CONSTRAINT ewkfid_fk FOREIGN KEY (ewkfid) REFERENCES public.eworkflow(ewkfid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2489 (class 2606 OID 960784)
-- Name: ewkfid_fk; Type: FK CONSTRAINT; Schema: montage; Owner: chiron
--

ALTER TABLE ONLY ocreateumosaic
    ADD CONSTRAINT ewkfid_fk FOREIGN KEY (ewkfid) REFERENCES public.eworkflow(ewkfid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2491 (class 2606 OID 960808)
-- Name: ewkfid_fk; Type: FK CONSTRAINT; Schema: montage; Owner: chiron
--

ALTER TABLE ONLY dlcalculateoverlaps
    ADD CONSTRAINT ewkfid_fk FOREIGN KEY (ewkfid) REFERENCES public.eworkflow(ewkfid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2496 (class 2606 OID 960839)
-- Name: ewkfid_fk; Type: FK CONSTRAINT; Schema: montage; Owner: chiron
--

ALTER TABLE ONLY ocalculateoverlaps
    ADD CONSTRAINT ewkfid_fk FOREIGN KEY (ewkfid) REFERENCES public.eworkflow(ewkfid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2498 (class 2606 OID 960863)
-- Name: ewkfid_fk; Type: FK CONSTRAINT; Schema: montage; Owner: chiron
--

ALTER TABLE ONLY dlextractdifferences
    ADD CONSTRAINT ewkfid_fk FOREIGN KEY (ewkfid) REFERENCES public.eworkflow(ewkfid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2503 (class 2606 OID 960894)
-- Name: ewkfid_fk; Type: FK CONSTRAINT; Schema: montage; Owner: chiron
--

ALTER TABLE ONLY oextractdifferences
    ADD CONSTRAINT ewkfid_fk FOREIGN KEY (ewkfid) REFERENCES public.eworkflow(ewkfid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2505 (class 2606 OID 960918)
-- Name: ewkfid_fk; Type: FK CONSTRAINT; Schema: montage; Owner: chiron
--

ALTER TABLE ONLY dlcalculatedifference
    ADD CONSTRAINT ewkfid_fk FOREIGN KEY (ewkfid) REFERENCES public.eworkflow(ewkfid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2511 (class 2606 OID 960954)
-- Name: ewkfid_fk; Type: FK CONSTRAINT; Schema: montage; Owner: chiron
--

ALTER TABLE ONLY ocalculatedifference
    ADD CONSTRAINT ewkfid_fk FOREIGN KEY (ewkfid) REFERENCES public.eworkflow(ewkfid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2513 (class 2606 OID 960978)
-- Name: ewkfid_fk; Type: FK CONSTRAINT; Schema: montage; Owner: chiron
--

ALTER TABLE ONLY dlfitplane
    ADD CONSTRAINT ewkfid_fk FOREIGN KEY (ewkfid) REFERENCES public.eworkflow(ewkfid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2519 (class 2606 OID 961014)
-- Name: ewkfid_fk; Type: FK CONSTRAINT; Schema: montage; Owner: chiron
--

ALTER TABLE ONLY ofitplane
    ADD CONSTRAINT ewkfid_fk FOREIGN KEY (ewkfid) REFERENCES public.eworkflow(ewkfid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2521 (class 2606 OID 961038)
-- Name: ewkfid_fk; Type: FK CONSTRAINT; Schema: montage; Owner: chiron
--

ALTER TABLE ONLY dlcreatemosaic
    ADD CONSTRAINT ewkfid_fk FOREIGN KEY (ewkfid) REFERENCES public.eworkflow(ewkfid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2524 (class 2606 OID 961059)
-- Name: ewkfid_fk; Type: FK CONSTRAINT; Schema: montage; Owner: chiron
--

ALTER TABLE ONLY ocreatemosaic
    ADD CONSTRAINT ewkfid_fk FOREIGN KEY (ewkfid) REFERENCES public.eworkflow(ewkfid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2467 (class 2606 OID 960617)
-- Name: nextactid_fk; Type: FK CONSTRAINT; Schema: montage; Owner: chiron
--

ALTER TABLE ONLY olistfits
    ADD CONSTRAINT nextactid_fk FOREIGN KEY (nextactid) REFERENCES public.eactivity(actid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2475 (class 2606 OID 960677)
-- Name: nextactid_fk; Type: FK CONSTRAINT; Schema: montage; Owner: chiron
--

ALTER TABLE ONLY oprojection
    ADD CONSTRAINT nextactid_fk FOREIGN KEY (nextactid) REFERENCES public.eactivity(actid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2482 (class 2606 OID 960732)
-- Name: nextactid_fk; Type: FK CONSTRAINT; Schema: montage; Owner: chiron
--

ALTER TABLE ONLY oselectprojections
    ADD CONSTRAINT nextactid_fk FOREIGN KEY (nextactid) REFERENCES public.eactivity(actid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2494 (class 2606 OID 960829)
-- Name: nextactid_fk; Type: FK CONSTRAINT; Schema: montage; Owner: chiron
--

ALTER TABLE ONLY ocalculateoverlaps
    ADD CONSTRAINT nextactid_fk FOREIGN KEY (nextactid) REFERENCES public.eactivity(actid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2501 (class 2606 OID 960884)
-- Name: nextactid_fk; Type: FK CONSTRAINT; Schema: montage; Owner: chiron
--

ALTER TABLE ONLY oextractdifferences
    ADD CONSTRAINT nextactid_fk FOREIGN KEY (nextactid) REFERENCES public.eactivity(actid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2509 (class 2606 OID 960944)
-- Name: nextactid_fk; Type: FK CONSTRAINT; Schema: montage; Owner: chiron
--

ALTER TABLE ONLY ocalculatedifference
    ADD CONSTRAINT nextactid_fk FOREIGN KEY (nextactid) REFERENCES public.eactivity(actid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2517 (class 2606 OID 961004)
-- Name: nextactid_fk; Type: FK CONSTRAINT; Schema: montage; Owner: chiron
--

ALTER TABLE ONLY ofitplane
    ADD CONSTRAINT nextactid_fk FOREIGN KEY (nextactid) REFERENCES public.eactivity(actid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2468 (class 2606 OID 960622)
-- Name: nexttaskid_fk; Type: FK CONSTRAINT; Schema: montage; Owner: chiron
--

ALTER TABLE ONLY olistfits
    ADD CONSTRAINT nexttaskid_fk FOREIGN KEY (nexttaskid) REFERENCES public.eactivation(taskid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2476 (class 2606 OID 960682)
-- Name: nexttaskid_fk; Type: FK CONSTRAINT; Schema: montage; Owner: chiron
--

ALTER TABLE ONLY oprojection
    ADD CONSTRAINT nexttaskid_fk FOREIGN KEY (nexttaskid) REFERENCES public.eactivation(taskid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2483 (class 2606 OID 960737)
-- Name: nexttaskid_fk; Type: FK CONSTRAINT; Schema: montage; Owner: chiron
--

ALTER TABLE ONLY oselectprojections
    ADD CONSTRAINT nexttaskid_fk FOREIGN KEY (nexttaskid) REFERENCES public.eactivation(taskid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2495 (class 2606 OID 960834)
-- Name: nexttaskid_fk; Type: FK CONSTRAINT; Schema: montage; Owner: chiron
--

ALTER TABLE ONLY ocalculateoverlaps
    ADD CONSTRAINT nexttaskid_fk FOREIGN KEY (nexttaskid) REFERENCES public.eactivation(taskid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2502 (class 2606 OID 960889)
-- Name: nexttaskid_fk; Type: FK CONSTRAINT; Schema: montage; Owner: chiron
--

ALTER TABLE ONLY oextractdifferences
    ADD CONSTRAINT nexttaskid_fk FOREIGN KEY (nexttaskid) REFERENCES public.eactivation(taskid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2510 (class 2606 OID 960949)
-- Name: nexttaskid_fk; Type: FK CONSTRAINT; Schema: montage; Owner: chiron
--

ALTER TABLE ONLY ocalculatedifference
    ADD CONSTRAINT nexttaskid_fk FOREIGN KEY (nexttaskid) REFERENCES public.eactivation(taskid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2518 (class 2606 OID 961009)
-- Name: nexttaskid_fk; Type: FK CONSTRAINT; Schema: montage; Owner: chiron
--

ALTER TABLE ONLY ofitplane
    ADD CONSTRAINT nexttaskid_fk FOREIGN KEY (nexttaskid) REFERENCES public.eactivation(taskid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2466 (class 2606 OID 960612)
-- Name: previousactid_fk; Type: FK CONSTRAINT; Schema: montage; Owner: chiron
--

ALTER TABLE ONLY olistfits
    ADD CONSTRAINT previousactid_fk FOREIGN KEY (previousactid) REFERENCES public.eactivity(actid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2474 (class 2606 OID 960672)
-- Name: previousactid_fk; Type: FK CONSTRAINT; Schema: montage; Owner: chiron
--

ALTER TABLE ONLY oprojection
    ADD CONSTRAINT previousactid_fk FOREIGN KEY (previousactid) REFERENCES public.eactivity(actid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2481 (class 2606 OID 960727)
-- Name: previousactid_fk; Type: FK CONSTRAINT; Schema: montage; Owner: chiron
--

ALTER TABLE ONLY oselectprojections
    ADD CONSTRAINT previousactid_fk FOREIGN KEY (previousactid) REFERENCES public.eactivity(actid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2493 (class 2606 OID 960824)
-- Name: previousactid_fk; Type: FK CONSTRAINT; Schema: montage; Owner: chiron
--

ALTER TABLE ONLY ocalculateoverlaps
    ADD CONSTRAINT previousactid_fk FOREIGN KEY (previousactid) REFERENCES public.eactivity(actid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2500 (class 2606 OID 960879)
-- Name: previousactid_fk; Type: FK CONSTRAINT; Schema: montage; Owner: chiron
--

ALTER TABLE ONLY oextractdifferences
    ADD CONSTRAINT previousactid_fk FOREIGN KEY (previousactid) REFERENCES public.eactivity(actid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2508 (class 2606 OID 960939)
-- Name: previousactid_fk; Type: FK CONSTRAINT; Schema: montage; Owner: chiron
--

ALTER TABLE ONLY ocalculatedifference
    ADD CONSTRAINT previousactid_fk FOREIGN KEY (previousactid) REFERENCES public.eactivity(actid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2516 (class 2606 OID 960999)
-- Name: previousactid_fk; Type: FK CONSTRAINT; Schema: montage; Owner: chiron
--

ALTER TABLE ONLY ofitplane
    ADD CONSTRAINT previousactid_fk FOREIGN KEY (previousactid) REFERENCES public.eactivity(actid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2463 (class 2606 OID 960591)
-- Name: taskid_fk; Type: FK CONSTRAINT; Schema: montage; Owner: chiron
--

ALTER TABLE ONLY dllistfits
    ADD CONSTRAINT taskid_fk FOREIGN KEY (taskid) REFERENCES public.eactivation(taskid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2470 (class 2606 OID 960646)
-- Name: taskid_fk; Type: FK CONSTRAINT; Schema: montage; Owner: chiron
--

ALTER TABLE ONLY dlprojection
    ADD CONSTRAINT taskid_fk FOREIGN KEY (taskid) REFERENCES public.eactivation(taskid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2478 (class 2606 OID 960706)
-- Name: taskid_fk; Type: FK CONSTRAINT; Schema: montage; Owner: chiron
--

ALTER TABLE ONLY dlselectprojections
    ADD CONSTRAINT taskid_fk FOREIGN KEY (taskid) REFERENCES public.eactivation(taskid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2485 (class 2606 OID 960758)
-- Name: taskid_fk; Type: FK CONSTRAINT; Schema: montage; Owner: chiron
--

ALTER TABLE ONLY dlcreateumosaic
    ADD CONSTRAINT taskid_fk FOREIGN KEY (taskid) REFERENCES public.eactivation(taskid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2488 (class 2606 OID 960779)
-- Name: taskid_fk; Type: FK CONSTRAINT; Schema: montage; Owner: chiron
--

ALTER TABLE ONLY ocreateumosaic
    ADD CONSTRAINT taskid_fk FOREIGN KEY (taskid) REFERENCES public.eactivation(taskid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2490 (class 2606 OID 960803)
-- Name: taskid_fk; Type: FK CONSTRAINT; Schema: montage; Owner: chiron
--

ALTER TABLE ONLY dlcalculateoverlaps
    ADD CONSTRAINT taskid_fk FOREIGN KEY (taskid) REFERENCES public.eactivation(taskid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2497 (class 2606 OID 960858)
-- Name: taskid_fk; Type: FK CONSTRAINT; Schema: montage; Owner: chiron
--

ALTER TABLE ONLY dlextractdifferences
    ADD CONSTRAINT taskid_fk FOREIGN KEY (taskid) REFERENCES public.eactivation(taskid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2504 (class 2606 OID 960913)
-- Name: taskid_fk; Type: FK CONSTRAINT; Schema: montage; Owner: chiron
--

ALTER TABLE ONLY dlcalculatedifference
    ADD CONSTRAINT taskid_fk FOREIGN KEY (taskid) REFERENCES public.eactivation(taskid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2512 (class 2606 OID 960973)
-- Name: taskid_fk; Type: FK CONSTRAINT; Schema: montage; Owner: chiron
--

ALTER TABLE ONLY dlfitplane
    ADD CONSTRAINT taskid_fk FOREIGN KEY (taskid) REFERENCES public.eactivation(taskid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2520 (class 2606 OID 961033)
-- Name: taskid_fk; Type: FK CONSTRAINT; Schema: montage; Owner: chiron
--

ALTER TABLE ONLY dlcreatemosaic
    ADD CONSTRAINT taskid_fk FOREIGN KEY (taskid) REFERENCES public.eactivation(taskid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2523 (class 2606 OID 961054)
-- Name: taskid_fk; Type: FK CONSTRAINT; Schema: montage; Owner: chiron
--

ALTER TABLE ONLY ocreatemosaic
    ADD CONSTRAINT taskid_fk FOREIGN KEY (taskid) REFERENCES public.eactivation(taskid) ON UPDATE CASCADE ON DELETE CASCADE;


SET search_path = public, pg_catalog;

--
-- TOC entry 2444 (class 2606 OID 959456)
-- Name: cactivity_wkfid_fk; Type: FK CONSTRAINT; Schema: public; Owner: vitor
--

ALTER TABLE ONLY cactivity
    ADD CONSTRAINT cactivity_wkfid_fk FOREIGN KEY (wkfid) REFERENCES cworkflow(wkfid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2445 (class 2606 OID 959478)
-- Name: cextractor_actid_fk; Type: FK CONSTRAINT; Schema: public; Owner: vitor
--

ALTER TABLE ONLY cextractor
    ADD CONSTRAINT cextractor_actid_fk FOREIGN KEY (wkfid) REFERENCES cworkflow(wkfid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2449 (class 2606 OID 959498)
-- Name: cfield_extid_fk; Type: FK CONSTRAINT; Schema: public; Owner: vitor
--

ALTER TABLE ONLY cfield
    ADD CONSTRAINT cfield_extid_fk FOREIGN KEY (extid) REFERENCES cextractor(extid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2450 (class 2606 OID 959503)
-- Name: cfield_realid_fk; Type: FK CONSTRAINT; Schema: public; Owner: vitor
--

ALTER TABLE ONLY cfield
    ADD CONSTRAINT cfield_realid_fk FOREIGN KEY (relid) REFERENCES crelation(relid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2447 (class 2606 OID 959488)
-- Name: cjoin_innerextid_fk; Type: FK CONSTRAINT; Schema: public; Owner: vitor
--

ALTER TABLE ONLY cjoin
    ADD CONSTRAINT cjoin_innerextid_fk FOREIGN KEY (innerextid) REFERENCES cextractor(extid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2448 (class 2606 OID 959493)
-- Name: cjoin_outerextid_fk; Type: FK CONSTRAINT; Schema: public; Owner: vitor
--

ALTER TABLE ONLY cjoin
    ADD CONSTRAINT cjoin_outerextid_fk FOREIGN KEY (outerextid) REFERENCES cextractor(extid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2446 (class 2606 OID 959483)
-- Name: cjoin_relid_fk; Type: FK CONSTRAINT; Schema: public; Owner: vitor
--

ALTER TABLE ONLY cjoin
    ADD CONSTRAINT cjoin_relid_fk FOREIGN KEY (relid) REFERENCES crelation(relid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2459 (class 2606 OID 959463)
-- Name: cmapping_crelid_fk; Type: FK CONSTRAINT; Schema: public; Owner: vitor
--

ALTER TABLE ONLY cmapping
    ADD CONSTRAINT cmapping_crelid_fk FOREIGN KEY (crelid) REFERENCES crelation(relid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2461 (class 2606 OID 959473)
-- Name: cmapping_next_fk; Type: FK CONSTRAINT; Schema: public; Owner: vitor
--

ALTER TABLE ONLY cmapping
    ADD CONSTRAINT cmapping_next_fk FOREIGN KEY (nextid) REFERENCES cactivity(actid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2460 (class 2606 OID 959468)
-- Name: cmapping_previousid_fk; Type: FK CONSTRAINT; Schema: public; Owner: vitor
--

ALTER TABLE ONLY cmapping
    ADD CONSTRAINT cmapping_previousid_fk FOREIGN KEY (previousid) REFERENCES cactivity(actid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2451 (class 2606 OID 959508)
-- Name: coperand_actid_fk; Type: FK CONSTRAINT; Schema: public; Owner: vitor
--

ALTER TABLE ONLY coperand
    ADD CONSTRAINT coperand_actid_fk FOREIGN KEY (actid) REFERENCES cactivity(actid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2454 (class 2606 OID 959513)
-- Name: eactibity_cactid_fk; Type: FK CONSTRAINT; Schema: public; Owner: vitor
--

ALTER TABLE ONLY eactivity
    ADD CONSTRAINT eactibity_cactid_fk FOREIGN KEY (cactid) REFERENCES cactivity(actid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2452 (class 2606 OID 959518)
-- Name: eactivation_machineid_fk; Type: FK CONSTRAINT; Schema: public; Owner: vitor
--

ALTER TABLE ONLY eactivation
    ADD CONSTRAINT eactivation_machineid_fk FOREIGN KEY (machineid) REFERENCES emachine(machineid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2455 (class 2606 OID 959523)
-- Name: eactivity_wkfid_fk; Type: FK CONSTRAINT; Schema: public; Owner: vitor
--

ALTER TABLE ONLY eactivity
    ADD CONSTRAINT eactivity_wkfid_fk FOREIGN KEY (wkfid) REFERENCES eworkflow(ewkfid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2456 (class 2606 OID 959528)
-- Name: efile_actid_fk; Type: FK CONSTRAINT; Schema: public; Owner: vitor
--

ALTER TABLE ONLY efile
    ADD CONSTRAINT efile_actid_fk FOREIGN KEY (actid) REFERENCES eactivity(actid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2457 (class 2606 OID 959533)
-- Name: efile_taskid_fk; Type: FK CONSTRAINT; Schema: public; Owner: vitor
--

ALTER TABLE ONLY efile
    ADD CONSTRAINT efile_taskid_fk FOREIGN KEY (taskid) REFERENCES eactivation(taskid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2453 (class 2606 OID 959538)
-- Name: etask_actid_fk; Type: FK CONSTRAINT; Schema: public; Owner: vitor
--

ALTER TABLE ONLY eactivation
    ADD CONSTRAINT etask_actid_fk FOREIGN KEY (actid) REFERENCES eactivity(actid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2458 (class 2606 OID 959543)
-- Name: eworkflow_fk; Type: FK CONSTRAINT; Schema: public; Owner: vitor
--

ALTER TABLE ONLY eworkflow
    ADD CONSTRAINT eworkflow_fk FOREIGN KEY (tag) REFERENCES cworkflow(tag) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2704 (class 0 OID 0)
-- Dependencies: 6
-- Name: public; Type: ACL; Schema: -; Owner: vitor
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM vitor;
GRANT ALL ON SCHEMA public TO vitor;
GRANT ALL ON SCHEMA public TO chiron;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- TOC entry 2706 (class 0 OID 0)
-- Dependencies: 173
-- Name: cactivity; Type: ACL; Schema: public; Owner: vitor
--

REVOKE ALL ON TABLE cactivity FROM PUBLIC;
REVOKE ALL ON TABLE cactivity FROM vitor;
GRANT ALL ON TABLE cactivity TO vitor;
GRANT ALL ON TABLE cactivity TO chiron;
GRANT ALL ON TABLE cactivity TO PUBLIC;


--
-- TOC entry 2707 (class 0 OID 0)
-- Dependencies: 174
-- Name: cextractor; Type: ACL; Schema: public; Owner: vitor
--

REVOKE ALL ON TABLE cextractor FROM PUBLIC;
REVOKE ALL ON TABLE cextractor FROM vitor;
GRANT ALL ON TABLE cextractor TO vitor;
GRANT ALL ON TABLE cextractor TO chiron;
GRANT ALL ON TABLE cextractor TO PUBLIC;


--
-- TOC entry 2708 (class 0 OID 0)
-- Dependencies: 176
-- Name: cfield; Type: ACL; Schema: public; Owner: vitor
--

REVOKE ALL ON TABLE cfield FROM PUBLIC;
REVOKE ALL ON TABLE cfield FROM vitor;
GRANT ALL ON TABLE cfield TO vitor;
GRANT ALL ON TABLE cfield TO chiron;
GRANT ALL ON TABLE cfield TO PUBLIC;


--
-- TOC entry 2709 (class 0 OID 0)
-- Dependencies: 175
-- Name: cjoin; Type: ACL; Schema: public; Owner: vitor
--

REVOKE ALL ON TABLE cjoin FROM PUBLIC;
REVOKE ALL ON TABLE cjoin FROM vitor;
GRANT ALL ON TABLE cjoin TO vitor;
GRANT ALL ON TABLE cjoin TO chiron;
GRANT ALL ON TABLE cjoin TO PUBLIC;


--
-- TOC entry 2710 (class 0 OID 0)
-- Dependencies: 177
-- Name: coperand; Type: ACL; Schema: public; Owner: vitor
--

REVOKE ALL ON TABLE coperand FROM PUBLIC;
REVOKE ALL ON TABLE coperand FROM vitor;
GRANT ALL ON TABLE coperand TO vitor;
GRANT ALL ON TABLE coperand TO chiron;
GRANT ALL ON TABLE coperand TO PUBLIC;


--
-- TOC entry 2711 (class 0 OID 0)
-- Dependencies: 179
-- Name: crelation; Type: ACL; Schema: public; Owner: vitor
--

REVOKE ALL ON TABLE crelation FROM PUBLIC;
REVOKE ALL ON TABLE crelation FROM vitor;
GRANT ALL ON TABLE crelation TO vitor;
GRANT ALL ON TABLE crelation TO chiron;
GRANT ALL ON TABLE crelation TO PUBLIC;


--
-- TOC entry 2712 (class 0 OID 0)
-- Dependencies: 181
-- Name: cworkflow; Type: ACL; Schema: public; Owner: vitor
--

REVOKE ALL ON TABLE cworkflow FROM PUBLIC;
REVOKE ALL ON TABLE cworkflow FROM vitor;
GRANT ALL ON TABLE cworkflow TO vitor;
GRANT ALL ON TABLE cworkflow TO chiron;
GRANT ALL ON TABLE cworkflow TO PUBLIC;


--
-- TOC entry 2713 (class 0 OID 0)
-- Dependencies: 182
-- Name: eactivation; Type: ACL; Schema: public; Owner: vitor
--

REVOKE ALL ON TABLE eactivation FROM PUBLIC;
REVOKE ALL ON TABLE eactivation FROM vitor;
GRANT ALL ON TABLE eactivation TO vitor;
GRANT ALL ON TABLE eactivation TO chiron;
GRANT ALL ON TABLE eactivation TO PUBLIC;


--
-- TOC entry 2714 (class 0 OID 0)
-- Dependencies: 183
-- Name: eactivity; Type: ACL; Schema: public; Owner: vitor
--

REVOKE ALL ON TABLE eactivity FROM PUBLIC;
REVOKE ALL ON TABLE eactivity FROM vitor;
GRANT ALL ON TABLE eactivity TO vitor;
GRANT ALL ON TABLE eactivity TO chiron;
GRANT ALL ON TABLE eactivity TO PUBLIC;


--
-- TOC entry 2715 (class 0 OID 0)
-- Dependencies: 184
-- Name: efile; Type: ACL; Schema: public; Owner: vitor
--

REVOKE ALL ON TABLE efile FROM PUBLIC;
REVOKE ALL ON TABLE efile FROM vitor;
GRANT ALL ON TABLE efile TO vitor;
GRANT ALL ON TABLE efile TO chiron;
GRANT ALL ON TABLE efile TO PUBLIC;


--
-- TOC entry 2716 (class 0 OID 0)
-- Dependencies: 185
-- Name: emachine; Type: ACL; Schema: public; Owner: vitor
--

REVOKE ALL ON TABLE emachine FROM PUBLIC;
REVOKE ALL ON TABLE emachine FROM vitor;
GRANT ALL ON TABLE emachine TO vitor;
GRANT ALL ON TABLE emachine TO chiron;
GRANT ALL ON TABLE emachine TO PUBLIC;


--
-- TOC entry 2717 (class 0 OID 0)
-- Dependencies: 189
-- Name: eworkflow; Type: ACL; Schema: public; Owner: vitor
--

REVOKE ALL ON TABLE eworkflow FROM PUBLIC;
REVOKE ALL ON TABLE eworkflow FROM vitor;
GRANT ALL ON TABLE eworkflow TO vitor;
GRANT ALL ON TABLE eworkflow TO chiron;
GRANT ALL ON TABLE eworkflow TO PUBLIC;


-- Completed on 2016-10-11 11:04:05 BRT

--
-- PostgreSQL database dump complete
--

