--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.14
-- Dumped by pg_dump version 10.5 (Ubuntu 10.5-0ubuntu0.18.04)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: discovery; Type: DATABASE; Schema: -; Owner: discovery
--

CREATE DATABASE discovery WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.utf8' LC_CTYPE = 'en_US.utf8';


ALTER DATABASE discovery OWNER TO discovery;

\connect discovery

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: activity; Type: TABLE; Schema: public; Owner: discovery
--

CREATE TABLE public.activity (
    id integer NOT NULL,
    topic character varying(32) NOT NULL,
    "timestamp" timestamp with time zone NOT NULL,
    user_id integer,
    model character varying(16),
    model_id integer,
    database_id integer,
    table_id integer,
    custom_id character varying(48),
    details character varying NOT NULL
);


ALTER TABLE public.activity OWNER TO discovery;

--
-- Name: activity_id_seq; Type: SEQUENCE; Schema: public; Owner: discovery
--

CREATE SEQUENCE public.activity_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.activity_id_seq OWNER TO discovery;

--
-- Name: activity_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: discovery
--

ALTER SEQUENCE public.activity_id_seq OWNED BY public.activity.id;


--
-- Name: card_label; Type: TABLE; Schema: public; Owner: discovery
--

CREATE TABLE public.card_label (
    id integer NOT NULL,
    card_id integer NOT NULL,
    label_id integer NOT NULL
);


ALTER TABLE public.card_label OWNER TO discovery;

--
-- Name: card_label_id_seq; Type: SEQUENCE; Schema: public; Owner: discovery
--

CREATE SEQUENCE public.card_label_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.card_label_id_seq OWNER TO discovery;

--
-- Name: card_label_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: discovery
--

ALTER SEQUENCE public.card_label_id_seq OWNED BY public.card_label.id;


--
-- Name: collection; Type: TABLE; Schema: public; Owner: discovery
--

CREATE TABLE public.collection (
    id integer NOT NULL,
    name text NOT NULL,
    slug character varying(254) NOT NULL,
    description text,
    color character(7) NOT NULL,
    archived boolean DEFAULT false NOT NULL
);


ALTER TABLE public.collection OWNER TO discovery;

--
-- Name: TABLE collection; Type: COMMENT; Schema: public; Owner: discovery
--

COMMENT ON TABLE public.collection IS 'Collections are an optional way to organize Cards and handle permissions for them.';


--
-- Name: COLUMN collection.name; Type: COMMENT; Schema: public; Owner: discovery
--

COMMENT ON COLUMN public.collection.name IS 'The unique, user-facing name of this Collection.';


--
-- Name: COLUMN collection.slug; Type: COMMENT; Schema: public; Owner: discovery
--

COMMENT ON COLUMN public.collection.slug IS 'URL-friendly, sluggified, indexed version of name.';


--
-- Name: COLUMN collection.description; Type: COMMENT; Schema: public; Owner: discovery
--

COMMENT ON COLUMN public.collection.description IS 'Optional description for this Collection.';


--
-- Name: COLUMN collection.color; Type: COMMENT; Schema: public; Owner: discovery
--

COMMENT ON COLUMN public.collection.color IS 'Seven-character hex color for this Collection, including the preceding hash sign.';


--
-- Name: COLUMN collection.archived; Type: COMMENT; Schema: public; Owner: discovery
--

COMMENT ON COLUMN public.collection.archived IS 'Whether this Collection has been archived and should be hidden from users.';


--
-- Name: collection_id_seq; Type: SEQUENCE; Schema: public; Owner: discovery
--

CREATE SEQUENCE public.collection_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.collection_id_seq OWNER TO discovery;

--
-- Name: collection_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: discovery
--

ALTER SEQUENCE public.collection_id_seq OWNED BY public.collection.id;


--
-- Name: collection_revision; Type: TABLE; Schema: public; Owner: discovery
--

CREATE TABLE public.collection_revision (
    id integer NOT NULL,
    before text NOT NULL,
    after text NOT NULL,
    user_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    remark text
);


ALTER TABLE public.collection_revision OWNER TO discovery;

--
-- Name: TABLE collection_revision; Type: COMMENT; Schema: public; Owner: discovery
--

COMMENT ON TABLE public.collection_revision IS 'Used to keep track of changes made to collections.';


--
-- Name: COLUMN collection_revision.before; Type: COMMENT; Schema: public; Owner: discovery
--

COMMENT ON COLUMN public.collection_revision.before IS 'Serialized JSON of the collections graph before the changes.';


--
-- Name: COLUMN collection_revision.after; Type: COMMENT; Schema: public; Owner: discovery
--

COMMENT ON COLUMN public.collection_revision.after IS 'Serialized JSON of the collections graph after the changes.';


--
-- Name: COLUMN collection_revision.user_id; Type: COMMENT; Schema: public; Owner: discovery
--

COMMENT ON COLUMN public.collection_revision.user_id IS 'The ID of the admin who made this set of changes.';


--
-- Name: COLUMN collection_revision.created_at; Type: COMMENT; Schema: public; Owner: discovery
--

COMMENT ON COLUMN public.collection_revision.created_at IS 'The timestamp of when these changes were made.';


--
-- Name: COLUMN collection_revision.remark; Type: COMMENT; Schema: public; Owner: discovery
--

COMMENT ON COLUMN public.collection_revision.remark IS 'Optional remarks explaining why these changes were made.';


--
-- Name: collection_revision_id_seq; Type: SEQUENCE; Schema: public; Owner: discovery
--

CREATE SEQUENCE public.collection_revision_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.collection_revision_id_seq OWNER TO discovery;

--
-- Name: collection_revision_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: discovery
--

ALTER SEQUENCE public.collection_revision_id_seq OWNED BY public.collection_revision.id;


--
-- Name: computation_job; Type: TABLE; Schema: public; Owner: discovery
--

CREATE TABLE public.computation_job (
    id integer NOT NULL,
    creator_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    type character varying(254) NOT NULL,
    status character varying(254) NOT NULL,
    context text,
    ended_at timestamp without time zone
);


ALTER TABLE public.computation_job OWNER TO discovery;

--
-- Name: TABLE computation_job; Type: COMMENT; Schema: public; Owner: discovery
--

COMMENT ON TABLE public.computation_job IS 'Stores submitted async computation jobs.';


--
-- Name: computation_job_id_seq; Type: SEQUENCE; Schema: public; Owner: discovery
--

CREATE SEQUENCE public.computation_job_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.computation_job_id_seq OWNER TO discovery;

--
-- Name: computation_job_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: discovery
--

ALTER SEQUENCE public.computation_job_id_seq OWNED BY public.computation_job.id;


--
-- Name: computation_job_result; Type: TABLE; Schema: public; Owner: discovery
--

CREATE TABLE public.computation_job_result (
    id integer NOT NULL,
    job_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    permanence character varying(254) NOT NULL,
    payload text NOT NULL
);


ALTER TABLE public.computation_job_result OWNER TO discovery;

--
-- Name: TABLE computation_job_result; Type: COMMENT; Schema: public; Owner: discovery
--

COMMENT ON TABLE public.computation_job_result IS 'Stores results of async computation jobs.';


--
-- Name: computation_job_result_id_seq; Type: SEQUENCE; Schema: public; Owner: discovery
--

CREATE SEQUENCE public.computation_job_result_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.computation_job_result_id_seq OWNER TO discovery;

--
-- Name: computation_job_result_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: discovery
--

ALTER SEQUENCE public.computation_job_result_id_seq OWNED BY public.computation_job_result.id;


--
-- Name: core_session; Type: TABLE; Schema: public; Owner: discovery
--

CREATE TABLE public.core_session (
    id character varying(254) NOT NULL,
    user_id integer NOT NULL,
    created_at timestamp with time zone NOT NULL
);


ALTER TABLE public.core_session OWNER TO discovery;

--
-- Name: core_user; Type: TABLE; Schema: public; Owner: discovery
--

CREATE TABLE public.core_user (
    id integer NOT NULL,
    email character varying(254) NOT NULL,
    first_name character varying(254) NOT NULL,
    last_name character varying(254) NOT NULL,
    password character varying(254) NOT NULL,
    password_salt character varying(254) DEFAULT 'default'::character varying NOT NULL,
    date_joined timestamp with time zone NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    is_active boolean NOT NULL,
    reset_token character varying(254),
    reset_triggered bigint,
    is_qbnewb boolean DEFAULT true NOT NULL,
    google_auth boolean DEFAULT false NOT NULL,
    ldap_auth boolean DEFAULT false NOT NULL
);


ALTER TABLE public.core_user OWNER TO discovery;

--
-- Name: core_user_id_seq; Type: SEQUENCE; Schema: public; Owner: discovery
--

CREATE SEQUENCE public.core_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.core_user_id_seq OWNER TO discovery;

--
-- Name: core_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: discovery
--

ALTER SEQUENCE public.core_user_id_seq OWNED BY public.core_user.id;


--
-- Name: dashboard_favorite; Type: TABLE; Schema: public; Owner: discovery
--

CREATE TABLE public.dashboard_favorite (
    id integer NOT NULL,
    user_id integer NOT NULL,
    dashboard_id integer NOT NULL
);


ALTER TABLE public.dashboard_favorite OWNER TO discovery;

--
-- Name: TABLE dashboard_favorite; Type: COMMENT; Schema: public; Owner: discovery
--

COMMENT ON TABLE public.dashboard_favorite IS 'Presence of a row here indicates a given User has favorited a given Dashboard.';


--
-- Name: COLUMN dashboard_favorite.user_id; Type: COMMENT; Schema: public; Owner: discovery
--

COMMENT ON COLUMN public.dashboard_favorite.user_id IS 'ID of the User who favorited the Dashboard.';


--
-- Name: COLUMN dashboard_favorite.dashboard_id; Type: COMMENT; Schema: public; Owner: discovery
--

COMMENT ON COLUMN public.dashboard_favorite.dashboard_id IS 'ID of the Dashboard favorited by the User.';


--
-- Name: dashboard_favorite_id_seq; Type: SEQUENCE; Schema: public; Owner: discovery
--

CREATE SEQUENCE public.dashboard_favorite_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dashboard_favorite_id_seq OWNER TO discovery;

--
-- Name: dashboard_favorite_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: discovery
--

ALTER SEQUENCE public.dashboard_favorite_id_seq OWNED BY public.dashboard_favorite.id;


--
-- Name: dashboardcard_series; Type: TABLE; Schema: public; Owner: discovery
--

CREATE TABLE public.dashboardcard_series (
    id integer NOT NULL,
    dashboardcard_id integer NOT NULL,
    card_id integer NOT NULL,
    "position" integer NOT NULL
);


ALTER TABLE public.dashboardcard_series OWNER TO discovery;

--
-- Name: dashboardcard_series_id_seq; Type: SEQUENCE; Schema: public; Owner: discovery
--

CREATE SEQUENCE public.dashboardcard_series_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dashboardcard_series_id_seq OWNER TO discovery;

--
-- Name: dashboardcard_series_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: discovery
--

ALTER SEQUENCE public.dashboardcard_series_id_seq OWNED BY public.dashboardcard_series.id;


--
-- Name: data_migrations; Type: TABLE; Schema: public; Owner: discovery
--

CREATE TABLE public.data_migrations (
    id character varying(254) NOT NULL,
    "timestamp" timestamp without time zone NOT NULL
);


ALTER TABLE public.data_migrations OWNER TO discovery;

--
-- Name: databasechangelog; Type: TABLE; Schema: public; Owner: discovery
--

CREATE TABLE public.databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


ALTER TABLE public.databasechangelog OWNER TO discovery;

--
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: discovery
--

CREATE TABLE public.databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE public.databasechangeloglock OWNER TO discovery;

--
-- Name: dependency; Type: TABLE; Schema: public; Owner: discovery
--

CREATE TABLE public.dependency (
    id integer NOT NULL,
    model character varying(32) NOT NULL,
    model_id integer NOT NULL,
    dependent_on_model character varying(32) NOT NULL,
    dependent_on_id integer NOT NULL,
    created_at timestamp with time zone NOT NULL
);


ALTER TABLE public.dependency OWNER TO discovery;

--
-- Name: dependency_id_seq; Type: SEQUENCE; Schema: public; Owner: discovery
--

CREATE SEQUENCE public.dependency_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dependency_id_seq OWNER TO discovery;

--
-- Name: dependency_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: discovery
--

ALTER SEQUENCE public.dependency_id_seq OWNED BY public.dependency.id;


--
-- Name: dimension; Type: TABLE; Schema: public; Owner: discovery
--

CREATE TABLE public.dimension (
    id integer NOT NULL,
    field_id integer NOT NULL,
    name character varying(254) NOT NULL,
    type character varying(254) NOT NULL,
    human_readable_field_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.dimension OWNER TO discovery;

--
-- Name: TABLE dimension; Type: COMMENT; Schema: public; Owner: discovery
--

COMMENT ON TABLE public.dimension IS 'Stores references to alternate views of existing fields, such as remapping an integer to a description, like an enum';


--
-- Name: COLUMN dimension.field_id; Type: COMMENT; Schema: public; Owner: discovery
--

COMMENT ON COLUMN public.dimension.field_id IS 'ID of the field this dimension row applies to';


--
-- Name: COLUMN dimension.name; Type: COMMENT; Schema: public; Owner: discovery
--

COMMENT ON COLUMN public.dimension.name IS 'Short description used as the display name of this new column';


--
-- Name: COLUMN dimension.type; Type: COMMENT; Schema: public; Owner: discovery
--

COMMENT ON COLUMN public.dimension.type IS 'Either internal for a user defined remapping or external for a foreign key based remapping';


--
-- Name: COLUMN dimension.human_readable_field_id; Type: COMMENT; Schema: public; Owner: discovery
--

COMMENT ON COLUMN public.dimension.human_readable_field_id IS 'Only used with external type remappings. Indicates which field on the FK related table to use for display';


--
-- Name: COLUMN dimension.created_at; Type: COMMENT; Schema: public; Owner: discovery
--

COMMENT ON COLUMN public.dimension.created_at IS 'The timestamp of when the dimension was created.';


--
-- Name: COLUMN dimension.updated_at; Type: COMMENT; Schema: public; Owner: discovery
--

COMMENT ON COLUMN public.dimension.updated_at IS 'The timestamp of when these dimension was last updated.';


--
-- Name: dimension_id_seq; Type: SEQUENCE; Schema: public; Owner: discovery
--

CREATE SEQUENCE public.dimension_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dimension_id_seq OWNER TO discovery;

--
-- Name: dimension_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: discovery
--

ALTER SEQUENCE public.dimension_id_seq OWNED BY public.dimension.id;


--
-- Name: label; Type: TABLE; Schema: public; Owner: discovery
--

CREATE TABLE public.label (
    id integer NOT NULL,
    name character varying(254) NOT NULL,
    slug character varying(254) NOT NULL,
    icon character varying(128)
);


ALTER TABLE public.label OWNER TO discovery;

--
-- Name: label_id_seq; Type: SEQUENCE; Schema: public; Owner: discovery
--

CREATE SEQUENCE public.label_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.label_id_seq OWNER TO discovery;

--
-- Name: label_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: discovery
--

ALTER SEQUENCE public.label_id_seq OWNED BY public.label.id;


--
-- Name: metabase_database; Type: TABLE; Schema: public; Owner: discovery
--

CREATE TABLE public.metabase_database (
    id integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    name character varying(254) NOT NULL,
    description text,
    details text,
    engine character varying(254) NOT NULL,
    is_sample boolean DEFAULT false NOT NULL,
    is_full_sync boolean DEFAULT true NOT NULL,
    points_of_interest text,
    caveats text,
    metadata_sync_schedule character varying(254) DEFAULT '0 50 * * * ? *'::character varying NOT NULL,
    cache_field_values_schedule character varying(254) DEFAULT '0 50 0 * * ? *'::character varying NOT NULL,
    timezone character varying(254),
    is_on_demand boolean DEFAULT false NOT NULL,
    options text
);


ALTER TABLE public.metabase_database OWNER TO discovery;

--
-- Name: COLUMN metabase_database.metadata_sync_schedule; Type: COMMENT; Schema: public; Owner: discovery
--

COMMENT ON COLUMN public.metabase_database.metadata_sync_schedule IS 'The cron schedule string for when this database should undergo the metadata sync process (and analysis for new fields).';


--
-- Name: COLUMN metabase_database.cache_field_values_schedule; Type: COMMENT; Schema: public; Owner: discovery
--

COMMENT ON COLUMN public.metabase_database.cache_field_values_schedule IS 'The cron schedule string for when FieldValues for eligible Fields should be updated.';


--
-- Name: COLUMN metabase_database.timezone; Type: COMMENT; Schema: public; Owner: discovery
--

COMMENT ON COLUMN public.metabase_database.timezone IS 'Timezone identifier for the database, set by the sync process';


--
-- Name: COLUMN metabase_database.is_on_demand; Type: COMMENT; Schema: public; Owner: discovery
--

COMMENT ON COLUMN public.metabase_database.is_on_demand IS 'Whether we should do On-Demand caching of FieldValues for this DB. This means FieldValues are updated when their Field is used in a Dashboard or Card param.';


--
-- Name: COLUMN metabase_database.options; Type: COMMENT; Schema: public; Owner: discovery
--

COMMENT ON COLUMN public.metabase_database.options IS 'Serialized JSON containing various options like QB behavior.';


--
-- Name: metabase_database_id_seq; Type: SEQUENCE; Schema: public; Owner: discovery
--

CREATE SEQUENCE public.metabase_database_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.metabase_database_id_seq OWNER TO discovery;

--
-- Name: metabase_database_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: discovery
--

ALTER SEQUENCE public.metabase_database_id_seq OWNED BY public.metabase_database.id;


--
-- Name: metabase_field; Type: TABLE; Schema: public; Owner: discovery
--

CREATE TABLE public.metabase_field (
    id integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    name character varying(254) NOT NULL,
    base_type character varying(255) NOT NULL,
    special_type character varying(255),
    active boolean DEFAULT true NOT NULL,
    description text,
    preview_display boolean DEFAULT true NOT NULL,
    "position" integer DEFAULT 0 NOT NULL,
    table_id integer NOT NULL,
    parent_id integer,
    display_name character varying(254),
    visibility_type character varying(32) DEFAULT 'normal'::character varying NOT NULL,
    fk_target_field_id integer,
    raw_column_id integer,
    last_analyzed timestamp with time zone,
    points_of_interest text,
    caveats text,
    fingerprint text,
    fingerprint_version integer DEFAULT 0 NOT NULL,
    database_type character varying(255) NOT NULL,
    has_field_values text
);


ALTER TABLE public.metabase_field OWNER TO discovery;

--
-- Name: COLUMN metabase_field.fingerprint; Type: COMMENT; Schema: public; Owner: discovery
--

COMMENT ON COLUMN public.metabase_field.fingerprint IS 'Serialized JSON containing non-identifying information about this Field, such as min, max, and percent JSON. Used for classification.';


--
-- Name: COLUMN metabase_field.fingerprint_version; Type: COMMENT; Schema: public; Owner: discovery
--

COMMENT ON COLUMN public.metabase_field.fingerprint_version IS 'The version of the fingerprint for this Field. Used so we can keep track of which Fields need to be analyzed again when new things are added to fingerprints.';


--
-- Name: COLUMN metabase_field.database_type; Type: COMMENT; Schema: public; Owner: discovery
--

COMMENT ON COLUMN public.metabase_field.database_type IS 'The actual type of this column in the database. e.g. VARCHAR or TEXT.';


--
-- Name: COLUMN metabase_field.has_field_values; Type: COMMENT; Schema: public; Owner: discovery
--

COMMENT ON COLUMN public.metabase_field.has_field_values IS 'Whether we have FieldValues ("list"), should ad-hoc search ("search"), disable entirely ("none"), or infer dynamically (null)"';


--
-- Name: metabase_field_id_seq; Type: SEQUENCE; Schema: public; Owner: discovery
--

CREATE SEQUENCE public.metabase_field_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.metabase_field_id_seq OWNER TO discovery;

--
-- Name: metabase_field_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: discovery
--

ALTER SEQUENCE public.metabase_field_id_seq OWNED BY public.metabase_field.id;


--
-- Name: metabase_fieldvalues; Type: TABLE; Schema: public; Owner: discovery
--

CREATE TABLE public.metabase_fieldvalues (
    id integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    "values" text,
    human_readable_values text,
    field_id integer NOT NULL
);


ALTER TABLE public.metabase_fieldvalues OWNER TO discovery;

--
-- Name: metabase_fieldvalues_id_seq; Type: SEQUENCE; Schema: public; Owner: discovery
--

CREATE SEQUENCE public.metabase_fieldvalues_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.metabase_fieldvalues_id_seq OWNER TO discovery;

--
-- Name: metabase_fieldvalues_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: discovery
--

ALTER SEQUENCE public.metabase_fieldvalues_id_seq OWNED BY public.metabase_fieldvalues.id;


--
-- Name: metabase_table; Type: TABLE; Schema: public; Owner: discovery
--

CREATE TABLE public.metabase_table (
    id integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    name character varying(254) NOT NULL,
    rows bigint,
    description text,
    entity_name character varying(254),
    entity_type character varying(254),
    active boolean NOT NULL,
    db_id integer NOT NULL,
    display_name character varying(254),
    visibility_type character varying(254),
    schema character varying(254),
    raw_table_id integer,
    points_of_interest text,
    caveats text,
    show_in_getting_started boolean DEFAULT false NOT NULL
);


ALTER TABLE public.metabase_table OWNER TO discovery;

--
-- Name: metabase_table_id_seq; Type: SEQUENCE; Schema: public; Owner: discovery
--

CREATE SEQUENCE public.metabase_table_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.metabase_table_id_seq OWNER TO discovery;

--
-- Name: metabase_table_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: discovery
--

ALTER SEQUENCE public.metabase_table_id_seq OWNED BY public.metabase_table.id;


--
-- Name: metric; Type: TABLE; Schema: public; Owner: discovery
--

CREATE TABLE public.metric (
    id integer NOT NULL,
    table_id integer NOT NULL,
    creator_id integer NOT NULL,
    name character varying(254) NOT NULL,
    description text,
    is_active boolean DEFAULT true NOT NULL,
    definition text NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    points_of_interest text,
    caveats text,
    how_is_this_calculated text,
    show_in_getting_started boolean DEFAULT false NOT NULL
);


ALTER TABLE public.metric OWNER TO discovery;

--
-- Name: metric_id_seq; Type: SEQUENCE; Schema: public; Owner: discovery
--

CREATE SEQUENCE public.metric_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.metric_id_seq OWNER TO discovery;

--
-- Name: metric_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: discovery
--

ALTER SEQUENCE public.metric_id_seq OWNED BY public.metric.id;


--
-- Name: metric_important_field; Type: TABLE; Schema: public; Owner: discovery
--

CREATE TABLE public.metric_important_field (
    id integer NOT NULL,
    metric_id integer NOT NULL,
    field_id integer NOT NULL
);


ALTER TABLE public.metric_important_field OWNER TO discovery;

--
-- Name: metric_important_field_id_seq; Type: SEQUENCE; Schema: public; Owner: discovery
--

CREATE SEQUENCE public.metric_important_field_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.metric_important_field_id_seq OWNER TO discovery;

--
-- Name: metric_important_field_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: discovery
--

ALTER SEQUENCE public.metric_important_field_id_seq OWNED BY public.metric_important_field.id;


--
-- Name: permissions; Type: TABLE; Schema: public; Owner: discovery
--

CREATE TABLE public.permissions (
    id integer NOT NULL,
    object character varying(254) NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.permissions OWNER TO discovery;

--
-- Name: permissions_group; Type: TABLE; Schema: public; Owner: discovery
--

CREATE TABLE public.permissions_group (
    id integer NOT NULL,
    name character varying(255) NOT NULL
);


ALTER TABLE public.permissions_group OWNER TO discovery;

--
-- Name: permissions_group_id_seq; Type: SEQUENCE; Schema: public; Owner: discovery
--

CREATE SEQUENCE public.permissions_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.permissions_group_id_seq OWNER TO discovery;

--
-- Name: permissions_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: discovery
--

ALTER SEQUENCE public.permissions_group_id_seq OWNED BY public.permissions_group.id;


--
-- Name: permissions_group_membership; Type: TABLE; Schema: public; Owner: discovery
--

CREATE TABLE public.permissions_group_membership (
    id integer NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.permissions_group_membership OWNER TO discovery;

--
-- Name: permissions_group_membership_id_seq; Type: SEQUENCE; Schema: public; Owner: discovery
--

CREATE SEQUENCE public.permissions_group_membership_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.permissions_group_membership_id_seq OWNER TO discovery;

--
-- Name: permissions_group_membership_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: discovery
--

ALTER SEQUENCE public.permissions_group_membership_id_seq OWNED BY public.permissions_group_membership.id;


--
-- Name: permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: discovery
--

CREATE SEQUENCE public.permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.permissions_id_seq OWNER TO discovery;

--
-- Name: permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: discovery
--

ALTER SEQUENCE public.permissions_id_seq OWNED BY public.permissions.id;


--
-- Name: permissions_revision; Type: TABLE; Schema: public; Owner: discovery
--

CREATE TABLE public.permissions_revision (
    id integer NOT NULL,
    before text NOT NULL,
    after text NOT NULL,
    user_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    remark text
);


ALTER TABLE public.permissions_revision OWNER TO discovery;

--
-- Name: TABLE permissions_revision; Type: COMMENT; Schema: public; Owner: discovery
--

COMMENT ON TABLE public.permissions_revision IS 'Used to keep track of changes made to permissions.';


--
-- Name: COLUMN permissions_revision.before; Type: COMMENT; Schema: public; Owner: discovery
--

COMMENT ON COLUMN public.permissions_revision.before IS 'Serialized JSON of the permissions before the changes.';


--
-- Name: COLUMN permissions_revision.after; Type: COMMENT; Schema: public; Owner: discovery
--

COMMENT ON COLUMN public.permissions_revision.after IS 'Serialized JSON of the permissions after the changes.';


--
-- Name: COLUMN permissions_revision.user_id; Type: COMMENT; Schema: public; Owner: discovery
--

COMMENT ON COLUMN public.permissions_revision.user_id IS 'The ID of the admin who made this set of changes.';


--
-- Name: COLUMN permissions_revision.created_at; Type: COMMENT; Schema: public; Owner: discovery
--

COMMENT ON COLUMN public.permissions_revision.created_at IS 'The timestamp of when these changes were made.';


--
-- Name: COLUMN permissions_revision.remark; Type: COMMENT; Schema: public; Owner: discovery
--

COMMENT ON COLUMN public.permissions_revision.remark IS 'Optional remarks explaining why these changes were made.';


--
-- Name: permissions_revision_id_seq; Type: SEQUENCE; Schema: public; Owner: discovery
--

CREATE SEQUENCE public.permissions_revision_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.permissions_revision_id_seq OWNER TO discovery;

--
-- Name: permissions_revision_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: discovery
--

ALTER SEQUENCE public.permissions_revision_id_seq OWNED BY public.permissions_revision.id;


--
-- Name: pulse; Type: TABLE; Schema: public; Owner: discovery
--

CREATE TABLE public.pulse (
    id integer NOT NULL,
    creator_id integer NOT NULL,
    name character varying(254),
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    skip_if_empty boolean DEFAULT false NOT NULL,
    alert_condition character varying(254),
    alert_first_only boolean,
    alert_above_goal boolean
);


ALTER TABLE public.pulse OWNER TO discovery;

--
-- Name: COLUMN pulse.skip_if_empty; Type: COMMENT; Schema: public; Owner: discovery
--

COMMENT ON COLUMN public.pulse.skip_if_empty IS 'Skip a scheduled Pulse if none of its questions have any results';


--
-- Name: COLUMN pulse.alert_condition; Type: COMMENT; Schema: public; Owner: discovery
--

COMMENT ON COLUMN public.pulse.alert_condition IS 'Condition (i.e. "rows" or "goal") used as a guard for alerts';


--
-- Name: COLUMN pulse.alert_first_only; Type: COMMENT; Schema: public; Owner: discovery
--

COMMENT ON COLUMN public.pulse.alert_first_only IS 'True if the alert should be disabled after the first notification';


--
-- Name: COLUMN pulse.alert_above_goal; Type: COMMENT; Schema: public; Owner: discovery
--

COMMENT ON COLUMN public.pulse.alert_above_goal IS 'For a goal condition, alert when above the goal';


--
-- Name: pulse_card; Type: TABLE; Schema: public; Owner: discovery
--

CREATE TABLE public.pulse_card (
    id integer NOT NULL,
    pulse_id integer NOT NULL,
    card_id integer NOT NULL,
    "position" integer NOT NULL,
    include_csv boolean DEFAULT false NOT NULL,
    include_xls boolean DEFAULT false NOT NULL
);


ALTER TABLE public.pulse_card OWNER TO discovery;

--
-- Name: COLUMN pulse_card.include_csv; Type: COMMENT; Schema: public; Owner: discovery
--

COMMENT ON COLUMN public.pulse_card.include_csv IS 'True if a CSV of the data should be included for this pulse card';


--
-- Name: COLUMN pulse_card.include_xls; Type: COMMENT; Schema: public; Owner: discovery
--

COMMENT ON COLUMN public.pulse_card.include_xls IS 'True if a XLS of the data should be included for this pulse card';


--
-- Name: pulse_card_id_seq; Type: SEQUENCE; Schema: public; Owner: discovery
--

CREATE SEQUENCE public.pulse_card_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.pulse_card_id_seq OWNER TO discovery;

--
-- Name: pulse_card_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: discovery
--

ALTER SEQUENCE public.pulse_card_id_seq OWNED BY public.pulse_card.id;


--
-- Name: pulse_channel; Type: TABLE; Schema: public; Owner: discovery
--

CREATE TABLE public.pulse_channel (
    id integer NOT NULL,
    pulse_id integer NOT NULL,
    channel_type character varying(32) NOT NULL,
    details text NOT NULL,
    schedule_type character varying(32) NOT NULL,
    schedule_hour integer,
    schedule_day character varying(64),
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    schedule_frame character varying(32),
    enabled boolean DEFAULT true NOT NULL
);


ALTER TABLE public.pulse_channel OWNER TO discovery;

--
-- Name: pulse_channel_id_seq; Type: SEQUENCE; Schema: public; Owner: discovery
--

CREATE SEQUENCE public.pulse_channel_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.pulse_channel_id_seq OWNER TO discovery;

--
-- Name: pulse_channel_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: discovery
--

ALTER SEQUENCE public.pulse_channel_id_seq OWNED BY public.pulse_channel.id;


--
-- Name: pulse_channel_recipient; Type: TABLE; Schema: public; Owner: discovery
--

CREATE TABLE public.pulse_channel_recipient (
    id integer NOT NULL,
    pulse_channel_id integer NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.pulse_channel_recipient OWNER TO discovery;

--
-- Name: pulse_channel_recipient_id_seq; Type: SEQUENCE; Schema: public; Owner: discovery
--

CREATE SEQUENCE public.pulse_channel_recipient_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.pulse_channel_recipient_id_seq OWNER TO discovery;

--
-- Name: pulse_channel_recipient_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: discovery
--

ALTER SEQUENCE public.pulse_channel_recipient_id_seq OWNED BY public.pulse_channel_recipient.id;


--
-- Name: pulse_id_seq; Type: SEQUENCE; Schema: public; Owner: discovery
--

CREATE SEQUENCE public.pulse_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.pulse_id_seq OWNER TO discovery;

--
-- Name: pulse_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: discovery
--

ALTER SEQUENCE public.pulse_id_seq OWNED BY public.pulse.id;


--
-- Name: query; Type: TABLE; Schema: public; Owner: discovery
--

CREATE TABLE public.query (
    query_hash bytea NOT NULL,
    average_execution_time integer NOT NULL
);


ALTER TABLE public.query OWNER TO discovery;

--
-- Name: TABLE query; Type: COMMENT; Schema: public; Owner: discovery
--

COMMENT ON TABLE public.query IS 'Information (such as average execution time) for different queries that have been previously ran.';


--
-- Name: COLUMN query.query_hash; Type: COMMENT; Schema: public; Owner: discovery
--

COMMENT ON COLUMN public.query.query_hash IS 'The hash of the query dictionary. (This is a 256-bit SHA3 hash of the query dict.)';


--
-- Name: COLUMN query.average_execution_time; Type: COMMENT; Schema: public; Owner: discovery
--

COMMENT ON COLUMN public.query.average_execution_time IS 'Average execution time for the query, round to nearest number of milliseconds. This is updated as a rolling average.';


--
-- Name: query_cache; Type: TABLE; Schema: public; Owner: discovery
--

CREATE TABLE public.query_cache (
    query_hash bytea NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    results bytea NOT NULL
);


ALTER TABLE public.query_cache OWNER TO discovery;

--
-- Name: TABLE query_cache; Type: COMMENT; Schema: public; Owner: discovery
--

COMMENT ON TABLE public.query_cache IS 'Cached results of queries are stored here when using the DB-based query cache.';


--
-- Name: COLUMN query_cache.query_hash; Type: COMMENT; Schema: public; Owner: discovery
--

COMMENT ON COLUMN public.query_cache.query_hash IS 'The hash of the query dictionary. (This is a 256-bit SHA3 hash of the query dict).';


--
-- Name: COLUMN query_cache.updated_at; Type: COMMENT; Schema: public; Owner: discovery
--

COMMENT ON COLUMN public.query_cache.updated_at IS 'The timestamp of when these query results were last refreshed.';


--
-- Name: COLUMN query_cache.results; Type: COMMENT; Schema: public; Owner: discovery
--

COMMENT ON COLUMN public.query_cache.results IS 'Cached, compressed results of running the query with the given hash.';


--
-- Name: query_execution; Type: TABLE; Schema: public; Owner: discovery
--

CREATE TABLE public.query_execution (
    id integer NOT NULL,
    hash bytea NOT NULL,
    started_at timestamp without time zone NOT NULL,
    running_time integer NOT NULL,
    result_rows integer NOT NULL,
    native boolean NOT NULL,
    context character varying(32),
    error text,
    executor_id integer,
    card_id integer,
    dashboard_id integer,
    pulse_id integer
);


ALTER TABLE public.query_execution OWNER TO discovery;

--
-- Name: TABLE query_execution; Type: COMMENT; Schema: public; Owner: discovery
--

COMMENT ON TABLE public.query_execution IS 'A log of executed queries, used for calculating historic execution times, auditing, and other purposes.';


--
-- Name: COLUMN query_execution.hash; Type: COMMENT; Schema: public; Owner: discovery
--

COMMENT ON COLUMN public.query_execution.hash IS 'The hash of the query dictionary. This is a 256-bit SHA3 hash of the query.';


--
-- Name: COLUMN query_execution.started_at; Type: COMMENT; Schema: public; Owner: discovery
--

COMMENT ON COLUMN public.query_execution.started_at IS 'Timestamp of when this query started running.';


--
-- Name: COLUMN query_execution.running_time; Type: COMMENT; Schema: public; Owner: discovery
--

COMMENT ON COLUMN public.query_execution.running_time IS 'The time, in milliseconds, this query took to complete.';


--
-- Name: COLUMN query_execution.result_rows; Type: COMMENT; Schema: public; Owner: discovery
--

COMMENT ON COLUMN public.query_execution.result_rows IS 'Number of rows in the query results.';


--
-- Name: COLUMN query_execution.native; Type: COMMENT; Schema: public; Owner: discovery
--

COMMENT ON COLUMN public.query_execution.native IS 'Whether the query was a native query, as opposed to an MBQL one (e.g., created with the GUI).';


--
-- Name: COLUMN query_execution.context; Type: COMMENT; Schema: public; Owner: discovery
--

COMMENT ON COLUMN public.query_execution.context IS 'Short string specifying how this query was executed, e.g. in a Dashboard or Pulse.';


--
-- Name: COLUMN query_execution.error; Type: COMMENT; Schema: public; Owner: discovery
--

COMMENT ON COLUMN public.query_execution.error IS 'Error message returned by failed query, if any.';


--
-- Name: COLUMN query_execution.executor_id; Type: COMMENT; Schema: public; Owner: discovery
--

COMMENT ON COLUMN public.query_execution.executor_id IS 'The ID of the User who triggered this query execution, if any.';


--
-- Name: COLUMN query_execution.card_id; Type: COMMENT; Schema: public; Owner: discovery
--

COMMENT ON COLUMN public.query_execution.card_id IS 'The ID of the Card (Question) associated with this query execution, if any.';


--
-- Name: COLUMN query_execution.dashboard_id; Type: COMMENT; Schema: public; Owner: discovery
--

COMMENT ON COLUMN public.query_execution.dashboard_id IS 'The ID of the Dashboard associated with this query execution, if any.';


--
-- Name: COLUMN query_execution.pulse_id; Type: COMMENT; Schema: public; Owner: discovery
--

COMMENT ON COLUMN public.query_execution.pulse_id IS 'The ID of the Pulse associated with this query execution, if any.';


--
-- Name: query_execution_id_seq; Type: SEQUENCE; Schema: public; Owner: discovery
--

CREATE SEQUENCE public.query_execution_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.query_execution_id_seq OWNER TO discovery;

--
-- Name: query_execution_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: discovery
--

ALTER SEQUENCE public.query_execution_id_seq OWNED BY public.query_execution.id;


--
-- Name: raw_column; Type: TABLE; Schema: public; Owner: discovery
--

CREATE TABLE public.raw_column (
    id integer NOT NULL,
    raw_table_id integer NOT NULL,
    active boolean NOT NULL,
    name character varying(255) NOT NULL,
    column_type character varying(128),
    is_pk boolean NOT NULL,
    fk_target_column_id integer,
    details text NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE public.raw_column OWNER TO discovery;

--
-- Name: raw_column_id_seq; Type: SEQUENCE; Schema: public; Owner: discovery
--

CREATE SEQUENCE public.raw_column_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.raw_column_id_seq OWNER TO discovery;

--
-- Name: raw_column_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: discovery
--

ALTER SEQUENCE public.raw_column_id_seq OWNED BY public.raw_column.id;


--
-- Name: raw_table; Type: TABLE; Schema: public; Owner: discovery
--

CREATE TABLE public.raw_table (
    id integer NOT NULL,
    database_id integer NOT NULL,
    active boolean NOT NULL,
    schema character varying(255),
    name character varying(255) NOT NULL,
    details text NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE public.raw_table OWNER TO discovery;

--
-- Name: raw_table_id_seq; Type: SEQUENCE; Schema: public; Owner: discovery
--

CREATE SEQUENCE public.raw_table_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.raw_table_id_seq OWNER TO discovery;

--
-- Name: raw_table_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: discovery
--

ALTER SEQUENCE public.raw_table_id_seq OWNED BY public.raw_table.id;


--
-- Name: report_card; Type: TABLE; Schema: public; Owner: discovery
--

CREATE TABLE public.report_card (
    id integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    name character varying(254) NOT NULL,
    description text,
    display character varying(254) NOT NULL,
    dataset_query text NOT NULL,
    visualization_settings text NOT NULL,
    creator_id integer NOT NULL,
    database_id integer,
    table_id integer,
    query_type character varying(16),
    archived boolean DEFAULT false NOT NULL,
    collection_id integer,
    public_uuid character(36),
    made_public_by_id integer,
    enable_embedding boolean DEFAULT false NOT NULL,
    embedding_params text,
    cache_ttl integer,
    result_metadata text,
    read_permissions text
);


ALTER TABLE public.report_card OWNER TO discovery;

--
-- Name: COLUMN report_card.collection_id; Type: COMMENT; Schema: public; Owner: discovery
--

COMMENT ON COLUMN public.report_card.collection_id IS 'Optional ID of Collection this Card belongs to.';


--
-- Name: COLUMN report_card.public_uuid; Type: COMMENT; Schema: public; Owner: discovery
--

COMMENT ON COLUMN public.report_card.public_uuid IS 'Unique UUID used to in publically-accessible links to this Card.';


--
-- Name: COLUMN report_card.made_public_by_id; Type: COMMENT; Schema: public; Owner: discovery
--

COMMENT ON COLUMN public.report_card.made_public_by_id IS 'The ID of the User who first publically shared this Card.';


--
-- Name: COLUMN report_card.enable_embedding; Type: COMMENT; Schema: public; Owner: discovery
--

COMMENT ON COLUMN public.report_card.enable_embedding IS 'Is this Card allowed to be embedded in different websites (using a signed JWT)?';


--
-- Name: COLUMN report_card.embedding_params; Type: COMMENT; Schema: public; Owner: discovery
--

COMMENT ON COLUMN public.report_card.embedding_params IS 'Serialized JSON containing information about required parameters that must be supplied when embedding this Card.';


--
-- Name: COLUMN report_card.cache_ttl; Type: COMMENT; Schema: public; Owner: discovery
--

COMMENT ON COLUMN public.report_card.cache_ttl IS 'The maximum time, in seconds, to return cached results for this Card rather than running a new query.';


--
-- Name: COLUMN report_card.result_metadata; Type: COMMENT; Schema: public; Owner: discovery
--

COMMENT ON COLUMN public.report_card.result_metadata IS 'Serialized JSON containing metadata about the result columns from running the query.';


--
-- Name: COLUMN report_card.read_permissions; Type: COMMENT; Schema: public; Owner: discovery
--

COMMENT ON COLUMN public.report_card.read_permissions IS 'Permissions required to view this Card and run its query.';


--
-- Name: report_card_id_seq; Type: SEQUENCE; Schema: public; Owner: discovery
--

CREATE SEQUENCE public.report_card_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.report_card_id_seq OWNER TO discovery;

--
-- Name: report_card_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: discovery
--

ALTER SEQUENCE public.report_card_id_seq OWNED BY public.report_card.id;


--
-- Name: report_cardfavorite; Type: TABLE; Schema: public; Owner: discovery
--

CREATE TABLE public.report_cardfavorite (
    id integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    card_id integer NOT NULL,
    owner_id integer NOT NULL
);


ALTER TABLE public.report_cardfavorite OWNER TO discovery;

--
-- Name: report_cardfavorite_id_seq; Type: SEQUENCE; Schema: public; Owner: discovery
--

CREATE SEQUENCE public.report_cardfavorite_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.report_cardfavorite_id_seq OWNER TO discovery;

--
-- Name: report_cardfavorite_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: discovery
--

ALTER SEQUENCE public.report_cardfavorite_id_seq OWNED BY public.report_cardfavorite.id;


--
-- Name: report_dashboard; Type: TABLE; Schema: public; Owner: discovery
--

CREATE TABLE public.report_dashboard (
    id integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    name character varying(254) NOT NULL,
    description text,
    creator_id integer NOT NULL,
    parameters text NOT NULL,
    points_of_interest text,
    caveats text,
    show_in_getting_started boolean DEFAULT false NOT NULL,
    public_uuid character(36),
    made_public_by_id integer,
    enable_embedding boolean DEFAULT false NOT NULL,
    embedding_params text,
    archived boolean DEFAULT false NOT NULL,
    "position" integer
);


ALTER TABLE public.report_dashboard OWNER TO discovery;

--
-- Name: COLUMN report_dashboard.public_uuid; Type: COMMENT; Schema: public; Owner: discovery
--

COMMENT ON COLUMN public.report_dashboard.public_uuid IS 'Unique UUID used to in publically-accessible links to this Dashboard.';


--
-- Name: COLUMN report_dashboard.made_public_by_id; Type: COMMENT; Schema: public; Owner: discovery
--

COMMENT ON COLUMN public.report_dashboard.made_public_by_id IS 'The ID of the User who first publically shared this Dashboard.';


--
-- Name: COLUMN report_dashboard.enable_embedding; Type: COMMENT; Schema: public; Owner: discovery
--

COMMENT ON COLUMN public.report_dashboard.enable_embedding IS 'Is this Dashboard allowed to be embedded in different websites (using a signed JWT)?';


--
-- Name: COLUMN report_dashboard.embedding_params; Type: COMMENT; Schema: public; Owner: discovery
--

COMMENT ON COLUMN public.report_dashboard.embedding_params IS 'Serialized JSON containing information about required parameters that must be supplied when embedding this Dashboard.';


--
-- Name: COLUMN report_dashboard.archived; Type: COMMENT; Schema: public; Owner: discovery
--

COMMENT ON COLUMN public.report_dashboard.archived IS 'Is this Dashboard archived (effectively treated as deleted?)';


--
-- Name: COLUMN report_dashboard."position"; Type: COMMENT; Schema: public; Owner: discovery
--

COMMENT ON COLUMN public.report_dashboard."position" IS 'The position this Dashboard should appear in the Dashboards list, lower-numbered positions appearing before higher numbered ones.';


--
-- Name: report_dashboard_id_seq; Type: SEQUENCE; Schema: public; Owner: discovery
--

CREATE SEQUENCE public.report_dashboard_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.report_dashboard_id_seq OWNER TO discovery;

--
-- Name: report_dashboard_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: discovery
--

ALTER SEQUENCE public.report_dashboard_id_seq OWNED BY public.report_dashboard.id;


--
-- Name: report_dashboardcard; Type: TABLE; Schema: public; Owner: discovery
--

CREATE TABLE public.report_dashboardcard (
    id integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    "sizeX" integer NOT NULL,
    "sizeY" integer NOT NULL,
    "row" integer DEFAULT 0 NOT NULL,
    col integer DEFAULT 0 NOT NULL,
    card_id integer,
    dashboard_id integer NOT NULL,
    parameter_mappings text NOT NULL,
    visualization_settings text NOT NULL
);


ALTER TABLE public.report_dashboardcard OWNER TO discovery;

--
-- Name: report_dashboardcard_id_seq; Type: SEQUENCE; Schema: public; Owner: discovery
--

CREATE SEQUENCE public.report_dashboardcard_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.report_dashboardcard_id_seq OWNER TO discovery;

--
-- Name: report_dashboardcard_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: discovery
--

ALTER SEQUENCE public.report_dashboardcard_id_seq OWNED BY public.report_dashboardcard.id;


--
-- Name: revision; Type: TABLE; Schema: public; Owner: discovery
--

CREATE TABLE public.revision (
    id integer NOT NULL,
    model character varying(16) NOT NULL,
    model_id integer NOT NULL,
    user_id integer NOT NULL,
    "timestamp" timestamp with time zone NOT NULL,
    object character varying NOT NULL,
    is_reversion boolean DEFAULT false NOT NULL,
    is_creation boolean DEFAULT false NOT NULL,
    message text
);


ALTER TABLE public.revision OWNER TO discovery;

--
-- Name: revision_id_seq; Type: SEQUENCE; Schema: public; Owner: discovery
--

CREATE SEQUENCE public.revision_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.revision_id_seq OWNER TO discovery;

--
-- Name: revision_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: discovery
--

ALTER SEQUENCE public.revision_id_seq OWNED BY public.revision.id;


--
-- Name: segment; Type: TABLE; Schema: public; Owner: discovery
--

CREATE TABLE public.segment (
    id integer NOT NULL,
    table_id integer NOT NULL,
    creator_id integer NOT NULL,
    name character varying(254) NOT NULL,
    description text,
    is_active boolean DEFAULT true NOT NULL,
    definition text NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    points_of_interest text,
    caveats text,
    show_in_getting_started boolean DEFAULT false NOT NULL
);


ALTER TABLE public.segment OWNER TO discovery;

--
-- Name: segment_id_seq; Type: SEQUENCE; Schema: public; Owner: discovery
--

CREATE SEQUENCE public.segment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.segment_id_seq OWNER TO discovery;

--
-- Name: segment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: discovery
--

ALTER SEQUENCE public.segment_id_seq OWNED BY public.segment.id;


--
-- Name: setting; Type: TABLE; Schema: public; Owner: discovery
--

CREATE TABLE public.setting (
    key character varying(254) NOT NULL,
    value text NOT NULL
);


ALTER TABLE public.setting OWNER TO discovery;

--
-- Name: view_log; Type: TABLE; Schema: public; Owner: discovery
--

CREATE TABLE public.view_log (
    id integer NOT NULL,
    user_id integer,
    model character varying(16) NOT NULL,
    model_id integer NOT NULL,
    "timestamp" timestamp with time zone NOT NULL
);


ALTER TABLE public.view_log OWNER TO discovery;

--
-- Name: view_log_id_seq; Type: SEQUENCE; Schema: public; Owner: discovery
--

CREATE SEQUENCE public.view_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.view_log_id_seq OWNER TO discovery;

--
-- Name: view_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: discovery
--

ALTER SEQUENCE public.view_log_id_seq OWNED BY public.view_log.id;


--
-- Name: activity id; Type: DEFAULT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.activity ALTER COLUMN id SET DEFAULT nextval('public.activity_id_seq'::regclass);


--
-- Name: card_label id; Type: DEFAULT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.card_label ALTER COLUMN id SET DEFAULT nextval('public.card_label_id_seq'::regclass);


--
-- Name: collection id; Type: DEFAULT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.collection ALTER COLUMN id SET DEFAULT nextval('public.collection_id_seq'::regclass);


--
-- Name: collection_revision id; Type: DEFAULT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.collection_revision ALTER COLUMN id SET DEFAULT nextval('public.collection_revision_id_seq'::regclass);


--
-- Name: computation_job id; Type: DEFAULT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.computation_job ALTER COLUMN id SET DEFAULT nextval('public.computation_job_id_seq'::regclass);


--
-- Name: computation_job_result id; Type: DEFAULT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.computation_job_result ALTER COLUMN id SET DEFAULT nextval('public.computation_job_result_id_seq'::regclass);


--
-- Name: core_user id; Type: DEFAULT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.core_user ALTER COLUMN id SET DEFAULT nextval('public.core_user_id_seq'::regclass);


--
-- Name: dashboard_favorite id; Type: DEFAULT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.dashboard_favorite ALTER COLUMN id SET DEFAULT nextval('public.dashboard_favorite_id_seq'::regclass);


--
-- Name: dashboardcard_series id; Type: DEFAULT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.dashboardcard_series ALTER COLUMN id SET DEFAULT nextval('public.dashboardcard_series_id_seq'::regclass);


--
-- Name: dependency id; Type: DEFAULT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.dependency ALTER COLUMN id SET DEFAULT nextval('public.dependency_id_seq'::regclass);


--
-- Name: dimension id; Type: DEFAULT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.dimension ALTER COLUMN id SET DEFAULT nextval('public.dimension_id_seq'::regclass);


--
-- Name: label id; Type: DEFAULT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.label ALTER COLUMN id SET DEFAULT nextval('public.label_id_seq'::regclass);


--
-- Name: metabase_database id; Type: DEFAULT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.metabase_database ALTER COLUMN id SET DEFAULT nextval('public.metabase_database_id_seq'::regclass);


--
-- Name: metabase_field id; Type: DEFAULT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.metabase_field ALTER COLUMN id SET DEFAULT nextval('public.metabase_field_id_seq'::regclass);


--
-- Name: metabase_fieldvalues id; Type: DEFAULT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.metabase_fieldvalues ALTER COLUMN id SET DEFAULT nextval('public.metabase_fieldvalues_id_seq'::regclass);


--
-- Name: metabase_table id; Type: DEFAULT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.metabase_table ALTER COLUMN id SET DEFAULT nextval('public.metabase_table_id_seq'::regclass);


--
-- Name: metric id; Type: DEFAULT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.metric ALTER COLUMN id SET DEFAULT nextval('public.metric_id_seq'::regclass);


--
-- Name: metric_important_field id; Type: DEFAULT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.metric_important_field ALTER COLUMN id SET DEFAULT nextval('public.metric_important_field_id_seq'::regclass);


--
-- Name: permissions id; Type: DEFAULT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.permissions ALTER COLUMN id SET DEFAULT nextval('public.permissions_id_seq'::regclass);


--
-- Name: permissions_group id; Type: DEFAULT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.permissions_group ALTER COLUMN id SET DEFAULT nextval('public.permissions_group_id_seq'::regclass);


--
-- Name: permissions_group_membership id; Type: DEFAULT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.permissions_group_membership ALTER COLUMN id SET DEFAULT nextval('public.permissions_group_membership_id_seq'::regclass);


--
-- Name: permissions_revision id; Type: DEFAULT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.permissions_revision ALTER COLUMN id SET DEFAULT nextval('public.permissions_revision_id_seq'::regclass);


--
-- Name: pulse id; Type: DEFAULT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.pulse ALTER COLUMN id SET DEFAULT nextval('public.pulse_id_seq'::regclass);


--
-- Name: pulse_card id; Type: DEFAULT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.pulse_card ALTER COLUMN id SET DEFAULT nextval('public.pulse_card_id_seq'::regclass);


--
-- Name: pulse_channel id; Type: DEFAULT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.pulse_channel ALTER COLUMN id SET DEFAULT nextval('public.pulse_channel_id_seq'::regclass);


--
-- Name: pulse_channel_recipient id; Type: DEFAULT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.pulse_channel_recipient ALTER COLUMN id SET DEFAULT nextval('public.pulse_channel_recipient_id_seq'::regclass);


--
-- Name: query_execution id; Type: DEFAULT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.query_execution ALTER COLUMN id SET DEFAULT nextval('public.query_execution_id_seq'::regclass);


--
-- Name: raw_column id; Type: DEFAULT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.raw_column ALTER COLUMN id SET DEFAULT nextval('public.raw_column_id_seq'::regclass);


--
-- Name: raw_table id; Type: DEFAULT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.raw_table ALTER COLUMN id SET DEFAULT nextval('public.raw_table_id_seq'::regclass);


--
-- Name: report_card id; Type: DEFAULT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.report_card ALTER COLUMN id SET DEFAULT nextval('public.report_card_id_seq'::regclass);


--
-- Name: report_cardfavorite id; Type: DEFAULT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.report_cardfavorite ALTER COLUMN id SET DEFAULT nextval('public.report_cardfavorite_id_seq'::regclass);


--
-- Name: report_dashboard id; Type: DEFAULT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.report_dashboard ALTER COLUMN id SET DEFAULT nextval('public.report_dashboard_id_seq'::regclass);


--
-- Name: report_dashboardcard id; Type: DEFAULT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.report_dashboardcard ALTER COLUMN id SET DEFAULT nextval('public.report_dashboardcard_id_seq'::regclass);


--
-- Name: revision id; Type: DEFAULT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.revision ALTER COLUMN id SET DEFAULT nextval('public.revision_id_seq'::regclass);


--
-- Name: segment id; Type: DEFAULT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.segment ALTER COLUMN id SET DEFAULT nextval('public.segment_id_seq'::regclass);


--
-- Name: view_log id; Type: DEFAULT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.view_log ALTER COLUMN id SET DEFAULT nextval('public.view_log_id_seq'::regclass);


--
-- Data for Name: activity; Type: TABLE DATA; Schema: public; Owner: discovery
--

INSERT INTO public.activity (id, topic, "timestamp", user_id, model, model_id, database_id, table_id, custom_id, details) VALUES (1, 'user-joined', '2018-10-31 15:51:27.327+00', 1, 'user', 1, NULL, NULL, NULL, '{}');
INSERT INTO public.activity (id, topic, "timestamp", user_id, model, model_id, database_id, table_id, custom_id, details) VALUES (2, 'dashboard-create', '2018-11-05 12:00:58.042+00', 1, 'dashboard', 1, NULL, NULL, NULL, '{"description":"example","name":"recipes_basic"}');
INSERT INTO public.activity (id, topic, "timestamp", user_id, model, model_id, database_id, table_id, custom_id, details) VALUES (3, 'card-create', '2018-11-05 12:07:26.24+00', 1, 'card', 1, 2, NULL, NULL, '{"name":"Uniques and visits by day","description":null}');
INSERT INTO public.activity (id, topic, "timestamp", user_id, model, model_id, database_id, table_id, custom_id, details) VALUES (4, 'dashboard-add-cards', '2018-11-05 12:07:39.584+00', 1, 'dashboard', 1, NULL, NULL, NULL, '{"description":"example","name":"recipes_basic","dashcards":[{"name":"Uniques and visits by day","description":null,"id":1,"card_id":1}]}');
INSERT INTO public.activity (id, topic, "timestamp", user_id, model, model_id, database_id, table_id, custom_id, details) VALUES (5, 'card-create', '2018-11-05 12:19:38.255+00', 1, 'card', 2, 2, NULL, NULL, '{"name":"visitors by language","description":null}');
INSERT INTO public.activity (id, topic, "timestamp", user_id, model, model_id, database_id, table_id, custom_id, details) VALUES (6, 'dashboard-add-cards', '2018-11-05 15:19:42.044+00', 1, 'dashboard', 1, NULL, NULL, NULL, '{"description":"example","name":"recipes_basic","dashcards":[{"name":"visitors by language","description":null,"id":2,"card_id":2}]}');
INSERT INTO public.activity (id, topic, "timestamp", user_id, model, model_id, database_id, table_id, custom_id, details) VALUES (7, 'card-create', '2018-11-05 16:48:32.532+00', 1, 'card', 3, 2, NULL, NULL, '{"name":"Operative systems","description":null}');
INSERT INTO public.activity (id, topic, "timestamp", user_id, model, model_id, database_id, table_id, custom_id, details) VALUES (8, 'card-create', '2018-11-05 16:49:16.635+00', 1, 'card', 4, 2, NULL, NULL, '{"name":"browser","description":null}');
INSERT INTO public.activity (id, topic, "timestamp", user_id, model, model_id, database_id, table_id, custom_id, details) VALUES (9, 'dashboard-add-cards', '2018-11-05 16:49:31.832+00', 1, 'dashboard', 1, NULL, NULL, NULL, '{"description":"example","name":"recipes_basic","dashcards":[{"name":"browser","description":null,"id":3,"card_id":4}]}');
INSERT INTO public.activity (id, topic, "timestamp", user_id, model, model_id, database_id, table_id, custom_id, details) VALUES (10, 'card-create', '2018-11-06 07:59:19.657+00', 1, 'card', 5, 2, NULL, NULL, '{"name":"Engagment visit duration","description":null}');


--
-- Data for Name: card_label; Type: TABLE DATA; Schema: public; Owner: discovery
--



--
-- Data for Name: collection; Type: TABLE DATA; Schema: public; Owner: discovery
--



--
-- Data for Name: collection_revision; Type: TABLE DATA; Schema: public; Owner: discovery
--



--
-- Data for Name: computation_job; Type: TABLE DATA; Schema: public; Owner: discovery
--



--
-- Data for Name: computation_job_result; Type: TABLE DATA; Schema: public; Owner: discovery
--



--
-- Data for Name: core_session; Type: TABLE DATA; Schema: public; Owner: discovery
--

INSERT INTO public.core_session (id, user_id, created_at) VALUES ('f17d7228-fdcc-4dc2-9f0a-79dee8205915', 1, '2018-10-31 15:51:27.314+00');


--
-- Data for Name: core_user; Type: TABLE DATA; Schema: public; Owner: discovery
--

INSERT INTO public.core_user (id, email, first_name, last_name, password, password_salt, date_joined, last_login, is_superuser, is_active, reset_token, reset_triggered, is_qbnewb, google_auth, ldap_auth) VALUES (1, 'demo@stratio.com', 'touchai', 'touchai', '$2a$10$gVVgepu2qo.0g5BSlx0EKe5O0uy9EO4Iu2VSjd22WdqD3bU0/mcv2', '8673ba5a-b74e-4c86-8280-d1d44144b20f', '2018-10-31 15:51:00.886+00', '2018-10-31 15:51:27.327+00', true, true, NULL, NULL, false, false, false);


--
-- Data for Name: dashboard_favorite; Type: TABLE DATA; Schema: public; Owner: discovery
--



--
-- Data for Name: dashboardcard_series; Type: TABLE DATA; Schema: public; Owner: discovery
--



--
-- Data for Name: data_migrations; Type: TABLE DATA; Schema: public; Owner: discovery
--

INSERT INTO public.data_migrations (id, "timestamp") VALUES ('set-card-database-and-table-ids', '2018-10-31 15:51:00.609');
INSERT INTO public.data_migrations (id, "timestamp") VALUES ('set-mongodb-databases-ssl-false', '2018-10-31 15:51:00.622');
INSERT INTO public.data_migrations (id, "timestamp") VALUES ('set-default-schemas', '2018-10-31 15:51:00.627');
INSERT INTO public.data_migrations (id, "timestamp") VALUES ('set-admin-email', '2018-10-31 15:51:00.635');
INSERT INTO public.data_migrations (id, "timestamp") VALUES ('remove-database-sync-activity-entries', '2018-10-31 15:51:00.647');
INSERT INTO public.data_migrations (id, "timestamp") VALUES ('update-dashboards-to-new-grid', '2018-10-31 15:51:00.653');
INSERT INTO public.data_migrations (id, "timestamp") VALUES ('migrate-field-visibility-type', '2018-10-31 15:51:00.66');
INSERT INTO public.data_migrations (id, "timestamp") VALUES ('add-users-to-default-permissions-groups', '2018-10-31 15:51:00.68');
INSERT INTO public.data_migrations (id, "timestamp") VALUES ('add-admin-group-root-entry', '2018-10-31 15:51:00.689');
INSERT INTO public.data_migrations (id, "timestamp") VALUES ('add-databases-to-magic-permissions-groups', '2018-10-31 15:51:00.702');
INSERT INTO public.data_migrations (id, "timestamp") VALUES ('migrate-field-types', '2018-10-31 15:51:00.816');
INSERT INTO public.data_migrations (id, "timestamp") VALUES ('fix-invalid-field-types', '2018-10-31 15:51:00.828');
INSERT INTO public.data_migrations (id, "timestamp") VALUES ('copy-site-url-setting-and-remove-trailing-slashes', '2018-10-31 15:51:00.832');
INSERT INTO public.data_migrations (id, "timestamp") VALUES ('migrate-query-executions', '2018-10-31 15:51:00.84');
INSERT INTO public.data_migrations (id, "timestamp") VALUES ('drop-old-query-execution-table', '2018-10-31 15:51:00.846');
INSERT INTO public.data_migrations (id, "timestamp") VALUES ('ensure-protocol-specified-in-site-url', '2018-10-31 15:51:00.858');
INSERT INTO public.data_migrations (id, "timestamp") VALUES ('populate-card-database-id', '2018-10-31 15:51:00.863');
INSERT INTO public.data_migrations (id, "timestamp") VALUES ('migrate-humanization-setting', '2018-10-31 15:51:00.866');
INSERT INTO public.data_migrations (id, "timestamp") VALUES ('populate-card-read-permissions', '2018-10-31 15:51:00.869');
INSERT INTO public.data_migrations (id, "timestamp") VALUES ('repopulate-card-read-permissions', '2018-10-31 15:51:00.875');
INSERT INTO public.data_migrations (id, "timestamp") VALUES ('mark-category-fields-as-list', '2018-10-31 15:51:00.882');


--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: discovery
--

INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('4', 'cammsaul', 'migrations/000_migrations.yaml', '2018-10-31 15:50:58.028684', 3, 'EXECUTED', '7:1ed887e91a846f4d6cbe84d1efd126c4', 'createTable tableName=setting', '', NULL, '3.5.3', NULL, NULL, '1001057865');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('32', 'agilliland', 'migrations/000_migrations.yaml', '2018-10-31 15:50:58.028684', 32, 'EXECUTED', '7:af1dea42abdc7cd058b5f744602d7a22', 'createTable tableName=raw_table; createIndex indexName=idx_rawtable_database_id, tableName=raw_table; addUniqueConstraint constraintName=uniq_raw_table_db_schema_name, tableName=raw_table; createTable tableName=raw_column; createIndex indexName=id...', '', NULL, '3.5.3', NULL, NULL, '1001057865');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('34', 'tlrobinson', 'migrations/000_migrations.yaml', '2018-10-31 15:50:58.028684', 33, 'EXECUTED', '7:e65d70b4c914cfdf5b3ef9927565e899', 'addColumn tableName=pulse_channel', '', NULL, '3.5.3', NULL, NULL, '1001057865');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('35', 'agilliland', 'migrations/000_migrations.yaml', '2018-10-31 15:50:58.028684', 34, 'EXECUTED', '7:ab80b6b8e6dfc3fa3e8fa5954e3a8ec4', 'modifyDataType columnName=value, tableName=setting', '', NULL, '3.5.3', NULL, NULL, '1001057865');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('36', 'agilliland', 'migrations/000_migrations.yaml', '2018-10-31 15:50:58.028684', 35, 'EXECUTED', '7:de534c871471b400d70ee29122f23847', 'addColumn tableName=report_dashboard; addNotNullConstraint columnName=parameters, tableName=report_dashboard; addColumn tableName=report_dashboardcard; addNotNullConstraint columnName=parameter_mappings, tableName=report_dashboardcard', '', NULL, '3.5.3', NULL, NULL, '1001057865');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('37', 'tlrobinson', 'migrations/000_migrations.yaml', '2018-10-31 15:50:58.028684', 36, 'EXECUTED', '7:487dd1fa57af0f25edf3265ed9899588', 'addColumn tableName=query_queryexecution; addNotNullConstraint columnName=query_hash, tableName=query_queryexecution; createIndex indexName=idx_query_queryexecution_query_hash, tableName=query_queryexecution; createIndex indexName=idx_query_querye...', '', NULL, '3.5.3', NULL, NULL, '1001057865');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('38', 'camsaul', 'migrations/000_migrations.yaml', '2018-10-31 15:50:58.028684', 37, 'EXECUTED', '7:5e32fa14a0c34b99027e25901b7e3255', 'addColumn tableName=metabase_database; addColumn tableName=metabase_table; addColumn tableName=metabase_field; addColumn tableName=report_dashboard; addColumn tableName=metric; addColumn tableName=segment; addColumn tableName=metabase_database; ad...', '', NULL, '3.5.3', NULL, NULL, '1001057865');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('39', 'camsaul', 'migrations/000_migrations.yaml', '2018-10-31 15:50:58.028684', 38, 'EXECUTED', '7:a63ada256c44684d2649b8f3c28a3023', 'addColumn tableName=core_user', '', NULL, '3.5.3', NULL, NULL, '1001057865');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('40', 'camsaul', 'migrations/000_migrations.yaml', '2018-10-31 15:50:58.028684', 39, 'EXECUTED', '7:0ba56822308957969bf5ad5ea8ee6707', 'createTable tableName=permissions_group; createIndex indexName=idx_permissions_group_name, tableName=permissions_group; createTable tableName=permissions_group_membership; addUniqueConstraint constraintName=unique_permissions_group_membership_user...', '', NULL, '3.5.3', NULL, NULL, '1001057865');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('41', 'camsaul', 'migrations/000_migrations.yaml', '2018-10-31 15:50:58.028684', 40, 'EXECUTED', '7:e1aa5b70f61426b29d74d38936e560de', 'dropColumn columnName=field_type, tableName=metabase_field; addDefaultValue columnName=active, tableName=metabase_field; addDefaultValue columnName=preview_display, tableName=metabase_field; addDefaultValue columnName=position, tableName=metabase_...', '', NULL, '3.5.3', NULL, NULL, '1001057865');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('42', 'camsaul', 'migrations/000_migrations.yaml', '2018-10-31 15:50:58.028684', 41, 'EXECUTED', '7:779407e2ea3b8d89092fc9f72e29fdaa', 'dropForeignKeyConstraint baseTableName=query_queryexecution, constraintName=fk_queryexecution_ref_query_id; dropColumn columnName=query_id, tableName=query_queryexecution; dropColumn columnName=is_staff, tableName=core_user; dropColumn columnName=...', '', NULL, '3.5.3', NULL, NULL, '1001057865');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('44', 'camsaul', 'migrations/000_migrations.yaml', '2018-10-31 15:50:58.028684', 43, 'EXECUTED', '7:1d09a61933bbc5a01b0ddef7bd1b1336', 'dropColumn columnName=public_perms, tableName=report_card; dropColumn columnName=public_perms, tableName=report_dashboard; dropColumn columnName=public_perms, tableName=pulse', '', NULL, '3.5.3', NULL, NULL, '1001057865');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('46', 'camsaul', 'migrations/000_migrations.yaml', '2018-10-31 15:50:58.028684', 45, 'EXECUTED', '7:aab12e940225b458986e15cf53d5d816', 'addNotNullConstraint columnName=row, tableName=report_dashboardcard; addNotNullConstraint columnName=col, tableName=report_dashboardcard; addDefaultValue columnName=row, tableName=report_dashboardcard; addDefaultValue columnName=col, tableName=rep...', '', NULL, '3.5.3', NULL, NULL, '1001057865');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('47', 'camsaul', 'migrations/000_migrations.yaml', '2018-10-31 15:50:58.028684', 46, 'EXECUTED', '7:381e18d5008269e299f12c9726163675', 'createTable tableName=collection; createIndex indexName=idx_collection_slug, tableName=collection; addColumn tableName=report_card; createIndex indexName=idx_card_collection_id, tableName=report_card', '', NULL, '3.5.3', NULL, NULL, '1001057865');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('49', 'camsaul', 'migrations/000_migrations.yaml', '2018-10-31 15:50:58.028684', 48, 'EXECUTED', '7:bb653dc1919f366bb81f3356a4cbfa6c', 'addColumn tableName=report_card; createIndex indexName=idx_card_public_uuid, tableName=report_card; addColumn tableName=report_dashboard; createIndex indexName=idx_dashboard_public_uuid, tableName=report_dashboard; dropNotNullConstraint columnName...', '', NULL, '3.5.3', NULL, NULL, '1001057865');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('50', 'camsaul', 'migrations/000_migrations.yaml', '2018-10-31 15:50:58.028684', 49, 'EXECUTED', '7:6a45ed802c2f724731835bfaa97c57c9', 'addColumn tableName=report_card; addColumn tableName=report_dashboard', '', NULL, '3.5.3', NULL, NULL, '1001057865');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('51', 'camsaul', 'migrations/000_migrations.yaml', '2018-10-31 15:50:58.028684', 50, 'EXECUTED', '7:2b28e18d04212a1cbd82eb7888ae4af3', 'createTable tableName=query_execution; createIndex indexName=idx_query_execution_started_at, tableName=query_execution; createIndex indexName=idx_query_execution_query_hash_started_at, tableName=query_execution', '', NULL, '3.5.3', NULL, NULL, '1001057865');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('52', 'camsaul', 'migrations/000_migrations.yaml', '2018-10-31 15:50:58.028684', 51, 'EXECUTED', '7:fbe1b7114f1d4f346543e3c22e28bde3', 'createTable tableName=query_cache; createIndex indexName=idx_query_cache_updated_at, tableName=query_cache; addColumn tableName=report_card', '', NULL, '3.5.3', NULL, NULL, '1001057865');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('54', 'tlrobinson', 'migrations/000_migrations.yaml', '2018-10-31 15:50:58.028684', 53, 'EXECUTED', '7:0857800db71a4757e7202aad4eaed48d', 'addColumn tableName=pulse', '', NULL, '3.5.3', NULL, NULL, '1001057865');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('55', 'camsaul', 'migrations/000_migrations.yaml', '2018-10-31 15:50:58.028684', 54, 'EXECUTED', '7:e169c9d0a5220127b97630e95717c033', 'addColumn tableName=report_dashboard; createTable tableName=dashboard_favorite; addUniqueConstraint constraintName=unique_dashboard_favorite_user_id_dashboard_id, tableName=dashboard_favorite; createIndex indexName=idx_dashboard_favorite_user_id, ...', '', NULL, '3.5.3', NULL, NULL, '1001057865');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('56', 'wwwiiilll', 'migrations/000_migrations.yaml', '2018-10-31 15:50:58.028684', 55, 'EXECUTED', '7:d72f90ad1c2911d60b943445a2cb7ee1', 'addColumn tableName=core_user', 'Added 0.25.0', NULL, '3.5.3', NULL, NULL, '1001057865');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('58', 'senior', 'migrations/000_migrations.yaml', '2018-10-31 15:50:58.028684', 57, 'EXECUTED', '7:a12d6057fa571739e5327316558a117f', 'createTable tableName=dimension; addUniqueConstraint constraintName=unique_dimension_field_id_name, tableName=dimension; createIndex indexName=idx_dimension_field_id, tableName=dimension', 'Added 0.25.0', NULL, '3.5.3', NULL, NULL, '1001057865');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('59', 'camsaul', 'migrations/000_migrations.yaml', '2018-10-31 15:50:58.028684', 58, 'EXECUTED', '7:583e67af40cae19cab645bbd703558ef', 'addColumn tableName=metabase_field', 'Added 0.26.0', NULL, '3.5.3', NULL, NULL, '1001057865');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('60', 'camsaul', 'migrations/000_migrations.yaml', '2018-10-31 15:50:58.028684', 59, 'EXECUTED', '7:888069f3cbfb80ac05a734c980ac5885', 'addColumn tableName=metabase_database', 'Added 0.26.0', NULL, '3.5.3', NULL, NULL, '1001057865');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('61', 'camsaul', 'migrations/000_migrations.yaml', '2018-10-31 15:50:58.028684', 60, 'EXECUTED', '7:070febe9fb610d73dc7bf69086f50a1d', 'addColumn tableName=metabase_field', 'Added 0.26.0', NULL, '3.5.3', NULL, NULL, '1001057865');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('19', 'camsaul', 'migrations/000_migrations.yaml', '2018-10-31 15:50:58.028684', 18, 'EXECUTED', '7:e8fa976811e4d58d42a45804affa1d07', 'addColumn tableName=metabase_table', '', NULL, '3.5.3', NULL, NULL, '1001057865');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('43', 'camsaul', 'migrations/000_migrations.yaml', '2018-10-31 15:50:58.028684', 42, 'EXECUTED', '7:dbc18c8ca697fc335869f0ed0eb5f4cb', 'createTable tableName=permissions_revision', '', NULL, '3.5.3', NULL, NULL, '1001057865');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('53', 'camsaul', 'migrations/000_migrations.yaml', '2018-10-31 15:50:58.028684', 52, 'EXECUTED', '7:cc7ef026c3375d31df5f03036bb7e850', 'createTable tableName=query', '', NULL, '3.5.3', NULL, NULL, '1001057865');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('62', 'senior', 'migrations/000_migrations.yaml', '2018-10-31 15:50:58.028684', 61, 'EXECUTED', '7:db49b2acae484cf753c67e0858e4b17f', 'addColumn tableName=metabase_database', 'Added 0.26.0', NULL, '3.5.3', NULL, NULL, '1001057865');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('63', 'camsaul', 'migrations/000_migrations.yaml', '2018-10-31 15:50:58.028684', 62, 'EXECUTED', '7:fd58f763ac416881865080b693ce9aab', 'addColumn tableName=metabase_database', 'Added 0.26.0', NULL, '3.5.3', NULL, NULL, '1001057865');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('69', 'senior', 'migrations/000_migrations.yaml', '2018-10-31 15:50:58.028684', 67, 'EXECUTED', '7:1de67869247405ada4cd35068f11cb5f', 'addColumn tableName=pulse; dropNotNullConstraint columnName=name, tableName=pulse', 'Added 0.27.0', NULL, '3.5.3', NULL, NULL, '1001057865');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('70', 'camsaul', 'migrations/000_migrations.yaml', '2018-10-31 15:50:58.028684', 68, 'EXECUTED', '7:1f500c2019ddfce7eaab040403614686', 'addColumn tableName=metabase_field; addNotNullConstraint columnName=database_type, tableName=metabase_field', 'Added 0.28.0', NULL, '3.5.3', NULL, NULL, '1001057865');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('71', 'camsaul', 'migrations/000_migrations.yaml', '2018-10-31 15:50:58.028684', 69, 'EXECUTED', '7:c538632c79c29ec8a18d34b27615c5ee', 'dropNotNullConstraint columnName=card_id, tableName=report_dashboardcard', 'Added 0.28.0', NULL, '3.5.3', NULL, NULL, '1001057865');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('72', 'senior', 'migrations/000_migrations.yaml', '2018-10-31 15:50:58.028684', 70, 'EXECUTED', '7:6645d330308b223e9bc895bdbf61599a', 'addColumn tableName=pulse_card', 'Added 0.28.0', NULL, '3.5.3', NULL, NULL, '1001057865');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('73', 'camsaul', 'migrations/000_migrations.yaml', '2018-10-31 15:50:58.028684', 71, 'EXECUTED', '7:498d532b8cf9444bd26b77024ce0299a', 'addColumn tableName=metabase_database', 'Added 0.29.0', NULL, '3.5.3', NULL, NULL, '1001057865');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('74', 'camsaul', 'migrations/000_migrations.yaml', '2018-10-31 15:50:58.028684', 72, 'EXECUTED', '7:917f786af02c25566784bea59cb1048f', 'addColumn tableName=metabase_field', 'Added 0.29.0', NULL, '3.5.3', NULL, NULL, '1001057865');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('75', 'camsaul', 'migrations/000_migrations.yaml', '2018-10-31 15:50:58.028684', 73, 'EXECUTED', '7:d2e02a7832a112a8976272c82c5bf721', 'addColumn tableName=report_card', 'Added 0.28.2', NULL, '3.5.3', NULL, NULL, '1001057865');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1', 'agilliland', 'migrations/000_migrations.yaml', '2018-10-31 15:50:58.028684', 1, 'EXECUTED', '7:4760863947b982cf4783d8a8e02dc4ea', 'createTable tableName=core_organization; createTable tableName=core_user; createTable tableName=core_userorgperm; addUniqueConstraint constraintName=idx_unique_user_id_organization_id, tableName=core_userorgperm; createIndex indexName=idx_userorgp...', '', NULL, '3.5.3', NULL, NULL, '1001057865');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('2', 'agilliland', 'migrations/000_migrations.yaml', '2018-10-31 15:50:58.028684', 2, 'EXECUTED', '7:816381628d3155232ae439826bfc3992', 'createTable tableName=core_session', '', NULL, '3.5.3', NULL, NULL, '1001057865');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('5', 'agilliland', 'migrations/000_migrations.yaml', '2018-10-31 15:50:58.028684', 4, 'EXECUTED', '7:593149128c8f3a7e1f37a483bc67a924', 'addColumn tableName=core_organization', '', NULL, '3.5.3', NULL, NULL, '1001057865');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('6', 'agilliland', 'migrations/000_migrations.yaml', '2018-10-31 15:50:58.028684', 5, 'EXECUTED', '7:d24f2f950306f150d87c4208520661d5', 'dropNotNullConstraint columnName=organization_id, tableName=metabase_database; dropForeignKeyConstraint baseTableName=metabase_database, constraintName=fk_database_ref_organization_id; dropNotNullConstraint columnName=organization_id, tableName=re...', '', NULL, '3.5.3', NULL, NULL, '1001057865');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('7', 'cammsaul', 'migrations/000_migrations.yaml', '2018-10-31 15:50:58.028684', 6, 'EXECUTED', '7:baec0ec600ccc9bdadc176c1c4b29b77', 'addColumn tableName=metabase_field', '', NULL, '3.5.3', NULL, NULL, '1001057865');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('8', 'tlrobinson', 'migrations/000_migrations.yaml', '2018-10-31 15:50:58.028684', 7, 'EXECUTED', '7:ea2727c7ce666178cff436549f81ddbd', 'addColumn tableName=metabase_table; addColumn tableName=metabase_field', '', NULL, '3.5.3', NULL, NULL, '1001057865');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('9', 'tlrobinson', 'migrations/000_migrations.yaml', '2018-10-31 15:50:58.028684', 8, 'EXECUTED', '7:c05cf8a25248b38e281e8e85de4275a2', 'addColumn tableName=metabase_table', '', NULL, '3.5.3', NULL, NULL, '1001057865');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('10', 'cammsaul', 'migrations/000_migrations.yaml', '2018-10-31 15:50:58.028684', 9, 'EXECUTED', '7:ec4f8eecc37fdc8c22440490de3a13f0', 'createTable tableName=revision; createIndex indexName=idx_revision_model_model_id, tableName=revision', '', NULL, '3.5.3', NULL, NULL, '1001057865');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('11', 'agilliland', 'migrations/000_migrations.yaml', '2018-10-31 15:50:58.028684', 10, 'EXECUTED', '7:c7ef8b4f4dcb3528f9282b51aea5bb2a', 'sql', '', NULL, '3.5.3', NULL, NULL, '1001057865');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('12', 'agilliland', 'migrations/000_migrations.yaml', '2018-10-31 15:50:58.028684', 11, 'EXECUTED', '7:f78e18f669d7c9e6d06c63ea9929391f', 'addColumn tableName=report_card', '', NULL, '3.5.3', NULL, NULL, '1001057865');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('13', 'agilliland', 'migrations/000_migrations.yaml', '2018-10-31 15:50:58.028684', 12, 'EXECUTED', '7:20a2ef1765573854864909ec2e7de766', 'createTable tableName=activity; createIndex indexName=idx_activity_timestamp, tableName=activity; createIndex indexName=idx_activity_user_id, tableName=activity; createIndex indexName=idx_activity_custom_id, tableName=activity', '', NULL, '3.5.3', NULL, NULL, '1001057865');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('14', 'agilliland', 'migrations/000_migrations.yaml', '2018-10-31 15:50:58.028684', 13, 'EXECUTED', '7:6614fcaca4e41d003ce26de5cbc882f7', 'createTable tableName=view_log; createIndex indexName=idx_view_log_user_id, tableName=view_log; createIndex indexName=idx_view_log_timestamp, tableName=view_log', '', NULL, '3.5.3', NULL, NULL, '1001057865');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('15', 'agilliland', 'migrations/000_migrations.yaml', '2018-10-31 15:50:58.028684', 14, 'EXECUTED', '7:50c72a51651af76928c06f21c9e04f97', 'addColumn tableName=revision', '', NULL, '3.5.3', NULL, NULL, '1001057865');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('16', 'agilliland', 'migrations/000_migrations.yaml', '2018-10-31 15:50:58.028684', 15, 'EXECUTED', '7:a398a37dd953a0e82633d12658c6ac8f', 'dropNotNullConstraint columnName=last_login, tableName=core_user', '', NULL, '3.5.3', NULL, NULL, '1001057865');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('17', 'agilliland', 'migrations/000_migrations.yaml', '2018-10-31 15:50:58.028684', 16, 'EXECUTED', '7:5401ec35a5bd1275f93a7cac1ddd7591', 'addColumn tableName=metabase_database; sql', '', NULL, '3.5.3', NULL, NULL, '1001057865');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('18', 'camsaul', 'migrations/000_migrations.yaml', '2018-10-31 15:50:58.028684', 17, 'EXECUTED', '7:329d897d44ba9893fdafc9ce7e876d73', 'createTable tableName=data_migrations; createIndex indexName=idx_data_migrations_id, tableName=data_migrations', '', NULL, '3.5.3', NULL, NULL, '1001057865');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('45', 'tlrobinson', 'migrations/000_migrations.yaml', '2018-10-31 15:50:58.028684', 44, 'EXECUTED', '7:9198081e3329df7903d9016804ef0cf0', 'addColumn tableName=report_dashboardcard; addNotNullConstraint columnName=visualization_settings, tableName=report_dashboardcard', '', NULL, '3.5.3', NULL, NULL, '1001057865');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('48', 'camsaul', 'migrations/000_migrations.yaml', '2018-10-31 15:50:58.028684', 47, 'EXECUTED', '7:b8957fda76bab207f99ced39353df1da', 'createTable tableName=collection_revision', '', NULL, '3.5.3', NULL, NULL, '1001057865');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('20', 'agilliland', 'migrations/000_migrations.yaml', '2018-10-31 15:50:58.028684', 19, 'EXECUTED', '7:9c5fedbd888307edf521a6a547f96f99', 'createTable tableName=pulse; createIndex indexName=idx_pulse_creator_id, tableName=pulse; createTable tableName=pulse_card; createIndex indexName=idx_pulse_card_pulse_id, tableName=pulse_card; createIndex indexName=idx_pulse_card_card_id, tableNam...', '', NULL, '3.5.3', NULL, NULL, '1001057865');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('21', 'agilliland', 'migrations/000_migrations.yaml', '2018-10-31 15:50:58.028684', 20, 'EXECUTED', '7:c23c71d8a11b3f38aaf5bf98acf51e6f', 'createTable tableName=segment; createIndex indexName=idx_segment_creator_id, tableName=segment; createIndex indexName=idx_segment_table_id, tableName=segment', '', NULL, '3.5.3', NULL, NULL, '1001057865');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('22', 'agilliland', 'migrations/000_migrations.yaml', '2018-10-31 15:50:58.028684', 21, 'EXECUTED', '7:cb6776ec86ab0ad9e74806a5460b9085', 'addColumn tableName=revision', '', NULL, '3.5.3', NULL, NULL, '1001057865');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('23', 'agilliland', 'migrations/000_migrations.yaml', '2018-10-31 15:50:58.028684', 22, 'EXECUTED', '7:43b9662bd798db391d4bbb7d4615bf0d', 'modifyDataType columnName=rows, tableName=metabase_table', '', NULL, '3.5.3', NULL, NULL, '1001057865');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('24', 'agilliland', 'migrations/000_migrations.yaml', '2018-10-31 15:50:58.028684', 23, 'EXECUTED', '7:69c2cad167fd7cec9e8c920d9ccab86e', 'createTable tableName=dependency; createIndex indexName=idx_dependency_model, tableName=dependency; createIndex indexName=idx_dependency_model_id, tableName=dependency; createIndex indexName=idx_dependency_dependent_on_model, tableName=dependency;...', '', NULL, '3.5.3', NULL, NULL, '1001057865');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('25', 'agilliland', 'migrations/000_migrations.yaml', '2018-10-31 15:50:58.028684', 24, 'EXECUTED', '7:327941d9ac9414f493471b746a812fa4', 'createTable tableName=metric; createIndex indexName=idx_metric_creator_id, tableName=metric; createIndex indexName=idx_metric_table_id, tableName=metric', '', NULL, '3.5.3', NULL, NULL, '1001057865');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('26', 'agilliland', 'migrations/000_migrations.yaml', '2018-10-31 15:50:58.028684', 25, 'EXECUTED', '7:ac7f40d2a3fbf3fea7936aa79bb1532b', 'addColumn tableName=metabase_database; sql', '', NULL, '3.5.3', NULL, NULL, '1001057865');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('27', 'agilliland', 'migrations/000_migrations.yaml', '2018-10-31 15:50:58.028684', 26, 'EXECUTED', '7:e3a52bd649da7940246e4236b204714b', 'createTable tableName=dashboardcard_series; createIndex indexName=idx_dashboardcard_series_dashboardcard_id, tableName=dashboardcard_series; createIndex indexName=idx_dashboardcard_series_card_id, tableName=dashboardcard_series', '', NULL, '3.5.3', NULL, NULL, '1001057865');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('28', 'agilliland', 'migrations/000_migrations.yaml', '2018-10-31 15:50:58.028684', 27, 'EXECUTED', '7:335e7e6b32dcbeb392150b3c3db2d5eb', 'addColumn tableName=core_user', '', NULL, '3.5.3', NULL, NULL, '1001057865');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('29', 'agilliland', 'migrations/000_migrations.yaml', '2018-10-31 15:50:58.028684', 28, 'EXECUTED', '7:7b0bb8fcb7de2aa29ce57b32baf9ff31', 'addColumn tableName=pulse_channel', '', NULL, '3.5.3', NULL, NULL, '1001057865');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('30', 'agilliland', 'migrations/000_migrations.yaml', '2018-10-31 15:50:58.028684', 29, 'EXECUTED', '7:7b5245de5d964eedb5cd6fdf5afdb6fd', 'addColumn tableName=metabase_field; addNotNullConstraint columnName=visibility_type, tableName=metabase_field', '', NULL, '3.5.3', NULL, NULL, '1001057865');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('31', 'agilliland', 'migrations/000_migrations.yaml', '2018-10-31 15:50:58.028684', 30, 'EXECUTED', '7:347281cdb65a285b03aeaf77cb28e618', 'addColumn tableName=metabase_field', '', NULL, '3.5.3', NULL, NULL, '1001057865');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('57', 'camsaul', 'migrations/000_migrations.yaml', '2018-10-31 15:50:58.028684', 56, 'EXECUTED', '7:5d51b16e22be3c81a27d3b5b345a8270', 'addColumn tableName=report_card', 'Added 0.25.0', NULL, '3.5.3', NULL, NULL, '1001057865');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('32', 'camsaul', 'migrations/000_migrations.yaml', '2018-10-31 15:50:58.028684', 31, 'EXECUTED', '7:ff40b5fbe06dc5221d0b9223992ece25', 'createTable tableName=label; createIndex indexName=idx_label_slug, tableName=label; createTable tableName=card_label; addUniqueConstraint constraintName=unique_card_label_card_id_label_id, tableName=card_label; createIndex indexName=idx_card_label...', '', NULL, '3.5.3', NULL, NULL, '1001057865');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('64', 'senior', 'migrations/000_migrations.yaml', '2018-10-31 15:50:58.028684', 63, 'EXECUTED', '7:1da13bf2e4248f9b47587f657c204dc3', 'dropForeignKeyConstraint baseTableName=raw_table, constraintName=fk_rawtable_ref_database', 'Added 0.26.0', NULL, '3.5.3', NULL, NULL, '1001057865');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('66', 'senior', 'migrations/000_migrations.yaml', '2018-10-31 15:50:58.028684', 64, 'EXECUTED', '7:76d06b44a544105c2a613603b8bdf25f', 'sql; sql', 'Added 0.26.0', NULL, '3.5.3', NULL, NULL, '1001057865');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('67', 'attekei', 'migrations/000_migrations.yaml', '2018-10-31 15:50:58.028684', 65, 'EXECUTED', '7:3fd33c68aff3798d5aa9777264fba837', 'createTable tableName=computation_job; createTable tableName=computation_job_result', 'Added 0.27.0', NULL, '3.5.3', NULL, NULL, '1001057865');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('68', 'sbelak', 'migrations/000_migrations.yaml', '2018-10-31 15:50:58.028684', 66, 'EXECUTED', '7:be83b1d77e3c3effde34aecb79e781dc', 'addColumn tableName=computation_job', 'Added 0.27.0', NULL, '3.5.3', NULL, NULL, '1001057865');


--
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: discovery
--

INSERT INTO public.databasechangeloglock (id, locked, lockgranted, lockedby) VALUES (1, false, NULL, NULL);


--
-- Data for Name: dependency; Type: TABLE DATA; Schema: public; Owner: discovery
--



--
-- Data for Name: dimension; Type: TABLE DATA; Schema: public; Owner: discovery
--



--
-- Data for Name: label; Type: TABLE DATA; Schema: public; Owner: discovery
--



--
-- Data for Name: metabase_database; Type: TABLE DATA; Schema: public; Owner: discovery
--

INSERT INTO public.metabase_database (id, created_at, updated_at, name, description, details, engine, is_sample, is_full_sync, points_of_interest, caveats, metadata_sync_schedule, cache_field_values_schedule, timezone, is_on_demand, options) VALUES (2, '2018-10-31 15:55:17.904+00', '2018-11-05 12:03:53.673+00', 'postgres', NULL, '{"host":"sparta-postgres","port":5432,"dbname":"postgres","user":"sparta","password":"sparta","ssl":false,"tunnel-port":22,"let-user-control-scheduling":false}', 'postgres', false, true, NULL, NULL, '0 0 * * * ? *', '0 0 0 * * ? *', 'UTC', false, NULL);


--
-- Data for Name: metabase_field; Type: TABLE DATA; Schema: public; Owner: discovery
--

INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (598, '2018-10-31 15:55:18.222+00', '2018-10-31 15:55:18.222+00', 'template_type', 'type/Text', NULL, true, NULL, true, 0, 41, NULL, 'Template Type', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (599, '2018-10-31 15:55:18.222+00', '2018-10-31 15:55:18.222+00', 'name', 'type/Text', NULL, true, NULL, true, 0, 41, NULL, 'Name', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (600, '2018-10-31 15:55:18.222+00', '2018-10-31 15:55:18.222+00', 'id', 'type/Text', 'type/PK', true, NULL, true, 0, 41, NULL, 'ID', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (601, '2018-10-31 15:55:18.222+00', '2018-10-31 15:55:18.222+00', 'class_name', 'type/Text', NULL, true, NULL, true, 0, 41, NULL, 'Class Name', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (602, '2018-10-31 15:55:18.222+00', '2018-10-31 15:55:18.222+00', 'execution_engine', 'type/Text', NULL, true, NULL, true, 0, 41, NULL, 'Execution Engine', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (603, '2018-10-31 15:55:18.222+00', '2018-10-31 15:55:18.222+00', 'supported_engines', 'type/Text', NULL, true, NULL, true, 0, 41, NULL, 'Supported Engines', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (604, '2018-10-31 15:55:18.222+00', '2018-10-31 15:55:18.222+00', 'last_update_date', 'type/DateTime', NULL, true, NULL, true, 0, 41, NULL, 'Last Update Date', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'timestamp', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (605, '2018-10-31 15:55:18.223+00', '2018-10-31 15:55:18.223+00', 'version_sparta', 'type/Text', NULL, true, NULL, true, 0, 41, NULL, 'Version Sparta', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (606, '2018-10-31 15:55:18.223+00', '2018-10-31 15:55:18.223+00', 'class_pretty_name', 'type/Text', NULL, true, NULL, true, 0, 41, NULL, 'Class Pretty Name', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (607, '2018-10-31 15:55:18.223+00', '2018-10-31 15:55:18.223+00', 'description', 'type/Text', NULL, true, NULL, true, 0, 41, NULL, 'Description', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (608, '2018-10-31 15:55:18.223+00', '2018-10-31 15:55:18.223+00', 'creation_date', 'type/DateTime', NULL, true, NULL, true, 0, 41, NULL, 'Creation Date', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'timestamp', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (609, '2018-10-31 15:55:18.223+00', '2018-10-31 15:55:18.223+00', 'configuration', 'type/Text', NULL, true, NULL, true, 0, 41, NULL, 'Configuration', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1183, '2018-10-31 15:55:20.186+00', '2018-10-31 16:50:01.164+00', 'user_custom_id', 'type/Text', 'type/Category', true, NULL, true, 0, 40, NULL, 'User Custom ID', 'normal', NULL, NULL, '2018-10-31 16:50:01.223+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":7.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (617, '2018-10-31 15:55:18.253+00', '2018-10-31 15:55:18.253+00', 'redirect_time_in_ms', 'type/BigInteger', NULL, true, NULL, true, 0, 42, NULL, 'Redirect Time In Ms', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'int8', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (632, '2018-10-31 15:55:18.316+00', '2018-10-31 15:55:18.316+00', 'referer_url_fragment', 'type/Text', NULL, true, NULL, true, 0, 24, NULL, 'Refer Er URL Fragment', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (634, '2018-10-31 15:55:18.316+00', '2018-10-31 15:55:18.316+00', 'marketing_network', 'type/Text', NULL, true, NULL, true, 0, 24, NULL, 'Marketing Network', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (638, '2018-10-31 15:55:18.317+00', '2018-10-31 15:55:18.317+00', 'marketing_term', 'type/Text', NULL, true, NULL, true, 0, 24, NULL, 'Marketing Term', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (644, '2018-10-31 15:55:18.318+00', '2018-10-31 15:55:18.318+00', 'os_build_version', 'type/Text', NULL, true, NULL, true, 0, 24, NULL, 'Os Build Version', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (645, '2018-10-31 15:55:18.318+00', '2018-10-31 15:55:18.318+00', 'marketing_content', 'type/Text', NULL, true, NULL, true, 0, 24, NULL, 'Marketing Content', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (650, '2018-10-31 15:55:18.319+00', '2018-10-31 15:55:18.319+00', 'referer_url_query', 'type/Text', NULL, true, NULL, true, 0, 24, NULL, 'Refer Er URL Query', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (654, '2018-10-31 15:55:18.32+00', '2018-10-31 15:55:18.32+00', 'browser_build_version', 'type/Text', NULL, true, NULL, true, 0, 24, NULL, 'Browser Build Version', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (619, '2018-10-31 15:55:18.253+00', '2018-10-31 15:55:21.714+00', 'processing_time_in_ms', 'type/BigInteger', 'type/Category', true, NULL, true, 0, 42, NULL, 'Processing Time In Ms', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":2},"type":{"type/Number":{"min":88,"max":94,"avg":90.0}}}', 2, 'int8', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (628, '2018-10-31 15:55:18.283+00', '2018-10-31 15:55:21.732+00', 'pp_count', 'type/BigInteger', 'type/Quantity', true, NULL, true, 0, 22, NULL, 'Pp Count', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":2},"type":{"type/Number":{"min":0,"max":1,"avg":0.75}}}', 2, 'int8', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (656, '2018-10-31 15:55:18.32+00', '2018-10-31 15:55:18.32+00', 'geo_region_name', 'type/Text', NULL, true, NULL, true, 0, 24, NULL, 'Geo Region Name', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1166, '2018-10-31 15:55:20.178+00', '2018-10-31 16:50:01.137+00', 'first_page_url_query', 'type/Text', 'type/Category', true, NULL, true, 0, 40, NULL, 'First Page URL Query', 'normal', NULL, NULL, '2018-10-31 16:50:01.223+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":27.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (658, '2018-10-31 15:55:18.32+00', '2018-10-31 15:55:18.32+00', 'geo_zipcode', 'type/Text', NULL, true, NULL, true, 0, 24, NULL, 'Geo Zip Code', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (659, '2018-10-31 15:55:18.32+00', '2018-10-31 15:55:18.32+00', 'geo_region', 'type/Text', NULL, true, NULL, true, 0, 24, NULL, 'Geo Region', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'bpchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (660, '2018-10-31 15:55:18.32+00', '2018-10-31 15:55:18.32+00', 'page_url_fragment', 'type/Text', NULL, true, NULL, true, 0, 24, NULL, 'Page URL Fragment', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1167, '2018-10-31 15:55:20.178+00', '2018-10-31 16:50:01.141+00', 'referer_medium', 'type/Text', 'type/Category', true, NULL, true, 0, 40, NULL, 'Refer Er Medium', 'normal', NULL, NULL, '2018-10-31 16:50:01.223+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":8.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1168, '2018-10-31 15:55:20.179+00', '2018-10-31 16:50:01.143+00', 'first_page_url_scheme', 'type/Text', 'type/Category', true, NULL, true, 0, 40, NULL, 'First Page URL Scheme', 'normal', NULL, NULL, '2018-10-31 16:50:01.223+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":4.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1169, '2018-10-31 15:55:20.179+00', '2018-10-31 16:50:01.145+00', 'first_page_title', 'type/Text', 'type/Title', true, NULL, true, 0, 40, NULL, 'First Page Title', 'normal', NULL, NULL, '2018-10-31 16:50:01.223+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":12.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1170, '2018-10-31 15:55:20.179+00', '2018-10-31 16:50:01.147+00', 'first_session_year', 'type/Integer', 'type/Category', true, NULL, true, 0, 40, NULL, 'First Session Year', 'normal', NULL, NULL, '2018-10-31 16:50:01.223+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Number":{"min":2018,"max":2018,"avg":2018.0}}}', 2, 'int4', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1171, '2018-10-31 15:55:20.179+00', '2018-10-31 16:50:01.149+00', 'referer_url_path', 'type/Text', 'type/Category', true, NULL, true, 0, 40, NULL, 'Refer Er URL Path', 'normal', NULL, NULL, '2018-10-31 16:50:01.223+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":10.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (666, '2018-10-31 15:55:18.321+00', '2018-10-31 15:55:18.321+00', 'referer_term', 'type/Text', NULL, true, NULL, true, 0, 24, NULL, 'Refer Er Term', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (668, '2018-10-31 15:55:18.322+00', '2018-10-31 15:55:18.322+00', 'ip_net_speed', 'type/Text', NULL, true, NULL, true, 0, 24, NULL, 'IP Net Speed', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1172, '2018-10-31 15:55:20.18+00', '2018-10-31 16:50:01.151+00', 'first_page_url_path', 'type/Text', 'type/Category', true, NULL, true, 0, 40, NULL, 'First Page URL Path', 'normal', NULL, NULL, '2018-10-31 16:50:01.223+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":10.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1173, '2018-10-31 15:55:20.18+00', '2018-10-31 16:50:01.153+00', 'first_session_quarter', 'type/Text', 'type/Category', true, NULL, true, 0, 40, NULL, 'First Session Quarter', 'normal', NULL, NULL, '2018-10-31 16:50:01.223+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":7.0}}}', 2, 'text', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (671, '2018-10-31 15:55:18.322+00', '2018-10-31 15:55:18.322+00', 'device_is_mobile', 'type/Boolean', NULL, true, NULL, true, 0, 24, NULL, 'Device Is Mobile', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'bool', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1175, '2018-10-31 15:55:20.183+00', '2018-10-31 16:50:01.155+00', 'time_engaged_in_s', 'type/Decimal', 'type/Category', true, NULL, true, 0, 40, NULL, 'Time Engaged In S', 'normal', NULL, NULL, '2018-10-31 16:50:01.223+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Number":{"min":20,"max":20,"avg":20.0}}}', 2, 'numeric', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1174, '2018-10-31 15:55:20.182+00', '2018-10-31 16:50:01.045+00', 'first_session_start', 'type/DateTime', NULL, true, NULL, true, 0, 40, NULL, 'First Session Start', 'normal', NULL, NULL, '2018-10-31 16:50:01.223+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/DateTime":{"earliest":"2018-10-31T00:00:00.000Z","latest":"2018-10-31T00:00:00.000Z"}}}', 2, 'timestamp', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1180, '2018-10-31 15:55:20.185+00', '2018-10-31 16:50:01.157+00', 'referer_url_host', 'type/Text', 'type/Category', true, NULL, true, 0, 40, NULL, 'Refer Er URL Host', 'normal', NULL, NULL, '2018-10-31 16:50:01.223+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":7.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (860, '2018-10-31 15:55:18.934+00', '2018-10-31 15:55:18.934+00', 'ip_isp', 'type/Text', NULL, true, NULL, true, 0, 30, NULL, 'IP Isp', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1179, '2018-10-31 15:55:20.185+00', '2018-10-31 16:50:01.049+00', 'first_session_start_local', 'type/DateTime', NULL, true, NULL, true, 0, 40, NULL, 'First Session Start Local', 'normal', NULL, NULL, '2018-10-31 16:50:01.223+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/DateTime":{"earliest":"2018-10-31T00:00:00.000Z","latest":"2018-10-31T00:00:00.000Z"}}}', 2, 'timestamp', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1181, '2018-10-31 15:55:20.185+00', '2018-10-31 16:50:01.162+00', 'sessions', 'type/BigInteger', 'type/Category', true, NULL, true, 0, 40, NULL, 'Sessions', 'normal', NULL, NULL, '2018-10-31 16:50:01.223+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Number":{"min":1,"max":1,"avg":1.0}}}', 2, 'int8', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1186, '2018-10-31 15:55:20.186+00', '2018-10-31 16:50:01.167+00', 'user_snowplow_domain_id', 'type/Text', 'type/Category', true, NULL, true, 0, 40, NULL, 'User Snowplow Domain ID', 'normal', NULL, NULL, '2018-10-31 16:50:01.223+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":36.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1187, '2018-10-31 15:55:20.186+00', '2018-10-31 16:50:01.169+00', 'first_page_url_port', 'type/Integer', 'type/Category', true, NULL, true, 0, 40, NULL, 'First Page URL Port', 'normal', NULL, NULL, '2018-10-31 16:50:01.223+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Number":{"min":8080,"max":8080,"avg":8080.0}}}', 2, 'int4', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1188, '2018-10-31 15:55:20.187+00', '2018-10-31 16:50:01.171+00', 'referer_url_scheme', 'type/Text', 'type/Category', true, NULL, true, 0, 40, NULL, 'Refer Er URL Scheme', 'normal', NULL, NULL, '2018-10-31 16:50:01.223+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":4.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (866, '2018-10-31 15:55:18.935+00', '2018-10-31 15:55:18.935+00', 'geo_city', 'type/Text', NULL, true, NULL, true, 0, 30, NULL, 'Geo City', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1190, '2018-10-31 15:55:20.187+00', '2018-10-31 16:50:01.173+00', 'first_session_hour', 'type/Text', 'type/Category', true, NULL, true, 0, 40, NULL, 'First Session Hour', 'normal', NULL, NULL, '2018-10-31 16:50:01.223+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":13.0}}}', 2, 'text', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (868, '2018-10-31 15:55:18.936+00', '2018-10-31 15:55:18.936+00', 'referer_source', 'type/Text', NULL, true, NULL, true, 0, 30, NULL, 'Refer Er Source', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1192, '2018-10-31 15:55:20.187+00', '2018-10-31 16:50:01.176+00', 'first_session_week', 'type/Text', 'type/Category', true, NULL, true, 0, 40, NULL, 'First Session Week', 'normal', NULL, NULL, '2018-10-31 16:50:01.223+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":10.0}}}', 2, 'text', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (870, '2018-10-31 15:55:18.936+00', '2018-10-31 15:55:18.936+00', 'ip_organization', 'type/Text', NULL, true, NULL, true, 0, 30, NULL, 'IP Organization', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (873, '2018-10-31 15:55:18.937+00', '2018-10-31 15:55:18.937+00', 'geo_timezone', 'type/Text', NULL, true, NULL, true, 0, 30, NULL, 'Geo Timezone', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (874, '2018-10-31 15:55:18.937+00', '2018-10-31 15:55:18.937+00', 'os_minor_version', 'type/Text', NULL, true, NULL, true, 0, 30, NULL, 'Os Minor Version', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (876, '2018-10-31 15:55:18.937+00', '2018-10-31 15:55:18.937+00', 'ip_domain', 'type/Text', NULL, true, NULL, true, 0, 30, NULL, 'IP Domain', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (881, '2018-10-31 15:55:19.23+00', '2018-10-31 15:55:19.23+00', 'ref_parent', 'type/Text', NULL, true, NULL, true, 0, 32, NULL, 'Ref Parent', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (885, '2018-10-31 15:55:19.232+00', '2018-10-31 15:55:19.232+00', 'schema_name', 'type/Text', NULL, true, NULL, true, 0, 32, NULL, 'Schema Name', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (887, '2018-10-31 15:55:19.233+00', '2018-10-31 15:55:19.233+00', 'schema_vendor', 'type/Text', NULL, true, NULL, true, 0, 32, NULL, 'Schema Vendor', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (667, '2018-10-31 15:55:18.322+00', '2018-10-31 15:55:21.949+00', 'page_view_local_day_of_week', 'type/Text', 'type/Category', true, NULL, true, 0, 24, NULL, 'Page View Local Day Of Week', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":1.0}}}', 2, 'text', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1193, '2018-10-31 15:55:20.188+00', '2018-10-31 16:50:01.178+00', 'app_id', 'type/Text', 'type/Category', true, NULL, true, 0, 40, NULL, 'App ID', 'normal', NULL, NULL, '2018-10-31 16:50:01.223+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":12.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1191, '2018-10-31 15:55:20.187+00', '2018-10-31 16:50:01.064+00', 'last_session_end', 'type/DateTime', NULL, true, NULL, true, 0, 40, NULL, 'Last Session End', 'normal', NULL, NULL, '2018-10-31 16:50:01.223+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/DateTime":{"earliest":"2018-10-31T00:00:00.000Z","latest":"2018-10-31T00:00:00.000Z"}}}', 2, 'timestamp', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1194, '2018-10-31 15:55:20.188+00', '2018-10-31 16:50:01.18+00', 'first_session_local_day_of_week_index', 'type/Integer', 'type/Category', true, NULL, true, 0, 40, NULL, 'First Session Local Day Of Week Index', 'normal', NULL, NULL, '2018-10-31 16:50:01.223+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Number":{"min":2,"max":2,"avg":2.0}}}', 2, 'int4', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1164, '2018-10-31 15:55:20.177+00', '2018-10-31 16:50:01.134+00', 'first_session_time', 'type/Text', 'type/Category', true, NULL, true, 0, 40, NULL, 'First Session Time', 'normal', NULL, NULL, '2018-10-31 16:50:01.223+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":19.0}}}', 2, 'text', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (687, '2018-10-31 15:55:18.325+00', '2018-10-31 15:55:18.325+00', 'device_type', 'type/Text', NULL, true, NULL, true, 0, 24, NULL, 'Device Type', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (689, '2018-10-31 15:55:18.325+00', '2018-10-31 15:55:18.325+00', 'os_manufacturer', 'type/Text', NULL, true, NULL, true, 0, 24, NULL, 'Os Manufacturer', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (697, '2018-10-31 15:55:18.327+00', '2018-10-31 15:55:18.327+00', 'marketing_campaign', 'type/Text', NULL, true, NULL, true, 0, 24, NULL, 'Marketing Campaign', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (698, '2018-10-31 15:55:18.327+00', '2018-10-31 15:55:18.327+00', 'redirect_time_in_ms', 'type/BigInteger', NULL, true, NULL, true, 0, 24, NULL, 'Redirect Time In Ms', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'int8', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (700, '2018-10-31 15:55:18.327+00', '2018-10-31 15:55:18.327+00', 'browser_engine', 'type/Text', NULL, true, NULL, true, 0, 24, NULL, 'Browser Engine', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (701, '2018-10-31 15:55:18.328+00', '2018-10-31 15:55:18.328+00', 'marketing_source', 'type/Text', NULL, true, NULL, true, 0, 24, NULL, 'Marketing Source', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (713, '2018-10-31 15:55:18.329+00', '2018-10-31 15:55:18.329+00', 'marketing_medium', 'type/Text', NULL, true, NULL, true, 0, 24, NULL, 'Marketing Medium', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (714, '2018-10-31 15:55:18.33+00', '2018-10-31 15:55:18.33+00', 'marketing_click_id', 'type/Text', NULL, true, NULL, true, 0, 24, NULL, 'Marketing Click ID', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (715, '2018-10-31 15:55:18.33+00', '2018-10-31 15:55:18.33+00', 'os_major_version', 'type/Text', NULL, true, NULL, true, 0, 24, NULL, 'Os Major Version', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (717, '2018-10-31 15:55:18.33+00', '2018-10-31 15:55:18.33+00', 'ip_isp', 'type/Text', NULL, true, NULL, true, 0, 24, NULL, 'IP Isp', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (724, '2018-10-31 15:55:18.331+00', '2018-10-31 15:55:18.331+00', 'geo_city', 'type/Text', NULL, true, NULL, true, 0, 24, NULL, 'Geo City', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (726, '2018-10-31 15:55:18.332+00', '2018-10-31 15:55:18.332+00', 'referer_source', 'type/Text', NULL, true, NULL, true, 0, 24, NULL, 'Refer Er Source', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (727, '2018-10-31 15:55:18.332+00', '2018-10-31 15:55:18.332+00', 'ip_organization', 'type/Text', NULL, true, NULL, true, 0, 24, NULL, 'IP Organization', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (723, '2018-10-31 15:55:18.331+00', '2018-10-31 15:55:21.906+00', 'page_view_quarter', 'type/Text', 'type/Category', true, NULL, true, 0, 24, NULL, 'Page View Quarter', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":7.0}}}', 2, 'text', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1195, '2018-11-05 10:50:00.507+00', '2018-11-05 10:50:00.507+00', 'time_spent_seconds', 'type/BigInteger', NULL, true, NULL, true, 0, 43, NULL, 'Time Spent Seconds', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'int8', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1196, '2018-11-05 10:50:00.508+00', '2018-11-05 10:50:00.508+00', 'max_pp_yoffset_max', 'type/Integer', NULL, true, NULL, true, 0, 43, NULL, 'Max Pp Y Offset Max', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'int4', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (733, '2018-10-31 15:55:18.333+00', '2018-10-31 15:55:18.333+00', 'geo_timezone', 'type/Text', NULL, true, NULL, true, 0, 24, NULL, 'Geo Timezone', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (734, '2018-10-31 15:55:18.333+00', '2018-10-31 15:55:18.333+00', 'os_minor_version', 'type/Text', NULL, true, NULL, true, 0, 24, NULL, 'Os Minor Version', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1197, '2018-11-05 10:50:00.508+00', '2018-11-05 10:50:00.508+00', 'pageview_id', 'type/Text', NULL, true, NULL, true, 0, 43, NULL, 'Page View ID', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'bpchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (736, '2018-10-31 15:55:18.333+00', '2018-10-31 15:55:18.333+00', 'ip_domain', 'type/Text', NULL, true, NULL, true, 0, 24, NULL, 'IP Domain', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (737, '2018-10-31 15:55:18.607+00', '2018-10-31 15:55:18.607+00', 'os_patch_minor', 'type/Text', NULL, true, NULL, true, 0, 25, NULL, 'Os Patch Minor', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (738, '2018-10-31 15:55:18.607+00', '2018-10-31 15:55:18.607+00', 'ref_parent', 'type/Text', NULL, true, NULL, true, 0, 25, NULL, 'Ref Parent', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (739, '2018-10-31 15:55:18.608+00', '2018-10-31 15:55:18.608+00', 'root_tstamp', 'type/DateTime', NULL, true, NULL, true, 0, 25, NULL, 'Root Ts Tamp', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'timestamp', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (740, '2018-10-31 15:55:18.608+00', '2018-10-31 15:55:18.608+00', 'schema_name', 'type/Text', NULL, true, NULL, true, 0, 25, NULL, 'Schema Name', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (741, '2018-10-31 15:55:18.608+00', '2018-10-31 15:55:18.608+00', 'schema_vendor', 'type/Text', NULL, true, NULL, true, 0, 25, NULL, 'Schema Vendor', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1198, '2018-11-05 10:50:00.508+00', '2018-11-05 10:50:00.508+00', 'max_doc_height', 'type/Integer', NULL, true, NULL, true, 0, 43, NULL, 'Max Doc Height', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'int4', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1199, '2018-11-05 10:50:00.508+00', '2018-11-05 10:50:00.508+00', 'scroll_depth_percent', 'type/Float', NULL, true, NULL, true, 0, 43, NULL, 'Scroll Depth Percent', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'float8', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (744, '2018-10-31 15:55:18.61+00', '2018-10-31 15:55:18.61+00', 'os_patch', 'type/Text', NULL, true, NULL, true, 0, 25, NULL, 'Os Patch', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (746, '2018-10-31 15:55:18.611+00', '2018-10-31 15:55:18.611+00', 'os_minor', 'type/Text', NULL, true, NULL, true, 0, 25, NULL, 'Os Minor', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (749, '2018-10-31 15:55:18.612+00', '2018-10-31 15:55:18.612+00', 'os_major', 'type/Text', NULL, true, NULL, true, 0, 25, NULL, 'Os Major', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (763, '2018-10-31 15:55:18.697+00', '2018-11-05 15:00:01.352+00', 'last_update_date', 'type/DateTime', NULL, true, NULL, true, 0, 26, NULL, 'Last Update Date', 'normal', NULL, NULL, '2018-11-05 15:00:01.962+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/DateTime":{"earliest":"2018-11-05T00:00:00.000Z","latest":"2018-11-05T00:00:00.000Z"}}}', 2, 'timestamp', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (753, '2018-10-31 15:55:18.614+00', '2018-10-31 15:55:18.614+00', 'ref_tree', 'type/Text', NULL, true, NULL, true, 0, 25, NULL, 'Ref Tree', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (754, '2018-10-31 15:55:18.614+00', '2018-10-31 15:55:18.614+00', 'ref_root', 'type/Text', NULL, true, NULL, true, 0, 25, NULL, 'Ref Root', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (755, '2018-10-31 15:55:18.615+00', '2018-10-31 15:55:18.615+00', 'schema_version', 'type/Text', NULL, true, NULL, true, 0, 25, NULL, 'Schema Version', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (756, '2018-10-31 15:55:18.616+00', '2018-10-31 15:55:18.616+00', 'schema_format', 'type/Text', NULL, true, NULL, true, 0, 25, NULL, 'Schema Format', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1223, '2018-11-05 11:50:00.767+00', '2018-11-05 11:50:01.428+00', 'Date', 'type/DateTime', NULL, true, NULL, true, 0, 54, NULL, 'Date', 'normal', NULL, NULL, '2018-11-05 11:50:01.553+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/DateTime":{"earliest":"2018-10-31T00:00:00.000Z","latest":"2018-10-31T00:00:00.000Z"}}}', 2, 'timestamp', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1200, '2018-11-05 11:50:00.574+00', '2018-11-05 11:50:01.446+00', 'fraction_of_visits_that_are_new', 'type/Float', 'type/Category', true, NULL, true, 0, 44, NULL, 'Fraction Of Visits That Are New', 'normal', NULL, NULL, '2018-11-05 11:50:01.553+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Number":{"min":0.0,"max":0.0,"avg":0.0}}}', 2, 'float8', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1217, '2018-11-05 11:50:00.703+00', '2018-11-05 11:50:01.518+00', 'Visitors', 'type/BigInteger', 'type/Category', true, NULL, true, 0, 52, NULL, 'Visitors', 'normal', NULL, NULL, '2018-11-05 11:50:01.553+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Number":{"min":2,"max":2,"avg":2.0}}}', 2, 'int8', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1220, '2018-11-05 11:50:00.734+00', '2018-11-05 11:50:01.523+00', 'Uniques', 'type/BigInteger', 'type/Category', true, NULL, true, 0, 53, NULL, 'Uni Ques', 'normal', NULL, NULL, '2018-11-05 11:50:01.553+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Number":{"min":2,"max":2,"avg":2.0}}}', 2, 'int8', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (762, '2018-10-31 15:55:18.697+00', '2018-10-31 15:55:18.697+00', 'parent', 'type/Text', NULL, true, NULL, true, 0, 26, NULL, 'Parent', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (764, '2018-10-31 15:55:18.698+00', '2018-10-31 15:55:18.698+00', 'description', 'type/Text', NULL, true, NULL, true, 0, 26, NULL, 'Description', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (766, '2018-10-31 15:55:18.699+00', '2018-10-31 15:55:18.699+00', 'versionSparta', 'type/Text', NULL, true, NULL, true, 0, 26, NULL, 'Version Sparta', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (767, '2018-10-31 15:55:18.75+00', '2018-10-31 15:55:18.75+00', 'os_patch_minor', 'type/Text', NULL, true, NULL, true, 0, 27, NULL, 'Os Patch Minor', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (748, '2018-10-31 15:55:18.612+00', '2018-11-05 15:00:01.825+00', 'useragent_patch', 'type/Text', 'type/Category', true, NULL, true, 0, 25, NULL, 'User Agent Patch', 'normal', NULL, NULL, '2018-11-05 15:00:01.962+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":4.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (771, '2018-10-31 15:55:18.752+00', '2018-10-31 15:55:18.752+00', 'os_patch', 'type/Text', NULL, true, NULL, true, 0, 27, NULL, 'Os Patch', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (773, '2018-10-31 15:55:18.752+00', '2018-10-31 15:55:18.752+00', 'os_minor', 'type/Text', NULL, true, NULL, true, 0, 27, NULL, 'Os Minor', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (775, '2018-10-31 15:55:18.754+00', '2018-10-31 15:55:18.754+00', 'useragent_patch', 'type/Text', NULL, true, NULL, true, 0, 27, NULL, 'User Agent Patch', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (776, '2018-10-31 15:55:18.754+00', '2018-10-31 15:55:18.754+00', 'os_major', 'type/Text', NULL, true, NULL, true, 0, 27, NULL, 'Os Major', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (780, '2018-10-31 15:55:18.812+00', '2018-10-31 15:55:18.812+00', 'ref_parent', 'type/Text', NULL, true, NULL, true, 0, 28, NULL, 'Ref Parent', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (781, '2018-10-31 15:55:18.813+00', '2018-10-31 15:55:18.813+00', 'root_tstamp', 'type/DateTime', NULL, true, NULL, true, 0, 28, NULL, 'Root Ts Tamp', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'timestamp', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (782, '2018-10-31 15:55:18.813+00', '2018-10-31 15:55:18.813+00', 'schema_name', 'type/Text', NULL, true, NULL, true, 0, 28, NULL, 'Schema Name', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (784, '2018-10-31 15:55:18.814+00', '2018-10-31 15:55:18.814+00', 'schema_vendor', 'type/Text', NULL, true, NULL, true, 0, 28, NULL, 'Schema Vendor', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (786, '2018-10-31 15:55:18.814+00', '2018-10-31 15:55:18.814+00', 'ref_tree', 'type/Text', NULL, true, NULL, true, 0, 28, NULL, 'Ref Tree', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (787, '2018-10-31 15:55:18.814+00', '2018-10-31 15:55:18.814+00', 'ref_root', 'type/Text', NULL, true, NULL, true, 0, 28, NULL, 'Ref Root', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (788, '2018-10-31 15:55:18.815+00', '2018-10-31 15:55:18.815+00', 'schema_version', 'type/Text', NULL, true, NULL, true, 0, 28, NULL, 'Schema Version', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (789, '2018-10-31 15:55:18.815+00', '2018-10-31 15:55:18.815+00', 'schema_format', 'type/Text', NULL, true, NULL, true, 0, 28, NULL, 'Schema Format', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (793, '2018-10-31 15:55:18.906+00', '2018-10-31 15:55:18.906+00', 'referer_url_fragment', 'type/Text', NULL, true, NULL, true, 0, 30, NULL, 'Refer Er URL Fragment', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (790, '2018-10-31 15:55:18.864+00', '2018-10-31 15:55:22.023+00', 'page_view_id', 'type/Text', 'type/Category', true, NULL, true, 0, 29, NULL, 'Page View ID', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":4},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":36.0}}}', 2, 'bpchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (795, '2018-10-31 15:55:18.907+00', '2018-10-31 15:55:18.907+00', 'marketing_network', 'type/Text', NULL, true, NULL, true, 0, 30, NULL, 'Marketing Network', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (797, '2018-10-31 15:55:18.908+00', '2018-10-31 15:55:18.908+00', 'marketing_term', 'type/Text', NULL, true, NULL, true, 0, 30, NULL, 'Marketing Term', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (801, '2018-10-31 15:55:18.91+00', '2018-10-31 15:55:18.91+00', 'os_build_version', 'type/Text', NULL, true, NULL, true, 0, 30, NULL, 'Os Build Version', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (802, '2018-10-31 15:55:18.911+00', '2018-10-31 15:55:18.911+00', 'marketing_content', 'type/Text', NULL, true, NULL, true, 0, 30, NULL, 'Marketing Content', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (805, '2018-10-31 15:55:18.912+00', '2018-10-31 15:55:18.912+00', 'referer_url_query', 'type/Text', NULL, true, NULL, true, 0, 30, NULL, 'Refer Er URL Query', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (807, '2018-10-31 15:55:18.913+00', '2018-10-31 15:55:18.913+00', 'browser_build_version', 'type/Text', NULL, true, NULL, true, 0, 30, NULL, 'Browser Build Version', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (808, '2018-10-31 15:55:18.914+00', '2018-10-31 15:55:18.914+00', 'geo_region_name', 'type/Text', NULL, true, NULL, true, 0, 30, NULL, 'Geo Region Name', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (810, '2018-10-31 15:55:18.915+00', '2018-10-31 15:55:18.915+00', 'geo_zipcode', 'type/Text', NULL, true, NULL, true, 0, 30, NULL, 'Geo Zip Code', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (811, '2018-10-31 15:55:18.916+00', '2018-10-31 15:55:18.916+00', 'geo_region', 'type/Text', NULL, true, NULL, true, 0, 30, NULL, 'Geo Region', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'bpchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (815, '2018-10-31 15:55:18.918+00', '2018-10-31 15:55:18.918+00', 'referer_term', 'type/Text', NULL, true, NULL, true, 0, 30, NULL, 'Refer Er Term', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (817, '2018-10-31 15:55:18.919+00', '2018-10-31 15:55:18.919+00', 'ip_net_speed', 'type/Text', NULL, true, NULL, true, 0, 30, NULL, 'IP Net Speed', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (818, '2018-10-31 15:55:18.919+00', '2018-10-31 15:55:18.919+00', 'device_is_mobile', 'type/Boolean', NULL, true, NULL, true, 0, 30, NULL, 'Device Is Mobile', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'bool', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (829, '2018-10-31 15:55:18.925+00', '2018-10-31 15:55:18.925+00', 'device_type', 'type/Text', NULL, true, NULL, true, 0, 30, NULL, 'Device Type', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (831, '2018-10-31 15:55:18.925+00', '2018-10-31 15:55:18.925+00', 'os_manufacturer', 'type/Text', NULL, true, NULL, true, 0, 30, NULL, 'Os Manufacturer', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (841, '2018-10-31 15:55:18.929+00', '2018-10-31 15:55:18.929+00', 'marketing_campaign', 'type/Text', NULL, true, NULL, true, 0, 30, NULL, 'Marketing Campaign', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (843, '2018-10-31 15:55:18.93+00', '2018-10-31 15:55:18.93+00', 'browser_engine', 'type/Text', NULL, true, NULL, true, 0, 30, NULL, 'Browser Engine', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (844, '2018-10-31 15:55:18.93+00', '2018-10-31 15:55:18.93+00', 'marketing_source', 'type/Text', NULL, true, NULL, true, 0, 30, NULL, 'Marketing Source', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (851, '2018-10-31 15:55:18.932+00', '2018-10-31 15:55:18.932+00', 'first_page_url_fragment', 'type/Text', NULL, true, NULL, true, 0, 30, NULL, 'First Page URL Fragment', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1201, '2018-11-05 11:50:00.574+00', '2018-11-05 11:50:01.259+00', 'Date', 'type/DateTime', NULL, true, NULL, true, 0, 44, NULL, 'Date', 'normal', NULL, NULL, '2018-11-05 11:50:01.553+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/DateTime":{"earliest":"2018-10-31T00:00:00.000Z","latest":"2018-10-31T00:00:00.000Z"}}}', 2, 'timestamp', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (848, '2018-10-31 15:55:18.931+00', '2018-10-31 15:55:22.094+00', 'session_year', 'type/Integer', 'type/Category', true, NULL, true, 0, 30, NULL, 'Session Year', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Number":{"min":2018,"max":2018,"avg":2018.0}}}', 2, 'int4', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (855, '2018-10-31 15:55:18.933+00', '2018-10-31 15:55:18.933+00', 'marketing_medium', 'type/Text', NULL, true, NULL, true, 0, 30, NULL, 'Marketing Medium', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (856, '2018-10-31 15:55:18.933+00', '2018-10-31 15:55:18.933+00', 'marketing_click_id', 'type/Text', NULL, true, NULL, true, 0, 30, NULL, 'Marketing Click ID', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (857, '2018-10-31 15:55:18.933+00', '2018-10-31 15:55:18.933+00', 'os_major_version', 'type/Text', NULL, true, NULL, true, 0, 30, NULL, 'Os Major Version', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1218, '2018-11-05 11:50:00.703+00', '2018-11-05 11:50:01.519+00', 'Country', 'type/Text', 'type/Country', true, NULL, true, 0, 52, NULL, 'Country', 'normal', NULL, NULL, '2018-11-05 11:50:01.553+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":2.0}}}', 2, 'bpchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (911, '2018-10-31 15:55:19.372+00', '2018-11-05 15:00:01.44+00', 'debug_id', 'type/Text', 'type/PK', true, NULL, true, 0, 33, NULL, 'Debug ID', 'normal', NULL, NULL, '2018-11-05 15:00:01.962+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":36.0}}}', 2, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (970, '2018-10-31 15:55:19.604+00', '2018-10-31 15:55:19.604+00', 'os_family', 'type/Text', NULL, true, NULL, true, 0, 37, NULL, 'Os Family', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (971, '2018-10-31 15:55:19.604+00', '2018-10-31 15:55:19.604+00', 'refr_term', 'type/Text', NULL, true, NULL, true, 0, 37, NULL, 'Re Fr Term', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (912, '2018-10-31 15:55:19.373+00', '2018-11-05 15:00:01.837+00', 'workflow_original', 'type/Text', 'type/Category', true, NULL, false, 0, 33, NULL, 'Work Flow Original', 'normal', NULL, NULL, '2018-11-05 15:00:01.962+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":1.0,"percent-url":0.0,"percent-email":0.0,"average-length":21620.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (973, '2018-10-31 15:55:19.605+00', '2018-10-31 15:55:19.605+00', 'dvce_type', 'type/Text', NULL, true, NULL, true, 0, 37, NULL, 'Dv Ce Type', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (974, '2018-10-31 15:55:19.605+00', '2018-10-31 15:55:19.605+00', 'page_urlfragment', 'type/Text', NULL, true, NULL, true, 0, 37, NULL, 'Page URL Fragment', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (975, '2018-10-31 15:55:19.605+00', '2018-10-31 15:55:19.605+00', 'refr_source', 'type/Text', NULL, true, NULL, true, 0, 37, NULL, 'Re Fr Source', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (913, '2018-10-31 15:55:19.373+00', '2018-11-05 15:00:01.84+00', 'workflow_debug', 'type/Text', 'type/Category', true, NULL, false, 0, 33, NULL, 'Work Flow Debug', 'normal', NULL, NULL, '2018-11-05 15:00:01.962+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":1.0,"percent-url":0.0,"percent-email":0.0,"average-length":27939.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (914, '2018-10-31 15:55:19.374+00', '2018-11-05 15:00:01.846+00', 'result', 'type/Text', 'type/Category', true, NULL, false, 0, 33, NULL, 'Result', 'normal', NULL, NULL, '2018-11-05 15:00:01.962+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":1.0,"percent-url":0.0,"percent-email":0.0,"average-length":99.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (978, '2018-10-31 15:55:19.606+00', '2018-10-31 15:55:19.606+00', 'os_manufacturer', 'type/Text', NULL, true, NULL, true, 0, 37, NULL, 'Os Manufacturer', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1138, '2018-10-31 15:55:19.868+00', '2018-10-31 15:55:19.868+00', 'mkt_source', 'type/Text', NULL, true, NULL, true, 0, 39, NULL, 'Mkt Source', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1139, '2018-10-31 15:55:19.869+00', '2018-10-31 15:55:19.869+00', 'refr_dvce_tstamp', 'type/DateTime', NULL, true, NULL, true, 0, 39, NULL, 'Re Fr Dv Ce Ts Tamp', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'timestamp', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1140, '2018-10-31 15:55:19.869+00', '2018-10-31 15:55:19.869+00', 'geo_timezone', 'type/Text', NULL, true, NULL, true, 0, 39, NULL, 'Geo Timezone', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1141, '2018-10-31 15:55:19.869+00', '2018-10-31 15:55:19.869+00', 'mkt_campaign', 'type/Text', NULL, true, NULL, true, 0, 39, NULL, 'Mkt Campaign', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1144, '2018-10-31 15:55:19.869+00', '2018-10-31 15:55:19.869+00', 'ip_domain', 'type/Text', NULL, true, NULL, true, 0, 39, NULL, 'IP Domain', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (909, '2018-10-31 15:55:19.241+00', '2018-10-31 15:55:22.174+00', 'load_event_end', 'type/BigInteger', 'type/Category', true, NULL, true, 0, 32, NULL, 'Load Event End', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":4},"type":{"type/Number":{"min":0,"max":1540994444039,"avg":1.1853802930924614E12}}}', 2, 'int8', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (900, '2018-10-31 15:55:19.238+00', '2018-10-31 15:55:19.238+00', 'chrome_first_paint', 'type/BigInteger', NULL, true, NULL, true, 0, 32, NULL, 'Chrome First Paint', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'int8', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1202, '2018-11-05 11:50:00.588+00', '2018-11-05 11:50:01.449+00', 'average_visit_duration_seconds', 'type/Float', 'type/Duration', true, NULL, true, 0, 45, NULL, 'Average Visit Duration Seconds', 'normal', NULL, NULL, '2018-11-05 11:50:01.553+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Number":{"min":19.608,"max":19.608,"avg":19.608}}}', 2, 'float8', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (902, '2018-10-31 15:55:19.239+00', '2018-10-31 15:55:19.239+00', 'ref_tree', 'type/Text', NULL, true, NULL, true, 0, 32, NULL, 'Ref Tree', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (903, '2018-10-31 15:55:19.239+00', '2018-10-31 15:55:19.239+00', 'ms_first_paint', 'type/BigInteger', NULL, true, NULL, true, 0, 32, NULL, 'Ms First Paint', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'int8', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1203, '2018-11-05 11:50:00.588+00', '2018-11-05 11:50:01.281+00', 'Date', 'type/DateTime', NULL, true, NULL, true, 0, 45, NULL, 'Date', 'normal', NULL, NULL, '2018-11-05 11:50:01.553+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/DateTime":{"earliest":"2018-10-31T00:00:00.000Z","latest":"2018-10-31T00:00:00.000Z"}}}', 2, 'timestamp', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (905, '2018-10-31 15:55:19.24+00', '2018-10-31 15:55:19.24+00', 'ref_root', 'type/Text', NULL, true, NULL, true, 0, 32, NULL, 'Ref Root', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (906, '2018-10-31 15:55:19.24+00', '2018-10-31 15:55:19.24+00', 'schema_version', 'type/Text', NULL, true, NULL, true, 0, 32, NULL, 'Schema Version', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (907, '2018-10-31 15:55:19.24+00', '2018-10-31 15:55:19.24+00', 'schema_format', 'type/Text', NULL, true, NULL, true, 0, 32, NULL, 'Schema Format', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1205, '2018-11-05 11:50:00.599+00', '2018-11-05 11:50:01.452+00', 'Bounce rate', 'type/Float', 'type/Share', true, NULL, true, 0, 46, NULL, 'Bounce Rate', 'normal', NULL, NULL, '2018-11-05 11:50:01.553+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Number":{"min":0.0,"max":0.0,"avg":0.0}}}', 2, 'float8', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1207, '2018-11-05 11:50:00.61+00', '2018-11-05 11:50:01.455+00', 'Number', 'type/BigInteger', 'type/Quantity', true, NULL, true, 0, 47, NULL, 'Number', 'normal', NULL, NULL, '2018-11-05 11:50:01.553+00', NULL, NULL, '{"global":{"distinct-count":3},"type":{"type/Number":{"min":1,"max":5,"avg":2.6666666666666665}}}', 2, 'int8', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1204, '2018-11-05 11:50:00.599+00', '2018-11-05 11:50:01.307+00', 'Date', 'type/DateTime', NULL, true, NULL, true, 0, 46, NULL, 'Date', 'normal', NULL, NULL, '2018-11-05 11:50:01.553+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/DateTime":{"earliest":"2018-10-31T00:00:00.000Z","latest":"2018-10-31T00:00:00.000Z"}}}', 2, 'timestamp', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1208, '2018-11-05 11:50:00.61+00', '2018-11-05 11:50:01.328+00', 'Date', 'type/DateTime', NULL, true, NULL, true, 0, 47, NULL, 'Date', 'normal', NULL, NULL, '2018-11-05 11:50:01.553+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/DateTime":{"earliest":"2018-10-31T00:00:00.000Z","latest":"2018-10-31T00:00:00.000Z"}}}', 2, 'timestamp', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1206, '2018-11-05 11:50:00.61+00', '2018-11-05 11:50:01.457+00', 'event', 'type/Text', 'type/Category', true, NULL, true, 0, 47, NULL, 'Event', 'normal', NULL, NULL, '2018-11-05 11:50:01.553+00', NULL, NULL, '{"global":{"distinct-count":6},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":9.833333333333334}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1210, '2018-11-05 11:50:00.623+00', '2018-11-05 11:50:01.469+00', 'frequency', 'type/BigInteger', 'type/Category', true, NULL, true, 0, 48, NULL, 'Frequency', 'normal', NULL, NULL, '2018-11-05 11:50:01.553+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Number":{"min":1,"max":1,"avg":1.0}}}', 2, 'int8', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1209, '2018-11-05 11:50:00.623+00', '2018-11-05 11:50:01.471+00', 'pages_visited', 'type/BigInteger', 'type/Category', true, NULL, true, 0, 48, NULL, 'Pages Visited', 'normal', NULL, NULL, '2018-11-05 11:50:01.553+00', NULL, NULL, '{"global":{"distinct-count":2},"type":{"type/Number":{"min":2,"max":3,"avg":2.5}}}', 2, 'int8', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (935, '2018-10-31 15:55:19.531+00', '2018-10-31 15:55:19.531+00', 'parameters_used_in_execution', 'type/Text', NULL, true, NULL, true, 0, 36, NULL, 'Parameters Used In Execution', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (940, '2018-10-31 15:55:19.533+00', '2018-10-31 15:55:19.533+00', 'tags', 'type/Text', NULL, true, NULL, true, 0, 36, NULL, 'Tags', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (944, '2018-10-31 15:55:19.534+00', '2018-10-31 15:55:19.534+00', 'version_sparta', 'type/Text', NULL, true, NULL, true, 0, 36, NULL, 'Version Sparta', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (947, '2018-10-31 15:55:19.536+00', '2018-10-31 15:55:19.536+00', 'creation_date', 'type/DateTime', NULL, true, NULL, true, 0, 36, NULL, 'Creation Date', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'timestamp', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (948, '2018-10-31 15:55:19.537+00', '2018-10-31 15:55:19.537+00', 'execution_id', 'type/Text', NULL, true, NULL, true, 0, 36, NULL, 'Execution ID', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (951, '2018-10-31 15:55:19.597+00', '2018-10-31 15:55:19.597+00', 'mkt_content', 'type/Text', NULL, true, NULL, true, 0, 37, NULL, 'Mkt Content', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (953, '2018-10-31 15:55:19.598+00', '2018-10-31 15:55:19.598+00', 'os_name', 'type/Text', NULL, true, NULL, true, 0, 37, NULL, 'Os Name', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (954, '2018-10-31 15:55:19.598+00', '2018-10-31 15:55:19.598+00', 'br_family', 'type/Text', NULL, true, NULL, true, 0, 37, NULL, 'Br Family', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (956, '2018-10-31 15:55:19.599+00', '2018-10-31 15:55:19.599+00', 'mkt_clickid', 'type/Text', NULL, true, NULL, true, 0, 37, NULL, 'Mkt Click ID', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (957, '2018-10-31 15:55:19.599+00', '2018-10-31 15:55:19.599+00', 'geo_region_name', 'type/Text', NULL, true, NULL, true, 0, 37, NULL, 'Geo Region Name', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (959, '2018-10-31 15:55:19.6+00', '2018-10-31 15:55:19.6+00', 'geo_zipcode', 'type/Text', NULL, true, NULL, true, 0, 37, NULL, 'Geo Zip Code', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (960, '2018-10-31 15:55:19.6+00', '2018-10-31 15:55:19.6+00', 'geo_region', 'type/Text', NULL, true, NULL, true, 0, 37, NULL, 'Geo Region', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'bpchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (962, '2018-10-31 15:55:19.601+00', '2018-10-31 15:55:19.601+00', 'ip_netspeed', 'type/Text', NULL, true, NULL, true, 0, 37, NULL, 'IP Net Speed', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (964, '2018-10-31 15:55:19.601+00', '2018-10-31 15:55:19.601+00', 'mkt_term', 'type/Text', NULL, true, NULL, true, 0, 37, NULL, 'Mkt Term', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (931, '2018-10-31 15:55:19.482+00', '2018-11-05 15:00:01.855+00', 'step', 'type/Text', 'type/Category', true, NULL, true, 0, 35, NULL, 'Step', 'normal', NULL, NULL, '2018-11-05 15:00:01.962+00', NULL, NULL, '{"global":{"distinct-count":12},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":12.333333333333334}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (981, '2018-10-31 15:55:19.608+00', '2018-10-31 15:55:19.608+00', 'mkt_medium', 'type/Text', NULL, true, NULL, true, 0, 37, NULL, 'Mkt Medium', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (982, '2018-10-31 15:55:19.608+00', '2018-10-31 15:55:19.608+00', 'br_renderengine', 'type/Text', NULL, true, NULL, true, 0, 37, NULL, 'Br Render Engine', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (983, '2018-10-31 15:55:19.608+00', '2018-10-31 15:55:19.608+00', 'dvce_ismobile', 'type/Boolean', NULL, true, NULL, true, 0, 37, NULL, 'Dv Ce Is Mobile', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'bool', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (926, '2018-10-31 15:55:19.417+00', '2018-10-31 15:55:22.21+00', 'relative_vmax', 'type/Float', 'type/Category', true, NULL, true, 0, 34, NULL, 'Relative Vma X', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Number":{"min":100.0,"max":100.0,"avg":100.0}}}', 2, 'float8', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (986, '2018-10-31 15:55:19.609+00', '2018-10-31 15:55:19.609+00', 'br_type', 'type/Text', NULL, true, NULL, true, 0, 37, NULL, 'Br Type', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (987, '2018-10-31 15:55:19.61+00', '2018-10-31 15:55:19.61+00', 'refr_urlquery', 'type/Text', NULL, true, NULL, true, 0, 37, NULL, 'Re Fr URL Query', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1211, '2018-11-05 11:50:00.634+00', '2018-11-05 11:50:01.474+00', 'page_views', 'type/BigInteger', 'type/Category', true, NULL, true, 0, 49, NULL, 'Page Views', 'normal', NULL, NULL, '2018-11-05 11:50:01.553+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Number":{"min":5,"max":5,"avg":5.0}}}', 2, 'int8', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1212, '2018-11-05 11:50:00.634+00', '2018-11-05 11:50:01.362+00', 'Date', 'type/DateTime', NULL, true, NULL, true, 0, 49, NULL, 'Date', 'normal', NULL, NULL, '2018-11-05 11:50:01.553+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/DateTime":{"earliest":"2018-10-31T00:00:00.000Z","latest":"2018-10-31T00:00:00.000Z"}}}', 2, 'timestamp', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (990, '2018-10-31 15:55:19.611+00', '2018-10-31 15:55:19.611+00', 'br_name', 'type/Text', NULL, true, NULL, true, 0, 37, NULL, 'Br Name', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1214, '2018-11-05 11:50:00.645+00', '2018-11-05 11:50:01.477+00', 'Frequency', 'type/BigInteger', 'type/Category', true, NULL, true, 0, 50, NULL, 'Frequency', 'normal', NULL, NULL, '2018-11-05 11:50:01.553+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Number":{"min":1,"max":1,"avg":1.0}}}', 2, 'int8', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (992, '2018-10-31 15:55:19.611+00', '2018-10-31 15:55:19.611+00', 'br_version', 'type/Text', NULL, true, NULL, true, 0, 37, NULL, 'Br Version', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (993, '2018-10-31 15:55:19.612+00', '2018-10-31 15:55:19.612+00', 'refr_urlfragment', 'type/Text', NULL, true, NULL, true, 0, 37, NULL, 'Re Fr URL Fragment', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1213, '2018-11-05 11:50:00.645+00', '2018-11-05 11:50:01.478+00', 'Number of visits', 'type/Integer', 'type/Quantity', true, NULL, true, 0, 50, NULL, 'Number Of Visits', 'normal', NULL, NULL, '2018-11-05 11:50:01.553+00', NULL, NULL, '{"global":{"distinct-count":2},"type":{"type/Number":{"min":2,"max":13,"avg":7.5}}}', 2, 'int2', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (995, '2018-10-31 15:55:19.612+00', '2018-10-31 15:55:19.612+00', 'mkt_network', 'type/Text', NULL, true, NULL, true, 0, 37, NULL, 'Mkt Network', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1216, '2018-11-05 11:50:00.673+00', '2018-11-05 11:50:01.509+00', 'br_lang', 'type/Text', 'type/Category', true, NULL, true, 0, 51, NULL, 'Br Lang', 'normal', NULL, NULL, '2018-11-05 11:50:01.553+00', NULL, NULL, '{"global":{"distinct-count":2},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":5.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1215, '2018-11-05 11:50:00.673+00', '2018-11-05 11:50:01.515+00', 'visitors', 'type/BigInteger', 'type/Category', true, NULL, true, 0, 51, NULL, 'Visitors', 'normal', NULL, NULL, '2018-11-05 11:50:01.553+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Number":{"min":1,"max":1,"avg":1.0}}}', 2, 'int8', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (998, '2018-10-31 15:55:19.613+00', '2018-10-31 15:55:19.613+00', 'ip_isp', 'type/Text', NULL, true, NULL, true, 0, 37, NULL, 'IP Isp', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1219, '2018-11-05 11:50:00.733+00', '2018-11-05 11:50:01.525+00', 'Visits', 'type/BigInteger', 'type/Category', true, NULL, true, 0, 53, NULL, 'Visits', 'normal', NULL, NULL, '2018-11-05 11:50:01.553+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Number":{"min":2,"max":2,"avg":2.0}}}', 2, 'int8', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1222, '2018-11-05 11:50:00.767+00', '2018-11-05 11:50:01.527+00', 'fraction_of_visits_that_are_new', 'type/Float', 'type/Category', true, NULL, true, 0, 54, NULL, 'Fraction Of Visits That Are New', 'normal', NULL, NULL, '2018-11-05 11:50:01.553+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Number":{"min":0.0,"max":0.0,"avg":0.0}}}', 2, 'float8', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1002, '2018-10-31 15:55:19.614+00', '2018-10-31 15:55:19.614+00', 'geo_city', 'type/Text', NULL, true, NULL, true, 0, 37, NULL, 'Geo City', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1003, '2018-10-31 15:55:19.614+00', '2018-10-31 15:55:19.614+00', 'ip_organization', 'type/Text', NULL, true, NULL, true, 0, 37, NULL, 'IP Organization', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1004, '2018-10-31 15:55:19.614+00', '2018-10-31 15:55:19.614+00', 'mkt_source', 'type/Text', NULL, true, NULL, true, 0, 37, NULL, 'Mkt Source', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1005, '2018-10-31 15:55:19.615+00', '2018-10-31 15:55:19.615+00', 'geo_timezone', 'type/Text', NULL, true, NULL, true, 0, 37, NULL, 'Geo Timezone', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1006, '2018-10-31 15:55:19.615+00', '2018-10-31 15:55:19.615+00', 'mkt_campaign', 'type/Text', NULL, true, NULL, true, 0, 37, NULL, 'Mkt Campaign', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1221, '2018-11-05 11:50:00.734+00', '2018-11-05 11:50:01.413+00', 'Date', 'type/DateTime', NULL, true, NULL, true, 0, 53, NULL, 'Date', 'normal', NULL, NULL, '2018-11-05 11:50:01.553+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/DateTime":{"earliest":"2018-10-31T00:00:00.000Z","latest":"2018-10-31T00:00:00.000Z"}}}', 2, 'timestamp', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1009, '2018-10-31 15:55:19.616+00', '2018-10-31 15:55:19.616+00', 'ip_domain', 'type/Text', NULL, true, NULL, true, 0, 37, NULL, 'IP Domain', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1019, '2018-10-31 15:55:19.849+00', '2018-10-31 15:55:19.849+00', 'mkt_content', 'type/Text', NULL, true, NULL, true, 0, 39, NULL, 'Mkt Content', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1023, '2018-10-31 15:55:19.85+00', '2018-10-31 15:55:19.85+00', 'ti_price_base', 'type/Decimal', NULL, true, NULL, true, 0, 39, NULL, 'Ti Price Base', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'numeric', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1024, '2018-10-31 15:55:19.85+00', '2018-10-31 15:55:19.85+00', 'tr_shipping_base', 'type/Decimal', NULL, true, NULL, true, 0, 39, NULL, 'Tr Shipping Base', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'numeric', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1025, '2018-10-31 15:55:19.85+00', '2018-10-31 15:55:19.85+00', 'os_name', 'type/Text', NULL, true, NULL, true, 0, 39, NULL, 'Os Name', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1026, '2018-10-31 15:55:19.85+00', '2018-10-31 15:55:19.85+00', 'br_family', 'type/Text', NULL, true, NULL, true, 0, 39, NULL, 'Br Family', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1028, '2018-10-31 15:55:19.851+00', '2018-10-31 15:55:19.851+00', 'se_property', 'type/Text', NULL, true, NULL, true, 0, 39, NULL, 'Se Property', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1029, '2018-10-31 15:55:19.851+00', '2018-10-31 15:55:19.851+00', 'mkt_clickid', 'type/Text', NULL, true, NULL, true, 0, 39, NULL, 'Mkt Click ID', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1030, '2018-10-31 15:55:19.851+00', '2018-10-31 15:55:19.851+00', 'base_currency', 'type/Text', NULL, true, NULL, true, 0, 39, NULL, 'Base Currency', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'bpchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1031, '2018-10-31 15:55:19.851+00', '2018-10-31 15:55:19.851+00', 'geo_region_name', 'type/Text', NULL, true, NULL, true, 0, 39, NULL, 'Geo Region Name', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1033, '2018-10-31 15:55:19.852+00', '2018-10-31 15:55:19.852+00', 'geo_zipcode', 'type/Text', NULL, true, NULL, true, 0, 39, NULL, 'Geo Zip Code', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1011, '2018-10-31 15:55:19.799+00', '2018-11-05 15:00:01.905+00', 'archived', 'type/Boolean', 'type/Category', true, NULL, true, 0, 38, NULL, 'Archived', 'normal', NULL, NULL, '2018-11-05 15:00:01.962+00', NULL, NULL, '{"global":{"distinct-count":1}}', 2, 'bool', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1046, '2018-10-31 15:55:19.854+00', '2018-10-31 15:55:19.854+00', 'tr_tax_base', 'type/Decimal', NULL, true, NULL, true, 0, 39, NULL, 'Tr Tax Base', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'numeric', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1049, '2018-10-31 15:55:19.855+00', '2018-10-31 15:55:19.855+00', 'mkt_term', 'type/Text', NULL, true, NULL, true, 0, 39, NULL, 'Mkt Term', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1053, '2018-10-31 15:55:19.855+00', '2018-10-31 15:55:19.855+00', 'tr_total_base', 'type/Decimal', NULL, true, NULL, true, 0, 39, NULL, 'Tr Total Base', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'numeric', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (999, '2018-10-31 15:55:19.613+00', '2018-10-31 15:55:22.28+00', 'user_ipaddress', 'type/Text', 'type/Category', true, NULL, true, 0, 37, NULL, 'User IP Address', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":12.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1034, '2018-10-31 15:55:19.852+00', '2018-10-31 15:55:19.852+00', 'geo_region', 'type/Text', NULL, true, NULL, true, 0, 39, NULL, 'Geo Region', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'bpchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1047, '2018-10-31 15:55:19.854+00', '2018-10-31 15:55:19.854+00', 'ip_netspeed', 'type/Text', NULL, true, NULL, true, 0, 39, NULL, 'IP Net Speed', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1060, '2018-10-31 15:55:19.856+00', '2018-10-31 15:55:19.856+00', 'refr_domain_userid', 'type/Text', NULL, true, NULL, true, 0, 39, NULL, 'Re Fr Domain Use Rid', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1062, '2018-10-31 15:55:19.857+00', '2018-10-31 15:55:19.857+00', 'os_family', 'type/Text', NULL, true, NULL, true, 0, 39, NULL, 'Os Family', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1064, '2018-10-31 15:55:19.857+00', '2018-10-31 15:55:19.857+00', 'refr_term', 'type/Text', NULL, true, NULL, true, 0, 39, NULL, 'Re Fr Term', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1067, '2018-10-31 15:55:19.857+00', '2018-10-31 15:55:19.857+00', 'dvce_type', 'type/Text', NULL, true, NULL, true, 0, 39, NULL, 'Dv Ce Type', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1068, '2018-10-31 15:55:19.858+00', '2018-10-31 15:55:19.858+00', 'tr_city', 'type/Text', NULL, true, NULL, true, 0, 39, NULL, 'Tr City', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1224, '2018-11-05 12:03:48.054+00', '2018-11-05 17:00:00.676+00', 'Operating System', 'type/Text', NULL, false, NULL, true, 0, 55, NULL, 'Operating System', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1070, '2018-10-31 15:55:19.858+00', '2018-10-31 15:55:19.858+00', 'page_urlfragment', 'type/Text', NULL, true, NULL, true, 0, 39, NULL, 'Page URL Fragment', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1071, '2018-10-31 15:55:19.858+00', '2018-10-31 15:55:19.858+00', 'event_fingerprint', 'type/Text', NULL, true, NULL, true, 0, 39, NULL, 'Event Fingerprint', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1232, '2018-11-05 12:03:48.191+00', '2018-11-05 13:00:01.459+00', 'Number of visits', 'type/BigInteger', 'type/Quantity', true, NULL, true, 0, 59, NULL, 'Number Of Visits', 'normal', NULL, NULL, '2018-11-05 13:00:01.531+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Number":{"min":1,"max":1,"avg":1.0}}}', 2, 'int8', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1073, '2018-10-31 15:55:19.859+00', '2018-10-31 15:55:19.859+00', 'refr_source', 'type/Text', NULL, true, NULL, true, 0, 39, NULL, 'Re Fr Source', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1103, '2018-10-31 15:55:19.863+00', '2018-10-31 15:55:19.863+00', 'ti_category', 'type/Text', NULL, true, NULL, true, 0, 39, NULL, 'Ti Category', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1104, '2018-10-31 15:55:19.863+00', '2018-10-31 15:55:19.863+00', 'tr_country', 'type/Text', NULL, true, NULL, true, 0, 39, NULL, 'Tr Country', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1225, '2018-11-05 12:03:48.054+00', '2018-11-05 13:00:01.425+00', 'Visits', 'type/BigInteger', 'type/Category', true, NULL, true, 0, 55, NULL, 'Visits', 'normal', NULL, NULL, '2018-11-05 13:00:01.531+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Number":{"min":2,"max":2,"avg":2.0}}}', 2, 'int8', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1227, '2018-11-05 12:03:48.092+00', '2018-11-05 13:00:01.432+00', 'Number of visits', 'type/BigInteger', 'type/Quantity', true, NULL, true, 0, 56, NULL, 'Number Of Visits', 'normal', NULL, NULL, '2018-11-05 13:00:01.531+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Number":{"min":2,"max":2,"avg":2.0}}}', 2, 'int8', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1226, '2018-11-05 12:03:48.091+00', '2018-11-05 13:00:01.437+00', 'Days between visits', 'type/Text', 'type/Category', true, NULL, true, 0, 56, NULL, 'Days Between Visits', 'normal', NULL, NULL, '2018-11-05 13:00:01.531+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":3.0}}}', 2, 'text', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1108, '2018-10-31 15:55:19.864+00', '2018-10-31 15:55:19.864+00', 'txn_id', 'type/Integer', NULL, true, NULL, true, 0, 39, NULL, 'Txn ID', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'int4', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1109, '2018-10-31 15:55:19.864+00', '2018-10-31 15:55:19.864+00', 'tr_affiliation', 'type/Text', NULL, true, NULL, true, 0, 39, NULL, 'Tr Affiliation', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1229, '2018-11-05 12:03:48.125+00', '2018-11-05 13:00:01.443+00', 'Visits', 'type/BigInteger', 'type/Category', true, NULL, true, 0, 57, NULL, 'Visits', 'normal', NULL, NULL, '2018-11-05 13:00:01.531+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Number":{"min":2,"max":2,"avg":2.0}}}', 2, 'int8', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (928, '2018-10-31 15:55:19.481+00', '2018-11-05 15:00:01.858+00', 'workflow_id', 'type/Text', 'type/Category', true, NULL, true, 0, 35, NULL, 'Work Flow ID', 'normal', NULL, NULL, '2018-11-05 15:00:01.962+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":36.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1113, '2018-10-31 15:55:19.865+00', '2018-10-31 15:55:19.865+00', 'br_version', 'type/Text', NULL, true, NULL, true, 0, 39, NULL, 'Br Version', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (932, '2018-10-31 15:55:19.483+00', '2018-11-05 15:00:01.861+00', 'data', 'type/Text', 'type/Category', true, NULL, false, 0, 35, NULL, 'Data', 'normal', NULL, NULL, '2018-11-05 15:00:01.962+00', NULL, NULL, '{"global":{"distinct-count":11},"type":{"type/Text":{"percent-json":1.0,"percent-url":0.0,"percent-email":0.0,"average-length":3071.5}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (930, '2018-10-31 15:55:19.482+00', '2018-11-05 15:00:01.482+00', 'id', 'type/Text', 'type/PK', true, NULL, true, 0, 35, NULL, 'ID', 'normal', NULL, NULL, '2018-11-05 15:00:01.962+00', NULL, NULL, '{"global":{"distinct-count":12},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":49.333333333333336}}}', 2, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1228, '2018-11-05 12:03:48.124+00', '2018-11-05 17:00:01.269+00', 'Browser', 'type/Text', 'type/Category', true, NULL, true, 0, 57, NULL, 'Browser', 'normal', NULL, NULL, '2018-11-05 17:00:01.288+00', NULL, NULL, '{"global":{"distinct-count":2},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":6.5}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1119, '2018-10-31 15:55:19.866+00', '2018-10-31 15:55:19.866+00', 'tr_shipping', 'type/Decimal', NULL, true, NULL, true, 0, 39, NULL, 'Tr Shipping', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'numeric', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1121, '2018-10-31 15:55:19.866+00', '2018-10-31 15:55:19.866+00', 'refr_urlfragment', 'type/Text', NULL, true, NULL, true, 0, 39, NULL, 'Re Fr URL Fragment', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1123, '2018-10-31 15:55:19.866+00', '2018-10-31 15:55:19.866+00', 'mkt_network', 'type/Text', NULL, true, NULL, true, 0, 39, NULL, 'Mkt Network', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1231, '2018-11-05 12:03:48.159+00', '2018-11-05 13:00:01.447+00', 'Visit duration', 'type/Text', 'type/Category', true, NULL, true, 0, 58, NULL, 'Visit Duration', 'normal', NULL, NULL, '2018-11-05 13:00:01.531+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":16.0}}}', 2, 'text', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1136, '2018-10-31 15:55:19.868+00', '2018-10-31 15:55:19.868+00', 'ip_organization', 'type/Text', NULL, true, NULL, true, 0, 39, NULL, 'IP Organization', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1230, '2018-11-05 12:03:48.158+00', '2018-11-05 13:00:01.454+00', 'Number of visits', 'type/BigInteger', 'type/Quantity', true, NULL, true, 0, 58, NULL, 'Number Of Visits', 'normal', NULL, NULL, '2018-11-05 13:00:01.531+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Number":{"min":2,"max":2,"avg":2.0}}}', 2, 'int8', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1122, '2018-10-31 15:55:19.866+00', '2018-10-31 15:55:22.418+00', 'br_features_realplayer', 'type/Boolean', 'type/Category', true, NULL, true, 0, 39, NULL, 'Br Features Realplayer', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1}}', 2, 'bool', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1118, '2018-10-31 15:55:19.865+00', '2018-10-31 15:55:22.422+00', 'br_features_pdf', 'type/Boolean', 'type/Category', true, NULL, true, 0, 39, NULL, 'Br Features Pdf', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":2}}', 2, 'bool', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1157, '2018-10-31 15:55:20.175+00', '2018-10-31 16:50:01.119+00', 'referer_url_port', 'type/Integer', 'type/Category', true, NULL, true, 0, 40, NULL, 'Refer Er URL Port', 'normal', NULL, NULL, '2018-10-31 16:50:01.223+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Number":{"min":8080,"max":8080,"avg":8080.0}}}', 2, 'int4', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1158, '2018-10-31 15:55:20.175+00', '2018-10-31 16:50:01.121+00', 'first_session_local_time_of_day', 'type/Text', 'type/Category', true, NULL, true, 0, 40, NULL, 'First Session Local Time Of Day', 'normal', NULL, NULL, '2018-10-31 16:50:01.223+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":5.0}}}', 2, 'text', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1147, '2018-10-31 15:55:20.173+00', '2018-10-31 16:50:01.108+00', 'referer_url', 'type/Text', 'type/URL', true, NULL, true, 0, 40, NULL, 'Refer Er URL', 'normal', NULL, NULL, '2018-10-31 16:50:01.223+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":17.0}}}', 2, 'text', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1079, '2018-10-31 15:55:19.86+00', '2018-10-31 15:55:19.86+00', 'os_manufacturer', 'type/Text', NULL, true, NULL, true, 0, 39, NULL, 'Os Manufacturer', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1151, '2018-10-31 15:55:20.174+00', '2018-10-31 16:50:01.111+00', 'first_session_local_time', 'type/Text', 'type/Category', true, NULL, true, 0, 40, NULL, 'First Session Local Time', 'normal', NULL, NULL, '2018-10-31 16:50:01.223+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":19.0}}}', 2, 'text', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1083, '2018-10-31 15:55:19.86+00', '2018-10-31 15:55:19.86+00', 'mkt_medium', 'type/Text', NULL, true, NULL, true, 0, 39, NULL, 'Mkt Medium', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1084, '2018-10-31 15:55:19.86+00', '2018-10-31 15:55:19.86+00', 'true_tstamp', 'type/DateTime', NULL, true, NULL, true, 0, 39, NULL, 'True Ts Tamp', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'timestamp', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1152, '2018-10-31 15:55:20.174+00', '2018-10-31 16:50:01.113+00', 'page_views', 'type/Decimal', 'type/Category', true, NULL, true, 0, 40, NULL, 'Page Views', 'normal', NULL, NULL, '2018-10-31 16:50:01.223+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Number":{"min":3,"max":3,"avg":3.0}}}', 2, 'numeric', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1153, '2018-10-31 15:55:20.174+00', '2018-10-31 16:50:01.115+00', 'first_page_url_host', 'type/Text', 'type/Category', true, NULL, true, 0, 40, NULL, 'First Page URL Host', 'normal', NULL, NULL, '2018-10-31 16:50:01.223+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":7.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1087, '2018-10-31 15:55:19.861+00', '2018-10-31 15:55:19.861+00', 'br_renderengine', 'type/Text', NULL, true, NULL, true, 0, 39, NULL, 'Br Render Engine', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1088, '2018-10-31 15:55:19.861+00', '2018-10-31 15:55:19.861+00', 'dvce_ismobile', 'type/Boolean', NULL, true, NULL, true, 0, 39, NULL, 'Dv Ce Is Mobile', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'bool', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1156, '2018-10-31 15:55:20.175+00', '2018-10-31 16:50:01.117+00', 'first_session_minute', 'type/Text', 'type/Category', true, NULL, true, 0, 40, NULL, 'First Session Minute', 'normal', NULL, NULL, '2018-10-31 16:50:01.223+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":16.0}}}', 2, 'text', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1233, '2018-11-05 12:03:48.192+00', '2018-11-05 13:00:01.457+00', 'Page views per visit', 'type/BigInteger', 'type/Category', true, NULL, true, 0, 59, NULL, 'Page Views Per Visit', 'normal', NULL, NULL, '2018-11-05 13:00:01.531+00', NULL, NULL, '{"global":{"distinct-count":2},"type":{"type/Number":{"min":2,"max":3,"avg":2.5}}}', 2, 'int8', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1235, '2018-11-05 12:03:48.227+00', '2018-11-05 13:00:01.462+00', 'Visits', 'type/BigInteger', 'type/Category', true, NULL, true, 0, 60, NULL, 'Visits', 'normal', NULL, NULL, '2018-11-05 13:00:01.531+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Number":{"min":2,"max":2,"avg":2.0}}}', 2, 'int8', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1093, '2018-10-31 15:55:19.862+00', '2018-10-31 15:55:19.862+00', 'br_type', 'type/Text', NULL, true, NULL, true, 0, 39, NULL, 'Br Type', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1094, '2018-10-31 15:55:19.862+00', '2018-10-31 15:55:19.862+00', 'tr_state', 'type/Text', NULL, true, NULL, true, 0, 39, NULL, 'Tr State', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1095, '2018-10-31 15:55:19.862+00', '2018-10-31 15:55:19.862+00', 'refr_urlquery', 'type/Text', NULL, true, NULL, true, 0, 39, NULL, 'Re Fr URL Query', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1096, '2018-10-31 15:55:19.862+00', '2018-10-31 15:55:19.862+00', 'etl_tags', 'type/Text', NULL, true, NULL, true, 0, 39, NULL, 'Etl Tags', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1234, '2018-11-05 12:03:48.226+00', '2018-11-05 13:00:01.467+00', 'Device type', 'type/Text', 'type/Category', true, NULL, true, 0, 60, NULL, 'Device Type', 'normal', NULL, NULL, '2018-11-05 13:00:01.531+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":7.0}}}', 2, 'text', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1100, '2018-10-31 15:55:19.863+00', '2018-10-31 15:55:19.863+00', 'br_name', 'type/Text', NULL, true, NULL, true, 0, 39, NULL, 'Br Name', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1101, '2018-10-31 15:55:19.863+00', '2018-10-31 15:55:19.863+00', 'tr_tax', 'type/Decimal', NULL, true, NULL, true, 0, 39, NULL, 'Tr Tax', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'numeric', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1127, '2018-10-31 15:55:19.867+00', '2018-10-31 15:55:19.867+00', 'ip_isp', 'type/Text', NULL, true, NULL, true, 0, 39, NULL, 'IP Isp', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (937, '2018-10-31 15:55:19.531+00', '2018-11-05 15:00:01.524+00', 'group_id', 'type/Text', 'type/FK', true, NULL, true, 0, 36, NULL, 'Group ID', 'normal', 878, NULL, '2018-11-05 15:00:01.962+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":36.0}}}', 2, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (939, '2018-10-31 15:55:19.532+00', '2018-11-05 15:00:01.889+00', 'debug_mode', 'type/Boolean', 'type/Category', true, NULL, true, 0, 36, NULL, 'Debug Mode', 'normal', NULL, NULL, '2018-11-05 15:00:01.962+00', NULL, NULL, '{"global":{"distinct-count":1}}', 2, 'bool', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1135, '2018-10-31 15:55:19.868+00', '2018-10-31 15:55:19.868+00', 'geo_city', 'type/Text', NULL, true, NULL, true, 0, 39, NULL, 'Geo City', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1148, '2018-10-31 15:55:20.173+00', '2018-10-31 15:55:20.173+00', 'referer_url_fragment', 'type/Text', NULL, true, NULL, true, 0, 40, NULL, 'Refer Er URL Fragment', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1149, '2018-10-31 15:55:20.173+00', '2018-10-31 15:55:20.173+00', 'marketing_network', 'type/Text', NULL, true, NULL, true, 0, 40, NULL, 'Marketing Network', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1150, '2018-10-31 15:55:20.174+00', '2018-10-31 15:55:20.174+00', 'marketing_term', 'type/Text', NULL, true, NULL, true, 0, 40, NULL, 'Marketing Term', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1154, '2018-10-31 15:55:20.174+00', '2018-10-31 15:55:20.174+00', 'marketing_content', 'type/Text', NULL, true, NULL, true, 0, 40, NULL, 'Marketing Content', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1155, '2018-10-31 15:55:20.175+00', '2018-10-31 15:55:20.175+00', 'referer_url_query', 'type/Text', NULL, true, NULL, true, 0, 40, NULL, 'Refer Er URL Query', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1159, '2018-10-31 15:55:20.176+00', '2018-10-31 15:55:20.176+00', 'referer_term', 'type/Text', NULL, true, NULL, true, 0, 40, NULL, 'Refer Er Term', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1134, '2018-10-31 15:55:19.868+00', '2018-10-31 15:55:22.388+00', 'geo_country', 'type/Text', 'type/Category', true, NULL, true, 0, 39, NULL, 'Geo Country', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":2.0}}}', 2, 'bpchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1092, '2018-10-31 15:55:19.862+00', '2018-10-31 15:55:22.449+00', 'br_cookies', 'type/Boolean', 'type/Category', true, NULL, true, 0, 39, NULL, 'Br Cookies', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1}}', 2, 'bool', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1176, '2018-10-31 15:55:20.183+00', '2018-10-31 15:55:20.183+00', 'marketing_campaign', 'type/Text', NULL, true, NULL, true, 0, 40, NULL, 'Marketing Campaign', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1017, '2018-10-31 15:55:19.801+00', '2018-11-05 15:00:01.922+00', 'local_execution', 'type/Text', 'type/Category', true, NULL, true, 0, 38, NULL, 'Local Execution', 'normal', NULL, NULL, '2018-11-05 15:00:01.962+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":1.0,"percent-url":0.0,"percent-email":0.0,"average-length":36.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (620, '2018-10-31 15:55:18.254+00', '2018-10-31 15:55:21.705+00', 'dom_interactive_to_complete_time_in_ms', 'type/BigInteger', 'type/Category', true, NULL, true, 0, 42, NULL, 'Dom Interactive To Complete Time In Ms', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":3},"type":{"type/Number":{"min":56,"max":69,"avg":63.0}}}', 2, 'int8', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (622, '2018-10-31 15:55:18.254+00', '2018-10-31 15:55:21.707+00', 'response_time_in_ms', 'type/BigInteger', 'type/Category', true, NULL, true, 0, 42, NULL, 'Response Time In Ms', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Number":{"min":0,"max":0,"avg":0.0}}}', 2, 'int8', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (895, '2018-10-31 15:55:19.236+00', '2018-10-31 15:55:22.164+00', 'navigation_start', 'type/BigInteger', 'type/Category', true, NULL, true, 0, 32, NULL, 'Navigation Start', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":4},"type":{"type/Number":{"min":1540993926616,"max":1540994443940,"avg":1.540994393134923E12}}}', 2, 'int8', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (897, '2018-10-31 15:55:19.237+00', '2018-10-31 15:55:22.166+00', 'request_start', 'type/BigInteger', 'type/Category', true, NULL, true, 0, 32, NULL, 'Request Start', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":4},"type":{"type/Number":{"min":1540993926624,"max":1540994443945,"avg":1.540994393146923E12}}}', 2, 'int8', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (899, '2018-10-31 15:55:19.238+00', '2018-10-31 15:55:22.168+00', 'domain_lookup_end', 'type/BigInteger', 'type/Category', true, NULL, true, 0, 32, NULL, 'Domain Lookup End', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":4},"type":{"type/Number":{"min":1540993926624,"max":1540994443940,"avg":1.5409943931377693E12}}}', 2, 'int8', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (904, '2018-10-31 15:55:19.239+00', '2018-10-31 15:55:22.176+00', 'load_event_start', 'type/BigInteger', 'type/Category', true, NULL, true, 0, 32, NULL, 'Load Event Start', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":4},"type":{"type/Number":{"min":0,"max":1540994444037,"avg":1.1853802930907693E12}}}', 2, 'int8', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (889, '2018-10-31 15:55:19.234+00', '2018-10-31 15:55:22.189+00', 'dom_content_loaded_event_start', 'type/BigInteger', 'type/Category', true, NULL, true, 0, 32, NULL, 'Dom Content Loaded Event Start', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":4},"type":{"type/Number":{"min":1540993926673,"max":1540994443974,"avg":1.5409943931806924E12}}}', 2, 'int8', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1160, '2018-10-31 15:55:20.176+00', '2018-10-31 16:50:01.123+00', 'first_session_local_day_of_week', 'type/Text', 'type/Category', true, NULL, true, 0, 40, NULL, 'First Session Local Day Of Week', 'normal', NULL, NULL, '2018-10-31 16:50:01.223+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":1.0}}}', 2, 'text', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1161, '2018-10-31 15:55:20.176+00', '2018-10-31 16:50:01.125+00', 'first_page_url', 'type/Text', 'type/URL', true, NULL, true, 0, 40, NULL, 'First Page URL', 'normal', NULL, NULL, '2018-10-31 16:50:01.223+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":17.0}}}', 2, 'text', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1162, '2018-10-31 15:55:20.176+00', '2018-10-31 16:50:01.127+00', 'first_session_date', 'type/Text', 'type/Category', true, NULL, true, 0, 40, NULL, 'First Session Date', 'normal', NULL, NULL, '2018-10-31 16:50:01.223+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":10.0}}}', 2, 'text', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1163, '2018-10-31 15:55:20.177+00', '2018-10-31 16:50:01.13+00', 'user_snowplow_crossdomain_id', 'type/Text', 'type/Category', true, NULL, true, 0, 40, NULL, 'User Snowplow Cross Domain ID', 'normal', NULL, NULL, '2018-10-31 16:50:01.223+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":36.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1177, '2018-10-31 15:55:20.183+00', '2018-10-31 16:50:01.132+00', 'first_session_month', 'type/Text', 'type/Category', true, NULL, true, 0, 40, NULL, 'First Session Month', 'normal', NULL, NULL, '2018-10-31 16:50:01.223+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":7.0}}}', 2, 'text', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1178, '2018-10-31 15:55:20.183+00', '2018-10-31 15:55:20.183+00', 'marketing_source', 'type/Text', NULL, true, NULL, true, 0, 40, NULL, 'Marketing Source', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1182, '2018-10-31 15:55:20.185+00', '2018-10-31 15:55:20.185+00', 'first_page_url_fragment', 'type/Text', NULL, true, NULL, true, 0, 40, NULL, 'First Page URL Fragment', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1184, '2018-10-31 15:55:20.186+00', '2018-10-31 15:55:20.186+00', 'marketing_medium', 'type/Text', NULL, true, NULL, true, 0, 40, NULL, 'Marketing Medium', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1185, '2018-10-31 15:55:20.186+00', '2018-10-31 15:55:20.186+00', 'marketing_click_id', 'type/Text', NULL, true, NULL, true, 0, 40, NULL, 'Marketing Click ID', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1189, '2018-10-31 15:55:20.187+00', '2018-10-31 15:55:20.187+00', 'referer_source', 'type/Text', NULL, true, NULL, true, 0, 40, NULL, 'Refer Er Source', 'normal', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (934, '2018-10-31 15:55:19.53+00', '2018-11-05 15:00:01.87+00', 'version', 'type/BigInteger', 'type/Category', true, NULL, true, 0, 36, NULL, 'Version', 'normal', NULL, NULL, '2018-11-05 15:00:01.962+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Number":{"min":2,"max":2,"avg":2.0}}}', 2, 'int8', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (936, '2018-10-31 15:55:19.531+00', '2018-11-05 15:00:01.873+00', 'name', 'type/Text', 'type/Name', true, NULL, true, 0, 36, NULL, 'Name', 'normal', NULL, NULL, '2018-11-05 15:00:01.962+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":16.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (941, '2018-10-31 15:55:19.533+00', '2018-11-05 15:00:01.879+00', 'group', 'type/Text', 'type/Category', true, NULL, false, 0, 36, NULL, 'Group', 'normal', NULL, NULL, '2018-11-05 15:00:01.962+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":1.0,"percent-url":0.0,"percent-email":0.0,"average-length":60.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (943, '2018-10-31 15:55:19.534+00', '2018-11-05 15:00:01.882+00', 'settings', 'type/Text', 'type/Category', true, NULL, false, 0, 36, NULL, 'Settings', 'normal', NULL, NULL, '2018-11-05 15:00:01.962+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":1.0,"percent-url":0.0,"percent-email":0.0,"average-length":2544.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (946, '2018-10-31 15:55:19.536+00', '2018-11-05 15:00:01.885+00', 'description', 'type/Text', 'type/Description', true, NULL, true, 0, 36, NULL, 'Description', 'normal', NULL, NULL, '2018-11-05 15:00:01.962+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":0.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (929, '2018-10-31 15:55:19.482+00', '2018-11-05 15:00:01.852+00', 'num_events', 'type/Integer', 'type/Quantity', true, NULL, true, 0, 35, NULL, 'Num Events', 'normal', NULL, NULL, '2018-11-05 15:00:01.962+00', NULL, NULL, '{"global":{"distinct-count":3},"type":{"type/Number":{"min":0,"max":3,"avg":1.0}}}', 2, 'int4', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1012, '2018-10-31 15:55:19.799+00', '2018-11-05 15:00:01.908+00', 'generic_data_execution', 'type/Text', 'type/Category', true, NULL, false, 0, 38, NULL, 'Generic Data Execution', 'normal', NULL, NULL, '2018-11-05 15:00:01.962+00', NULL, NULL, '{"global":{"distinct-count":7},"type":{"type/Text":{"percent-json":1.0,"percent-url":0.0,"percent-email":0.0,"average-length":78749.71428571429}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1013, '2018-10-31 15:55:19.8+00', '2018-11-05 15:00:01.911+00', 'spark_dispatcher_execution', 'type/Text', 'type/Category', true, NULL, true, 0, 38, NULL, 'Spark Dispatcher Execution', 'normal', NULL, NULL, '2018-11-05 15:00:01.962+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":0.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1016, '2018-10-31 15:55:19.801+00', '2018-11-05 15:00:01.914+00', 'marathon_execution', 'type/Text', 'type/Category', true, NULL, true, 0, 38, NULL, 'Marathon Execution', 'normal', NULL, NULL, '2018-11-05 15:00:01.962+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":0.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1014, '2018-10-31 15:55:19.8+00', '2018-11-05 15:00:01.621+00', 'workflow_execution_id', 'type/Text', 'type/PK', true, NULL, true, 0, 38, NULL, 'Work Flow Execution ID', 'normal', NULL, NULL, '2018-11-05 15:00:01.962+00', NULL, NULL, '{"global":{"distinct-count":7},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":36.0}}}', 2, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1018, '2018-10-31 15:55:19.802+00', '2018-11-05 15:00:01.916+00', 'spark_submit_execution', 'type/Text', 'type/Category', true, NULL, true, 0, 38, NULL, 'Spark Submit Execution', 'normal', NULL, NULL, '2018-11-05 15:00:01.962+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":0.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (942, '2018-10-31 15:55:19.534+00', '2018-11-05 15:00:01.534+00', 'last_update_date', 'type/DateTime', NULL, true, NULL, true, 0, 36, NULL, 'Last Update Date', 'normal', NULL, NULL, '2018-11-05 15:00:01.962+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/DateTime":{"earliest":"2018-11-05T00:00:00.000Z","latest":"2018-11-05T00:00:00.000Z"}}}', 2, 'timestamp', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (949, '2018-10-31 15:55:19.537+00', '2018-11-05 15:00:01.545+00', 'workflow_id', 'type/Text', 'type/PK', true, NULL, true, 0, 36, NULL, 'Work Flow ID', 'normal', NULL, NULL, '2018-11-05 15:00:01.962+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":36.0}}}', 2, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (945, '2018-10-31 15:55:19.535+00', '2018-11-05 15:00:01.892+00', 'pipeline_graph', 'type/Text', 'type/Category', true, NULL, false, 0, 36, NULL, 'Pipeline Graph', 'normal', NULL, NULL, '2018-11-05 15:00:01.962+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":1.0,"percent-url":0.0,"percent-email":0.0,"average-length":18659.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1015, '2018-10-31 15:55:19.8+00', '2018-11-05 15:00:01.919+00', 'spark_execution', 'type/Text', 'type/Category', true, NULL, true, 0, 38, NULL, 'Spark Execution', 'normal', NULL, NULL, '2018-11-05 15:00:01.962+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":0.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (933, '2018-10-31 15:55:19.483+00', '2018-11-05 15:00:01.865+00', 'schema', 'type/Text', 'type/Category', true, NULL, false, 0, 35, NULL, 'Schema', 'normal', NULL, NULL, '2018-11-05 15:00:01.962+00', NULL, NULL, '{"global":{"distinct-count":10},"type":{"type/Text":{"percent-json":1.0,"percent-url":0.0,"percent-email":0.0,"average-length":6837.666666666667}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (938, '2018-10-31 15:55:19.532+00', '2018-11-05 15:00:01.876+00', 'execution_engine', 'type/Text', 'type/Category', true, NULL, true, 0, 36, NULL, 'Execution Engine', 'normal', NULL, NULL, '2018-11-05 15:00:01.962+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":11.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (950, '2018-10-31 15:55:19.537+00', '2018-11-05 15:00:01.895+00', 'ui_settings', 'type/Text', 'type/Category', true, NULL, false, 0, 36, NULL, 'Ui Settings', 'normal', NULL, NULL, '2018-11-05 15:00:01.962+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":1.0,"percent-url":0.0,"percent-email":0.0,"average-length":84.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1165, '2018-10-31 15:55:20.178+00', '2018-10-31 16:50:01.135+00', 'first_session_local_hour_of_day', 'type/Integer', 'type/Category', true, NULL, true, 0, 40, NULL, 'First Session Local Hour Of Day', 'normal', NULL, NULL, '2018-10-31 16:50:01.223+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Number":{"min":14,"max":14,"avg":14.0}}}', 2, 'int4', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (626, '2018-10-31 15:55:18.283+00', '2018-10-31 15:55:20.617+00', 'max_tstamp', 'type/DateTime', NULL, true, NULL, true, 0, 22, NULL, 'Max Ts Tamp', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/DateTime":{"earliest":"2018-10-31T00:00:00.000Z","latest":"2018-10-31T00:00:00.000Z"}}}', 2, 'timestamp', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1010, '2018-10-31 15:55:19.799+00', '2018-11-05 15:00:01.902+00', 'execution_status', 'type/Text', 'type/Category', true, NULL, false, 0, 38, NULL, 'Execution Status', 'normal', NULL, NULL, '2018-11-05 15:00:01.962+00', NULL, NULL, '{"global":{"distinct-count":7},"type":{"type/Text":{"percent-json":1.0,"percent-url":0.0,"percent-email":0.0,"average-length":611.4285714285714}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (655, '2018-10-31 15:55:18.32+00', '2018-10-31 15:55:20.892+00', 'page_view_end', 'type/DateTime', NULL, true, NULL, true, 0, 24, NULL, 'Page View End', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/DateTime":{"earliest":"2018-10-31T00:00:00.000Z","latest":"2018-10-31T00:00:00.000Z"}}}', 2, 'timestamp', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1236, '2018-11-05 17:00:00.662+00', '2018-11-05 17:00:01.265+00', 'OS', 'type/Text', 'type/Category', true, NULL, true, 0, 55, NULL, 'Os', 'normal', NULL, NULL, '2018-11-05 17:00:01.288+00', NULL, NULL, '{"global":{"distinct-count":2},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":5.5}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (785, '2018-10-31 15:55:18.814+00', '2018-10-31 15:55:21.025+00', 'root_id', 'type/Text', 'type/FK', true, NULL, true, 0, 28, NULL, 'Root ID', 'normal', 1069, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":13},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":36.0}}}', 2, 'bpchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (915, '2018-10-31 15:55:19.412+00', '2018-10-31 15:55:22.198+00', 'vmax', 'type/Integer', 'type/Category', true, NULL, true, 0, 34, NULL, 'Vma X', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Number":{"min":0,"max":0,"avg":0.0}}}', 2, 'int4', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (878, '2018-10-31 15:55:19.186+00', '2018-10-31 15:55:21.181+00', 'group_id', 'type/Text', 'type/PK', true, NULL, true, 0, 31, NULL, 'Group ID', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":36.0}}}', 2, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (901, '2018-10-31 15:55:19.238+00', '2018-10-31 15:55:21.203+00', 'root_id', 'type/Text', 'type/FK', true, NULL, true, 0, 32, NULL, 'Root ID', 'normal', 1069, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":13},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":36.0}}}', 2, 'bpchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (621, '2018-10-31 15:55:18.254+00', '2018-10-31 15:55:21.712+00', 'total_time_in_ms', 'type/BigInteger', 'type/Income', true, NULL, true, 0, 42, NULL, 'Total Time In Ms', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":2},"type":{"type/Number":{"min":99,"max":115,"avg":109.66666666666667}}}', 2, 'int8', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1090, '2018-10-31 15:55:19.861+00', '2018-10-31 15:55:21.554+00', 'collector_tstamp', 'type/DateTime', NULL, true, NULL, true, 0, 39, NULL, 'Collector Ts Tamp', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/DateTime":{"earliest":"2018-10-31T00:00:00.000Z","latest":"2018-10-31T00:00:00.000Z"}}}', 2, 'timestamp', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (618, '2018-10-31 15:55:18.253+00', '2018-10-31 15:55:21.716+00', 'request_time_in_ms', 'type/BigInteger', 'type/Category', true, NULL, true, 0, 42, NULL, 'Request Time In Ms', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":2},"type":{"type/Number":{"min":0,"max":8,"avg":2.0}}}', 2, 'int8', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (615, '2018-10-31 15:55:18.253+00', '2018-10-31 15:55:21.718+00', 'onload_time_in_ms', 'type/BigInteger', 'type/Category', true, NULL, true, 0, 42, NULL, 'Onload Time In Ms', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":2},"type":{"type/Number":{"min":2,"max":4,"avg":2.6666666666666665}}}', 2, 'int8', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (613, '2018-10-31 15:55:18.252+00', '2018-10-31 15:55:21.721+00', 'tcp_time_in_ms', 'type/BigInteger', 'type/Category', true, NULL, true, 0, 42, NULL, 'Tcp Time In Ms', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":2},"type":{"type/Number":{"min":0,"max":1,"avg":0.25}}}', 2, 'int8', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (611, '2018-10-31 15:55:18.252+00', '2018-10-31 15:55:21.723+00', 'dns_time_in_ms', 'type/BigInteger', 'type/Category', true, NULL, true, 0, 42, NULL, 'Dns Time In Ms', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Number":{"min":0,"max":0,"avg":0.0}}}', 2, 'int8', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (623, '2018-10-31 15:55:18.283+00', '2018-10-31 15:55:21.734+00', 'time_engaged_in_s', 'type/BigInteger', 'type/Category', true, NULL, true, 0, 22, NULL, 'Time Engaged In S', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":2},"type":{"type/Number":{"min":0,"max":10,"avg":5.0}}}', 2, 'int8', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (629, '2018-10-31 15:55:18.301+00', '2018-10-31 15:55:21.74+00', 'value', 'type/Text', 'type/Category', true, NULL, true, 0, 23, NULL, 'Value', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":15},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":30.58823529411765}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (625, '2018-10-31 15:55:18.283+00', '2018-10-31 15:55:20.62+00', 'min_tstamp', 'type/DateTime', NULL, true, NULL, true, 0, 22, NULL, 'Min Ts Tamp', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/DateTime":{"earliest":"2018-10-31T00:00:00.000Z","latest":"2018-10-31T00:00:00.000Z"}}}', 2, 'timestamp', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (653, '2018-10-31 15:55:18.319+00', '2018-10-31 15:55:21.957+00', 'browser', 'type/Text', 'type/Category', true, NULL, true, 0, 24, NULL, 'Browser', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":12.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (651, '2018-10-31 15:55:18.319+00', '2018-10-31 15:55:21.959+00', 'page_url_port', 'type/Integer', 'type/Category', true, NULL, true, 0, 24, NULL, 'Page URL Port', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Number":{"min":8080,"max":8080,"avg":8080.0}}}', 2, 'int4', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (649, '2018-10-31 15:55:18.319+00', '2018-10-31 15:55:21.961+00', 'page_title', 'type/Text', 'type/Title', true, NULL, true, 0, 24, NULL, 'Page Title', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":12.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (647, '2018-10-31 15:55:18.319+00', '2018-10-31 15:55:21.963+00', 'browser_window_height', 'type/Integer', 'type/Category', true, NULL, true, 0, 24, NULL, 'Browser Window Height', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Number":{"min":936,"max":936,"avg":936.0}}}', 2, 'int4', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (643, '2018-10-31 15:55:18.318+00', '2018-10-31 15:55:21.965+00', 'session_index', 'type/Integer', 'type/Category', true, NULL, true, 0, 24, NULL, 'Session Index', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Number":{"min":13,"max":13,"avg":13.0}}}', 2, 'int2', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (641, '2018-10-31 15:55:18.318+00', '2018-10-31 15:55:21.967+00', 'page_url_path', 'type/Text', 'type/Category', true, NULL, true, 0, 24, NULL, 'Page URL Path', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":10.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (639, '2018-10-31 15:55:18.317+00', '2018-10-31 15:55:21.969+00', 'os', 'type/Text', 'type/Category', true, NULL, true, 0, 24, NULL, 'Os', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":6.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (637, '2018-10-31 15:55:18.317+00', '2018-10-31 15:55:21.971+00', 'device', 'type/Text', 'type/Category', true, NULL, true, 0, 24, NULL, 'Device', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":5.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (635, '2018-10-31 15:55:18.317+00', '2018-10-31 15:55:21.973+00', 'vertical_pixels_scrolled', 'type/Integer', 'type/Category', true, NULL, true, 0, 24, NULL, 'Vertical Pixels Scrolled', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Number":{"min":0,"max":0,"avg":0.0}}}', 2, 'int4', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (665, '2018-10-31 15:55:18.321+00', '2018-10-31 15:55:21.951+00', 'referer_url_port', 'type/Integer', 'type/Category', true, NULL, true, 0, 24, NULL, 'Refer Er URL Port', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Number":{"min":8080,"max":8080,"avg":8080.0}}}', 2, 'int4', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (662, '2018-10-31 15:55:18.321+00', '2018-10-31 15:55:21.953+00', 'horizontal_pixels_scrolled', 'type/Integer', 'type/Category', true, NULL, true, 0, 24, NULL, 'Horizontal Pixels Scrolled', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Number":{"min":0,"max":0,"avg":0.0}}}', 2, 'int4', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (661, '2018-10-31 15:55:18.321+00', '2018-10-31 15:55:21.955+00', 'page_view_id', 'type/Text', 'type/Category', true, NULL, true, 0, 24, NULL, 'Page View ID', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":3},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":36.0}}}', 2, 'bpchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (871, '2018-10-31 15:55:18.936+00', '2018-10-31 15:55:22.082+00', 'session_quarter', 'type/Text', 'type/Category', true, NULL, true, 0, 30, NULL, 'Session Quarter', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":7.0}}}', 2, 'text', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (864, '2018-10-31 15:55:18.935+00', '2018-10-31 15:55:22.084+00', 'geo_country', 'type/Text', 'type/Category', true, NULL, true, 0, 30, NULL, 'Geo Country', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":2.0}}}', 2, 'bpchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (862, '2018-10-31 15:55:18.934+00', '2018-10-31 15:55:22.086+00', 'referer_url_scheme', 'type/Text', 'type/Category', true, NULL, true, 0, 30, NULL, 'Refer Er URL Scheme', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":4.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (867, '2018-10-31 15:55:18.935+00', '2018-10-31 15:55:21.077+00', 'session_start', 'type/DateTime', NULL, true, NULL, true, 0, 30, NULL, 'Session Start', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/DateTime":{"earliest":"2018-10-31T00:00:00.000Z","latest":"2018-10-31T00:00:00.000Z"}}}', 2, 'timestamp', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (859, '2018-10-31 15:55:18.934+00', '2018-10-31 15:55:22.088+00', 'first_page_url_port', 'type/Integer', 'type/Category', true, NULL, true, 0, 30, NULL, 'First Page URL Port', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Number":{"min":8080,"max":8080,"avg":8080.0}}}', 2, 'int4', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (877, '2018-10-31 15:55:19.186+00', '2018-10-31 15:55:22.149+00', 'name', 'type/Text', 'type/Name', true, NULL, true, 0, 31, NULL, 'Name', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":5.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (898, '2018-10-31 15:55:19.237+00', '2018-10-31 15:55:22.179+00', 'redirect_start', 'type/BigInteger', 'type/Category', true, NULL, true, 0, 32, NULL, 'Redirect Start', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Number":{"min":0,"max":0,"avg":0.0}}}', 2, 'int8', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (896, '2018-10-31 15:55:19.237+00', '2018-10-31 15:55:22.181+00', 'response_end', 'type/BigInteger', 'type/Category', true, NULL, true, 0, 32, NULL, 'Response End', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":4},"type":{"type/Number":{"min":1540993926632,"max":1540994443945,"avg":1.5409943931475386E12}}}', 2, 'int8', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1057, '2018-10-31 15:55:19.856+00', '2018-10-31 15:55:22.476+00', 'page_urlscheme', 'type/Text', 'type/Category', true, NULL, true, 0, 39, NULL, 'Page URL Scheme', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":4.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1041, '2018-10-31 15:55:19.853+00', '2018-10-31 15:55:22.486+00', 'v_collector', 'type/Text', 'type/Category', true, NULL, true, 0, 39, NULL, 'V Collector', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":16.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (894, '2018-10-31 15:55:19.236+00', '2018-10-31 15:55:22.183+00', 'redirect_end', 'type/BigInteger', 'type/Category', true, NULL, true, 0, 32, NULL, 'Redirect End', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Number":{"min":0,"max":0,"avg":0.0}}}', 2, 'int8', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (893, '2018-10-31 15:55:19.235+00', '2018-10-31 15:55:22.185+00', 'dom_loading', 'type/BigInteger', 'type/Category', true, NULL, true, 0, 32, NULL, 'Dom Loading', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":4},"type":{"type/Number":{"min":1540993926639,"max":1540994443949,"avg":1.5409943931526155E12}}}', 2, 'int8', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (891, '2018-10-31 15:55:19.235+00', '2018-10-31 15:55:22.187+00', 'secure_connection_start', 'type/BigInteger', 'type/Category', true, NULL, true, 0, 32, NULL, 'Secure Connection Start', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Number":{"min":0,"max":0,"avg":0.0}}}', 2, 'int8', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (886, '2018-10-31 15:55:19.232+00', '2018-10-31 15:55:22.191+00', 'unload_event_end', 'type/BigInteger', 'type/Category', true, NULL, true, 0, 32, NULL, 'Unload Event End', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":4},"type":{"type/Number":{"min":1540993926640,"max":1540994443949,"avg":1.5409943931533845E12}}}', 2, 'int8', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (880, '2018-10-31 15:55:19.23+00', '2018-10-31 15:55:22.194+00', 'dom_complete', 'type/BigInteger', 'type/Category', true, NULL, true, 0, 32, NULL, 'Dom Complete', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":4},"type":{"type/Number":{"min":0,"max":1540994444037,"avg":1.1853802930907693E12}}}', 2, 'int8', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (883, '2018-10-31 15:55:19.231+00', '2018-10-31 15:55:21.243+00', 'root_tstamp', 'type/DateTime', NULL, true, NULL, true, 0, 32, NULL, 'Root Ts Tamp', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/DateTime":{"earliest":"2018-10-31T00:00:00.000Z","latest":"2018-10-31T00:00:00.000Z"}}}', 2, 'timestamp', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (670, '2018-10-31 15:55:18.322+00', '2018-10-31 15:55:21.947+00', 'browser_window_width', 'type/Integer', 'type/Category', true, NULL, true, 0, 24, NULL, 'Browser Window Width', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Number":{"min":1920,"max":1920,"avg":1920.0}}}', 2, 'int4', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (721, '2018-10-31 15:55:18.331+00', '2018-10-31 15:55:21.908+00', 'geo_country', 'type/Text', 'type/Category', true, NULL, true, 0, 24, NULL, 'Geo Country', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":2.0}}}', 2, 'bpchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (716, '2018-10-31 15:55:18.33+00', '2018-10-31 15:55:21.911+00', 'user_snowplow_domain_id', 'type/Text', 'type/Category', true, NULL, true, 0, 24, NULL, 'User Snowplow Domain ID', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":36.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (719, '2018-10-31 15:55:18.33+00', '2018-10-31 15:55:20.748+00', 'page_view_start', 'type/DateTime', NULL, true, NULL, true, 0, 24, NULL, 'Page View Start', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/DateTime":{"earliest":"2018-10-31T00:00:00.000Z","latest":"2018-10-31T00:00:00.000Z"}}}', 2, 'timestamp', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (711, '2018-10-31 15:55:18.329+00', '2018-10-31 15:55:21.913+00', 'ip_address', 'type/Text', 'type/Category', true, NULL, true, 0, 24, NULL, 'IP Address', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":12.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (709, '2018-10-31 15:55:18.329+00', '2018-10-31 15:55:21.915+00', 'page_view_time', 'type/Text', 'type/Category', true, NULL, true, 0, 24, NULL, 'Page View Time', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":3},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":19.0}}}', 2, 'text', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (707, '2018-10-31 15:55:18.328+00', '2018-10-31 15:55:21.917+00', 'page_url_host', 'type/Text', 'type/Category', true, NULL, true, 0, 24, NULL, 'Page URL Host', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":7.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (703, '2018-10-31 15:55:18.328+00', '2018-10-31 15:55:21.919+00', 'page_view_index', 'type/BigInteger', 'type/Category', true, NULL, true, 0, 24, NULL, 'Page View Index', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":3},"type":{"type/Number":{"min":1,"max":3,"avg":2.0}}}', 2, 'int8', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (705, '2018-10-31 15:55:18.328+00', '2018-10-31 15:55:20.771+00', 'page_view_end_local', 'type/DateTime', NULL, true, NULL, true, 0, 24, NULL, 'Page View End Local', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/DateTime":{"earliest":"2018-10-31T00:00:00.000Z","latest":"2018-10-31T00:00:00.000Z"}}}', 2, 'timestamp', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (699, '2018-10-31 15:55:18.327+00', '2018-10-31 15:55:21.921+00', 'page_view_minute', 'type/Text', 'type/Category', true, NULL, true, 0, 24, NULL, 'Page View Minute', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":16.0}}}', 2, 'text', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (695, '2018-10-31 15:55:18.327+00', '2018-10-31 15:55:21.923+00', 'referer_url_path', 'type/Text', 'type/Category', true, NULL, true, 0, 24, NULL, 'Refer Er URL Path', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":10.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (693, '2018-10-31 15:55:18.326+00', '2018-10-31 15:55:21.926+00', 'browser_language', 'type/Text', 'type/Category', true, NULL, true, 0, 24, NULL, 'Browser Language', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":5.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (692, '2018-10-31 15:55:18.326+00', '2018-10-31 15:55:21.928+00', 'page_height', 'type/Integer', 'type/Category', true, NULL, true, 0, 24, NULL, 'Page Height', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Number":{"min":936,"max":936,"avg":936.0}}}', 2, 'int4', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (686, '2018-10-31 15:55:18.325+00', '2018-10-31 15:55:21.932+00', 'unload_time_in_ms', 'type/BigInteger', 'type/Category', true, NULL, true, 0, 24, NULL, 'Unload Time In Ms', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":2},"type":{"type/Number":{"min":0,"max":1,"avg":0.3333333333333333}}}', 2, 'int8', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (683, '2018-10-31 15:55:18.325+00', '2018-10-31 15:55:21.934+00', 'browser_minor_version', 'type/Text', 'type/Category', true, NULL, true, 0, 24, NULL, 'Browser Minor Version', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":1.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (682, '2018-10-31 15:55:18.324+00', '2018-10-31 15:55:21.937+00', 'browser_name', 'type/Text', 'type/Category', true, NULL, true, 0, 24, NULL, 'Browser Name', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":7.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (680, '2018-10-31 15:55:18.324+00', '2018-10-31 15:55:21.939+00', 'onload_time_in_ms', 'type/BigInteger', 'type/Category', true, NULL, true, 0, 24, NULL, 'Onload Time In Ms', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Number":{"min":2,"max":2,"avg":2.0}}}', 2, 'int8', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (678, '2018-10-31 15:55:18.324+00', '2018-10-31 15:55:21.941+00', 'app_cache_time_in_ms', 'type/BigInteger', 'type/Category', true, NULL, true, 0, 24, NULL, 'App Cache Time In Ms', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":2},"type":{"type/Number":{"min":0,"max":10,"avg":3.3333333333333335}}}', 2, 'int8', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (677, '2018-10-31 15:55:18.323+00', '2018-10-31 15:55:21.943+00', 'user_bounced', 'type/Boolean', 'type/Category', true, NULL, true, 0, 24, NULL, 'User Bounced', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":2}}', 2, 'bool', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (675, '2018-10-31 15:55:18.323+00', '2018-10-31 15:55:21.945+00', 'geo_longitude', 'type/Float', 'type/Longitude', true, NULL, true, 0, 24, NULL, 'Geo Longitude', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Number":{"min":-97.822,"max":-97.822,"avg":-97.822}}}', 2, 'float8', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (794, '2018-10-31 15:55:18.907+00', '2018-10-31 15:55:22.146+00', 'session_time', 'type/Text', 'type/Category', true, NULL, true, 0, 30, NULL, 'Session Time', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":19.0}}}', 2, 'text', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (757, '2018-10-31 15:55:18.617+00', '2018-10-31 15:55:21.987+00', 'useragent_version', 'type/Text', 'type/Category', true, NULL, true, 0, 25, NULL, 'User Agent Version', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":2},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":12.75}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (750, '2018-10-31 15:55:18.613+00', '2018-10-31 15:55:21.989+00', 'os_version', 'type/Text', 'type/Category', true, NULL, true, 0, 25, NULL, 'Os Version', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":2},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":5.8125}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (745, '2018-10-31 15:55:18.611+00', '2018-10-31 15:55:21.991+00', 'device_family', 'type/Text', 'type/Category', true, NULL, true, 0, 25, NULL, 'Device Family', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":5.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (761, '2018-10-31 15:55:18.696+00', '2018-10-31 15:55:21.997+00', 'tags', 'type/Text', 'type/Category', true, NULL, true, 0, 26, NULL, 'Tags', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":1.0,"percent-url":0.0,"percent-email":0.0,"average-length":2.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (765, '2018-10-31 15:55:18.698+00', '2018-10-31 15:55:20.972+00', 'creation_date', 'type/DateTime', NULL, true, NULL, true, 0, 26, NULL, 'Creation Date', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/DateTime":{"earliest":"2018-10-29T00:00:00.000Z","latest":"2018-10-29T00:00:00.000Z"}}}', 2, 'timestamp', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (758, '2018-10-31 15:55:18.695+00', '2018-10-31 15:55:21.999+00', 'name', 'type/Text', 'type/Name', true, NULL, true, 0, 26, NULL, 'Name', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":2},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":9.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (778, '2018-10-31 15:55:18.755+00', '2018-10-31 15:55:22.009+00', 'useragent_major', 'type/Text', 'type/Category', true, NULL, true, 0, 27, NULL, 'User Agent Major', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":2.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (774, '2018-10-31 15:55:18.753+00', '2018-10-31 15:55:22.012+00', 'os_family', 'type/Text', 'type/Category', true, NULL, true, 0, 27, NULL, 'Os Family', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":6.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (770, '2018-10-31 15:55:18.751+00', '2018-10-31 15:55:22.014+00', 'useragent_minor', 'type/Text', 'type/Category', true, NULL, true, 0, 27, NULL, 'User Agent Minor', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":1.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (783, '2018-10-31 15:55:18.813+00', '2018-10-31 15:55:22.018+00', 'id', 'type/Text', 'type/PK', true, NULL, true, 0, 28, NULL, 'ID', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":4},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":36.0}}}', 2, 'bpchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (845, '2018-10-31 15:55:18.93+00', '2018-10-31 15:55:22.097+00', 'geo_latitude', 'type/Float', 'type/Category', true, NULL, true, 0, 30, NULL, 'Geo Latitude', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Number":{"min":37.751,"max":37.751,"avg":37.751}}}', 2, 'float8', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (846, '2018-10-31 15:55:18.93+00', '2018-10-31 15:55:21.104+00', 'session_end', 'type/DateTime', NULL, true, NULL, true, 0, 30, NULL, 'Session End', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/DateTime":{"earliest":"2018-10-31T00:00:00.000Z","latest":"2018-10-31T00:00:00.000Z"}}}', 2, 'timestamp', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (838, '2018-10-31 15:55:18.928+00', '2018-10-31 15:55:22.1+00', 'first_page_url_path', 'type/Text', 'type/Category', true, NULL, true, 0, 30, NULL, 'First Page URL Path', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":10.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (836, '2018-10-31 15:55:18.927+00', '2018-10-31 15:55:22.102+00', 'referer_url_path', 'type/Text', 'type/Category', true, NULL, true, 0, 30, NULL, 'Refer Er URL Path', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":10.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (834, '2018-10-31 15:55:18.927+00', '2018-10-31 15:55:22.105+00', 'first_page_title', 'type/Text', 'type/Title', true, NULL, true, 0, 30, NULL, 'First Page Title', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":12.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (832, '2018-10-31 15:55:18.926+00', '2018-10-31 15:55:22.106+00', 'referer_medium', 'type/Text', 'type/Category', true, NULL, true, 0, 30, NULL, 'Refer Er Medium', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":8.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (828, '2018-10-31 15:55:18.924+00', '2018-10-31 15:55:22.121+00', 'session_id', 'type/Text', 'type/Category', true, NULL, true, 0, 30, NULL, 'Session ID', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":36.0}}}', 2, 'bpchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (827, '2018-10-31 15:55:18.924+00', '2018-10-31 15:55:22.124+00', 'user_engaged', 'type/Boolean', 'type/Category', true, NULL, true, 0, 30, NULL, 'User Engaged', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1}}', 2, 'bool', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (825, '2018-10-31 15:55:18.923+00', '2018-10-31 15:55:22.126+00', 'browser_name', 'type/Text', 'type/Category', true, NULL, true, 0, 30, NULL, 'Browser Name', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":7.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (822, '2018-10-31 15:55:18.922+00', '2018-10-31 15:55:22.128+00', 'user_bounced', 'type/Boolean', 'type/Category', true, NULL, true, 0, 30, NULL, 'User Bounced', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1}}', 2, 'bool', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (816, '2018-10-31 15:55:18.918+00', '2018-10-31 15:55:22.134+00', 'first_page_url', 'type/Text', 'type/URL', true, NULL, true, 0, 30, NULL, 'First Page URL', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":17.0}}}', 2, 'text', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (823, '2018-10-31 15:55:18.922+00', '2018-10-31 15:55:21.137+00', 'session_start_local', 'type/DateTime', NULL, true, NULL, true, 0, 30, NULL, 'Session Start Local', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/DateTime":{"earliest":"2018-10-31T00:00:00.000Z","latest":"2018-10-31T00:00:00.000Z"}}}', 2, 'timestamp', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (812, '2018-10-31 15:55:18.916+00', '2018-10-31 15:55:22.136+00', 'session_month', 'type/Text', 'type/Category', true, NULL, true, 0, 30, NULL, 'Session Month', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":7.0}}}', 2, 'text', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (809, '2018-10-31 15:55:18.915+00', '2018-10-31 15:55:22.138+00', 'session_local_day_of_week_index', 'type/Integer', 'type/Category', true, NULL, true, 0, 30, NULL, 'Session Local Day Of Week Index', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Number":{"min":2,"max":2,"avg":2.0}}}', 2, 'int4', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (803, '2018-10-31 15:55:18.911+00', '2018-10-31 15:55:22.14+00', 'os_name', 'type/Text', 'type/Category', true, NULL, true, 0, 30, NULL, 'Os Name', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":6.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (800, '2018-10-31 15:55:18.91+00', '2018-10-31 15:55:22.142+00', 'session_index', 'type/Integer', 'type/Category', true, NULL, true, 0, 30, NULL, 'Session Index', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Number":{"min":13,"max":13,"avg":13.0}}}', 2, 'int2', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (798, '2018-10-31 15:55:18.909+00', '2018-10-31 15:55:22.144+00', 'os', 'type/Text', 'type/Category', true, NULL, true, 0, 30, NULL, 'Os', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":6.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (850, '2018-10-31 15:55:18.931+00', '2018-10-31 15:55:22.092+00', 'session_date', 'type/Text', 'type/Category', true, NULL, true, 0, 30, NULL, 'Session Date', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":10.0}}}', 2, 'text', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (919, '2018-10-31 15:55:19.414+00', '2018-10-31 15:55:22.218+00', 'page_view_id', 'type/Text', 'type/Category', true, NULL, true, 0, 34, NULL, 'Page View ID', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":4},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":36.0}}}', 2, 'bpchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (917, '2018-10-31 15:55:19.413+00', '2018-10-31 15:55:22.22+00', 'relative_hmin', 'type/Float', 'type/Category', true, NULL, true, 0, 34, NULL, 'Relative Hm In', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Number":{"min":0.0,"max":0.0,"avg":0.0}}}', 2, 'float8', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (916, '2018-10-31 15:55:19.412+00', '2018-10-31 15:55:22.222+00', 'hmax', 'type/Integer', 'type/Category', true, NULL, true, 0, 34, NULL, 'Hm A X', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Number":{"min":0,"max":0,"avg":0.0}}}', 2, 'int4', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (972, '2018-10-31 15:55:19.604+00', '2018-10-31 15:55:22.291+00', 'refr_urlpath', 'type/Text', 'type/Category', true, NULL, true, 0, 37, NULL, 'Re Fr URL Path', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":10.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (969, '2018-10-31 15:55:19.603+00', '2018-10-31 15:55:22.293+00', 'refr_urlport', 'type/Integer', 'type/Category', true, NULL, true, 0, 37, NULL, 'Re Fr URL Port', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Number":{"min":8080,"max":8080,"avg":8080.0}}}', 2, 'int4', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (630, '2018-10-31 15:55:18.301+00', '2018-10-31 15:55:21.737+00', 'name', 'type/Text', 'type/Name', true, NULL, true, 0, 23, NULL, 'Name', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":17},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":22.058823529411764}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (688, '2018-10-31 15:55:18.325+00', '2018-10-31 15:55:21.823+00', 'page_url', 'type/Text', 'type/URL', true, NULL, true, 0, 24, NULL, 'Page URL', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":17.0}}}', 2, 'text', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (708, '2018-10-31 15:55:18.329+00', '2018-10-31 15:55:21.858+00', 'request_time_in_ms', 'type/BigInteger', 'type/Category', true, NULL, true, 0, 24, NULL, 'Request Time In Ms', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Number":{"min":0,"max":0,"avg":0.0}}}', 2, 'int8', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (710, '2018-10-31 15:55:18.329+00', '2018-10-31 15:55:21.861+00', 'user_custom_id', 'type/Text', 'type/Category', true, NULL, true, 0, 24, NULL, 'User Custom ID', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":7.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (718, '2018-10-31 15:55:18.33+00', '2018-10-31 15:55:21.865+00', 'referer_url_scheme', 'type/Text', 'type/Category', true, NULL, true, 0, 24, NULL, 'Refer Er URL Scheme', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":4.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (720, '2018-10-31 15:55:18.33+00', '2018-10-31 15:55:21.867+00', 'page_view_year', 'type/Integer', 'type/Category', true, NULL, true, 0, 24, NULL, 'Page View Year', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Number":{"min":2018,"max":2018,"avg":2018.0}}}', 2, 'int4', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (722, '2018-10-31 15:55:18.331+00', '2018-10-31 15:55:21.869+00', 'processing_time_in_ms', 'type/BigInteger', 'type/Category', true, NULL, true, 0, 24, NULL, 'Processing Time In Ms', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":2},"type":{"type/Number":{"min":88,"max":94,"avg":91.0}}}', 2, 'int8', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (725, '2018-10-31 15:55:18.331+00', '2018-10-31 15:55:21.871+00', 'dom_interactive_to_complete_time_in_ms', 'type/BigInteger', 'type/Category', true, NULL, true, 0, 24, NULL, 'Dom Interactive To Complete Time In Ms', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":2},"type":{"type/Number":{"min":64,"max":69,"avg":66.5}}}', 2, 'int8', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (729, '2018-10-31 15:55:18.332+00', '2018-10-31 15:55:21.873+00', 'total_time_in_ms', 'type/BigInteger', 'type/Income', true, NULL, true, 0, 24, NULL, 'Total Time In Ms', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":2},"type":{"type/Number":{"min":99,"max":115,"avg":107.0}}}', 2, 'int8', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (730, '2018-10-31 15:55:18.332+00', '2018-10-31 15:55:21.882+00', 'page_view_date', 'type/Text', 'type/Category', true, NULL, true, 0, 24, NULL, 'Page View Date', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":10.0}}}', 2, 'text', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (731, '2018-10-31 15:55:18.332+00', '2018-10-31 15:55:21.888+00', 'page_view_local_day_of_week_index', 'type/Integer', 'type/Category', true, NULL, true, 0, 24, NULL, 'Page View Local Day Of Week Index', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Number":{"min":2,"max":2,"avg":2.0}}}', 2, 'int4', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (735, '2018-10-31 15:55:18.333+00', '2018-10-31 15:55:21.893+00', 'app_id', 'type/Text', 'type/Category', true, NULL, true, 0, 24, NULL, 'App ID', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":12.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (854, '2018-10-31 15:55:18.933+00', '2018-10-31 15:55:22.09+00', 'browser_major_version', 'type/Text', 'type/Category', true, NULL, true, 0, 30, NULL, 'Browser Major Version', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":2.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (924, '2018-10-31 15:55:19.416+00', '2018-10-31 15:55:22.212+00', 'hmin', 'type/Integer', 'type/Category', true, NULL, true, 0, 34, NULL, 'Hm In', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Number":{"min":0,"max":0,"avg":0.0}}}', 2, 'int4', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (923, '2018-10-31 15:55:19.416+00', '2018-10-31 15:55:22.214+00', 'br_viewheight', 'type/Integer', 'type/Category', true, NULL, true, 0, 34, NULL, 'Br View Height', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Number":{"min":936,"max":936,"avg":936.0}}}', 2, 'int4', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (921, '2018-10-31 15:55:19.415+00', '2018-10-31 15:55:22.216+00', 'vmin', 'type/Integer', 'type/Category', true, NULL, true, 0, 34, NULL, 'Vm In', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Number":{"min":0,"max":0,"avg":0.0}}}', 2, 'int4', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (984, '2018-10-31 15:55:19.609+00', '2018-10-31 15:55:22.286+00', 'useragent', 'type/Text', 'type/Category', true, NULL, false, 0, 37, NULL, 'User Agent', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":76.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (966, '2018-10-31 15:55:19.602+00', '2018-10-31 15:55:22.297+00', 'name_tracker', 'type/Text', 'type/Category', true, NULL, true, 0, 37, NULL, 'Name Tracker', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":2.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (961, '2018-10-31 15:55:19.6+00', '2018-10-31 15:55:22.299+00', 'page_view_id', 'type/Text', 'type/Category', true, NULL, true, 0, 37, NULL, 'Page View ID', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":3},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":36.0}}}', 2, 'bpchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (958, '2018-10-31 15:55:19.6+00', '2018-10-31 15:55:22.3+00', 'user_id', 'type/Text', 'type/Category', true, NULL, true, 0, 37, NULL, 'User ID', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":7.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (952, '2018-10-31 15:55:19.598+00', '2018-10-31 15:55:22.302+00', 'domain_sessionidx', 'type/Integer', 'type/Category', true, NULL, true, 0, 37, NULL, 'Domain Session I Dx', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Number":{"min":13,"max":13,"avg":13.0}}}', 2, 'int2', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (996, '2018-10-31 15:55:19.612+00', '2018-10-31 15:55:22.282+00', 'br_lang', 'type/Text', 'type/Category', true, NULL, true, 0, 37, NULL, 'Br Lang', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":5.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (991, '2018-10-31 15:55:19.611+00', '2018-10-31 15:55:22.284+00', 'geo_latitude', 'type/Float', 'type/Category', true, NULL, true, 0, 37, NULL, 'Geo Latitude', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Number":{"min":37.751,"max":37.751,"avg":37.751}}}', 2, 'float8', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1054, '2018-10-31 15:55:19.855+00', '2018-10-31 15:55:22.478+00', 'os_timezone', 'type/Text', 'type/Category', true, NULL, true, 0, 39, NULL, 'Os Timezone', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":13.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1052, '2018-10-31 15:55:19.855+00', '2018-10-31 15:55:22.48+00', 'pp_yoffset_min', 'type/Integer', 'type/Category', true, NULL, true, 0, 39, NULL, 'Pp Y Offset Min', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Number":{"min":0,"max":0,"avg":0.0}}}', 2, 'int4', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1050, '2018-10-31 15:55:19.855+00', '2018-10-31 15:55:22.482+00', 'event', 'type/Text', 'type/Category', true, NULL, true, 0, 39, NULL, 'Event', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":6},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":9.125}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1043, '2018-10-31 15:55:19.853+00', '2018-10-31 15:55:22.484+00', 'ti_name', 'type/Text', 'type/Category', true, NULL, true, 0, 39, NULL, 'Ti Name', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":9.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1045, '2018-10-31 15:55:19.854+00', '2018-10-31 15:55:21.635+00', 'derived_tstamp', 'type/DateTime', NULL, true, NULL, true, 0, 39, NULL, 'Derived Ts Tamp', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/DateTime":{"earliest":"2018-10-31T00:00:00.000Z","latest":"2018-10-31T00:00:00.000Z"}}}', 2, 'timestamp', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1032, '2018-10-31 15:55:19.851+00', '2018-10-31 15:55:22.496+00', 'user_id', 'type/Text', 'type/Category', true, NULL, true, 0, 39, NULL, 'User ID', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":7.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1022, '2018-10-31 15:55:19.85+00', '2018-10-31 15:55:22.498+00', 'ti_quantity', 'type/Integer', 'type/Quantity', true, NULL, true, 0, 39, NULL, 'Ti Quantity', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Number":{"min":1,"max":1,"avg":1.0}}}', 2, 'int4', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1020, '2018-10-31 15:55:19.849+00', '2018-10-31 15:55:22.5+00', 'domain_sessionidx', 'type/Integer', 'type/Category', true, NULL, true, 0, 39, NULL, 'Domain Session I Dx', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":2},"type":{"type/Number":{"min":2,"max":13,"avg":10.9375}}}', 2, 'int2', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1120, '2018-10-31 15:55:19.866+00', '2018-10-31 15:55:21.508+00', 'dvce_sent_tstamp', 'type/DateTime', NULL, true, NULL, true, 0, 39, NULL, 'Dv Ce Sent Ts Tamp', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/DateTime":{"earliest":"2018-10-31T00:00:00.000Z","latest":"2018-10-31T00:00:00.000Z"}}}', 2, 'timestamp', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1117, '2018-10-31 15:55:19.865+00', '2018-10-31 15:55:22.424+00', 'pp_xoffset_min', 'type/Integer', 'type/Category', true, NULL, true, 0, 39, NULL, 'Pp X Offset Min', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Number":{"min":0,"max":0,"avg":0.0}}}', 2, 'int4', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1116, '2018-10-31 15:55:19.865+00', '2018-10-31 15:55:22.426+00', 'event_vendor', 'type/Text', 'type/Company', true, NULL, true, 0, 39, NULL, 'Event Vendor', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":2},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":29.375}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1115, '2018-10-31 15:55:19.865+00', '2018-10-31 15:55:22.428+00', 'v_tracker', 'type/Text', 'type/Category', true, NULL, true, 0, 39, NULL, 'V Tracker', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":17.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1114, '2018-10-31 15:55:19.865+00', '2018-10-31 15:55:22.43+00', 'pp_yoffset_max', 'type/Integer', 'type/Category', true, NULL, true, 0, 39, NULL, 'Pp Y Offset Max', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Number":{"min":0,"max":0,"avg":0.0}}}', 2, 'int4', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1112, '2018-10-31 15:55:19.864+00', '2018-10-31 15:55:22.432+00', 'br_features_gears', 'type/Boolean', 'type/Category', true, NULL, true, 0, 39, NULL, 'Br Features Gears', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1}}', 2, 'bool', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1111, '2018-10-31 15:55:19.864+00', '2018-10-31 15:55:22.434+00', 'doc_width', 'type/Integer', 'type/Category', true, NULL, true, 0, 39, NULL, 'Doc Width', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Number":{"min":1920,"max":1920,"avg":1920.0}}}', 2, 'int4', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1107, '2018-10-31 15:55:19.864+00', '2018-10-31 15:55:22.438+00', 'event_format', 'type/Text', 'type/Category', true, NULL, true, 0, 39, NULL, 'Event Format', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":10.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1106, '2018-10-31 15:55:19.864+00', '2018-10-31 15:55:22.44+00', 'dvce_screenwidth', 'type/Integer', 'type/Category', true, NULL, true, 0, 39, NULL, 'Dv Ce Screen Width', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Number":{"min":1920,"max":1920,"avg":1920.0}}}', 2, 'int4', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1105, '2018-10-31 15:55:19.863+00', '2018-10-31 15:55:22.443+00', 'geo_latitude', 'type/Float', 'type/Category', true, NULL, true, 0, 39, NULL, 'Geo Latitude', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Number":{"min":37.751,"max":37.751,"avg":37.75099999999999}}}', 2, 'float8', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1072, '2018-10-31 15:55:19.858+00', '2018-10-31 15:55:22.464+00', 'br_features_quicktime', 'type/Boolean', 'type/Category', true, NULL, true, 0, 39, NULL, 'Br Features Quicktime', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1}}', 2, 'bool', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1066, '2018-10-31 15:55:19.857+00', '2018-10-31 15:55:22.466+00', 'tr_currency', 'type/Text', 'type/Category', true, NULL, true, 0, 39, NULL, 'Tr Currency', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":3.0}}}', 2, 'bpchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1065, '2018-10-31 15:55:19.857+00', '2018-10-31 15:55:22.468+00', 'refr_urlpath', 'type/Text', 'type/Category', true, NULL, true, 0, 39, NULL, 'Re Fr URL Path', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":10.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1069, '2018-10-31 15:55:19.858+00', '2018-10-31 15:55:21.585+00', 'event_id', 'type/Text', 'type/PK', true, NULL, true, 0, 39, NULL, 'Event ID', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":16},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":36.0}}}', 2, 'bpchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1063, '2018-10-31 15:55:19.857+00', '2018-10-31 15:55:22.469+00', 'br_features_java', 'type/Boolean', 'type/Category', true, NULL, true, 0, 39, NULL, 'Br Features Java', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1}}', 2, 'bool', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1039, '2018-10-31 15:55:19.853+00', '2018-10-31 15:55:22.488+00', 'br_features_director', 'type/Boolean', 'type/Category', true, NULL, true, 0, 39, NULL, 'Br Features Director', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1}}', 2, 'bool', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1038, '2018-10-31 15:55:19.853+00', '2018-10-31 15:55:22.49+00', 'br_viewwidth', 'type/Integer', 'type/Category', true, NULL, true, 0, 39, NULL, 'Br View Width', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Number":{"min":1920,"max":1920,"avg":1920.0}}}', 2, 'int4', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1036, '2018-10-31 15:55:19.852+00', '2018-10-31 15:55:22.492+00', 'ti_price', 'type/Decimal', 'type/Category', true, NULL, true, 0, 39, NULL, 'Ti Price', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Number":{"min":4000.00,"max":4000.00,"avg":4000.0}}}', 2, 'numeric', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1035, '2018-10-31 15:55:19.852+00', '2018-10-31 15:55:22.494+00', 'br_features_windowsmedia', 'type/Boolean', 'type/Category', true, NULL, true, 0, 39, NULL, 'Br Features Windows Media', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1}}', 2, 'bool', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1132, '2018-10-31 15:55:19.868+00', '2018-10-31 15:55:22.393+00', 'dvce_screenheight', 'type/Integer', 'type/Category', true, NULL, true, 0, 39, NULL, 'Dv Ce Screen Height', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Number":{"min":1080,"max":1080,"avg":1080.0}}}', 2, 'int4', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1130, '2018-10-31 15:55:19.867+00', '2018-10-31 15:55:22.396+00', 'doc_height', 'type/Integer', 'type/Category', true, NULL, true, 0, 39, NULL, 'Doc Height', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":2},"type":{"type/Number":{"min":918,"max":936,"avg":932.625}}}', 2, 'int4', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1125, '2018-10-31 15:55:19.867+00', '2018-10-31 15:55:22.408+00', 'doc_charset', 'type/Text', 'type/Category', true, NULL, true, 0, 39, NULL, 'Doc Char Set', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":5.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1099, '2018-10-31 15:55:19.863+00', '2018-10-31 15:55:22.445+00', 'refr_urlhost', 'type/Text', 'type/Category', true, NULL, true, 0, 39, NULL, 'Re Fr URL Host', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":7.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1097, '2018-10-31 15:55:19.862+00', '2018-10-31 15:55:22.447+00', 'dvce_created_tstamp', 'type/DateTime', 'type/CreationTimestamp', true, NULL, true, 0, 39, NULL, 'Dv Ce Created Ts Tamp', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/DateTime":{"earliest":"2018-10-31T00:00:00.000Z","latest":"2018-10-31T00:00:00.000Z"}}}', 2, 'timestamp', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1089, '2018-10-31 15:55:19.861+00', '2018-10-31 15:55:22.451+00', 'useragent', 'type/Text', 'type/Category', true, NULL, false, 0, 39, NULL, 'User Agent', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":2},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":81.25}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1085, '2018-10-31 15:55:19.86+00', '2018-10-31 15:55:22.453+00', 'br_viewheight', 'type/Integer', 'type/Category', true, NULL, true, 0, 39, NULL, 'Br View Height', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":2},"type":{"type/Number":{"min":918,"max":936,"avg":932.625}}}', 2, 'int4', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1082, '2018-10-31 15:55:19.86+00', '2018-10-31 15:55:22.455+00', 'domain_sessionid', 'type/Text', 'type/Category', true, NULL, true, 0, 39, NULL, 'Domain Session ID', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":2},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":36.0}}}', 2, 'bpchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1080, '2018-10-31 15:55:19.86+00', '2018-10-31 15:55:22.457+00', 'refr_urlscheme', 'type/Text', 'type/Category', true, NULL, true, 0, 39, NULL, 'Re Fr URL Scheme', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":4.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1076, '2018-10-31 15:55:19.859+00', '2018-10-31 15:55:22.459+00', 'page_url', 'type/Text', 'type/URL', true, NULL, false, 0, 39, NULL, 'Page URL', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":1.0,"percent-email":0.0,"average-length":57.0}}}', 2, 'text', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1075, '2018-10-31 15:55:19.859+00', '2018-10-31 15:55:22.462+00', 'page_urlport', 'type/Integer', 'type/Category', true, NULL, true, 0, 39, NULL, 'Page URL Port', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Number":{"min":8080,"max":8080,"avg":8080.0}}}', 2, 'int4', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1058, '2018-10-31 15:55:19.856+00', '2018-10-31 15:55:22.474+00', 'refr_urlport', 'type/Integer', 'type/Category', true, NULL, true, 0, 39, NULL, 'Re Fr URL Port', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Number":{"min":8080,"max":8080,"avg":8080.0}}}', 2, 'int4', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1137, '2018-10-31 15:55:19.868+00', '2018-10-31 15:55:22.378+00', 'br_features_flash', 'type/Boolean', 'type/Category', true, NULL, true, 0, 39, NULL, 'Br Features Flash', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":2}}', 2, 'bool', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (752, '2018-10-31 15:55:18.614+00', '2018-10-31 15:55:20.941+00', 'root_id', 'type/Text', 'type/FK', true, NULL, true, 0, 25, NULL, 'Root ID', 'normal', 1069, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":16},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":36.0}}}', 2, 'bpchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (612, '2018-10-31 15:55:18.252+00', '2018-10-31 15:55:21.698+00', 'page_view_id', 'type/Text', 'type/Category', true, NULL, true, 0, 42, NULL, 'Page View ID', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":4},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":36.0}}}', 2, 'bpchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (614, '2018-10-31 15:55:18.252+00', '2018-10-31 15:55:21.7+00', 'app_cache_time_in_ms', 'type/BigInteger', 'type/Category', true, NULL, true, 0, 42, NULL, 'App Cache Time In Ms', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":3},"type":{"type/Number":{"min":0,"max":10,"avg":4.25}}}', 2, 'int8', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (616, '2018-10-31 15:55:18.253+00', '2018-10-31 15:55:21.702+00', 'unload_time_in_ms', 'type/BigInteger', 'type/Category', true, NULL, true, 0, 42, NULL, 'Unload Time In Ms', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":2},"type":{"type/Number":{"min":0,"max":1,"avg":0.5}}}', 2, 'int8', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (627, '2018-10-31 15:55:18.283+00', '2018-10-31 15:55:21.73+00', 'pv_count', 'type/BigInteger', 'type/Quantity', true, NULL, true, 0, 22, NULL, 'Pv Count', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":2},"type":{"type/Number":{"min":0,"max":1,"avg":0.75}}}', 2, 'int8', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (821, '2018-10-31 15:55:18.921+00', '2018-10-31 15:55:22.044+00', 'geo_longitude', 'type/Float', 'type/Longitude', true, NULL, true, 0, 30, NULL, 'Geo Longitude', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Number":{"min":-97.822,"max":-97.822,"avg":-97.822}}}', 2, 'float8', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (824, '2018-10-31 15:55:18.923+00', '2018-10-31 15:55:22.046+00', 'session_local_hour_of_day', 'type/Integer', 'type/Category', true, NULL, true, 0, 30, NULL, 'Session Local Hour Of Day', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Number":{"min":14,"max":14,"avg":14.0}}}', 2, 'int4', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (826, '2018-10-31 15:55:18.924+00', '2018-10-31 15:55:22.048+00', 'browser_minor_version', 'type/Text', 'type/Category', true, NULL, true, 0, 30, NULL, 'Browser Minor Version', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":1.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (830, '2018-10-31 15:55:18.925+00', '2018-10-31 15:55:22.05+00', 'first_page_url_query', 'type/Text', 'type/Category', true, NULL, true, 0, 30, NULL, 'First Page URL Query', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":27.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (833, '2018-10-31 15:55:18.926+00', '2018-10-31 15:55:22.052+00', 'first_page_url_scheme', 'type/Text', 'type/Category', true, NULL, true, 0, 30, NULL, 'First Page URL Scheme', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":4.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (835, '2018-10-31 15:55:18.927+00', '2018-10-31 15:55:22.054+00', 'browser_language', 'type/Text', 'type/Category', true, NULL, true, 0, 30, NULL, 'Browser Language', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":5.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (837, '2018-10-31 15:55:18.928+00', '2018-10-31 15:55:22.056+00', 'session_local_time', 'type/Text', 'type/Category', true, NULL, true, 0, 30, NULL, 'Session Local Time', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":19.0}}}', 2, 'text', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (652, '2018-10-31 15:55:18.319+00', '2018-10-31 15:55:20.896+00', 'page_view_start_local', 'type/DateTime', NULL, true, NULL, true, 0, 24, NULL, 'Page View Start Local', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/DateTime":{"earliest":"2018-10-31T00:00:00.000Z","latest":"2018-10-31T00:00:00.000Z"}}}', 2, 'timestamp', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (759, '2018-10-31 15:55:18.696+00', '2018-10-31 15:55:20.977+00', 'id', 'type/Text', 'type/PK', true, NULL, true, 0, 26, NULL, 'ID', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":2},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":36.0}}}', 2, 'varchar', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (847, '2018-10-31 15:55:18.931+00', '2018-10-31 15:55:21.102+00', 'session_end_local', 'type/DateTime', NULL, true, NULL, true, 0, 30, NULL, 'Session End Local', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/DateTime":{"earliest":"2018-10-31T00:00:00.000Z","latest":"2018-10-31T00:00:00.000Z"}}}', 2, 'timestamp', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (640, '2018-10-31 15:55:18.317+00', '2018-10-31 15:55:21.748+00', 'dom_loading_to_interactive_time_in_ms', 'type/BigInteger', 'type/Category', true, NULL, true, 0, 24, NULL, 'Dom Loading To Interactive Time In Ms', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":3},"type":{"type/Number":{"min":24,"max":26,"avg":25.0}}}', 2, 'int8', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (642, '2018-10-31 15:55:18.318+00', '2018-10-31 15:55:21.751+00', 'time_engaged_in_s', 'type/BigInteger', 'type/Category', true, NULL, true, 0, 24, NULL, 'Time Engaged In S', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":2},"type":{"type/Number":{"min":0,"max":10,"avg":6.666666666666667}}}', 2, 'int8', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (646, '2018-10-31 15:55:18.318+00', '2018-10-31 15:55:21.753+00', 'os_name', 'type/Text', 'type/Category', true, NULL, true, 0, 24, NULL, 'Os Name', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":6.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (648, '2018-10-31 15:55:18.319+00', '2018-10-31 15:55:21.755+00', 'time_engaged_in_s_tier', 'type/Text', 'type/Category', true, NULL, true, 0, 24, NULL, 'Time Engaged In S Tier', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":2},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":9.333333333333334}}}', 2, 'text', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (657, '2018-10-31 15:55:18.32+00', '2018-10-31 15:55:21.757+00', 'dns_time_in_ms', 'type/BigInteger', 'type/Category', true, NULL, true, 0, 24, NULL, 'Dns Time In Ms', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Number":{"min":0,"max":0,"avg":0.0}}}', 2, 'int8', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (663, '2018-10-31 15:55:18.321+00', '2018-10-31 15:55:21.766+00', 'page_view_local_time', 'type/Text', 'type/Category', true, NULL, true, 0, 24, NULL, 'Page View Local Time', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":3},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":19.0}}}', 2, 'text', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (664, '2018-10-31 15:55:18.321+00', '2018-10-31 15:55:21.771+00', 'page_view_hour', 'type/Text', 'type/Category', true, NULL, true, 0, 24, NULL, 'Page View Hour', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":13.0}}}', 2, 'text', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (669, '2018-10-31 15:55:18.322+00', '2018-10-31 15:55:21.777+00', 'vertical_percentage_scrolled', 'type/Float', 'type/Share', true, NULL, true, 0, 24, NULL, 'Vertical Percentage Scrolled', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Number":{"min":100.0,"max":100.0,"avg":100.0}}}', 2, 'float8', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (673, '2018-10-31 15:55:18.323+00', '2018-10-31 15:55:21.797+00', 'tcp_time_in_ms', 'type/BigInteger', 'type/Category', true, NULL, true, 0, 24, NULL, 'Tcp Time In Ms', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":2},"type":{"type/Number":{"min":0,"max":1,"avg":0.3333333333333333}}}', 2, 'int8', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (681, '2018-10-31 15:55:18.324+00', '2018-10-31 15:55:21.814+00', 'horizontal_percentage_scrolled', 'type/Float', 'type/Share', true, NULL, true, 0, 24, NULL, 'Horizontal Percentage Scrolled', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Number":{"min":100.0,"max":100.0,"avg":100.0}}}', 2, 'float8', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (684, '2018-10-31 15:55:18.325+00', '2018-10-31 15:55:21.818+00', 'user_engaged', 'type/Boolean', 'type/Category', true, NULL, true, 0, 24, NULL, 'User Engaged', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1}}', 2, 'bool', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (691, '2018-10-31 15:55:18.326+00', '2018-10-31 15:55:21.825+00', 'page_view_month', 'type/Text', 'type/Category', true, NULL, true, 0, 24, NULL, 'Page View Month', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":7.0}}}', 2, 'text', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (694, '2018-10-31 15:55:18.326+00', '2018-10-31 15:55:21.827+00', 'vertical_percentage_scrolled_tier', 'type/Text', 'type/Category', true, NULL, true, 0, 24, NULL, 'Vertical Percentage Scrolled Tier', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":11.0}}}', 2, 'text', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (696, '2018-10-31 15:55:18.327+00', '2018-10-31 15:55:21.836+00', 'page_view_local_hour_of_day', 'type/Integer', 'type/Category', true, NULL, true, 0, 24, NULL, 'Page View Local Hour Of Day', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Number":{"min":14,"max":14,"avg":14.0}}}', 2, 'int4', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (702, '2018-10-31 15:55:18.328+00', '2018-10-31 15:55:21.842+00', 'page_url_query', 'type/Text', 'type/Category', true, NULL, true, 0, 24, NULL, 'Page URL Query', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":27.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (704, '2018-10-31 15:55:18.328+00', '2018-10-31 15:55:21.847+00', 'geo_latitude', 'type/Float', 'type/Category', true, NULL, true, 0, 24, NULL, 'Geo Latitude', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Number":{"min":37.751,"max":37.751,"avg":37.751}}}', 2, 'float8', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (706, '2018-10-31 15:55:18.328+00', '2018-10-31 15:55:21.853+00', 'referer_url_host', 'type/Text', 'type/Category', true, NULL, true, 0, 24, NULL, 'Refer Er URL Host', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":7.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (742, '2018-10-31 15:55:18.609+00', '2018-10-31 15:55:21.978+00', 'useragent_family', 'type/Text', 'type/Category', true, NULL, true, 0, 25, NULL, 'User Agent Family', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":2},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":6.8125}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (743, '2018-10-31 15:55:18.61+00', '2018-10-31 15:55:21.98+00', 'useragent_minor', 'type/Text', 'type/Category', true, NULL, true, 0, 25, NULL, 'User Agent Minor', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":1.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (747, '2018-10-31 15:55:18.611+00', '2018-10-31 15:55:21.983+00', 'os_family', 'type/Text', 'type/Category', true, NULL, true, 0, 25, NULL, 'Os Family', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":2},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":5.8125}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (751, '2018-10-31 15:55:18.613+00', '2018-10-31 15:55:21.984+00', 'useragent_major', 'type/Text', 'type/Category', true, NULL, true, 0, 25, NULL, 'User Agent Major', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":2},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":2.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (760, '2018-10-31 15:55:18.696+00', '2018-10-31 15:55:21.994+00', 'parameters', 'type/Text', 'type/Category', true, NULL, false, 0, 26, NULL, 'Parameters', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":2},"type":{"type/Text":{"percent-json":1.0,"percent-url":0.0,"percent-email":0.0,"average-length":606.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (842, '2018-10-31 15:55:18.929+00', '2018-10-31 15:55:22.06+00', 'bounced_page_views', 'type/BigInteger', 'type/Category', true, NULL, true, 0, 30, NULL, 'Bounced Page Views', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Number":{"min":1,"max":1,"avg":1.0}}}', 2, 'int8', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (679, '2018-10-31 15:55:18.324+00', '2018-10-31 15:55:21.807+00', 'page_view_in_session_index', 'type/BigInteger', 'type/Category', true, NULL, true, 0, 24, NULL, 'Page View In Session Index', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":3},"type":{"type/Number":{"min":1,"max":3,"avg":2.0}}}', 2, 'int8', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (685, '2018-10-31 15:55:18.325+00', '2018-10-31 15:55:21.821+00', 'session_id', 'type/Text', 'type/Category', true, NULL, true, 0, 24, NULL, 'Session ID', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":36.0}}}', 2, 'bpchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (769, '2018-10-31 15:55:18.751+00', '2018-10-31 15:55:22.002+00', 'useragent_family', 'type/Text', 'type/Category', true, NULL, true, 0, 27, NULL, 'User Agent Family', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":7.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (772, '2018-10-31 15:55:18.752+00', '2018-10-31 15:55:22.004+00', 'device_family', 'type/Text', 'type/Category', true, NULL, true, 0, 27, NULL, 'Device Family', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":5.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (779, '2018-10-31 15:55:18.756+00', '2018-10-31 15:55:22.007+00', 'useragent_version', 'type/Text', 'type/Category', true, NULL, true, 0, 27, NULL, 'User Agent Version', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":12.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (791, '2018-10-31 15:55:18.864+00', '2018-10-31 15:55:22.021+00', 'root_id', 'type/Text', 'type/Category', true, NULL, true, 0, 29, NULL, 'Root ID', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":13},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":36.0}}}', 2, 'bpchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (839, '2018-10-31 15:55:18.928+00', '2018-10-31 15:55:22.058+00', 'session_local_day_of_week', 'type/Text', 'type/Category', true, NULL, true, 0, 30, NULL, 'Session Local Day Of Week', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":1.0}}}', 2, 'text', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (849, '2018-10-31 15:55:18.931+00', '2018-10-31 15:55:22.062+00', 'referer_url_host', 'type/Text', 'type/Category', true, NULL, true, 0, 30, NULL, 'Refer Er URL Host', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":7.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (852, '2018-10-31 15:55:18.932+00', '2018-10-31 15:55:22.064+00', 'user_custom_id', 'type/Text', 'type/Category', true, NULL, true, 0, 30, NULL, 'User Custom ID', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":7.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (853, '2018-10-31 15:55:18.932+00', '2018-10-31 15:55:22.066+00', 'ip_address', 'type/Text', 'type/Category', true, NULL, true, 0, 30, NULL, 'IP Address', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":12.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (858, '2018-10-31 15:55:18.934+00', '2018-10-31 15:55:22.068+00', 'user_snowplow_domain_id', 'type/Text', 'type/Category', true, NULL, true, 0, 30, NULL, 'User Snowplow Domain ID', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":36.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (861, '2018-10-31 15:55:18.934+00', '2018-10-31 15:55:22.07+00', 'session_week', 'type/Text', 'type/Category', true, NULL, true, 0, 30, NULL, 'Session Week', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":10.0}}}', 2, 'text', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (863, '2018-10-31 15:55:18.935+00', '2018-10-31 15:55:22.072+00', 'page_views', 'type/BigInteger', 'type/Category', true, NULL, true, 0, 30, NULL, 'Page Views', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Number":{"min":3,"max":3,"avg":3.0}}}', 2, 'int8', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (869, '2018-10-31 15:55:18.936+00', '2018-10-31 15:55:22.075+00', 'session_hour', 'type/Text', 'type/Category', true, NULL, true, 0, 30, NULL, 'Session Hour', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":13.0}}}', 2, 'text', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (872, '2018-10-31 15:55:18.937+00', '2018-10-31 15:55:22.078+00', 'engaged_page_views', 'type/BigInteger', 'type/Category', true, NULL, true, 0, 30, NULL, 'Engaged Page Views', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Number":{"min":0,"max":0,"avg":0.0}}}', 2, 'int8', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (879, '2018-10-31 15:55:19.23+00', '2018-10-31 15:55:22.152+00', 'connect_start', 'type/BigInteger', 'type/Category', true, NULL, true, 0, 32, NULL, 'Connect Start', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":4},"type":{"type/Number":{"min":1540993926624,"max":1540994443940,"avg":1.5409943931377693E12}}}', 2, 'int8', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (882, '2018-10-31 15:55:19.231+00', '2018-10-31 15:55:22.154+00', 'dom_content_loaded_event_end', 'type/BigInteger', 'type/Category', true, NULL, true, 0, 32, NULL, 'Dom Content Loaded Event End', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":4},"type":{"type/Number":{"min":1540993926677,"max":1540994443976,"avg":1.5409943931828462E12}}}', 2, 'int8', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (884, '2018-10-31 15:55:19.232+00', '2018-10-31 15:55:22.156+00', 'unload_event_start', 'type/BigInteger', 'type/Category', true, NULL, true, 0, 32, NULL, 'Unload Event Start', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":4},"type":{"type/Number":{"min":1540993926639,"max":1540994443949,"avg":1.5409943931526155E12}}}', 2, 'int8', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (888, '2018-10-31 15:55:19.233+00', '2018-10-31 15:55:22.158+00', 'domain_lookup_start', 'type/BigInteger', 'type/Category', true, NULL, true, 0, 32, NULL, 'Domain Lookup Start', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":4},"type":{"type/Number":{"min":1540993926624,"max":1540994443940,"avg":1.5409943931377693E12}}}', 2, 'int8', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (890, '2018-10-31 15:55:19.234+00', '2018-10-31 15:55:22.16+00', 'response_start', 'type/BigInteger', 'type/Category', true, NULL, true, 0, 32, NULL, 'Response Start', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":4},"type":{"type/Number":{"min":1540993926632,"max":1540994443945,"avg":1.5409943931475386E12}}}', 2, 'int8', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (918, '2018-10-31 15:55:19.414+00', '2018-10-31 15:55:22.2+00', 'relative_hmax', 'type/Float', 'type/Category', true, NULL, true, 0, 34, NULL, 'Relative Hm A X', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Number":{"min":100.0,"max":100.0,"avg":100.0}}}', 2, 'float8', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (920, '2018-10-31 15:55:19.414+00', '2018-10-31 15:55:22.202+00', 'br_viewwidth', 'type/Integer', 'type/Category', true, NULL, true, 0, 34, NULL, 'Br View Width', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Number":{"min":1920,"max":1920,"avg":1920.0}}}', 2, 'int4', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (922, '2018-10-31 15:55:19.415+00', '2018-10-31 15:55:22.204+00', 'relative_vmin', 'type/Float', 'type/Category', true, NULL, true, 0, 34, NULL, 'Relative Vm In', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Number":{"min":0.0,"max":0.0,"avg":0.0}}}', 2, 'float8', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (925, '2018-10-31 15:55:19.417+00', '2018-10-31 15:55:22.206+00', 'doc_width', 'type/Integer', 'type/Category', true, NULL, true, 0, 34, NULL, 'Doc Width', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Number":{"min":1920,"max":1920,"avg":1920.0}}}', 2, 'int4', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (927, '2018-10-31 15:55:19.417+00', '2018-10-31 15:55:22.208+00', 'doc_height', 'type/Integer', 'type/Category', true, NULL, true, 0, 34, NULL, 'Doc Height', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Number":{"min":936,"max":936,"avg":936.0}}}', 2, 'int4', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (796, '2018-10-31 15:55:18.908+00', '2018-10-31 15:55:22.029+00', 'device', 'type/Text', 'type/Category', true, NULL, true, 0, 30, NULL, 'Device', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":5.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (799, '2018-10-31 15:55:18.909+00', '2018-10-31 15:55:22.031+00', 'first_page_url_host', 'type/Text', 'type/Category', true, NULL, true, 0, 30, NULL, 'First Page URL Host', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":7.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (804, '2018-10-31 15:55:18.912+00', '2018-10-31 15:55:22.033+00', 'time_engaged_in_s_tier', 'type/Text', 'type/Category', true, NULL, true, 0, 30, NULL, 'Time Engaged In S Tier', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":10.0}}}', 2, 'text', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (806, '2018-10-31 15:55:18.913+00', '2018-10-31 15:55:22.035+00', 'browser', 'type/Text', 'type/Category', true, NULL, true, 0, 30, NULL, 'Browser', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":12.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (814, '2018-10-31 15:55:18.917+00', '2018-10-31 15:55:22.039+00', 'referer_url_port', 'type/Integer', 'type/Category', true, NULL, true, 0, 30, NULL, 'Refer Er URL Port', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Number":{"min":8080,"max":8080,"avg":8080.0}}}', 2, 'int4', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (820, '2018-10-31 15:55:18.921+00', '2018-10-31 15:55:22.041+00', 'user_snowplow_crossdomain_id', 'type/Text', 'type/Category', true, NULL, true, 0, 30, NULL, 'User Snowplow Cross Domain ID', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":36.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (892, '2018-10-31 15:55:19.235+00', '2018-10-31 15:55:22.162+00', 'connect_end', 'type/BigInteger', 'type/Category', true, NULL, true, 0, 32, NULL, 'Connect End', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":4},"type":{"type/Number":{"min":1540993926624,"max":1540994443940,"avg":1.5409943931378462E12}}}', 2, 'int8', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (908, '2018-10-31 15:55:19.241+00', '2018-10-31 15:55:22.17+00', 'dom_interactive', 'type/BigInteger', 'type/Category', true, NULL, true, 0, 32, NULL, 'Dom Interactive', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":4},"type":{"type/Number":{"min":1540993926671,"max":1540994443973,"avg":1.540994393178077E12}}}', 2, 'int8', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (910, '2018-10-31 15:55:19.241+00', '2018-10-31 15:55:22.172+00', 'fetch_start', 'type/BigInteger', 'type/Category', true, NULL, true, 0, 32, NULL, 'Fetch Start', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":4},"type":{"type/Number":{"min":1540993926617,"max":1540994443940,"avg":1.5409943931364614E12}}}', 2, 'int8', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (955, '2018-10-31 15:55:19.599+00', '2018-10-31 15:55:22.228+00', 'page_title', 'type/Text', 'type/Title', true, NULL, true, 0, 37, NULL, 'Page Title', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":12.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (963, '2018-10-31 15:55:19.601+00', '2018-10-31 15:55:22.233+00', 'page_urlquery', 'type/Text', 'type/Category', true, NULL, true, 0, 37, NULL, 'Page URL Query', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":27.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (965, '2018-10-31 15:55:19.602+00', '2018-10-31 15:55:22.239+00', 'os_timezone', 'type/Text', 'type/Category', true, NULL, true, 0, 37, NULL, 'Os Timezone', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":13.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (967, '2018-10-31 15:55:19.603+00', '2018-10-31 15:55:22.242+00', 'geo_longitude', 'type/Float', 'type/Longitude', true, NULL, true, 0, 37, NULL, 'Geo Longitude', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Number":{"min":-97.822,"max":-97.822,"avg":-97.822}}}', 2, 'float8', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (976, '2018-10-31 15:55:19.606+00', '2018-10-31 15:55:22.247+00', 'refr_medium', 'type/Text', 'type/Category', true, NULL, true, 0, 37, NULL, 'Re Fr Medium', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":8.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (977, '2018-10-31 15:55:19.606+00', '2018-10-31 15:55:22.249+00', 'page_urlport', 'type/Integer', 'type/Category', true, NULL, true, 0, 37, NULL, 'Page URL Port', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Number":{"min":8080,"max":8080,"avg":8080.0}}}', 2, 'int4', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (985, '2018-10-31 15:55:19.609+00', '2018-10-31 15:55:22.254+00', 'page_urlhost', 'type/Text', 'type/Category', true, NULL, true, 0, 37, NULL, 'Page URL Host', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":7.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (988, '2018-10-31 15:55:19.61+00', '2018-10-31 15:55:22.256+00', 'dvce_created_tstamp', 'type/DateTime', 'type/CreationTimestamp', true, NULL, true, 0, 37, NULL, 'Dv Ce Created Ts Tamp', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/DateTime":{"earliest":"2018-10-31T00:00:00.000Z","latest":"2018-10-31T00:00:00.000Z"}}}', 2, 'timestamp', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (989, '2018-10-31 15:55:19.611+00', '2018-10-31 15:55:22.258+00', 'refr_urlhost', 'type/Text', 'type/Category', true, NULL, true, 0, 37, NULL, 'Re Fr URL Host', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":7.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1102, '2018-10-31 15:55:19.863+00', '2018-10-31 15:55:22.342+00', 'se_action', 'type/Text', 'type/Category', true, NULL, true, 0, 39, NULL, 'Se Action', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":4.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1126, '2018-10-31 15:55:19.867+00', '2018-10-31 15:55:22.345+00', 'domain_userid', 'type/Text', 'type/Category', true, NULL, true, 0, 39, NULL, 'Domain Use Rid', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":2},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":36.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1129, '2018-10-31 15:55:19.867+00', '2018-10-31 15:55:22.347+00', 'user_ipaddress', 'type/Text', 'type/Category', true, NULL, true, 0, 39, NULL, 'User IP Address', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":12.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1131, '2018-10-31 15:55:19.867+00', '2018-10-31 15:55:22.349+00', 'page_urlpath', 'type/Text', 'type/Category', true, NULL, true, 0, 39, NULL, 'Page URL Path', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":10.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1133, '2018-10-31 15:55:19.868+00', '2018-10-31 15:55:22.351+00', 'tr_orderid', 'type/Text', 'type/Category', true, NULL, true, 0, 39, NULL, 'Tr Order ID', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":9.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1142, '2018-10-31 15:55:19.869+00', '2018-10-31 15:55:22.353+00', 'app_id', 'type/Text', 'type/Category', true, NULL, true, 0, 39, NULL, 'App ID', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":12.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (610, '2018-10-31 15:55:18.252+00', '2018-10-31 15:55:21.725+00', 'dom_loading_to_interactive_time_in_ms', 'type/BigInteger', 'type/Category', true, NULL, true, 0, 42, NULL, 'Dom Loading To Interactive Time In Ms', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":4},"type":{"type/Number":{"min":24,"max":32,"avg":26.75}}}', 2, 'int8', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (624, '2018-10-31 15:55:18.283+00', '2018-10-31 15:55:21.728+00', 'page_view_id', 'type/Text', 'type/Category', true, NULL, true, 0, 22, NULL, 'Page View ID', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":4},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":36.0}}}', 2, 'bpchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (633, '2018-10-31 15:55:18.316+00', '2018-10-31 15:55:21.744+00', 'page_width', 'type/Integer', 'type/Category', true, NULL, true, 0, 24, NULL, 'Page Width', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Number":{"min":1920,"max":1920,"avg":1920.0}}}', 2, 'int4', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (636, '2018-10-31 15:55:18.317+00', '2018-10-31 15:55:21.746+00', 'page_view_week', 'type/Text', 'type/Category', true, NULL, true, 0, 24, NULL, 'Page View Week', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":10.0}}}', 2, 'text', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (672, '2018-10-31 15:55:18.323+00', '2018-10-31 15:55:21.789+00', 'os_timezone', 'type/Text', 'type/Category', true, NULL, true, 0, 24, NULL, 'Os Timezone', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":13.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (674, '2018-10-31 15:55:18.323+00', '2018-10-31 15:55:21.799+00', 'user_snowplow_crossdomain_id', 'type/Text', 'type/Category', true, NULL, true, 0, 24, NULL, 'User Snowplow Cross Domain ID', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":36.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (676, '2018-10-31 15:55:18.323+00', '2018-10-31 15:55:21.801+00', 'page_view_local_time_of_day', 'type/Text', 'type/Category', true, NULL, true, 0, 24, NULL, 'Page View Local Time Of Day', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":5.0}}}', 2, 'text', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (712, '2018-10-31 15:55:18.329+00', '2018-10-31 15:55:21.863+00', 'browser_major_version', 'type/Text', 'type/Category', true, NULL, true, 0, 24, NULL, 'Browser Major Version', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":2.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (732, '2018-10-31 15:55:18.333+00', '2018-10-31 15:55:21.899+00', 'response_time_in_ms', 'type/BigInteger', 'type/Category', true, NULL, true, 0, 24, NULL, 'Response Time In Ms', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Number":{"min":0,"max":0,"avg":0.0}}}', 2, 'int8', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (728, '2018-10-31 15:55:18.332+00', '2018-10-31 15:55:21.904+00', 'page_url_scheme', 'type/Text', 'type/Category', true, NULL, true, 0, 24, NULL, 'Page URL Scheme', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":4.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (690, '2018-10-31 15:55:18.326+00', '2018-10-31 15:55:21.93+00', 'referer_medium', 'type/Text', 'type/Category', true, NULL, true, 0, 24, NULL, 'Refer Er Medium', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":8.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (631, '2018-10-31 15:55:18.316+00', '2018-10-31 15:55:21.975+00', 'referer_url', 'type/Text', 'type/URL', true, NULL, true, 0, 24, NULL, 'Refer Er URL', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":17.0}}}', 2, 'text', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (777, '2018-10-31 15:55:18.754+00', '2018-10-31 15:55:22.005+00', 'os_version', 'type/Text', 'type/Category', true, NULL, true, 0, 27, NULL, 'Os Version', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":6.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (768, '2018-10-31 15:55:18.75+00', '2018-10-31 15:55:22.016+00', 'page_view_id', 'type/Text', 'type/Category', true, NULL, true, 0, 27, NULL, 'Page View ID', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":4},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":36.0}}}', 2, 'bpchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (792, '2018-10-31 15:55:18.906+00', '2018-10-31 15:55:22.027+00', 'referer_url', 'type/Text', 'type/URL', true, NULL, true, 0, 30, NULL, 'Refer Er URL', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":17.0}}}', 2, 'text', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (813, '2018-10-31 15:55:18.917+00', '2018-10-31 15:55:22.037+00', 'session_minute', 'type/Text', 'type/Category', true, NULL, true, 0, 30, NULL, 'Session Minute', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":16.0}}}', 2, 'text', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (865, '2018-10-31 15:55:18.935+00', '2018-10-31 15:55:22.074+00', 'session_local_time_of_day', 'type/Text', 'type/Category', true, NULL, true, 0, 30, NULL, 'Session Local Time Of Day', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":5.0}}}', 2, 'text', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (875, '2018-10-31 15:55:18.937+00', '2018-10-31 15:55:22.08+00', 'app_id', 'type/Text', 'type/Category', true, NULL, true, 0, 30, NULL, 'App ID', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":12.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (840, '2018-10-31 15:55:18.929+00', '2018-10-31 15:55:22.099+00', 'time_engaged_in_s', 'type/Decimal', 'type/Category', true, NULL, true, 0, 30, NULL, 'Time Engaged In S', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Number":{"min":20,"max":20,"avg":20.0}}}', 2, 'numeric', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (819, '2018-10-31 15:55:18.92+00', '2018-10-31 15:55:22.131+00', 'os_timezone', 'type/Text', 'type/Category', true, NULL, true, 0, 30, NULL, 'Os Timezone', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":13.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (994, '2018-10-31 15:55:19.612+00', '2018-10-31 15:55:22.267+00', 'n', 'type/BigInteger', 'type/Category', true, NULL, true, 0, 37, NULL, 'N', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Number":{"min":1,"max":1,"avg":1.0}}}', 2, 'int8', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (997, '2018-10-31 15:55:19.613+00', '2018-10-31 15:55:22.269+00', 'domain_userid', 'type/Text', 'type/Category', true, NULL, true, 0, 37, NULL, 'Domain Use Rid', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":36.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1000, '2018-10-31 15:55:19.613+00', '2018-10-31 15:55:22.271+00', 'page_urlpath', 'type/Text', 'type/Category', true, NULL, true, 0, 37, NULL, 'Page URL Path', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":10.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1007, '2018-10-31 15:55:19.615+00', '2018-10-31 15:55:22.274+00', 'app_id', 'type/Text', 'type/Category', true, NULL, true, 0, 37, NULL, 'App ID', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":12.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1145, '2018-10-31 15:55:19.869+00', '2018-10-31 15:55:22.362+00', 'event_name', 'type/Text', 'type/Category', true, NULL, true, 0, 39, NULL, 'Event Name', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":7},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":9.8125}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1146, '2018-10-31 15:55:19.87+00', '2018-10-31 15:55:22.368+00', 'tr_total', 'type/Decimal', 'type/Income', true, NULL, true, 0, 39, NULL, 'Tr Total', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Number":{"min":8000.00,"max":8000.00,"avg":8000.0}}}', 2, 'numeric', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1051, '2018-10-31 15:55:19.855+00', '2018-10-31 15:55:21.624+00', 'etl_tstamp', 'type/DateTime', NULL, true, NULL, true, 0, 39, NULL, 'Etl Ts Tamp', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/DateTime":{"earliest":"2018-10-31T00:00:00.000Z","latest":"2018-10-31T00:00:00.000Z"}}}', 2, 'timestamp', NULL);
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (980, '2018-10-31 15:55:19.607+00', '2018-10-31 15:55:22.251+00', 'domain_sessionid', 'type/Text', 'type/Category', true, NULL, true, 0, 37, NULL, 'Domain Session ID', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":36.0}}}', 2, 'bpchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1008, '2018-10-31 15:55:19.615+00', '2018-10-31 15:55:22.276+00', 'network_userid', 'type/Text', 'type/Category', true, NULL, true, 0, 37, NULL, 'Network Use Rid', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":36.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1001, '2018-10-31 15:55:19.614+00', '2018-10-31 15:55:22.278+00', 'geo_country', 'type/Text', 'type/Category', true, NULL, true, 0, 37, NULL, 'Geo Country', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":2.0}}}', 2, 'bpchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (979, '2018-10-31 15:55:19.607+00', '2018-10-31 15:55:22.289+00', 'refr_urlscheme', 'type/Text', 'type/Category', true, NULL, true, 0, 37, NULL, 'Re Fr URL Scheme', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":4.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (968, '2018-10-31 15:55:19.603+00', '2018-10-31 15:55:22.295+00', 'page_urlscheme', 'type/Text', 'type/Category', true, NULL, true, 0, 37, NULL, 'Page URL Scheme', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":4.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1021, '2018-10-31 15:55:19.849+00', '2018-10-31 15:55:22.307+00', 'br_features_silverlight', 'type/Boolean', 'type/Category', true, NULL, true, 0, 39, NULL, 'Br Features Silverlight', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1}}', 2, 'bool', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1027, '2018-10-31 15:55:19.851+00', '2018-10-31 15:55:22.309+00', 'page_title', 'type/Text', 'type/Title', true, NULL, true, 0, 39, NULL, 'Page Title', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":12.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1037, '2018-10-31 15:55:19.852+00', '2018-10-31 15:55:22.311+00', 'platform', 'type/Text', 'type/Category', true, NULL, true, 0, 39, NULL, 'Platform', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":3.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1040, '2018-10-31 15:55:19.853+00', '2018-10-31 15:55:22.313+00', 'page_referrer', 'type/Text', 'type/Category', true, NULL, true, 0, 39, NULL, 'Page Refer Rer', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":1.0,"percent-email":0.0,"average-length":29.0}}}', 2, 'text', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1042, '2018-10-31 15:55:19.853+00', '2018-10-31 15:55:22.315+00', 'ti_sku', 'type/Text', 'type/Category', true, NULL, true, 0, 39, NULL, 'Ti Sk U', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":4.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1044, '2018-10-31 15:55:19.853+00', '2018-10-31 15:55:22.317+00', 'pp_xoffset_max', 'type/Integer', 'type/Category', true, NULL, true, 0, 39, NULL, 'Pp X Offset Max', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Number":{"min":0,"max":0,"avg":0.0}}}', 2, 'int4', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1048, '2018-10-31 15:55:19.855+00', '2018-10-31 15:55:22.319+00', 'page_urlquery', 'type/Text', 'type/Category', true, NULL, true, 0, 39, NULL, 'Page URL Query', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":27.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1055, '2018-10-31 15:55:19.856+00', '2018-10-31 15:55:22.321+00', 'name_tracker', 'type/Text', 'type/Category', true, NULL, true, 0, 39, NULL, 'Name Tracker', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":2.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1056, '2018-10-31 15:55:19.856+00', '2018-10-31 15:55:22.323+00', 'geo_longitude', 'type/Float', 'type/Longitude', true, NULL, true, 0, 39, NULL, 'Geo Longitude', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Number":{"min":-97.822,"max":-97.822,"avg":-97.82200000000003}}}', 2, 'float8', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1059, '2018-10-31 15:55:19.856+00', '2018-10-31 15:55:22.326+00', 'v_etl', 'type/Text', 'type/Category', true, NULL, true, 0, 39, NULL, 'V Etl', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":34.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1074, '2018-10-31 15:55:19.859+00', '2018-10-31 15:55:22.328+00', 'refr_medium', 'type/Text', 'type/Category', true, NULL, true, 0, 39, NULL, 'Re Fr Medium', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":8.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1077, '2018-10-31 15:55:19.859+00', '2018-10-31 15:55:22.329+00', 'event_version', 'type/Text', 'type/Category', true, NULL, true, 0, 39, NULL, 'Event Version', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":5.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1078, '2018-10-31 15:55:19.859+00', '2018-10-31 15:55:22.331+00', 'se_category', 'type/Text', 'type/Category', true, NULL, true, 0, 39, NULL, 'Se Category', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":5.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1081, '2018-10-31 15:55:19.86+00', '2018-10-31 15:55:22.334+00', 'se_label', 'type/Text', 'type/Category', true, NULL, true, 0, 39, NULL, 'Se Label', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":19.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1086, '2018-10-31 15:55:19.861+00', '2018-10-31 15:55:22.336+00', 'br_colordepth', 'type/Text', 'type/Category', true, NULL, true, 0, 39, NULL, 'Br Color Depth', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":2.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1091, '2018-10-31 15:55:19.862+00', '2018-10-31 15:55:22.338+00', 'page_urlhost', 'type/Text', 'type/Category', true, NULL, true, 0, 39, NULL, 'Page URL Host', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":7.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1098, '2018-10-31 15:55:19.863+00', '2018-10-31 15:55:22.34+00', 'ti_orderid', 'type/Text', 'type/Category', true, NULL, true, 0, 39, NULL, 'Ti Order ID', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":9.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1143, '2018-10-31 15:55:19.869+00', '2018-10-31 15:55:22.355+00', 'network_userid', 'type/Text', 'type/Category', true, NULL, true, 0, 39, NULL, 'Network Use Rid', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":2},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":36.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1128, '2018-10-31 15:55:19.867+00', '2018-10-31 15:55:22.402+00', 'ti_currency', 'type/Text', 'type/Category', true, NULL, true, 0, 39, NULL, 'Ti Currency', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":3.0}}}', 2, 'bpchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1124, '2018-10-31 15:55:19.866+00', '2018-10-31 15:55:22.412+00', 'br_lang', 'type/Text', 'type/Category', true, NULL, true, 0, 39, NULL, 'Br Lang', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":2},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":5.0}}}', 2, 'varchar', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1110, '2018-10-31 15:55:19.864+00', '2018-10-31 15:55:22.436+00', 'se_value', 'type/Float', 'type/Category', true, NULL, true, 0, 39, NULL, 'Se Value', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":1},"type":{"type/Number":{"min":0.0,"max":0.0,"avg":0.0}}}', 2, 'float8', 'auto-list');
INSERT INTO public.metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values) VALUES (1061, '2018-10-31 15:55:19.857+00', '2018-10-31 15:55:22.471+00', 'user_fingerprint', 'type/Text', 'type/Category', true, NULL, true, 0, 39, NULL, 'User Fingerprint', 'normal', NULL, NULL, '2018-10-31 15:55:22.546+00', NULL, NULL, '{"global":{"distinct-count":2},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":9.625}}}', 2, 'varchar', 'auto-list');


--
-- Data for Name: metabase_fieldvalues; Type: TABLE DATA; Schema: public; Owner: discovery
--

INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (302, '2018-10-31 15:55:22.6+00', '2018-11-06 00:00:00.219+00', '[0,1]', NULL, 613);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (301, '2018-10-31 15:55:22.593+00', '2018-11-06 00:00:00.233+00', '[0]', NULL, 611);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (299, '2018-10-31 15:55:22.579+00', '2018-11-06 00:00:00.25+00', '[0,7,10]', NULL, 614);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (298, '2018-10-31 15:55:22.573+00', '2018-11-06 00:00:00.266+00', '[0,1]', NULL, 616);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (297, '2018-10-31 15:55:22.565+00', '2018-11-06 00:00:00.275+00', '[24,25,26,32]', NULL, 610);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (312, '2018-10-31 15:55:22.669+00', '2018-11-06 00:00:00.283+00', '[0,1]', NULL, 628);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (311, '2018-10-31 15:55:22.662+00', '2018-11-06 00:00:00.29+00', '[0,10]', NULL, 623);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (310, '2018-10-31 15:55:22.655+00', '2018-11-06 00:00:00.3+00', '[0,1]', NULL, 627);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (386, '2018-10-31 15:55:23.287+00', '2018-11-06 00:00:00.336+00', '["4"]', NULL, 667);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (385, '2018-10-31 15:55:23.277+00', '2018-11-06 00:00:00.381+00', '["2018-10"]', NULL, 723);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (384, '2018-10-31 15:55:23.268+00', '2018-11-06 00:00:00.4+00', '["Firefox 63.0"]', NULL, 653);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (383, '2018-10-31 15:55:23.259+00', '2018-11-06 00:00:00.407+00', '[8080]', NULL, 651);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (382, '2018-10-31 15:55:23.252+00', '2018-11-06 00:00:00.415+00', '["TouchAI Test"]', NULL, 649);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (381, '2018-10-31 15:55:23.242+00', '2018-11-06 00:00:00.424+00', '[936]', NULL, 647);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (380, '2018-10-31 15:55:23.235+00', '2018-11-06 00:00:00.431+00', '[13]', NULL, 643);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (379, '2018-10-31 15:55:23.228+00', '2018-11-06 00:00:00.44+00', '["/test.html"]', NULL, 641);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (378, '2018-10-31 15:55:23.22+00', '2018-11-06 00:00:00.447+00', '["Ubuntu"]', NULL, 639);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (377, '2018-10-31 15:55:23.213+00', '2018-11-06 00:00:00.457+00', '["Other"]', NULL, 637);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (376, '2018-10-31 15:55:23.164+00', '2018-11-06 00:00:00.464+00', '[0]', NULL, 635);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (375, '2018-10-31 15:55:23.157+00', '2018-11-06 00:00:00.471+00', '[8080]', NULL, 665);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (374, '2018-10-31 15:55:23.15+00', '2018-11-06 00:00:00.478+00', '[0]', NULL, 662);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (373, '2018-10-31 15:55:23.144+00', '2018-11-06 00:00:00.535+00', '["32c1cd2e-ba56-4579-8cd0-74ded027f1c7","55183b93-0978-4731-b681-1cc0350cc951","861f1ef6-1fd8-4fee-86e6-a0e3d16bc809"]', NULL, 661);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (372, '2018-10-31 15:55:23.137+00', '2018-11-06 00:00:00.544+00', '[1920]', NULL, 670);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (371, '2018-10-31 15:55:23.131+00', '2018-11-06 00:00:00.551+00', '["US"]', NULL, 721);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (370, '2018-10-31 15:55:23.125+00', '2018-11-06 00:00:00.558+00', '["05508805-07cb-480c-93c4-f8ed074fb1cf"]', NULL, 716);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (369, '2018-10-31 15:55:23.118+00', '2018-11-06 00:00:00.565+00', '["192.100.11.1"]', NULL, 711);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (368, '2018-10-31 15:55:23.112+00', '2018-11-06 00:00:00.572+00', '["2018-10-31 14:00:28","2018-10-31 14:00:29","2018-10-31 14:00:44"]', NULL, 709);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (367, '2018-10-31 15:55:23.106+00', '2018-11-06 00:00:00.578+00', '["0.0.0.0"]', NULL, 707);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (366, '2018-10-31 15:55:23.099+00', '2018-11-06 00:00:00.585+00', '[1,2,3]', NULL, 703);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (365, '2018-10-31 15:55:23.092+00', '2018-11-06 00:00:00.592+00', '["2018-10-31 14:00"]', NULL, 699);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (364, '2018-10-31 15:55:23.084+00', '2018-11-06 00:00:00.599+00', '["/test.html"]', NULL, 695);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (363, '2018-10-31 15:55:23.077+00', '2018-11-06 00:00:00.609+00', '["es-ES"]', NULL, 693);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (362, '2018-10-31 15:55:23.07+00', '2018-11-06 00:00:00.617+00', '[936]', NULL, 692);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (361, '2018-10-31 15:55:23.064+00', '2018-11-06 00:00:00.624+00', '[0,1]', NULL, 686);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (360, '2018-10-31 15:55:23.058+00', '2018-11-06 00:00:00.631+00', '["0"]', NULL, 683);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (359, '2018-10-31 15:55:23.052+00', '2018-11-06 00:00:00.638+00', '["Firefox"]', NULL, 682);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (358, '2018-10-31 15:55:23.045+00', '2018-11-06 00:00:00.645+00', '[2,null]', NULL, 680);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (357, '2018-10-31 15:55:23.039+00', '2018-11-06 00:00:00.653+00', '[0,10]', NULL, 678);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (356, '2018-10-31 15:55:23.032+00', '2018-11-06 00:00:00.661+00', '[false,true]', NULL, 677);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (355, '2018-10-31 15:55:23.025+00', '2018-11-06 00:00:00.677+00', '[-97.822]', NULL, 675);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (354, '2018-10-31 15:55:23.019+00', '2018-11-06 00:00:00.686+00', '["0.0.0.0/test.html"]', NULL, 688);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (353, '2018-10-31 15:55:23.013+00', '2018-11-06 00:00:00.697+00', '[0]', NULL, 708);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (352, '2018-10-31 15:55:23.006+00', '2018-11-06 00:00:00.709+00', '["alex123"]', NULL, 710);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (351, '2018-10-31 15:55:22.999+00', '2018-11-06 00:00:00.723+00', '["http"]', NULL, 718);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (350, '2018-10-31 15:55:22.992+00', '2018-11-06 00:00:00.733+00', '[2018]', NULL, 720);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (349, '2018-10-31 15:55:22.986+00', '2018-11-06 00:00:00.744+00', '[88,94,null]', NULL, 722);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (348, '2018-10-31 15:55:22.979+00', '2018-11-06 00:00:00.752+00', '[64,69,null]', NULL, 725);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (347, '2018-10-31 15:55:22.972+00', '2018-11-06 00:00:00.76+00', '[99,115,null]', NULL, 729);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (346, '2018-10-31 15:55:22.966+00', '2018-11-06 00:00:00.77+00', '["2018-10-31"]', NULL, 730);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (345, '2018-10-31 15:55:22.959+00', '2018-11-06 00:00:00.778+00', '[2]', NULL, 731);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (344, '2018-10-31 15:55:22.952+00', '2018-11-06 00:00:00.785+00', '["touchai-test"]', NULL, 735);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (343, '2018-10-31 15:55:22.941+00', '2018-11-06 00:00:00.794+00', '[24,25,26]', NULL, 640);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (342, '2018-10-31 15:55:22.934+00', '2018-11-06 00:00:00.801+00', '[0,10]', NULL, 642);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (341, '2018-10-31 15:55:22.923+00', '2018-11-06 00:00:00.809+00', '["Ubuntu"]', NULL, 646);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (340, '2018-10-31 15:55:22.914+00', '2018-11-06 00:00:00.819+00', '["0s to 9s","10s to 29s"]', NULL, 648);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (339, '2018-10-31 15:55:22.902+00', '2018-11-06 00:00:00.827+00', '[0]', NULL, 657);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (338, '2018-10-31 15:55:22.894+00', '2018-11-06 00:00:00.834+00', '["2018-10-31 14:00:28","2018-10-31 14:00:29","2018-10-31 14:00:44"]', NULL, 663);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (337, '2018-10-31 15:55:22.886+00', '2018-11-06 00:00:00.844+00', '["2018-10-31 14"]', NULL, 664);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (336, '2018-10-31 15:55:22.877+00', '2018-11-06 00:00:00.851+00', '[100.0]', NULL, 669);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (335, '2018-10-31 15:55:22.868+00', '2018-11-06 00:00:00.858+00', '[0,1]', NULL, 673);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (334, '2018-10-31 15:55:22.861+00', '2018-11-06 00:00:00.866+00', '[100.0]', NULL, 681);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (333, '2018-10-31 15:55:22.852+00', '2018-11-06 00:00:00.873+00', '[false]', NULL, 684);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (332, '2018-10-31 15:55:22.845+00', '2018-11-06 00:00:00.88+00', '["2018-10"]', NULL, 691);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (331, '2018-10-31 15:55:22.837+00', '2018-11-06 00:00:00.886+00', '["75% to 100%"]', NULL, 694);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (330, '2018-10-31 15:55:22.828+00', '2018-11-06 00:00:00.893+00', '[14]', NULL, 696);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (329, '2018-10-31 15:55:22.821+00', '2018-11-06 00:00:00.899+00', '["enableActivityTracking=true"]', NULL, 702);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (328, '2018-10-31 15:55:22.814+00', '2018-11-06 00:00:00.906+00', '[37.751]', NULL, 704);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (327, '2018-10-31 15:55:22.807+00', '2018-11-06 00:00:00.912+00', '["0.0.0.0"]', NULL, 706);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (326, '2018-10-31 15:55:22.799+00', '2018-11-06 00:00:00.919+00', '[1,2,3]', NULL, 679);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (325, '2018-10-31 15:55:22.792+00', '2018-11-06 00:00:00.926+00', '["b592b4d0-36dd-4e7d-955a-ac348e017086"]', NULL, 685);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (324, '2018-10-31 15:55:22.78+00', '2018-11-06 00:00:00.941+00', '[1920]', NULL, 633);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (323, '2018-10-31 15:55:22.773+00', '2018-11-06 00:00:00.978+00', '["2018-10-29"]', NULL, 636);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (322, '2018-10-31 15:55:22.764+00', '2018-11-06 00:00:00.985+00', '["Europe/Berlin"]', NULL, 672);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (321, '2018-10-31 15:55:22.749+00', '2018-11-06 00:00:00.991+00', '["5e1061b0-798e-4b25-a2b9-62ae9cb1f350"]', NULL, 674);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (320, '2018-10-31 15:55:22.74+00', '2018-11-06 00:00:01.011+00', '["14:00"]', NULL, 676);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (319, '2018-10-31 15:55:22.727+00', '2018-11-06 00:00:01.021+00', '["63"]', NULL, 712);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (318, '2018-10-31 15:55:22.72+00', '2018-11-06 00:00:01.035+00', '[0]', NULL, 732);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (317, '2018-10-31 15:55:22.712+00', '2018-11-06 00:00:01.041+00', '["http"]', NULL, 728);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (316, '2018-10-31 15:55:22.704+00', '2018-11-06 00:00:01.053+00', '["internal"]', NULL, 690);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (389, '2018-10-31 15:55:23.312+00', '2018-11-06 00:00:01.158+00', '["0"]', NULL, 743);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (388, '2018-10-31 15:55:23.305+00', '2018-11-06 00:00:01.178+00', '["Linux","Ubuntu"]', NULL, 747);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (387, '2018-10-31 15:55:23.299+00', '2018-11-06 00:00:01.184+00', '["63","69","70"]', NULL, 751);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (626, '2018-11-05 12:03:54.008+00', '2018-11-06 00:00:03.458+00', '[0.0,1.0]', NULL, 1200);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (305, '2018-10-31 15:55:22.621+00', '2018-11-06 00:00:00.19+00', '[99,115,null]', NULL, 621);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (304, '2018-10-31 15:55:22.614+00', '2018-11-06 00:00:00.197+00', '[0,8]', NULL, 618);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (303, '2018-10-31 15:55:22.607+00', '2018-11-06 00:00:00.204+00', '[2,4,null]', NULL, 615);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (315, '2018-10-31 15:55:22.694+00', '2018-11-06 00:00:01.061+00', '["0.0.0.0/test.html"]', NULL, 631);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (627, '2018-11-05 12:03:54.018+00', '2018-11-06 00:00:03.466+00', '[19.608,1408.281]', NULL, 1202);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (628, '2018-11-05 12:03:54.028+00', '2018-11-06 00:00:03.473+00', '[0.0,0.5]', NULL, 1205);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (629, '2018-11-05 12:03:54.038+00', '2018-11-06 00:00:03.481+00', '[1,2,4,5,6,8]', NULL, 1207);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (630, '2018-11-05 12:03:54.046+00', '2018-11-06 00:00:03.488+00', '["page_ping","page_view","struct","transaction","transaction_item","unstruct"]', NULL, 1206);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (631, '2018-11-05 12:03:54.056+00', '2018-11-06 00:00:03.496+00', '[1]', NULL, 1210);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (632, '2018-11-05 12:03:54.064+00', '2018-11-06 00:00:03.503+00', '[1,2,3,7]', NULL, 1209);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (633, '2018-11-05 12:03:54.073+00', '2018-11-06 00:00:03.511+00', '[5,8]', NULL, 1211);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (308, '2018-10-31 15:55:22.641+00', '2018-11-06 00:00:00.149+00', '[88,94,null]', NULL, 619);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (307, '2018-10-31 15:55:22.634+00', '2018-11-06 00:00:00.174+00', '[0]', NULL, 622);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (306, '2018-10-31 15:55:22.628+00', '2018-11-06 00:00:00.182+00', '[56,64,69,null]', NULL, 620);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (309, '2018-10-31 15:55:22.648+00', '2018-11-06 00:00:00.307+00', '["32c1cd2e-ba56-4579-8cd0-74ded027f1c7","55183b93-0978-4731-b681-1cc0350cc951","861f1ef6-1fd8-4fee-86e6-a0e3d16bc809","ecb0f20b-0f08-4ca5-9d61-14f15c26ba61"]', NULL, 624);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (313, '2018-10-31 15:55:22.677+00', '2018-11-06 00:00:00.321+00', '["DEFAULT_DELIMITER","DEFAULT_OUTPUT_FIELD","SPARK_CORES_MAX","SPARK_DRIVER_CORES","SPARK_DRIVER_JAVA_OPTIONS","SPARK_DRIVER_MEMORY","SPARK_EXECUTOR_BASE_IMAGE","SPARK_EXECUTOR_CORES","SPARK_EXECUTOR_EXTRA_JAVA_OPTIONS","SPARK_EXECUTOR_MEMORY","SPARK_LOCALITY_WAIT","SPARK_LOCAL_PATH","SPARK_MEMORY_FRACTION","SPARK_STREAMING_BLOCK_INTERVAL","SPARK_STREAMING_CHECKPOINT_PATH","SPARK_STREAMING_WINDOW","SPARK_TASK_MAX_FAILURES"]', NULL, 630);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (393, '2018-10-31 15:55:23.338+00', '2018-11-06 00:00:01.09+00', '["Chrome 69.0.3497","Chrome 70.0.3538","Firefox 63.0"]', NULL, 757);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (392, '2018-10-31 15:55:23.332+00', '2018-11-06 00:00:01.097+00', '["Linux","Ubuntu"]', NULL, 750);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (391, '2018-10-31 15:55:23.325+00', '2018-11-06 00:00:01.136+00', '["Other"]', NULL, 745);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (390, '2018-10-31 15:55:23.318+00', '2018-11-06 00:00:01.144+00', '["Chrome","Firefox"]', NULL, 742);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (404, '2018-10-31 15:55:23.42+00', '2018-11-06 00:00:01.218+00', '["63"]', NULL, 778);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (426, '2018-10-31 15:55:23.579+00', '2018-11-06 00:00:01.662+00', '["0.0.0.0"]', NULL, 849);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (410, '2018-10-31 15:55:23.47+00', '2018-11-06 00:00:01.802+00', '["14:00"]', NULL, 865);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (409, '2018-10-31 15:55:23.463+00', '2018-11-06 00:00:01.809+00', '["touchai-test"]', NULL, 875);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (587, '2018-10-31 15:55:24.737+00', '2018-11-06 00:00:02.675+00', '["ssc-0.14.0-kafka"]', NULL, 1041);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (634, '2018-11-05 12:03:54.082+00', '2018-11-06 00:00:03.517+00', '[1,2]', NULL, 1214);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (635, '2018-11-05 12:03:54.09+00', '2018-11-06 00:00:03.524+00', '[1,2,13]', NULL, 1213);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (636, '2018-11-05 12:03:54.099+00', '2018-11-06 00:00:03.531+00', '["en-US","es-ES"]', NULL, 1216);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (663, '2018-11-06 00:00:03.58+00', '2018-11-06 00:00:03.58+00', '["Linux","Ubuntu"]', NULL, 1236);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (664, '2018-11-06 00:00:03.587+00', '2018-11-06 00:00:03.587+00', '[1,3]', NULL, 1225);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (672, '2018-11-06 00:00:03.645+00', '2018-11-06 00:00:03.645+00', '[1]', NULL, 1232);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (300, '2018-10-31 15:55:22.586+00', '2018-11-06 00:00:00.241+00', '["32c1cd2e-ba56-4579-8cd0-74ded027f1c7","55183b93-0978-4731-b681-1cc0350cc951","861f1ef6-1fd8-4fee-86e6-a0e3d16bc809","ecb0f20b-0f08-4ca5-9d61-14f15c26ba61"]', NULL, 612);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (314, '2018-10-31 15:55:22.684+00', '2018-11-06 00:00:00.314+00', '[",","0.6","1","100","100ms","2","2G","2s","8","-Dfile.encoding=UTF-8 -Dconfig.file=/etc/sds/sparta/spark/reference.conf -XX:+UnlockExperimentalVMOptions -XX:+UseCGroupMemoryLimitForHeap -XX:+UseConcMarkSweepGC -Dlog4j.configurationFile=file:///etc/sds/sparta/log4j2.xml -Djava.util.logging.config.file=file:///etc/sds/sparta/log4j2.xml","-Dfile.encoding=UTF-8  -XX:+UnlockExperimentalVMOptions -XX:+UseCGroupMemoryLimitForHeap -XX:+UseConcMarkSweepGC","/opt/spark/dist","qa.stratio.com/stratio/spark-stratio-driver:2.2.0-2.0.0-ae1b428","raw","sparta/checkpoint"]', NULL, 629);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (643, '2018-11-06 00:00:01.079+00', '2018-11-06 00:00:01.079+00', '["3497",null]', NULL, 748);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (396, '2018-10-31 15:55:23.363+00', '2018-11-06 00:00:01.194+00', '["[]"]', NULL, 761);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (395, '2018-10-31 15:55:23.356+00', '2018-11-06 00:00:01.202+00', '["Default","Environment"]', NULL, 758);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (394, '2018-10-31 15:55:23.349+00', '2018-11-06 00:00:01.209+00', '["[]","[{\"name\":\"JDBC_DRIVER\",\"value\":\"org.postgresql.Driver\"},{\"name\":\"ES_PORT\",\"value\":\"9200\"},{\"name\":\"CASSANDRA_HOST\",\"value\":\"localhost\"},{\"name\":\"REDIS_HOST\",\"value\":\"localhost\"},{\"name\":\"CROSSDATA_ZOOKEEPER_CONNECTION\",\"value\":\"localhost:2181\"},{\"name\":\"KAFKA_MAX_POLL_TIMEOUT\",\"value\":\"512\"},{\"name\":\"ES_CLUSTER\",\"value\":\"elasticsearch\"},{\"name\":\"REDIS_PORT\",\"value\":\"6379\"},{\"name\":\"KAFKA_MAX_RATE_PER_PARTITION\",\"value\":\"0\"},{\"name\":\"CROSSDATA_ZOOKEEPER_PATH\",\"value\":\"/crossdata/offsets\"},{\"name\":\"MONGODB_PORT\",\"value\":\"27017\"},{\"name\":\"JDBC_URL\",\"value\":\"jdbc:postgresql://dbserver:port/database?user=postgres\"},{\"name\":\"ES_HOST\",\"value\":\"localhost\"},{\"name\":\"MONGODB_HOST\",\"value\":\"localhost\"},{\"name\":\"MONGODB_DB\",\"value\":\"sparta\"},{\"name\":\"KAFKA_BROKER_PORT\",\"value\":\"9092\"},{\"name\":\"POSTGRES_URL\",\"value\":\"jdbc:postgresql://dbserver:port/database?user=postgres\"},{\"name\":\"ES_INDEX_MAPPING\",\"value\":\"sparta\"},{\"name\":\"CASSANDRA_CLUSTER\",\"value\":\"sparta\"},{\"name\":\"WEBSOCKET_URL\",\"value\":\"ws://stream.meetup.com/2/rsvps\"},{\"name\":\"KAFKA_BROKER_HOST\",\"value\":\"localhost\"},{\"name\":\"KAFKA_GROUP_ID\",\"value\":\"sparta\"},{\"name\":\"CASSANDRA_PORT\",\"value\":\"9042\"},{\"name\":\"CASSANDRA_KEYSPACE\",\"value\":\"sparta\"}]"]', NULL, 760);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (403, '2018-10-31 15:55:23.411+00', '2018-11-06 00:00:01.223+00', '["Ubuntu"]', NULL, 774);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (402, '2018-10-31 15:55:23.403+00', '2018-11-06 00:00:01.303+00', '["0"]', NULL, 770);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (406, '2018-10-31 15:55:23.439+00', '2018-11-06 00:00:01.362+00', '["32c1cd2e-ba56-4579-8cd0-74ded027f1c7","55183b93-0978-4731-b681-1cc0350cc951","861f1ef6-1fd8-4fee-86e6-a0e3d16bc809","ecb0f20b-0f08-4ca5-9d61-14f15c26ba61"]', NULL, 790);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (405, '2018-10-31 15:55:23.433+00', '2018-11-06 00:00:01.368+00', '["18456522-fc42-4660-b1cd-036be27963ae","274d602e-1059-472b-a75a-e5c4c1c8d9bc","43595997-ab6b-46b7-8939-7afd9f782e38","5278c8fb-50ea-4361-9a34-bb3e53141462","5a02d6ed-81ca-42de-ab58-c1caf8d603d2","77590000-fc10-4831-8b4f-b573bbc6e492","9362e6f7-b4cc-40fb-a960-0c43f228c334","94bc5a20-b040-4ffa-b41d-d16b3e1a02fe","9501e701-85ef-454d-92e2-f496169812de","c54ef0d0-9625-4465-a7ba-a79e8c74c289","d062cae8-90f8-43da-bad3-57e562f40290","f1c4290e-5745-4c61-b2c2-bba0491aede4","f22e6f71-4b7e-42b4-9e8a-305a68abf0a7"]', NULL, 791);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (645, '2018-11-06 00:00:02.175+00', '2018-11-06 00:00:02.175+00', '["Csv","Explode","Explode_1","Json_contexts","Json_contexts_Discard","Json_derived_contexts","Json_derived_contexts_Discard","Kafka","SelectColumns","Trigger","Trigger_1","Trigger_1_1"]', NULL, 931);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (646, '2018-11-06 00:00:02.182+00', '2018-11-06 00:00:02.182+00', '["2f2c4839-9d7a-4b73-9554-5d98f682c9db"]', NULL, 928);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (647, '2018-11-06 00:00:02.234+00', '2018-11-06 00:00:02.234+00', '[0,1,3]', NULL, 929);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (648, '2018-11-06 00:00:02.243+00', '2018-11-06 00:00:02.243+00', '[false]', NULL, 939);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (649, '2018-11-06 00:00:02.252+00', '2018-11-06 00:00:02.252+00', '["\"Streaming\""]', NULL, 938);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (650, '2018-11-06 00:00:02.259+00', '2018-11-06 00:00:02.259+00', '["{\"position\":{\"x\":-35.033285998030124,\"y\":-77.17057033677514,\"k\":0.7957019281171375}}"]', NULL, 950);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (515, '2018-10-31 15:55:24.233+00', '2018-11-06 00:00:02.355+00', '["32c1cd2e-ba56-4579-8cd0-74ded027f1c7","55183b93-0978-4731-b681-1cc0350cc951","861f1ef6-1fd8-4fee-86e6-a0e3d16bc809"]', NULL, 961);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (637, '2018-11-05 12:03:54.109+00', '2018-11-06 00:00:03.537+00', '[1,3]', NULL, 1215);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (638, '2018-11-05 12:03:54.12+00', '2018-11-06 00:00:03.545+00', '[4]', NULL, 1217);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (639, '2018-11-05 12:03:54.143+00', '2018-11-06 00:00:03.551+00', '["US"]', NULL, 1218);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (401, '2018-10-31 15:55:23.396+00', '2018-11-06 00:00:01.311+00', '["Firefox"]', NULL, 769);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (400, '2018-10-31 15:55:23.39+00', '2018-11-06 00:00:01.324+00', '["Other"]', NULL, 772);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (399, '2018-10-31 15:55:23.383+00', '2018-11-06 00:00:01.333+00', '["Firefox 63.0"]', NULL, 779);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (398, '2018-10-31 15:55:23.377+00', '2018-11-06 00:00:01.344+00', '["Ubuntu"]', NULL, 777);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (397, '2018-10-31 15:55:23.371+00', '2018-11-06 00:00:01.351+00', '["32c1cd2e-ba56-4579-8cd0-74ded027f1c7","55183b93-0978-4731-b681-1cc0350cc951","861f1ef6-1fd8-4fee-86e6-a0e3d16bc809","ecb0f20b-0f08-4ca5-9d61-14f15c26ba61"]', NULL, 768);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (640, '2018-11-05 12:03:54.167+00', '2018-11-06 00:00:03.558+00', '[2]', NULL, 1220);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (642, '2018-11-05 12:03:54.203+00', '2018-11-06 00:00:03.573+00', '[0.0,1.0]', NULL, 1222);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (454, '2018-10-31 15:55:23.777+00', '2018-11-06 00:00:01.454+00', '[8080]', NULL, 859);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (453, '2018-10-31 15:55:23.771+00', '2018-11-06 00:00:01.471+00', '["2018-10-31 14:00:28"]', NULL, 794);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (452, '2018-10-31 15:55:23.764+00', '2018-11-06 00:00:01.481+00', '[37.751]', NULL, 845);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (451, '2018-10-31 15:55:23.758+00', '2018-11-06 00:00:01.488+00', '["/test.html"]', NULL, 838);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (450, '2018-10-31 15:55:23.75+00', '2018-11-06 00:00:01.494+00', '["/test.html"]', NULL, 836);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (432, '2018-10-31 15:55:23.62+00', '2018-11-06 00:00:01.606+00', '["enableActivityTracking=true"]', NULL, 830);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (407, '2018-10-31 15:55:23.449+00', '2018-11-06 00:00:01.824+00', '["Europe/Berlin"]', NULL, 819);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (469, '2018-10-31 15:55:23.888+00', '2018-11-06 00:00:01.979+00', '[1540993926640,1540994427950,1540994429834,1540994443949,1541430249458,1541430251034,1541430268286,1541430269423]', NULL, 886);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (464, '2018-10-31 15:55:23.855+00', '2018-11-06 00:00:02.012+00', '[1540993926624,1540994427943,1540994429816,1540994443940,1541430249443,1541430251024,1541430268277,1541430269413]', NULL, 888);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (461, '2018-10-31 15:55:23.835+00', '2018-11-06 00:00:02.042+00', '[1540993926671,1540994427976,1540994429858,1540994443973,1541430249476,1541430251051,1541430268297,1541430269440]', NULL, 908);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (644, '2018-11-06 00:00:02.081+00', '2018-11-06 00:00:02.081+00', '["{\"debugSuccessful\":true,\"stepResults\":{},\"stepErrors\":{},\"endExecutionDate\":\"2018-11-05T14:14:03Z\"}"]', NULL, 914);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (656, '2018-11-06 00:00:02.52+00', '2018-11-06 00:00:02.52+00', '[false]', NULL, 1011);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (657, '2018-11-06 00:00:02.527+00', '2018-11-06 00:00:02.527+00', '["{\"sparkURI\":\"http://localhost:4041\"}"]', NULL, 1017);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (658, '2018-11-06 00:00:02.554+00', '2018-11-06 00:00:02.554+00', '[""]', NULL, 1013);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (659, '2018-11-06 00:00:02.561+00', '2018-11-06 00:00:02.561+00', '[""]', NULL, 1016);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (660, '2018-11-06 00:00:02.567+00', '2018-11-06 00:00:02.567+00', '[""]', NULL, 1018);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (661, '2018-11-06 00:00:02.581+00', '2018-11-06 00:00:02.581+00', '[""]', NULL, 1015);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (662, '2018-11-06 00:00:02.595+00', '2018-11-06 00:00:02.595+00', '["[{\"state\":\"Failed\",\"statusInfo\":\"An error was encountered while executing input step Kafka\",\"lastUpdateDate\":\"2018-11-05T14:19:21Z\"},{\"state\":\"Starting\",\"statusInfo\":\"Starting workflow in local mode\",\"lastUpdateDate\":\"2018-11-05T14:19:21Z\"},{\"state\":\"NotStarted\",\"statusInfo\":\"Execution state changed to NotStarted\",\"lastUpdateDate\":\"2018-11-05T14:19:21Z\"},{\"state\":\"Created\",\"statusInfo\":\"Workflow execution created correctly\",\"lastUpdateDate\":\"2018-11-05T14:19:21Z\"}]","[{\"state\":\"Failed\",\"statusInfo\":\"Error initiating the workflow\",\"lastUpdateDate\":\"2018-11-05T14:18:16Z\"},{\"state\":\"Started\",\"statusInfo\":\"Workflow started successfully\",\"lastUpdateDate\":\"2018-11-05T14:17:54Z\"},{\"state\":\"Starting\",\"statusInfo\":\"Starting workflow in local mode\",\"lastUpdateDate\":\"2018-11-05T14:17:53Z\"},{\"state\":\"NotStarted\",\"statusInfo\":\"Execution state changed to NotStarted\",\"lastUpdateDate\":\"2018-11-05T14:17:53Z\"},{\"state\":\"Created\",\"statusInfo\":\"Workflow execution created correctly\",\"lastUpdateDate\":\"2018-11-05T14:17:53Z\"}]","[{\"state\":\"Failed\",\"statusInfo\":\"Error initiating the workflow\",\"lastUpdateDate\":\"2018-11-05T14:23:15Z\"},{\"state\":\"Started\",\"statusInfo\":\"Workflow started successfully\",\"lastUpdateDate\":\"2018-11-05T14:22:51Z\"},{\"state\":\"Starting\",\"statusInfo\":\"Starting workflow in local mode\",\"lastUpdateDate\":\"2018-11-05T14:22:50Z\"},{\"state\":\"NotStarted\",\"statusInfo\":\"Execution state changed to NotStarted\",\"lastUpdateDate\":\"2018-11-05T14:22:50Z\"},{\"state\":\"Created\",\"statusInfo\":\"Workflow execution created correctly\",\"lastUpdateDate\":\"2018-11-05T14:22:50Z\"}]","[{\"state\":\"Failed\",\"statusInfo\":\"Error initiating the workflow\",\"lastUpdateDate\":\"2018-11-05T14:25:16Z\"},{\"state\":\"Started\",\"statusInfo\":\"Workflow started successfully\",\"lastUpdateDate\":\"2018-11-05T14:25:14Z\"},{\"state\":\"Starting\",\"statusInfo\":\"Starting workflow in local mode\",\"lastUpdateDate\":\"2018-11-05T14:25:14Z\"},{\"state\":\"NotStarted\",\"statusInfo\":\"Execution state changed to NotStarted\",\"lastUpdateDate\":\"2018-11-05T14:25:13Z\"},{\"state\":\"Created\",\"statusInfo\":\"Workflow execution created correctly\",\"lastUpdateDate\":\"2018-11-05T14:25:13Z\"}]","[{\"state\":\"Failed\",\"statusInfo\":\"Error initiating the workflow\",\"lastUpdateDate\":\"2018-11-05T14:54:47Z\"},{\"state\":\"Started\",\"statusInfo\":\"Workflow started successfully\",\"lastUpdateDate\":\"2018-11-05T14:54:29Z\"},{\"state\":\"Starting\",\"statusInfo\":\"Starting workflow in local mode\",\"lastUpdateDate\":\"2018-11-05T14:54:29Z\"},{\"state\":\"NotStarted\",\"statusInfo\":\"Execution state changed to NotStarted\",\"lastUpdateDate\":\"2018-11-05T14:54:29Z\"},{\"state\":\"Created\",\"statusInfo\":\"Workflow execution created correctly\",\"lastUpdateDate\":\"2018-11-05T14:54:29Z\"}]","[{\"state\":\"Failed\",\"statusInfo\":\"Error initiating the workflow\",\"lastUpdateDate\":\"2018-11-05T15:10:27Z\"},{\"state\":\"Started\",\"statusInfo\":\"Checker: the workflow execution  started correctly\",\"lastUpdateDate\":\"2018-11-05T15:03:59Z\"},{\"state\":\"Starting\",\"statusInfo\":\"Starting workflow in local mode\",\"lastUpdateDate\":\"2018-11-05T15:03:57Z\"},{\"state\":\"NotStarted\",\"statusInfo\":\"Execution state changed to NotStarted\",\"lastUpdateDate\":\"2018-11-05T15:03:57Z\"},{\"state\":\"Created\",\"statusInfo\":\"Workflow execution created correctly\",\"lastUpdateDate\":\"2018-11-05T15:03:57Z\"}]","[{\"state\":\"Finished\",\"statusInfo\":\"The workflow was successfully finished with local scheduler\",\"lastUpdateDate\":\"2018-11-05T14:53:04Z\"},{\"state\":\"Stopped\",\"statusInfo\":\"The workflow was successfully stopped\",\"lastUpdateDate\":\"2018-11-05T14:53:04Z\"},{\"state\":\"Stopping\",\"statusInfo\":\"Execution state changed to Stopping\",\"lastUpdateDate\":\"2018-11-05T14:53:03Z\"},{\"state\":\"Started\",\"statusInfo\":\"Checker: the workflow execution  started correctly\",\"lastUpdateDate\":\"2018-11-05T14:28:21Z\"},{\"state\":\"Starting\",\"statusInfo\":\"Starting workflow in local mode\",\"lastUpdateDate\":\"2018-11-05T14:28:19Z\"},{\"state\":\"NotStarted\",\"statusInfo\":\"Execution state changed to NotStarted\",\"lastUpdateDate\":\"2018-11-05T14:28:19Z\"},{\"state\":\"Created\",\"statusInfo\":\"Workflow execution created correctly\",\"lastUpdateDate\":\"2018-11-05T14:28:19Z\"}]","[{\"state\":\"Finished\",\"statusInfo\":\"The workflow was successfully finished with local scheduler\",\"lastUpdateDate\":\"2018-11-05T14:54:24Z\"},{\"state\":\"Stopped\",\"statusInfo\":\"The workflow was successfully stopped\",\"lastUpdateDate\":\"2018-11-05T14:54:24Z\"},{\"state\":\"Stopping\",\"statusInfo\":\"Execution state changed to Stopping\",\"lastUpdateDate\":\"2018-11-05T14:54:24Z\"},{\"state\":\"Started\",\"statusInfo\":\"Workflow started successfully\",\"lastUpdateDate\":\"2018-11-05T14:53:40Z\"},{\"state\":\"Starting\",\"statusInfo\":\"Starting workflow in local mode\",\"lastUpdateDate\":\"2018-11-05T14:53:39Z\"},{\"state\":\"NotStarted\",\"statusInfo\":\"Execution state changed to NotStarted\",\"lastUpdateDate\":\"2018-11-05T14:53:39Z\"},{\"state\":\"Created\",\"statusInfo\":\"Workflow execution created correctly\",\"lastUpdateDate\":\"2018-11-05T14:53:39Z\"}]"]', NULL, 1010);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (589, '2018-10-31 15:55:24.752+00', '2018-11-06 00:00:02.65+00', '["US"]', NULL, 1134);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (641, '2018-11-05 12:03:54.184+00', '2018-11-06 00:00:03.566+00', '[2]', NULL, 1219);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (416, '2018-10-31 15:55:23.511+00', '2018-11-06 00:00:01.732+00', '["10s to 29s"]', NULL, 804);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (408, '2018-10-31 15:55:23.456+00', '2018-11-06 00:00:01.817+00', '[20]', NULL, 840);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (478, '2018-10-31 15:55:23.949+00', '2018-11-06 00:00:01.899+00', '[1540993926624,1540994427944,1540994429828,1540994443945,1541430249450,1541430251027,1541430268280,1541430269415]', NULL, 897);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (477, '2018-10-31 15:55:23.943+00', '2018-11-06 00:00:01.906+00', '[1540993926616,1540994427932,1540994429814,1540994443940,1541430249438,1541430251018,1541430268271,1541430269406]', NULL, 895);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (476, '2018-10-31 15:55:23.937+00', '2018-11-06 00:00:01.92+00', '[0,1540993926727,1540994429927,1540994444037,1541430269487]', NULL, 904);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (475, '2018-10-31 15:55:23.931+00', '2018-11-06 00:00:01.931+00', '[1540993926673,1540994427979,1540994429861,1540994443974,1541430249476,1541430251051,1541430268297,1541430269440]', NULL, 889);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (474, '2018-10-31 15:55:23.924+00', '2018-11-06 00:00:01.942+00', '[0]', NULL, 898);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (473, '2018-10-31 15:55:23.918+00', '2018-11-06 00:00:01.952+00', '[1540993926632,1540994427944,1540994429828,1540994443945,1541430249455,1541430251034,1541430268285,1541430269420]', NULL, 896);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (472, '2018-10-31 15:55:23.911+00', '2018-11-06 00:00:01.959+00', '[0]', NULL, 894);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (471, '2018-10-31 15:55:23.905+00', '2018-11-06 00:00:01.966+00', '[1540993926639,1540994427950,1540994429833,1540994443949,1541430249466,1541430251043,1541430268292,1541430269432]', NULL, 893);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (470, '2018-10-31 15:55:23.898+00', '2018-11-06 00:00:01.973+00', '[0]', NULL, 891);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (465, '2018-10-31 15:55:23.861+00', '2018-11-06 00:00:02.006+00', '[1540993926639,1540994427950,1540994429833,1540994443949,1541430249458,1541430251034,1541430268286,1541430269423]', NULL, 884);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (651, '2018-11-06 00:00:02.27+00', '2018-11-06 00:00:02.27+00', '[2]', NULL, 934);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (652, '2018-11-06 00:00:02.277+00', '2018-11-06 00:00:02.277+00', '["touchai-postgres"]', NULL, 936);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (653, '2018-11-06 00:00:02.284+00', '2018-11-06 00:00:02.284+00', '["{\"id\":\"940800b2-6d81-44a8-84d9-26913a2faea4\",\"name\":\"/home\"}"]', NULL, 941);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (654, '2018-11-06 00:00:02.291+00', '2018-11-06 00:00:02.291+00', '["{\"global\":{\"executionMode\":\"local\",\"userPluginsJars\":[],\"preExecutionSqlSentences\":[],\"postExecutionSqlSentences\":[],\"addAllUploadedPlugins\":false,\"mesosConstraint\":\"\",\"mesosConstraintOperator\":\"CLUSTER\",\"parametersLists\":[],\"parametersUsed\":[\"Global.DEFAULT_OUTPUT_FIELD\",\"Global.SPARK_CORES_MAX\",\"Global.SPARK_DRIVER_CORES\",\"Global.SPARK_DRIVER_JAVA_OPTIONS\",\"Global.SPARK_DRIVER_MEMORY\",\"Global.SPARK_EXECUTOR_BASE_IMAGE\",\"Global.SPARK_EXECUTOR_CORES\",\"Global.SPARK_EXECUTOR_EXTRA_JAVA_OPTIONS\",\"Global.SPARK_EXECUTOR_MEMORY\",\"Global.SPARK_LOCALITY_WAIT\",\"Global.SPARK_LOCAL_PATH\",\"Global.SPARK_MEMORY_FRACTION\",\"Global.SPARK_STREAMING_BLOCK_INTERVAL\",\"Global.SPARK_STREAMING_CHECKPOINT_PATH\",\"Global.SPARK_STREAMING_WINDOW\",\"Global.SPARK_TASK_MAX_FAILURES\"],\"udfsToRegister\":[],\"udafsToRegister\":[]},\"streamingSettings\":{\"window\":\"{{{Global.SPARK_STREAMING_WINDOW}}}\",\"remember\":\"\",\"backpressure\":false,\"blockInterval\":\"{{{Global.SPARK_STREAMING_BLOCK_INTERVAL}}}\",\"stopGracefully\":true,\"checkpointSettings\":{\"checkpointPath\":\"{{{Global.SPARK_STREAMING_CHECKPOINT_PATH}}}\",\"enableCheckpointing\":true,\"autoDeleteCheckpoint\":true,\"addTimeToCheckpointPath\":false}},\"sparkSettings\":{\"master\":\"mesos://leader.mesos:5050\",\"sparkKerberos\":true,\"sparkDataStoreTls\":true,\"sparkMesosSecurity\":true,\"submitArguments\":{\"userArguments\":[],\"deployMode\":\"client\",\"driverJavaOptions\":\"{{{Global.SPARK_DRIVER_JAVA_OPTIONS}}}\"},\"sparkConf\":{\"sparkResourcesConf\":{\"coresMax\":\"{{{Global.SPARK_CORES_MAX}}}\",\"executorMemory\":\"{{{Global.SPARK_EXECUTOR_MEMORY}}}\",\"executorCores\":\"{{{Global.SPARK_EXECUTOR_CORES}}}\",\"driverCores\":\"{{{Global.SPARK_DRIVER_CORES}}}\",\"driverMemory\":\"{{{Global.SPARK_DRIVER_MEMORY}}}\",\"mesosExtraCores\":\"\",\"localityWait\":\"{{{Global.SPARK_LOCALITY_WAIT}}}\",\"taskMaxFailures\":\"{{{Global.SPARK_TASK_MAX_FAILURES}}}\",\"sparkMemoryFraction\":\"{{{Global.SPARK_MEMORY_FRACTION}}}\",\"sparkParallelism\":\"\"},\"userSparkConf\":[],\"coarse\":true,\"sparkUser\":\"\",\"sparkLocalDir\":\"{{{Global.SPARK_LOCAL_PATH}}}\",\"executorDockerImage\":\"{{{Global.SPARK_EXECUTOR_BASE_IMAGE}}}\",\"sparkKryoSerialization\":false,\"sparkSqlCaseSensitive\":true,\"logStagesProgress\":false,\"hdfsTokenCache\":true,\"executorExtraJavaOptions\":\"{{{Global.SPARK_EXECUTOR_EXTRA_JAVA_OPTIONS}}}\"}},\"errorsManagement\":{\"genericErrorManagement\":{\"whenError\":\"Error\"},\"transformationStepsManagement\":{\"whenError\":\"Error\",\"whenRowError\":\"RowError\",\"whenFieldError\":\"FieldError\"},\"transactionsManagement\":{\"sendToOutputs\":[],\"sendStepData\":false,\"sendPredecessorsData\":true,\"sendInputData\":true}}}"]', NULL, 943);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (655, '2018-11-06 00:00:02.298+00', '2018-11-06 00:00:02.298+00', '[""]', NULL, 946);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (588, '2018-10-31 15:55:24.743+00', '2018-11-06 00:00:02.668+00', '["http"]', NULL, 1057);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (415, '2018-10-31 15:55:23.504+00', '2018-11-06 00:00:01.738+00', '["Firefox 63.0"]', NULL, 806);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (414, '2018-10-31 15:55:23.498+00', '2018-11-06 00:00:01.757+00', '[8080]', NULL, 814);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (413, '2018-10-31 15:55:23.491+00', '2018-11-06 00:00:01.774+00', '["5e1061b0-798e-4b25-a2b9-62ae9cb1f350"]', NULL, 820);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (412, '2018-10-31 15:55:23.484+00', '2018-11-06 00:00:01.786+00', '["0.0.0.0/test.html"]', NULL, 792);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (411, '2018-10-31 15:55:23.477+00', '2018-11-06 00:00:01.795+00', '["2018-10-31 14:00"]', NULL, 813);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (491, '2018-10-31 15:55:24.05+00', '2018-11-06 00:00:02.103+00', '["32c1cd2e-ba56-4579-8cd0-74ded027f1c7","55183b93-0978-4731-b681-1cc0350cc951","861f1ef6-1fd8-4fee-86e6-a0e3d16bc809","ecb0f20b-0f08-4ca5-9d61-14f15c26ba61"]', NULL, 919);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (665, '2018-11-06 00:00:03.595+00', '2018-11-06 00:00:03.595+00', '[2]', NULL, 1227);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (666, '2018-11-06 00:00:03.603+00', '2018-11-06 00:00:03.603+00', '["0","25+"]', NULL, 1226);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (667, '2018-11-06 00:00:03.611+00', '2018-11-06 00:00:03.611+00', '[1,3]', NULL, 1229);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (668, '2018-11-06 00:00:03.617+00', '2018-11-06 00:00:03.617+00', '["Chrome","Firefox"]', NULL, 1228);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (669, '2018-11-06 00:00:03.624+00', '2018-11-06 00:00:03.624+00', '["a. 0-10 seconds","b. 11-30 seconds","g. 1801+ seconds"]', NULL, 1231);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (670, '2018-11-06 00:00:03.631+00', '2018-11-06 00:00:03.631+00', '[1,2]', NULL, 1230);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (671, '2018-11-06 00:00:03.638+00', '2018-11-06 00:00:03.638+00', '[1,2,3,7]', NULL, 1233);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (673, '2018-11-06 00:00:03.669+00', '2018-11-06 00:00:03.669+00', '[4]', NULL, 1235);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (674, '2018-11-06 00:00:03.676+00', '2018-11-06 00:00:03.676+00', '["desktop"]', NULL, 1234);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (425, '2018-10-31 15:55:23.572+00', '2018-11-06 00:00:01.672+00', '["alex123"]', NULL, 852);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (424, '2018-10-31 15:55:23.566+00', '2018-11-06 00:00:01.68+00', '["192.100.11.1"]', NULL, 853);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (423, '2018-10-31 15:55:23.559+00', '2018-11-06 00:00:01.687+00', '["05508805-07cb-480c-93c4-f8ed074fb1cf"]', NULL, 858);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (422, '2018-10-31 15:55:23.554+00', '2018-11-06 00:00:01.693+00', '["2018-10-29"]', NULL, 861);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (421, '2018-10-31 15:55:23.547+00', '2018-11-06 00:00:01.7+00', '[3]', NULL, 863);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (420, '2018-10-31 15:55:23.54+00', '2018-11-06 00:00:01.706+00', '["2018-10-31 14"]', NULL, 869);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (419, '2018-10-31 15:55:23.533+00', '2018-11-06 00:00:01.713+00', '[0]', NULL, 872);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (418, '2018-10-31 15:55:23.527+00', '2018-11-06 00:00:01.719+00', '["Other"]', NULL, 796);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (417, '2018-10-31 15:55:23.52+00', '2018-11-06 00:00:01.726+00', '["0.0.0.0"]', NULL, 799);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (593, '2018-11-01 00:50:03.346+00', '2018-11-06 00:00:03.199+00', '["alex123"]', NULL, 1183);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (594, '2018-11-01 00:50:03.364+00', '2018-11-06 00:00:03.209+00', '["enableActivityTracking=true"]', NULL, 1166);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (595, '2018-11-01 00:50:03.381+00', '2018-11-06 00:00:03.22+00', '["internal"]', NULL, 1167);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (596, '2018-11-01 00:50:03.398+00', '2018-11-06 00:00:03.23+00', '["http"]', NULL, 1168);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (597, '2018-11-01 00:50:03.415+00', '2018-11-06 00:00:03.241+00', '["TouchAI Test"]', NULL, 1169);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (598, '2018-11-01 00:50:03.431+00', '2018-11-06 00:00:03.25+00', '[2018]', NULL, 1170);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (599, '2018-11-01 00:50:03.448+00', '2018-11-06 00:00:03.26+00', '["/test.html"]', NULL, 1171);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (600, '2018-11-01 00:50:03.464+00', '2018-11-06 00:00:03.27+00', '["/test.html"]', NULL, 1172);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (601, '2018-11-01 00:50:03.476+00', '2018-11-06 00:00:03.28+00', '["2018-10"]', NULL, 1173);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (602, '2018-11-01 00:50:03.497+00', '2018-11-06 00:00:03.293+00', '[20]', NULL, 1175);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (603, '2018-11-01 00:50:03.521+00', '2018-11-06 00:00:03.302+00', '["0.0.0.0"]', NULL, 1180);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (604, '2018-11-01 00:50:03.538+00', '2018-11-06 00:00:03.309+00', '[1]', NULL, 1181);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (605, '2018-11-01 00:50:03.555+00', '2018-11-06 00:00:03.317+00', '["05508805-07cb-480c-93c4-f8ed074fb1cf"]', NULL, 1186);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (606, '2018-11-01 00:50:03.571+00', '2018-11-06 00:00:03.324+00', '[8080]', NULL, 1187);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (607, '2018-11-01 00:50:03.587+00', '2018-11-06 00:00:03.33+00', '["http"]', NULL, 1188);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (608, '2018-11-01 00:50:03.604+00', '2018-11-06 00:00:03.338+00', '["2018-10-31 14"]', NULL, 1190);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (609, '2018-11-01 00:50:03.62+00', '2018-11-06 00:00:03.344+00', '["2018-10-29"]', NULL, 1192);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (610, '2018-11-01 00:50:03.636+00', '2018-11-06 00:00:03.351+00', '["touchai-test"]', NULL, 1193);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (611, '2018-11-01 00:50:03.654+00', '2018-11-06 00:00:03.358+00', '[2]', NULL, 1194);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (612, '2018-11-01 00:50:03.67+00', '2018-11-06 00:00:03.364+00', '["2018-10-31 14:00:28"]', NULL, 1164);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (613, '2018-11-01 00:50:03.686+00', '2018-11-06 00:00:03.37+00', '["0.0.0.0/test.html"]', NULL, 1147);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (614, '2018-11-01 00:50:03.709+00', '2018-11-06 00:00:03.377+00', '["2018-10-31 14:00:28"]', NULL, 1151);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (615, '2018-11-01 00:50:03.725+00', '2018-11-06 00:00:03.384+00', '[3]', NULL, 1152);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (616, '2018-11-01 00:50:03.746+00', '2018-11-06 00:00:03.391+00', '["0.0.0.0"]', NULL, 1153);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (617, '2018-11-01 00:50:03.765+00', '2018-11-06 00:00:03.397+00', '["2018-10-31 14:00"]', NULL, 1156);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (618, '2018-11-01 00:50:03.782+00', '2018-11-06 00:00:03.403+00', '[8080]', NULL, 1157);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (619, '2018-11-01 00:50:03.799+00', '2018-11-06 00:00:03.409+00', '["14:00"]', NULL, 1158);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (620, '2018-11-01 00:50:03.817+00', '2018-11-06 00:00:03.416+00', '["4"]', NULL, 1160);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (621, '2018-11-01 00:50:03.835+00', '2018-11-06 00:00:03.421+00', '["0.0.0.0/test.html"]', NULL, 1161);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (622, '2018-11-01 00:50:03.853+00', '2018-11-06 00:00:03.428+00', '["2018-10-31"]', NULL, 1162);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (623, '2018-11-01 00:50:03.871+00', '2018-11-06 00:00:03.435+00', '["5e1061b0-798e-4b25-a2b9-62ae9cb1f350"]', NULL, 1163);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (624, '2018-11-01 00:50:03.889+00', '2018-11-06 00:00:03.441+00', '["2018-10"]', NULL, 1177);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (625, '2018-11-01 00:50:03.906+00', '2018-11-06 00:00:03.448+00', '[14]', NULL, 1165);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (448, '2018-10-31 15:55:23.736+00', '2018-11-06 00:00:01.507+00', '["internal"]', NULL, 832);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (447, '2018-10-31 15:55:23.729+00', '2018-11-06 00:00:01.513+00', '["b592b4d0-36dd-4e7d-955a-ac348e017086"]', NULL, 828);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (446, '2018-10-31 15:55:23.721+00', '2018-11-06 00:00:01.519+00', '[false]', NULL, 827);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (445, '2018-10-31 15:55:23.714+00', '2018-11-06 00:00:01.525+00', '["Firefox"]', NULL, 825);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (444, '2018-10-31 15:55:23.707+00', '2018-11-06 00:00:01.532+00', '[false]', NULL, 822);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (443, '2018-10-31 15:55:23.696+00', '2018-11-06 00:00:01.539+00', '["0.0.0.0/test.html"]', NULL, 816);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (442, '2018-10-31 15:55:23.69+00', '2018-11-06 00:00:01.546+00', '["2018-10"]', NULL, 812);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (441, '2018-10-31 15:55:23.683+00', '2018-11-06 00:00:01.552+00', '[2]', NULL, 809);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (440, '2018-10-31 15:55:23.676+00', '2018-11-06 00:00:01.557+00', '["Ubuntu"]', NULL, 803);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (439, '2018-10-31 15:55:23.67+00', '2018-11-06 00:00:01.564+00', '[13]', NULL, 800);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (438, '2018-10-31 15:55:23.663+00', '2018-11-06 00:00:01.57+00', '["Ubuntu"]', NULL, 798);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (437, '2018-10-31 15:55:23.653+00', '2018-11-06 00:00:01.576+00', '["2018-10-31"]', NULL, 850);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (436, '2018-10-31 15:55:23.646+00', '2018-11-06 00:00:01.582+00', '["63"]', NULL, 854);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (435, '2018-10-31 15:55:23.639+00', '2018-11-06 00:00:01.588+00', '[-97.822]', NULL, 821);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (434, '2018-10-31 15:55:23.633+00', '2018-11-06 00:00:01.594+00', '[14]', NULL, 824);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (433, '2018-10-31 15:55:23.626+00', '2018-11-06 00:00:01.6+00', '["0"]', NULL, 826);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (431, '2018-10-31 15:55:23.613+00', '2018-11-06 00:00:01.613+00', '["http"]', NULL, 833);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (430, '2018-10-31 15:55:23.607+00', '2018-11-06 00:00:01.618+00', '["es-ES"]', NULL, 835);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (429, '2018-10-31 15:55:23.6+00', '2018-11-06 00:00:01.624+00', '["2018-10-31 14:00:28"]', NULL, 837);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (428, '2018-10-31 15:55:23.593+00', '2018-11-06 00:00:01.63+00', '[1]', NULL, 842);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (427, '2018-10-31 15:55:23.587+00', '2018-11-06 00:00:01.645+00', '["4"]', NULL, 839);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (459, '2018-10-31 15:55:23.82+00', '2018-11-06 00:00:01.847+00', '["/home"]', NULL, 877);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (480, '2018-10-31 15:55:23.963+00', '2018-11-06 00:00:01.874+00', '[0,1540993926731,1540994429929,1540994444039,1541430269488]', NULL, 909);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (479, '2018-10-31 15:55:23.956+00', '2018-11-06 00:00:01.89+00', '[1540993926624,1540994427943,1540994429816,1540994443940,1541430249443,1541430251024,1541430268277,1541430269413]', NULL, 899);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (468, '2018-10-31 15:55:23.881+00', '2018-11-06 00:00:01.986+00', '[0,1540993926727,1540994429927,1540994444037,1541430269487]', NULL, 880);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (467, '2018-10-31 15:55:23.875+00', '2018-11-06 00:00:01.993+00', '[1540993926624,1540994427943,1540994429816,1540994443940,1541430249443,1541430251024,1541430268277,1541430269413]', NULL, 879);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (466, '2018-10-31 15:55:23.868+00', '2018-11-06 00:00:01.999+00', '[1540993926677,1540994427981,1540994429863,1540994443976,1541430249476,1541430251051,1541430268297,1541430269440]', NULL, 882);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (463, '2018-10-31 15:55:23.848+00', '2018-11-06 00:00:02.018+00', '[1540993926632,1540994427944,1540994429828,1540994443945,1541430249452,1541430251028,1541430268282,1541430269417]', NULL, 890);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (462, '2018-10-31 15:55:23.842+00', '2018-11-06 00:00:02.025+00', '[1540993926624,1540994427944,1540994429816,1540994443940,1541430249443,1541430251024,1541430268277,1541430269413]', NULL, 892);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (460, '2018-10-31 15:55:23.829+00', '2018-11-06 00:00:02.057+00', '[1540993926617,1540994427933,1540994429816,1540994443940,1541430249443,1541430251024,1541430268277,1541430269413]', NULL, 910);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (493, '2018-10-31 15:55:24.064+00', '2018-11-06 00:00:02.09+00', '[100.0]', NULL, 926);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (492, '2018-10-31 15:55:24.057+00', '2018-11-06 00:00:02.097+00', '[0]', NULL, 915);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (490, '2018-10-31 15:55:24.044+00', '2018-11-06 00:00:02.11+00', '[0.0]', NULL, 917);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (489, '2018-10-31 15:55:24.037+00', '2018-11-06 00:00:02.117+00', '[0]', NULL, 916);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (488, '2018-10-31 15:55:24.031+00', '2018-11-06 00:00:02.124+00', '[0]', NULL, 924);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (487, '2018-10-31 15:55:24.024+00', '2018-11-06 00:00:02.13+00', '[936]', NULL, 923);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (486, '2018-10-31 15:55:24.017+00', '2018-11-06 00:00:02.137+00', '[0]', NULL, 921);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (485, '2018-10-31 15:55:24.011+00', '2018-11-06 00:00:02.143+00', '[100.0]', NULL, 918);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (484, '2018-10-31 15:55:24.004+00', '2018-11-06 00:00:02.15+00', '[1920]', NULL, 920);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (483, '2018-10-31 15:55:23.989+00', '2018-11-06 00:00:02.156+00', '[0.0]', NULL, 922);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (482, '2018-10-31 15:55:23.98+00', '2018-11-06 00:00:02.162+00', '[1920]', NULL, 925);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (481, '2018-10-31 15:55:23.974+00', '2018-11-06 00:00:02.168+00', '[936]', NULL, 927);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (520, '2018-10-31 15:55:24.267+00', '2018-11-06 00:00:02.318+00', '["192.100.11.1"]', NULL, 999);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (519, '2018-10-31 15:55:24.259+00', '2018-11-06 00:00:02.327+00', '["/test.html"]', NULL, 972);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (518, '2018-10-31 15:55:24.254+00', '2018-11-06 00:00:02.334+00', '[8080]', NULL, 969);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (517, '2018-10-31 15:55:24.247+00', '2018-11-06 00:00:02.341+00', '["Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:63.0) Gecko/20100101 Firefox/63.0"]', NULL, 984);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (516, '2018-10-31 15:55:24.241+00', '2018-11-06 00:00:02.348+00', '["cf"]', NULL, 966);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (514, '2018-10-31 15:55:24.226+00', '2018-11-06 00:00:02.361+00', '["alex123"]', NULL, 958);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (513, '2018-10-31 15:55:24.218+00', '2018-11-06 00:00:02.368+00', '[13]', NULL, 952);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (512, '2018-10-31 15:55:24.208+00', '2018-11-06 00:00:02.386+00', '["es-ES"]', NULL, 996);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (511, '2018-10-31 15:55:24.198+00', '2018-11-06 00:00:02.393+00', '[37.751]', NULL, 991);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (510, '2018-10-31 15:55:24.191+00', '2018-11-06 00:00:02.399+00', '["TouchAI Test"]', NULL, 955);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (509, '2018-10-31 15:55:24.185+00', '2018-11-06 00:00:02.406+00', '["enableActivityTracking=true"]', NULL, 963);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (508, '2018-10-31 15:55:24.18+00', '2018-11-06 00:00:02.413+00', '["Europe/Berlin"]', NULL, 965);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (507, '2018-10-31 15:55:24.173+00', '2018-11-06 00:00:02.419+00', '[-97.822]', NULL, 967);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (506, '2018-10-31 15:55:24.156+00', '2018-11-06 00:00:02.426+00', '["internal"]', NULL, 976);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (505, '2018-10-31 15:55:24.15+00', '2018-11-06 00:00:02.433+00', '[8080]', NULL, 977);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (504, '2018-10-31 15:55:24.144+00', '2018-11-06 00:00:02.439+00', '["0.0.0.0"]', NULL, 985);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (503, '2018-10-31 15:55:24.137+00', '2018-11-06 00:00:02.446+00', '["0.0.0.0"]', NULL, 989);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (502, '2018-10-31 15:55:24.131+00', '2018-11-06 00:00:02.456+00', '[1]', NULL, 994);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (501, '2018-10-31 15:55:24.125+00', '2018-11-06 00:00:02.464+00', '["05508805-07cb-480c-93c4-f8ed074fb1cf"]', NULL, 997);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (500, '2018-10-31 15:55:24.118+00', '2018-11-06 00:00:02.471+00', '["/test.html"]', NULL, 1000);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (499, '2018-10-31 15:55:24.112+00', '2018-11-06 00:00:02.478+00', '["touchai-test"]', NULL, 1007);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (498, '2018-10-31 15:55:24.105+00', '2018-11-06 00:00:02.486+00', '["b592b4d0-36dd-4e7d-955a-ac348e017086"]', NULL, 980);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (497, '2018-10-31 15:55:24.099+00', '2018-11-06 00:00:02.493+00', '["5e1061b0-798e-4b25-a2b9-62ae9cb1f350"]', NULL, 1008);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (496, '2018-10-31 15:55:24.092+00', '2018-11-06 00:00:02.499+00', '["US"]', NULL, 1001);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (495, '2018-10-31 15:55:24.085+00', '2018-11-06 00:00:02.506+00', '["http"]', NULL, 979);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (494, '2018-10-31 15:55:24.078+00', '2018-11-06 00:00:02.513+00', '["http"]', NULL, 968);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (538, '2018-10-31 15:55:24.39+00', '2018-11-06 00:00:03.012+00', '["1002",null]', NULL, 1042);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (537, '2018-10-31 15:55:24.384+00', '2018-11-06 00:00:03.018+00', '[0,null]', NULL, 1044);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (536, '2018-10-31 15:55:24.378+00', '2018-11-06 00:00:03.024+00', '["enableActivityTracking=true",null]', NULL, 1048);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (535, '2018-10-31 15:55:24.372+00', '2018-11-06 00:00:03.03+00', '["cf"]', NULL, 1055);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (534, '2018-10-31 15:55:24.366+00', '2018-11-06 00:00:03.037+00', '[-97.822]', NULL, 1056);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (533, '2018-10-31 15:55:24.36+00', '2018-11-06 00:00:03.043+00', '["stream-enrich-0.18.0-common-0.34.0"]', NULL, 1059);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (532, '2018-10-31 15:55:24.354+00', '2018-11-06 00:00:03.049+00', '["internal",null]', NULL, 1074);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (531, '2018-10-31 15:55:24.348+00', '2018-11-06 00:00:03.055+00', '["1-0-0","1-0-1"]', NULL, 1077);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (530, '2018-10-31 15:55:24.341+00', '2018-11-06 00:00:03.061+00', '["Mixes",null]', NULL, 1078);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (529, '2018-10-31 15:55:24.335+00', '2018-11-06 00:00:03.067+00', '["MRC/fabric-0503-mix",null]', NULL, 1081);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (528, '2018-10-31 15:55:24.329+00', '2018-11-06 00:00:03.074+00', '["24"]', NULL, 1086);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (527, '2018-10-31 15:55:24.323+00', '2018-11-06 00:00:03.08+00', '["0.0.0.0","site1"]', NULL, 1091);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (526, '2018-10-31 15:55:24.316+00', '2018-11-06 00:00:03.086+00', '["order-123",null]', NULL, 1098);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (525, '2018-10-31 15:55:24.31+00', '2018-11-06 00:00:03.102+00', '["43a81c91-4a52-4e77-bca7-fffb40f1cfa2","4ad7ebd8-620f-4899-aabe-27082519caa7","5e1061b0-798e-4b25-a2b9-62ae9cb1f350"]', NULL, 1143);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (524, '2018-10-31 15:55:24.303+00', '2018-11-06 00:00:03.12+00', '["JPY",null]', NULL, 1128);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (523, '2018-10-31 15:55:24.297+00', '2018-11-06 00:00:03.154+00', '["en-US","es-ES"]', NULL, 1124);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (522, '2018-10-31 15:55:24.291+00', '2018-11-06 00:00:03.174+00', '[0.0,null]', NULL, 1110);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (521, '2018-10-31 15:55:24.285+00', '2018-11-06 00:00:03.185+00', '["24212466","2536032505","695536893"]', NULL, 1061);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (458, '2018-10-31 15:55:23.809+00', '2018-11-06 00:00:01.384+00', '[2018]', NULL, 848);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (457, '2018-10-31 15:55:23.801+00', '2018-11-06 00:00:01.393+00', '["2018-10"]', NULL, 871);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (456, '2018-10-31 15:55:23.795+00', '2018-11-06 00:00:01.4+00', '["US"]', NULL, 864);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (455, '2018-10-31 15:55:23.789+00', '2018-11-06 00:00:01.406+00', '["http"]', NULL, 862);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (449, '2018-10-31 15:55:23.743+00', '2018-11-06 00:00:01.501+00', '["TouchAI Test"]', NULL, 834);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (586, '2018-10-31 15:55:24.73+00', '2018-11-06 00:00:02.682+00', '["Europe/Berlin"]', NULL, 1054);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (585, '2018-10-31 15:55:24.723+00', '2018-11-06 00:00:02.689+00', '[0,null]', NULL, 1052);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (584, '2018-10-31 15:55:24.717+00', '2018-11-06 00:00:02.695+00', '["page_ping","page_view","struct","transaction","transaction_item","unstruct"]', NULL, 1050);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (577, '2018-10-31 15:55:24.67+00', '2018-11-06 00:00:02.74+00', '["js-0.1.0-SNAPSHOT"]', NULL, 1115);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (576, '2018-10-31 15:55:24.664+00', '2018-11-06 00:00:02.746+00', '[0,null]', NULL, 1114);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (575, '2018-10-31 15:55:24.658+00', '2018-11-06 00:00:02.753+00', '[false]', NULL, 1112);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (571, '2018-10-31 15:55:24.63+00', '2018-11-06 00:00:02.779+00', '[37.751]', NULL, 1105);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (570, '2018-10-31 15:55:24.623+00', '2018-11-06 00:00:02.785+00', '[false]', NULL, 1072);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (569, '2018-10-31 15:55:24.615+00', '2018-11-06 00:00:02.791+00', '["JPY",null]', NULL, 1066);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (568, '2018-10-31 15:55:24.608+00', '2018-11-06 00:00:02.798+00', '["/","/test.html",null]', NULL, 1065);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (567, '2018-10-31 15:55:24.602+00', '2018-11-06 00:00:02.805+00', '[false]', NULL, 1063);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (555, '2018-10-31 15:55:24.52+00', '2018-11-06 00:00:02.881+00', '["http",null]', NULL, 1080);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (554, '2018-10-31 15:55:24.514+00', '2018-11-06 00:00:02.887+00', '["http://0.0.0.0:8080/test.html#","http://0.0.0.0:8080/test.html?enableActivityTracking=true","http://site1:8080/test.html#"]', NULL, 1076);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (553, '2018-10-31 15:55:24.507+00', '2018-11-06 00:00:02.893+00', '[8080]', NULL, 1075);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (552, '2018-10-31 15:55:24.501+00', '2018-11-06 00:00:02.899+00', '[8080,null]', NULL, 1058);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (551, '2018-10-31 15:55:24.495+00', '2018-11-06 00:00:02.905+00', '[false,true]', NULL, 1137);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (550, '2018-10-31 15:55:24.489+00', '2018-11-06 00:00:02.912+00', '["Play",null]', NULL, 1102);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (549, '2018-10-31 15:55:24.482+00', '2018-11-06 00:00:02.917+00', '["05508805-07cb-480c-93c4-f8ed074fb1cf","4a68aa7a-a315-4a3b-b7f9-885c8e8218c0","a8778c40-912f-4106-8cdf-14f29ba6df16","b79cc757-ec9d-43f4-8635-f7f46824cf4c"]', NULL, 1126);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (548, '2018-10-31 15:55:24.476+00', '2018-11-06 00:00:02.924+00', '["192.100.11.1"]', NULL, 1129);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (547, '2018-10-31 15:55:24.467+00', '2018-11-06 00:00:02.93+00', '["/test.html"]', NULL, 1131);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (546, '2018-10-31 15:55:24.461+00', '2018-11-06 00:00:02.937+00', '["order-123",null]', NULL, 1133);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (545, '2018-10-31 15:55:24.455+00', '2018-11-06 00:00:02.942+00', '["snowplowsmall","touchai-test"]', NULL, 1142);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (544, '2018-10-31 15:55:24.449+00', '2018-11-06 00:00:02.948+00', '["change_form","event","link_click","page_ping","page_view","submit_form","transaction","transaction_item"]', NULL, 1145);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (543, '2018-10-31 15:55:24.443+00', '2018-11-06 00:00:02.954+00', '[8000.00,null]', NULL, 1146);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (542, '2018-10-31 15:55:24.433+00', '2018-11-06 00:00:02.966+00', '[false]', NULL, 1021);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (541, '2018-10-31 15:55:24.423+00', '2018-11-06 00:00:02.992+00', '["TouchAI Javascript Tracker Test","TouchAI Test",null]', NULL, 1027);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (540, '2018-10-31 15:55:24.413+00', '2018-11-06 00:00:02.999+00', '["mob","web"]', NULL, 1037);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (539, '2018-10-31 15:55:24.403+00', '2018-11-06 00:00:03.005+00', '["http://0.0.0.0:8080/","http://0.0.0.0:8080/test.html",null]', NULL, 1040);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (590, '2018-10-31 15:55:24.763+00', '2018-11-06 00:00:02.631+00', '[false]', NULL, 1122);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (591, '2018-10-31 15:55:24.769+00', '2018-11-06 00:00:02.64+00', '[false,true]', NULL, 1118);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (592, '2018-10-31 15:55:24.778+00', '2018-11-06 00:00:02.661+00', '[true]', NULL, 1092);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (583, '2018-10-31 15:55:24.71+00', '2018-11-06 00:00:02.701+00', '["Red shoes",null]', NULL, 1043);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (582, '2018-10-31 15:55:24.703+00', '2018-11-06 00:00:02.708+00', '["alex123"]', NULL, 1032);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (581, '2018-10-31 15:55:24.697+00', '2018-11-06 00:00:02.714+00', '[1,null]', NULL, 1022);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (580, '2018-10-31 15:55:24.691+00', '2018-11-06 00:00:02.721+00', '[1,2,13]', NULL, 1020);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (579, '2018-10-31 15:55:24.684+00', '2018-11-06 00:00:02.727+00', '[0,null]', NULL, 1117);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (578, '2018-10-31 15:55:24.678+00', '2018-11-06 00:00:02.734+00', '["com.google.analytics","com.snowplowanalytics.snowplow"]', NULL, 1116);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (574, '2018-10-31 15:55:24.65+00', '2018-11-06 00:00:02.76+00', '[1920,2133]', NULL, 1111);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (573, '2018-10-31 15:55:24.644+00', '2018-11-06 00:00:02.766+00', '["jsonschema"]', NULL, 1107);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (572, '2018-10-31 15:55:24.636+00', '2018-11-06 00:00:02.772+00', '[1920]', NULL, 1106);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (566, '2018-10-31 15:55:24.593+00', '2018-11-06 00:00:02.812+00', '[false]', NULL, 1039);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (565, '2018-10-31 15:55:24.587+00', '2018-11-06 00:00:02.818+00', '[1920,2133]', NULL, 1038);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (564, '2018-10-31 15:55:24.581+00', '2018-11-06 00:00:02.825+00', '[4000.00,null]', NULL, 1036);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (563, '2018-10-31 15:55:24.574+00', '2018-11-06 00:00:02.832+00', '[false]', NULL, 1035);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (562, '2018-10-31 15:55:24.568+00', '2018-11-06 00:00:02.838+00', '[1080]', NULL, 1132);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (561, '2018-10-31 15:55:24.558+00', '2018-11-06 00:00:02.844+00', '[475,528,918,922,936,1024]', NULL, 1130);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (560, '2018-10-31 15:55:24.552+00', '2018-11-06 00:00:02.851+00', '["UTF-8"]', NULL, 1125);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (559, '2018-10-31 15:55:24.546+00', '2018-11-06 00:00:02.857+00', '["0.0.0.0",null]', NULL, 1099);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (558, '2018-10-31 15:55:24.54+00', '2018-11-06 00:00:02.863+00', '["Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36","Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36","Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:63.0) Gecko/20100101 Firefox/63.0"]', NULL, 1089);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (557, '2018-10-31 15:55:24.533+00', '2018-11-06 00:00:02.869+00', '[475,527,918,922,936,1024]', NULL, 1085);
INSERT INTO public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) VALUES (556, '2018-10-31 15:55:24.526+00', '2018-11-06 00:00:02.875+00', '["1265cae6-aebd-4ca2-b8e9-47246b0a7367","6cc1c14c-d4c4-4d3d-a5cc-025f719d243f","b592b4d0-36dd-4e7d-955a-ac348e017086","c6dccf02-72ef-4bfa-ad7d-62784a54a8c9"]', NULL, 1082);


--
-- Data for Name: metabase_table; Type: TABLE DATA; Schema: public; Owner: discovery
--

INSERT INTO public.metabase_table (id, created_at, updated_at, name, rows, description, entity_name, entity_type, active, db_id, display_name, visibility_type, schema, raw_table_id, points_of_interest, caveats, show_in_getting_started) VALUES (41, '2018-10-31 15:55:18.203+00', '2018-10-31 15:55:22.503+00', 'template', NULL, NULL, NULL, 'entity/GenericTable', true, 2, 'Template', NULL, 'sparta', NULL, NULL, NULL, false);
INSERT INTO public.metabase_table (id, created_at, updated_at, name, rows, description, entity_name, entity_type, active, db_id, display_name, visibility_type, schema, raw_table_id, points_of_interest, caveats, show_in_getting_started) VALUES (42, '2018-10-31 15:55:18.205+00', '2018-10-31 15:55:22.506+00', 'web_timing_context', NULL, NULL, NULL, 'entity/GenericTable', true, 2, 'Web Timing Context', NULL, 'scratch', NULL, NULL, NULL, false);
INSERT INTO public.metabase_table (id, created_at, updated_at, name, rows, description, entity_name, entity_type, active, db_id, display_name, visibility_type, schema, raw_table_id, points_of_interest, caveats, show_in_getting_started) VALUES (22, '2018-10-31 15:55:18.153+00', '2018-10-31 15:55:22.508+00', 'web_events_time', NULL, NULL, NULL, 'entity/GenericTable', true, 2, 'Web Events Time', NULL, 'scratch', NULL, NULL, NULL, false);
INSERT INTO public.metabase_table (id, created_at, updated_at, name, rows, description, entity_name, entity_type, active, db_id, display_name, visibility_type, schema, raw_table_id, points_of_interest, caveats, show_in_getting_started) VALUES (23, '2018-10-31 15:55:18.159+00', '2018-10-31 15:55:22.51+00', 'global_parameters', NULL, NULL, NULL, 'entity/GenericTable', true, 2, 'Global Parameters', NULL, 'sparta', NULL, NULL, NULL, false);
INSERT INTO public.metabase_table (id, created_at, updated_at, name, rows, description, entity_name, entity_type, active, db_id, display_name, visibility_type, schema, raw_table_id, points_of_interest, caveats, show_in_getting_started) VALUES (24, '2018-10-31 15:55:18.161+00', '2018-10-31 15:55:22.512+00', 'page_views_tmp', NULL, NULL, NULL, 'entity/GenericTable', true, 2, 'Page Views Tmp', NULL, 'web', NULL, NULL, NULL, false);
INSERT INTO public.metabase_table (id, created_at, updated_at, name, rows, description, entity_name, entity_type, active, db_id, display_name, visibility_type, schema, raw_table_id, points_of_interest, caveats, show_in_getting_started) VALUES (25, '2018-10-31 15:55:18.165+00', '2018-10-31 15:55:22.514+00', 'com_snowplowanalytics_snowplow_ua_parser_context_1', NULL, NULL, NULL, 'entity/GenericTable', true, 2, 'Com Snowplow Analytics Snowplow U A Parser Context 1', NULL, 'atomic', NULL, NULL, NULL, false);
INSERT INTO public.metabase_table (id, created_at, updated_at, name, rows, description, entity_name, entity_type, active, db_id, display_name, visibility_type, schema, raw_table_id, points_of_interest, caveats, show_in_getting_started) VALUES (26, '2018-10-31 15:55:18.167+00', '2018-10-31 15:55:22.516+00', 'parameter_list', NULL, NULL, NULL, 'entity/GenericTable', true, 2, 'Parameter List', NULL, 'sparta', NULL, NULL, NULL, false);
INSERT INTO public.metabase_table (id, created_at, updated_at, name, rows, description, entity_name, entity_type, active, db_id, display_name, visibility_type, schema, raw_table_id, points_of_interest, caveats, show_in_getting_started) VALUES (27, '2018-10-31 15:55:18.17+00', '2018-10-31 15:55:22.518+00', 'web_ua_parser_context', NULL, NULL, NULL, 'entity/GenericTable', true, 2, 'Web U A Parser Context', NULL, 'scratch', NULL, NULL, NULL, false);
INSERT INTO public.metabase_table (id, created_at, updated_at, name, rows, description, entity_name, entity_type, active, db_id, display_name, visibility_type, schema, raw_table_id, points_of_interest, caveats, show_in_getting_started) VALUES (28, '2018-10-31 15:55:18.172+00', '2018-10-31 15:55:22.52+00', 'com_snowplowanalytics_snowplow_web_page_1', NULL, NULL, NULL, 'entity/GenericTable', true, 2, 'Com Snowplow Analytics Snowplow Web Page 1', NULL, 'atomic', NULL, NULL, NULL, false);
INSERT INTO public.metabase_table (id, created_at, updated_at, name, rows, description, entity_name, entity_type, active, db_id, display_name, visibility_type, schema, raw_table_id, points_of_interest, caveats, show_in_getting_started) VALUES (29, '2018-10-31 15:55:18.175+00', '2018-10-31 15:55:22.522+00', 'web_page_context', NULL, NULL, NULL, 'entity/GenericTable', true, 2, 'Web Page Context', NULL, 'scratch', NULL, NULL, NULL, false);
INSERT INTO public.metabase_table (id, created_at, updated_at, name, rows, description, entity_name, entity_type, active, db_id, display_name, visibility_type, schema, raw_table_id, points_of_interest, caveats, show_in_getting_started) VALUES (30, '2018-10-31 15:55:18.177+00', '2018-10-31 15:55:22.524+00', 'sessions_tmp', NULL, NULL, NULL, 'entity/GenericTable', true, 2, 'Sessions Tmp', NULL, 'web', NULL, NULL, NULL, false);
INSERT INTO public.metabase_table (id, created_at, updated_at, name, rows, description, entity_name, entity_type, active, db_id, display_name, visibility_type, schema, raw_table_id, points_of_interest, caveats, show_in_getting_started) VALUES (31, '2018-10-31 15:55:18.179+00', '2018-10-31 15:55:22.527+00', 'groups', NULL, NULL, NULL, 'entity/GenericTable', true, 2, 'Groups', NULL, 'sparta', NULL, NULL, NULL, false);
INSERT INTO public.metabase_table (id, created_at, updated_at, name, rows, description, entity_name, entity_type, active, db_id, display_name, visibility_type, schema, raw_table_id, points_of_interest, caveats, show_in_getting_started) VALUES (32, '2018-10-31 15:55:18.182+00', '2018-10-31 15:55:22.529+00', 'org_w3_performance_timing_1', NULL, NULL, NULL, 'entity/GenericTable', true, 2, 'Org W3 Performance Timing 1', NULL, 'atomic', NULL, NULL, NULL, false);
INSERT INTO public.metabase_table (id, created_at, updated_at, name, rows, description, entity_name, entity_type, active, db_id, display_name, visibility_type, schema, raw_table_id, points_of_interest, caveats, show_in_getting_started) VALUES (33, '2018-10-31 15:55:18.184+00', '2018-10-31 15:55:22.531+00', 'debug', NULL, NULL, NULL, 'entity/GenericTable', true, 2, 'Debug', NULL, 'sparta', NULL, NULL, NULL, false);
INSERT INTO public.metabase_table (id, created_at, updated_at, name, rows, description, entity_name, entity_type, active, db_id, display_name, visibility_type, schema, raw_table_id, points_of_interest, caveats, show_in_getting_started) VALUES (34, '2018-10-31 15:55:18.186+00', '2018-10-31 15:55:22.533+00', 'web_events_scroll_depth', NULL, NULL, NULL, 'entity/GenericTable', true, 2, 'Web Events Scroll Depth', NULL, 'scratch', NULL, NULL, NULL, false);
INSERT INTO public.metabase_table (id, created_at, updated_at, name, rows, description, entity_name, entity_type, active, db_id, display_name, visibility_type, schema, raw_table_id, points_of_interest, caveats, show_in_getting_started) VALUES (35, '2018-10-31 15:55:18.189+00', '2018-10-31 15:55:22.535+00', 'debug_step_data', NULL, NULL, NULL, 'entity/GenericTable', true, 2, 'Debug Step Data', NULL, 'sparta', NULL, NULL, NULL, false);
INSERT INTO public.metabase_table (id, created_at, updated_at, name, rows, description, entity_name, entity_type, active, db_id, display_name, visibility_type, schema, raw_table_id, points_of_interest, caveats, show_in_getting_started) VALUES (36, '2018-10-31 15:55:18.191+00', '2018-10-31 15:55:22.537+00', 'workflow', NULL, NULL, NULL, 'entity/GenericTable', true, 2, 'Work Flow', NULL, 'sparta', NULL, NULL, NULL, false);
INSERT INTO public.metabase_table (id, created_at, updated_at, name, rows, description, entity_name, entity_type, active, db_id, display_name, visibility_type, schema, raw_table_id, points_of_interest, caveats, show_in_getting_started) VALUES (37, '2018-10-31 15:55:18.194+00', '2018-10-31 15:55:22.539+00', 'web_events', NULL, NULL, NULL, 'entity/EventTable', true, 2, 'Web Events', NULL, 'scratch', NULL, NULL, NULL, false);
INSERT INTO public.metabase_table (id, created_at, updated_at, name, rows, description, entity_name, entity_type, active, db_id, display_name, visibility_type, schema, raw_table_id, points_of_interest, caveats, show_in_getting_started) VALUES (38, '2018-10-31 15:55:18.196+00', '2018-10-31 15:55:22.541+00', 'workflow_execution', NULL, NULL, NULL, 'entity/GenericTable', true, 2, 'Work Flow Execution', NULL, 'sparta', NULL, NULL, NULL, false);
INSERT INTO public.metabase_table (id, created_at, updated_at, name, rows, description, entity_name, entity_type, active, db_id, display_name, visibility_type, schema, raw_table_id, points_of_interest, caveats, show_in_getting_started) VALUES (39, '2018-10-31 15:55:18.199+00', '2018-10-31 15:55:22.543+00', 'events', NULL, NULL, NULL, 'entity/EventTable', true, 2, 'Events', NULL, 'atomic', NULL, NULL, NULL, false);
INSERT INTO public.metabase_table (id, created_at, updated_at, name, rows, description, entity_name, entity_type, active, db_id, display_name, visibility_type, schema, raw_table_id, points_of_interest, caveats, show_in_getting_started) VALUES (40, '2018-10-31 15:55:18.201+00', '2018-10-31 15:55:22.544+00', 'users_tmp', NULL, NULL, NULL, 'entity/UserTable', true, 2, 'Users Tmp', NULL, 'web', NULL, NULL, NULL, false);
INSERT INTO public.metabase_table (id, created_at, updated_at, name, rows, description, entity_name, entity_type, active, db_id, display_name, visibility_type, schema, raw_table_id, points_of_interest, caveats, show_in_getting_started) VALUES (43, '2018-11-05 10:50:00.046+00', '2018-11-05 10:50:00.947+00', 'lookup_pageview', NULL, NULL, NULL, 'entity/GenericTable', true, 2, 'Lookup Page View', NULL, 'sparta', NULL, NULL, NULL, false);
INSERT INTO public.metabase_table (id, created_at, updated_at, name, rows, description, entity_name, entity_type, active, db_id, display_name, visibility_type, schema, raw_table_id, points_of_interest, caveats, show_in_getting_started) VALUES (44, '2018-11-05 11:50:00.048+00', '2018-11-05 11:50:01.535+00', 'fraction_new_visits_by_day', NULL, NULL, NULL, 'entity/GenericTable', true, 2, 'Fraction New Visits By Day', NULL, 'recipes_basic', NULL, NULL, NULL, false);
INSERT INTO public.metabase_table (id, created_at, updated_at, name, rows, description, entity_name, entity_type, active, db_id, display_name, visibility_type, schema, raw_table_id, points_of_interest, caveats, show_in_getting_started) VALUES (45, '2018-11-05 11:50:00.053+00', '2018-11-05 11:50:01.537+00', 'avg_visit_duration_by_day', NULL, NULL, NULL, 'entity/GenericTable', true, 2, 'Avg Visit Duration By Day', NULL, 'recipes_basic', NULL, NULL, NULL, false);
INSERT INTO public.metabase_table (id, created_at, updated_at, name, rows, description, entity_name, entity_type, active, db_id, display_name, visibility_type, schema, raw_table_id, points_of_interest, caveats, show_in_getting_started) VALUES (46, '2018-11-05 11:50:00.056+00', '2018-11-05 11:50:01.539+00', 'bounce_rate_by_day', NULL, NULL, NULL, 'entity/GenericTable', true, 2, 'Bounce Rate By Day', NULL, 'recipes_basic', NULL, NULL, NULL, false);
INSERT INTO public.metabase_table (id, created_at, updated_at, name, rows, description, entity_name, entity_type, active, db_id, display_name, visibility_type, schema, raw_table_id, points_of_interest, caveats, show_in_getting_started) VALUES (47, '2018-11-05 11:50:00.062+00', '2018-11-05 11:50:01.54+00', 'events_by_day', NULL, NULL, NULL, 'entity/EventTable', true, 2, 'Events By Day', NULL, 'recipes_basic', NULL, NULL, NULL, false);
INSERT INTO public.metabase_table (id, created_at, updated_at, name, rows, description, entity_name, entity_type, active, db_id, display_name, visibility_type, schema, raw_table_id, points_of_interest, caveats, show_in_getting_started) VALUES (48, '2018-11-05 11:50:00.065+00', '2018-11-05 11:50:01.542+00', 'pages_per_visit', NULL, NULL, NULL, 'entity/GenericTable', true, 2, 'Pages Per Visit', NULL, 'recipes_basic', NULL, NULL, NULL, false);
INSERT INTO public.metabase_table (id, created_at, updated_at, name, rows, description, entity_name, entity_type, active, db_id, display_name, visibility_type, schema, raw_table_id, points_of_interest, caveats, show_in_getting_started) VALUES (49, '2018-11-05 11:50:00.067+00', '2018-11-05 11:50:01.543+00', 'pageviews_by_day', NULL, NULL, NULL, 'entity/GenericTable', true, 2, 'Pageviews By Day', NULL, 'recipes_basic', NULL, NULL, NULL, false);
INSERT INTO public.metabase_table (id, created_at, updated_at, name, rows, description, entity_name, entity_type, active, db_id, display_name, visibility_type, schema, raw_table_id, points_of_interest, caveats, show_in_getting_started) VALUES (50, '2018-11-05 11:50:00.069+00', '2018-11-05 11:50:01.545+00', 'behavior_frequency', NULL, NULL, NULL, 'entity/GenericTable', true, 2, 'Behavior Frequency', NULL, 'recipes_basic', NULL, NULL, NULL, false);
INSERT INTO public.metabase_table (id, created_at, updated_at, name, rows, description, entity_name, entity_type, active, db_id, display_name, visibility_type, schema, raw_table_id, points_of_interest, caveats, show_in_getting_started) VALUES (51, '2018-11-05 11:50:00.071+00', '2018-11-05 11:50:01.547+00', 'visitors_by_language', NULL, NULL, NULL, 'entity/GenericTable', true, 2, 'Visitors By Language', NULL, 'recipes_basic', NULL, NULL, NULL, false);
INSERT INTO public.metabase_table (id, created_at, updated_at, name, rows, description, entity_name, entity_type, active, db_id, display_name, visibility_type, schema, raw_table_id, points_of_interest, caveats, show_in_getting_started) VALUES (52, '2018-11-05 11:50:00.074+00', '2018-11-05 11:50:01.549+00', 'visits_by_country', NULL, NULL, NULL, 'entity/GenericTable', true, 2, 'Visits By Country', NULL, 'recipes_basic', NULL, NULL, NULL, false);
INSERT INTO public.metabase_table (id, created_at, updated_at, name, rows, description, entity_name, entity_type, active, db_id, display_name, visibility_type, schema, raw_table_id, points_of_interest, caveats, show_in_getting_started) VALUES (53, '2018-11-05 11:50:00.076+00', '2018-11-05 11:50:01.55+00', 'uniques_and_visits_by_day', NULL, NULL, NULL, 'entity/GenericTable', true, 2, 'Uni Ques And Visits By Day', NULL, 'recipes_basic', NULL, NULL, NULL, false);
INSERT INTO public.metabase_table (id, created_at, updated_at, name, rows, description, entity_name, entity_type, active, db_id, display_name, visibility_type, schema, raw_table_id, points_of_interest, caveats, show_in_getting_started) VALUES (54, '2018-11-05 11:50:00.079+00', '2018-11-05 11:50:01.552+00', 'new_vs_returning', NULL, NULL, NULL, 'entity/GenericTable', true, 2, 'New Vs Returning', NULL, 'recipes_basic', NULL, NULL, NULL, false);
INSERT INTO public.metabase_table (id, created_at, updated_at, name, rows, description, entity_name, entity_type, active, db_id, display_name, visibility_type, schema, raw_table_id, points_of_interest, caveats, show_in_getting_started) VALUES (55, '2018-11-05 12:03:47.461+00', '2018-11-05 13:00:01.519+00', 'technology_os', NULL, NULL, NULL, 'entity/GenericTable', true, 2, 'Technology Os', NULL, 'recipes_basic', NULL, NULL, NULL, false);
INSERT INTO public.metabase_table (id, created_at, updated_at, name, rows, description, entity_name, entity_type, active, db_id, display_name, visibility_type, schema, raw_table_id, points_of_interest, caveats, show_in_getting_started) VALUES (56, '2018-11-05 12:03:47.466+00', '2018-11-05 13:00:01.522+00', 'behavior_recency', NULL, NULL, NULL, 'entity/GenericTable', true, 2, 'Behavior Rec En Cy', NULL, 'recipes_basic', NULL, NULL, NULL, false);
INSERT INTO public.metabase_table (id, created_at, updated_at, name, rows, description, entity_name, entity_type, active, db_id, display_name, visibility_type, schema, raw_table_id, points_of_interest, caveats, show_in_getting_started) VALUES (57, '2018-11-05 12:03:47.47+00', '2018-11-05 13:00:01.524+00', 'technology_browser', NULL, NULL, NULL, 'entity/GenericTable', true, 2, 'Technology Browser', NULL, 'recipes_basic', NULL, NULL, NULL, false);
INSERT INTO public.metabase_table (id, created_at, updated_at, name, rows, description, entity_name, entity_type, active, db_id, display_name, visibility_type, schema, raw_table_id, points_of_interest, caveats, show_in_getting_started) VALUES (58, '2018-11-05 12:03:47.473+00', '2018-11-05 13:00:01.526+00', 'engagement_visit_duration', NULL, NULL, NULL, 'entity/GenericTable', true, 2, 'Engagement Visit Duration', NULL, 'recipes_basic', NULL, NULL, NULL, false);
INSERT INTO public.metabase_table (id, created_at, updated_at, name, rows, description, entity_name, entity_type, active, db_id, display_name, visibility_type, schema, raw_table_id, points_of_interest, caveats, show_in_getting_started) VALUES (59, '2018-11-05 12:03:47.476+00', '2018-11-05 13:00:01.528+00', 'engagement_pageviews_per_visit', NULL, NULL, NULL, 'entity/GenericTable', true, 2, 'Engagement Pageviews Per Visit', NULL, 'recipes_basic', NULL, NULL, NULL, false);
INSERT INTO public.metabase_table (id, created_at, updated_at, name, rows, description, entity_name, entity_type, active, db_id, display_name, visibility_type, schema, raw_table_id, points_of_interest, caveats, show_in_getting_started) VALUES (60, '2018-11-05 12:03:47.479+00', '2018-11-05 13:00:01.53+00', 'technology_mobile', NULL, NULL, NULL, 'entity/GenericTable', true, 2, 'Technology Mobile', NULL, 'recipes_basic', NULL, NULL, NULL, false);


--
-- Data for Name: metric; Type: TABLE DATA; Schema: public; Owner: discovery
--



--
-- Data for Name: metric_important_field; Type: TABLE DATA; Schema: public; Owner: discovery
--



--
-- Data for Name: permissions; Type: TABLE DATA; Schema: public; Owner: discovery
--

INSERT INTO public.permissions (id, object, group_id) VALUES (1, '/', 2);
INSERT INTO public.permissions (id, object, group_id) VALUES (4, '/db/2/', 1);
INSERT INTO public.permissions (id, object, group_id) VALUES (5, '/db/2/', 3);


--
-- Data for Name: permissions_group; Type: TABLE DATA; Schema: public; Owner: discovery
--

INSERT INTO public.permissions_group (id, name) VALUES (1, 'All Users');
INSERT INTO public.permissions_group (id, name) VALUES (2, 'Administrators');
INSERT INTO public.permissions_group (id, name) VALUES (3, 'MetaBot');


--
-- Data for Name: permissions_group_membership; Type: TABLE DATA; Schema: public; Owner: discovery
--

INSERT INTO public.permissions_group_membership (id, user_id, group_id) VALUES (1, 1, 1);
INSERT INTO public.permissions_group_membership (id, user_id, group_id) VALUES (2, 1, 2);


--
-- Data for Name: permissions_revision; Type: TABLE DATA; Schema: public; Owner: discovery
--



--
-- Data for Name: pulse; Type: TABLE DATA; Schema: public; Owner: discovery
--



--
-- Data for Name: pulse_card; Type: TABLE DATA; Schema: public; Owner: discovery
--



--
-- Data for Name: pulse_channel; Type: TABLE DATA; Schema: public; Owner: discovery
--



--
-- Data for Name: pulse_channel_recipient; Type: TABLE DATA; Schema: public; Owner: discovery
--



--
-- Data for Name: query; Type: TABLE DATA; Schema: public; Owner: discovery
--

INSERT INTO public.query (query_hash, average_execution_time) VALUES ('\x67426e03f97a6e9bd5617f593c22b505c015239709e4208098bc67afe9656f7b', 112);
INSERT INTO public.query (query_hash, average_execution_time) VALUES ('\xb71230ff5645cefb6e678055b8bf966827c92e621b3abcb8fd6582f21367bae2', 89);
INSERT INTO public.query (query_hash, average_execution_time) VALUES ('\x6bffe25313782ad5a3d4b6b28473b6c1de2adffc802753a5a3675cf99c8cc00b', 150);
INSERT INTO public.query (query_hash, average_execution_time) VALUES ('\x2871d03504a42f47411d3034c6adc91b84c73f81b9cd2f192c2e0de24358d660', 225);
INSERT INTO public.query (query_hash, average_execution_time) VALUES ('\xc48023a6dd08a37abe34dfa6de717b682d8c7428ebb6feba83efbfd80c5a254f', 180);
INSERT INTO public.query (query_hash, average_execution_time) VALUES ('\x5c2882f2bbf324d97ba1087edf15521a7b2ecf0cf1a845072bb84a311df06701', 124);
INSERT INTO public.query (query_hash, average_execution_time) VALUES ('\x803006a55518688975e785dbce2e1a9cad3b53e58f1e00bb9c699a7514d4f48f', 128);
INSERT INTO public.query (query_hash, average_execution_time) VALUES ('\x3617bf002041a31fba600844fac939fd4b766059b807dd8dc22941c0554c6b43', 123);
INSERT INTO public.query (query_hash, average_execution_time) VALUES ('\xb6fccb28ae2ac07ef1dce7a8cbc270e0aa69a8c60686243f8fce3f9f822d9b70', 135);
INSERT INTO public.query (query_hash, average_execution_time) VALUES ('\xa1b814e68385cd8abbacf446fc97cbb057d2a90062a528c148eb0c767a85520d', 236);
INSERT INTO public.query (query_hash, average_execution_time) VALUES ('\xd42744908b02c07ff54cf8b093d5ef85310ae430149d2a1a1d93cb1ff4870691', 69);
INSERT INTO public.query (query_hash, average_execution_time) VALUES ('\xc7220af2a150c2c8372c17dfa6fcdfefb4ec2c0432fd780d7244e2cd0ed82509', 56);
INSERT INTO public.query (query_hash, average_execution_time) VALUES ('\x1b1bdc14d95a417df66d95db39e7060e8297f6475deb23bab8526252d8dd2cf6', 98);
INSERT INTO public.query (query_hash, average_execution_time) VALUES ('\x2794f05e8b9ff862ea6fbb0286455b7ffaa88ba79277f84d3db207c7f118aa03', 49);
INSERT INTO public.query (query_hash, average_execution_time) VALUES ('\x2dfab27b6abefb1affd7b25131dbbbf59deb088e5a756050a5694e2b2be2ccb5', 34);
INSERT INTO public.query (query_hash, average_execution_time) VALUES ('\x4b9c8adee40dcfbd622b73ddb9940819ee662e61697eaec28ac3f799db7355bd', 241);
INSERT INTO public.query (query_hash, average_execution_time) VALUES ('\xdd08c01bf699e58380def3c4d88d8c90b311f665c9fdc657935232a576cd8d51', 24);
INSERT INTO public.query (query_hash, average_execution_time) VALUES ('\xcf08c45513c73202d33b8790a72d9a8a227775b33ebca360c5e89d1d87e1500d', 20);
INSERT INTO public.query (query_hash, average_execution_time) VALUES ('\x7d9420e01bd543928631444c508b9c16e91e6e2d4b65d521f1bafb787e4884f7', 15);
INSERT INTO public.query (query_hash, average_execution_time) VALUES ('\x5ff0bf6b3f5d2b99fc080a9c8429e910955ff2a0f3bc1b2ea226ac681960c3af', 29);
INSERT INTO public.query (query_hash, average_execution_time) VALUES ('\x26c1af1c05c1294b478c973357c29fc4275b576facb08500434fe741bf52990d', 19);
INSERT INTO public.query (query_hash, average_execution_time) VALUES ('\x49c2d614c3f78de2c3890b6e5b976cf309456ca250290c3c5bedb04d3996bd92', 52);
INSERT INTO public.query (query_hash, average_execution_time) VALUES ('\x371cb284118365e14d43b76a31eb172463726f428c29bdd71a76808eb990d466', 36);
INSERT INTO public.query (query_hash, average_execution_time) VALUES ('\xae1f9b9080634ca90d271fc2b61c1d10e5c656dfb15179dfaa78e45096021a1d', 40);


--
-- Data for Name: query_cache; Type: TABLE DATA; Schema: public; Owner: discovery
--



--
-- Data for Name: query_execution; Type: TABLE DATA; Schema: public; Owner: discovery
--

INSERT INTO public.query_execution (id, hash, started_at, running_time, result_rows, native, context, error, executor_id, card_id, dashboard_id, pulse_id) VALUES (1, '\x2871d03504a42f47411d3034c6adc91b84c73f81b9cd2f192c2e0de24358d660', '2018-10-31 15:55:32.389', 225, 1, false, 'ad-hoc', NULL, 1, NULL, NULL, NULL);
INSERT INTO public.query_execution (id, hash, started_at, running_time, result_rows, native, context, error, executor_id, card_id, dashboard_id, pulse_id) VALUES (2, '\xb71230ff5645cefb6e678055b8bf966827c92e621b3abcb8fd6582f21367bae2', '2018-10-31 15:55:32.528', 89, 1, false, 'ad-hoc', NULL, 1, NULL, NULL, NULL);
INSERT INTO public.query_execution (id, hash, started_at, running_time, result_rows, native, context, error, executor_id, card_id, dashboard_id, pulse_id) VALUES (3, '\xc48023a6dd08a37abe34dfa6de717b682d8c7428ebb6feba83efbfd80c5a254f', '2018-10-31 15:55:32.47', 180, 1, false, 'ad-hoc', NULL, 1, NULL, NULL, NULL);
INSERT INTO public.query_execution (id, hash, started_at, running_time, result_rows, native, context, error, executor_id, card_id, dashboard_id, pulse_id) VALUES (4, '\x6bffe25313782ad5a3d4b6b28473b6c1de2adffc802753a5a3675cf99c8cc00b', '2018-10-31 15:55:32.467', 150, 1, false, 'ad-hoc', NULL, 1, NULL, NULL, NULL);
INSERT INTO public.query_execution (id, hash, started_at, running_time, result_rows, native, context, error, executor_id, card_id, dashboard_id, pulse_id) VALUES (5, '\x67426e03f97a6e9bd5617f593c22b505c015239709e4208098bc67afe9656f7b', '2018-10-31 15:55:32.516', 112, 1, false, 'ad-hoc', NULL, 1, NULL, NULL, NULL);
INSERT INTO public.query_execution (id, hash, started_at, running_time, result_rows, native, context, error, executor_id, card_id, dashboard_id, pulse_id) VALUES (6, '\x5c2882f2bbf324d97ba1087edf15521a7b2ecf0cf1a845072bb84a311df06701', '2018-10-31 15:55:32.698', 124, 1, false, 'ad-hoc', NULL, 1, NULL, NULL, NULL);
INSERT INTO public.query_execution (id, hash, started_at, running_time, result_rows, native, context, error, executor_id, card_id, dashboard_id, pulse_id) VALUES (7, '\x803006a55518688975e785dbce2e1a9cad3b53e58f1e00bb9c699a7514d4f48f', '2018-10-31 15:55:32.705', 128, 3, false, 'ad-hoc', NULL, 1, NULL, NULL, NULL);
INSERT INTO public.query_execution (id, hash, started_at, running_time, result_rows, native, context, error, executor_id, card_id, dashboard_id, pulse_id) VALUES (8, '\x3617bf002041a31fba600844fac939fd4b766059b807dd8dc22941c0554c6b43', '2018-10-31 15:55:32.696', 123, 1, false, 'ad-hoc', NULL, 1, NULL, NULL, NULL);
INSERT INTO public.query_execution (id, hash, started_at, running_time, result_rows, native, context, error, executor_id, card_id, dashboard_id, pulse_id) VALUES (9, '\xb6fccb28ae2ac07ef1dce7a8cbc270e0aa69a8c60686243f8fce3f9f822d9b70', '2018-10-31 15:55:32.702', 135, 1, false, 'ad-hoc', NULL, 1, NULL, NULL, NULL);
INSERT INTO public.query_execution (id, hash, started_at, running_time, result_rows, native, context, error, executor_id, card_id, dashboard_id, pulse_id) VALUES (10, '\xa1b814e68385cd8abbacf446fc97cbb057d2a90062a528c148eb0c767a85520d', '2018-10-31 15:55:32.698', 236, 1, false, 'ad-hoc', NULL, 1, NULL, NULL, NULL);
INSERT INTO public.query_execution (id, hash, started_at, running_time, result_rows, native, context, error, executor_id, card_id, dashboard_id, pulse_id) VALUES (11, '\xd42744908b02c07ff54cf8b093d5ef85310ae430149d2a1a1d93cb1ff4870691', '2018-10-31 15:55:32.888', 69, 1, false, 'ad-hoc', NULL, 1, NULL, NULL, NULL);
INSERT INTO public.query_execution (id, hash, started_at, running_time, result_rows, native, context, error, executor_id, card_id, dashboard_id, pulse_id) VALUES (12, '\xc7220af2a150c2c8372c17dfa6fcdfefb4ec2c0432fd780d7244e2cd0ed82509', '2018-10-31 15:55:32.905', 56, 1, false, 'ad-hoc', NULL, 1, NULL, NULL, NULL);
INSERT INTO public.query_execution (id, hash, started_at, running_time, result_rows, native, context, error, executor_id, card_id, dashboard_id, pulse_id) VALUES (13, '\x1b1bdc14d95a417df66d95db39e7060e8297f6475deb23bab8526252d8dd2cf6', '2018-10-31 15:55:32.907', 98, 1, false, 'ad-hoc', NULL, 1, NULL, NULL, NULL);
INSERT INTO public.query_execution (id, hash, started_at, running_time, result_rows, native, context, error, executor_id, card_id, dashboard_id, pulse_id) VALUES (14, '\x2794f05e8b9ff862ea6fbb0286455b7ffaa88ba79277f84d3db207c7f118aa03', '2018-10-31 15:55:32.953', 49, 1, false, 'ad-hoc', NULL, 1, NULL, NULL, NULL);
INSERT INTO public.query_execution (id, hash, started_at, running_time, result_rows, native, context, error, executor_id, card_id, dashboard_id, pulse_id) VALUES (15, '\x2dfab27b6abefb1affd7b25131dbbbf59deb088e5a756050a5694e2b2be2ccb5', '2018-10-31 15:55:32.967', 34, 1, false, 'ad-hoc', NULL, 1, NULL, NULL, NULL);
INSERT INTO public.query_execution (id, hash, started_at, running_time, result_rows, native, context, error, executor_id, card_id, dashboard_id, pulse_id) VALUES (16, '\x4b9c8adee40dcfbd622b73ddb9940819ee662e61697eaec28ac3f799db7355bd', '2018-11-05 12:06:50.854', 241, 0, true, 'ad-hoc', 'Multiple ResultSets were returned by the query.', 1, NULL, NULL, NULL);
INSERT INTO public.query_execution (id, hash, started_at, running_time, result_rows, native, context, error, executor_id, card_id, dashboard_id, pulse_id) VALUES (17, '\x49c2d614c3f78de2c3890b6e5b976cf309456ca250290c3c5bedb04d3996bd92', '2018-11-05 12:06:57.916', 13, 1, true, 'ad-hoc', NULL, 1, NULL, NULL, NULL);
INSERT INTO public.query_execution (id, hash, started_at, running_time, result_rows, native, context, error, executor_id, card_id, dashboard_id, pulse_id) VALUES (18, '\x49c2d614c3f78de2c3890b6e5b976cf309456ca250290c3c5bedb04d3996bd92', '2018-11-05 12:07:35.336', 10, 1, true, 'question', NULL, 1, 1, NULL, NULL);
INSERT INTO public.query_execution (id, hash, started_at, running_time, result_rows, native, context, error, executor_id, card_id, dashboard_id, pulse_id) VALUES (19, '\x49c2d614c3f78de2c3890b6e5b976cf309456ca250290c3c5bedb04d3996bd92', '2018-11-05 12:07:44.209', 8, 1, true, 'question', NULL, 1, 1, NULL, NULL);
INSERT INTO public.query_execution (id, hash, started_at, running_time, result_rows, native, context, error, executor_id, card_id, dashboard_id, pulse_id) VALUES (20, '\x49c2d614c3f78de2c3890b6e5b976cf309456ca250290c3c5bedb04d3996bd92', '2018-11-05 12:08:33.414', 6, 1, true, 'question', NULL, 1, 1, NULL, NULL);
INSERT INTO public.query_execution (id, hash, started_at, running_time, result_rows, native, context, error, executor_id, card_id, dashboard_id, pulse_id) VALUES (21, '\xdd08c01bf699e58380def3c4d88d8c90b311f665c9fdc657935232a576cd8d51', '2018-11-05 12:16:14.531', 24, 2, false, 'ad-hoc', NULL, 1, NULL, NULL, NULL);
INSERT INTO public.query_execution (id, hash, started_at, running_time, result_rows, native, context, error, executor_id, card_id, dashboard_id, pulse_id) VALUES (22, '\x371cb284118365e14d43b76a31eb172463726f428c29bdd71a76808eb990d466', '2018-11-05 12:18:47.609', 42, 2, true, 'ad-hoc', NULL, 1, NULL, NULL, NULL);
INSERT INTO public.query_execution (id, hash, started_at, running_time, result_rows, native, context, error, executor_id, card_id, dashboard_id, pulse_id) VALUES (23, '\x49c2d614c3f78de2c3890b6e5b976cf309456ca250290c3c5bedb04d3996bd92', '2018-11-05 12:19:44.612', 5, 1, true, 'question', NULL, 1, 1, NULL, NULL);
INSERT INTO public.query_execution (id, hash, started_at, running_time, result_rows, native, context, error, executor_id, card_id, dashboard_id, pulse_id) VALUES (24, '\x371cb284118365e14d43b76a31eb172463726f428c29bdd71a76808eb990d466', '2018-11-05 12:19:44.709', 5, 2, true, 'question', NULL, 1, 2, NULL, NULL);
INSERT INTO public.query_execution (id, hash, started_at, running_time, result_rows, native, context, error, executor_id, card_id, dashboard_id, pulse_id) VALUES (25, '\x49c2d614c3f78de2c3890b6e5b976cf309456ca250290c3c5bedb04d3996bd92', '2018-11-05 12:24:21.577', 5, 1, true, 'question', NULL, 1, 1, NULL, NULL);
INSERT INTO public.query_execution (id, hash, started_at, running_time, result_rows, native, context, error, executor_id, card_id, dashboard_id, pulse_id) VALUES (26, '\x49c2d614c3f78de2c3890b6e5b976cf309456ca250290c3c5bedb04d3996bd92', '2018-11-05 12:24:26.853', 9, 1, true, 'question', NULL, 1, 1, NULL, NULL);
INSERT INTO public.query_execution (id, hash, started_at, running_time, result_rows, native, context, error, executor_id, card_id, dashboard_id, pulse_id) VALUES (27, '\x49c2d614c3f78de2c3890b6e5b976cf309456ca250290c3c5bedb04d3996bd92', '2018-11-05 12:24:45.381', 5, 1, true, 'question', NULL, 1, 1, NULL, NULL);
INSERT INTO public.query_execution (id, hash, started_at, running_time, result_rows, native, context, error, executor_id, card_id, dashboard_id, pulse_id) VALUES (28, '\x371cb284118365e14d43b76a31eb172463726f428c29bdd71a76808eb990d466', '2018-11-05 12:24:50.25', 13, 2, true, 'question', NULL, 1, 2, NULL, NULL);
INSERT INTO public.query_execution (id, hash, started_at, running_time, result_rows, native, context, error, executor_id, card_id, dashboard_id, pulse_id) VALUES (29, '\x49c2d614c3f78de2c3890b6e5b976cf309456ca250290c3c5bedb04d3996bd92', '2018-11-05 14:52:06.065', 359, 2, true, 'question', NULL, 1, 1, NULL, NULL);
INSERT INTO public.query_execution (id, hash, started_at, running_time, result_rows, native, context, error, executor_id, card_id, dashboard_id, pulse_id) VALUES (30, '\x49c2d614c3f78de2c3890b6e5b976cf309456ca250290c3c5bedb04d3996bd92', '2018-11-05 15:19:07.897', 336, 2, true, 'question', NULL, 1, 1, NULL, NULL);
INSERT INTO public.query_execution (id, hash, started_at, running_time, result_rows, native, context, error, executor_id, card_id, dashboard_id, pulse_id) VALUES (31, '\x371cb284118365e14d43b76a31eb172463726f428c29bdd71a76808eb990d466', '2018-11-05 15:19:16.993', 51, 2, true, 'question', NULL, 1, 2, NULL, NULL);
INSERT INTO public.query_execution (id, hash, started_at, running_time, result_rows, native, context, error, executor_id, card_id, dashboard_id, pulse_id) VALUES (32, '\x49c2d614c3f78de2c3890b6e5b976cf309456ca250290c3c5bedb04d3996bd92', '2018-11-05 15:19:28.389', 12, 2, true, 'question', NULL, 1, 1, NULL, NULL);
INSERT INTO public.query_execution (id, hash, started_at, running_time, result_rows, native, context, error, executor_id, card_id, dashboard_id, pulse_id) VALUES (33, '\x371cb284118365e14d43b76a31eb172463726f428c29bdd71a76808eb990d466', '2018-11-05 15:19:38.7', 22, 2, true, 'question', NULL, 1, 2, NULL, NULL);
INSERT INTO public.query_execution (id, hash, started_at, running_time, result_rows, native, context, error, executor_id, card_id, dashboard_id, pulse_id) VALUES (34, '\x49c2d614c3f78de2c3890b6e5b976cf309456ca250290c3c5bedb04d3996bd92', '2018-11-05 15:19:45.026', 38, 2, true, 'question', NULL, 1, 1, NULL, NULL);
INSERT INTO public.query_execution (id, hash, started_at, running_time, result_rows, native, context, error, executor_id, card_id, dashboard_id, pulse_id) VALUES (35, '\x371cb284118365e14d43b76a31eb172463726f428c29bdd71a76808eb990d466', '2018-11-05 15:19:45.03', 55, 2, true, 'question', NULL, 1, 2, NULL, NULL);
INSERT INTO public.query_execution (id, hash, started_at, running_time, result_rows, native, context, error, executor_id, card_id, dashboard_id, pulse_id) VALUES (36, '\xcf08c45513c73202d33b8790a72d9a8a227775b33ebca360c5e89d1d87e1500d', '2018-11-05 15:20:43.166', 20, 1, true, 'ad-hoc', NULL, 1, NULL, NULL, NULL);
INSERT INTO public.query_execution (id, hash, started_at, running_time, result_rows, native, context, error, executor_id, card_id, dashboard_id, pulse_id) VALUES (37, '\x7d9420e01bd543928631444c508b9c16e91e6e2d4b65d521f1bafb787e4884f7', '2018-11-05 15:21:43.949', 15, 2, true, 'ad-hoc', NULL, 1, NULL, NULL, NULL);
INSERT INTO public.query_execution (id, hash, started_at, running_time, result_rows, native, context, error, executor_id, card_id, dashboard_id, pulse_id) VALUES (38, '\x26c1af1c05c1294b478c973357c29fc4275b576facb08500434fe741bf52990d', '2018-11-05 16:48:08.916', 17, 2, true, 'ad-hoc', NULL, 1, NULL, NULL, NULL);
INSERT INTO public.query_execution (id, hash, started_at, running_time, result_rows, native, context, error, executor_id, card_id, dashboard_id, pulse_id) VALUES (39, '\x49c2d614c3f78de2c3890b6e5b976cf309456ca250290c3c5bedb04d3996bd92', '2018-11-05 16:48:37.31', 37, 2, true, 'question', NULL, 1, 1, NULL, NULL);
INSERT INTO public.query_execution (id, hash, started_at, running_time, result_rows, native, context, error, executor_id, card_id, dashboard_id, pulse_id) VALUES (40, '\x371cb284118365e14d43b76a31eb172463726f428c29bdd71a76808eb990d466', '2018-11-05 16:48:37.339', 59, 2, true, 'question', NULL, 1, 2, NULL, NULL);
INSERT INTO public.query_execution (id, hash, started_at, running_time, result_rows, native, context, error, executor_id, card_id, dashboard_id, pulse_id) VALUES (41, '\x26c1af1c05c1294b478c973357c29fc4275b576facb08500434fe741bf52990d', '2018-11-05 16:48:37.497', 33, 2, true, 'question', NULL, 1, 3, NULL, NULL);
INSERT INTO public.query_execution (id, hash, started_at, running_time, result_rows, native, context, error, executor_id, card_id, dashboard_id, pulse_id) VALUES (42, '\xae1f9b9080634ca90d271fc2b61c1d10e5c656dfb15179dfaa78e45096021a1d', '2018-11-05 16:48:58.586', 54, 2, true, 'ad-hoc', NULL, 1, NULL, NULL, NULL);
INSERT INTO public.query_execution (id, hash, started_at, running_time, result_rows, native, context, error, executor_id, card_id, dashboard_id, pulse_id) VALUES (43, '\x49c2d614c3f78de2c3890b6e5b976cf309456ca250290c3c5bedb04d3996bd92', '2018-11-05 16:49:19.292', 17, 2, true, 'question', NULL, 1, 1, NULL, NULL);
INSERT INTO public.query_execution (id, hash, started_at, running_time, result_rows, native, context, error, executor_id, card_id, dashboard_id, pulse_id) VALUES (44, '\x371cb284118365e14d43b76a31eb172463726f428c29bdd71a76808eb990d466', '2018-11-05 16:49:19.315', 6, 2, true, 'question', NULL, 1, 2, NULL, NULL);
INSERT INTO public.query_execution (id, hash, started_at, running_time, result_rows, native, context, error, executor_id, card_id, dashboard_id, pulse_id) VALUES (45, '\xae1f9b9080634ca90d271fc2b61c1d10e5c656dfb15179dfaa78e45096021a1d', '2018-11-05 16:49:19.468', 9, 2, true, 'question', NULL, 1, 4, NULL, NULL);
INSERT INTO public.query_execution (id, hash, started_at, running_time, result_rows, native, context, error, executor_id, card_id, dashboard_id, pulse_id) VALUES (46, '\x371cb284118365e14d43b76a31eb172463726f428c29bdd71a76808eb990d466', '2018-11-05 16:49:37.056', 11, 2, true, 'question', NULL, 1, 2, NULL, NULL);
INSERT INTO public.query_execution (id, hash, started_at, running_time, result_rows, native, context, error, executor_id, card_id, dashboard_id, pulse_id) VALUES (47, '\xae1f9b9080634ca90d271fc2b61c1d10e5c656dfb15179dfaa78e45096021a1d', '2018-11-05 16:49:37.064', 7, 2, true, 'question', NULL, 1, 4, NULL, NULL);
INSERT INTO public.query_execution (id, hash, started_at, running_time, result_rows, native, context, error, executor_id, card_id, dashboard_id, pulse_id) VALUES (48, '\x49c2d614c3f78de2c3890b6e5b976cf309456ca250290c3c5bedb04d3996bd92', '2018-11-05 16:49:37.053', 9, 2, true, 'question', NULL, 1, 1, NULL, NULL);
INSERT INTO public.query_execution (id, hash, started_at, running_time, result_rows, native, context, error, executor_id, card_id, dashboard_id, pulse_id) VALUES (49, '\x26c1af1c05c1294b478c973357c29fc4275b576facb08500434fe741bf52990d', '2018-11-05 16:49:42.044', 21, 2, true, 'question', NULL, 1, 3, NULL, NULL);
INSERT INTO public.query_execution (id, hash, started_at, running_time, result_rows, native, context, error, executor_id, card_id, dashboard_id, pulse_id) VALUES (50, '\x49c2d614c3f78de2c3890b6e5b976cf309456ca250290c3c5bedb04d3996bd92', '2018-11-06 07:58:37.185', 85, 2, true, 'question', NULL, 1, 1, NULL, NULL);
INSERT INTO public.query_execution (id, hash, started_at, running_time, result_rows, native, context, error, executor_id, card_id, dashboard_id, pulse_id) VALUES (51, '\xae1f9b9080634ca90d271fc2b61c1d10e5c656dfb15179dfaa78e45096021a1d', '2018-11-06 07:58:37.213', 58, 2, true, 'question', NULL, 1, 4, NULL, NULL);
INSERT INTO public.query_execution (id, hash, started_at, running_time, result_rows, native, context, error, executor_id, card_id, dashboard_id, pulse_id) VALUES (52, '\x371cb284118365e14d43b76a31eb172463726f428c29bdd71a76808eb990d466', '2018-11-06 07:58:37.214', 65, 2, true, 'question', NULL, 1, 2, NULL, NULL);
INSERT INTO public.query_execution (id, hash, started_at, running_time, result_rows, native, context, error, executor_id, card_id, dashboard_id, pulse_id) VALUES (53, '\x5ff0bf6b3f5d2b99fc080a9c8429e910955ff2a0f3bc1b2ea226ac681960c3af', '2018-11-06 07:58:54.312', 28, 3, true, 'ad-hoc', NULL, 1, NULL, NULL, NULL);
INSERT INTO public.query_execution (id, hash, started_at, running_time, result_rows, native, context, error, executor_id, card_id, dashboard_id, pulse_id) VALUES (54, '\x49c2d614c3f78de2c3890b6e5b976cf309456ca250290c3c5bedb04d3996bd92', '2018-11-06 07:59:23.132', 48, 2, true, 'question', NULL, 1, 1, NULL, NULL);
INSERT INTO public.query_execution (id, hash, started_at, running_time, result_rows, native, context, error, executor_id, card_id, dashboard_id, pulse_id) VALUES (55, '\xae1f9b9080634ca90d271fc2b61c1d10e5c656dfb15179dfaa78e45096021a1d', '2018-11-06 07:59:23.231', 16, 2, true, 'question', NULL, 1, 4, NULL, NULL);
INSERT INTO public.query_execution (id, hash, started_at, running_time, result_rows, native, context, error, executor_id, card_id, dashboard_id, pulse_id) VALUES (56, '\x371cb284118365e14d43b76a31eb172463726f428c29bdd71a76808eb990d466', '2018-11-06 07:59:23.231', 25, 2, true, 'question', NULL, 1, 2, NULL, NULL);
INSERT INTO public.query_execution (id, hash, started_at, running_time, result_rows, native, context, error, executor_id, card_id, dashboard_id, pulse_id) VALUES (57, '\x5ff0bf6b3f5d2b99fc080a9c8429e910955ff2a0f3bc1b2ea226ac681960c3af', '2018-11-06 07:59:23.257', 33, 3, true, 'question', NULL, 1, 5, NULL, NULL);
INSERT INTO public.query_execution (id, hash, started_at, running_time, result_rows, native, context, error, executor_id, card_id, dashboard_id, pulse_id) VALUES (58, '\x26c1af1c05c1294b478c973357c29fc4275b576facb08500434fe741bf52990d', '2018-11-06 07:59:40.368', 21, 2, true, 'question', NULL, 1, 3, NULL, NULL);
INSERT INTO public.query_execution (id, hash, started_at, running_time, result_rows, native, context, error, executor_id, card_id, dashboard_id, pulse_id) VALUES (59, '\x49c2d614c3f78de2c3890b6e5b976cf309456ca250290c3c5bedb04d3996bd92', '2018-11-06 09:41:11.924', 20, 2, true, 'question', NULL, 1, 1, NULL, NULL);
INSERT INTO public.query_execution (id, hash, started_at, running_time, result_rows, native, context, error, executor_id, card_id, dashboard_id, pulse_id) VALUES (60, '\x371cb284118365e14d43b76a31eb172463726f428c29bdd71a76808eb990d466', '2018-11-06 09:41:11.96', 32, 2, true, 'question', NULL, 1, 2, NULL, NULL);
INSERT INTO public.query_execution (id, hash, started_at, running_time, result_rows, native, context, error, executor_id, card_id, dashboard_id, pulse_id) VALUES (61, '\xae1f9b9080634ca90d271fc2b61c1d10e5c656dfb15179dfaa78e45096021a1d', '2018-11-06 09:41:11.994', 6, 2, true, 'question', NULL, 1, 4, NULL, NULL);


--
-- Data for Name: raw_column; Type: TABLE DATA; Schema: public; Owner: discovery
--



--
-- Data for Name: raw_table; Type: TABLE DATA; Schema: public; Owner: discovery
--



--
-- Data for Name: report_card; Type: TABLE DATA; Schema: public; Owner: discovery
--

INSERT INTO public.report_card (id, created_at, updated_at, name, description, display, dataset_query, visualization_settings, creator_id, database_id, table_id, query_type, archived, collection_id, public_uuid, made_public_by_id, enable_embedding, embedding_params, cache_ttl, result_metadata, read_permissions) VALUES (5, '2018-11-06 07:59:19.557+00', '2018-11-06 07:59:23.284+00', 'Engagment visit duration', NULL, 'bar', '{"database":2,"type":"native","native":{"query":"select * from recipes_basic.engagement_visit_duration;\n","template_tags":{}}}', '{"graph.dimensions":["Visit duration"],"graph.metrics":["Number of visits"]}', 1, 2, NULL, 'native', false, NULL, NULL, NULL, false, NULL, NULL, '[{"base_type":"type/Text","display_name":"Visit Duration","name":"Visit duration"},{"base_type":"type/Integer","display_name":"Number Of Visits","name":"Number of visits"}]', '["/db/2/native/read/"]');
INSERT INTO public.report_card (id, created_at, updated_at, name, description, display, dataset_query, visualization_settings, creator_id, database_id, table_id, query_type, archived, collection_id, public_uuid, made_public_by_id, enable_embedding, embedding_params, cache_ttl, result_metadata, read_permissions) VALUES (3, '2018-11-05 16:48:32.498+00', '2018-11-06 07:59:40.379+00', 'Operative systems', NULL, 'pie', '{"database":2,"type":"native","native":{"query":"select * from recipes_basic.technology_os;","template_tags":{}}}', '{}', 1, 2, NULL, 'native', false, NULL, NULL, NULL, false, NULL, NULL, '[{"base_type":"type/Text","display_name":"Os","name":"OS"},{"base_type":"type/Integer","display_name":"Visits","name":"Visits"}]', '["/db/2/native/read/"]');
INSERT INTO public.report_card (id, created_at, updated_at, name, description, display, dataset_query, visualization_settings, creator_id, database_id, table_id, query_type, archived, collection_id, public_uuid, made_public_by_id, enable_embedding, embedding_params, cache_ttl, result_metadata, read_permissions) VALUES (1, '2018-11-05 12:07:26.233+00', '2018-11-06 09:41:11.935+00', 'Uniques and visits by day', NULL, 'table', '{"database":2,"type":"native","native":{"query":"select * from recipes_basic.uniques_and_visits_by_day;\n","template_tags":{}}}', '{}', 1, 2, NULL, 'native', false, NULL, NULL, NULL, false, NULL, NULL, '[{"base_type":"type/DateTime","display_name":"Date","name":"Date"},{"base_type":"type/Integer","display_name":"Uni Ques","name":"Uniques"},{"base_type":"type/Integer","display_name":"Visits","name":"Visits"}]', '["/db/2/native/read/"]');
INSERT INTO public.report_card (id, created_at, updated_at, name, description, display, dataset_query, visualization_settings, creator_id, database_id, table_id, query_type, archived, collection_id, public_uuid, made_public_by_id, enable_embedding, embedding_params, cache_ttl, result_metadata, read_permissions) VALUES (2, '2018-11-05 12:19:38.245+00', '2018-11-06 09:41:11.984+00', 'visitors by language', NULL, 'bar', '{"database":2,"type":"native","native":{"query":"select * from recipes_basic.visitors_by_language;","template_tags":{}}}', '{"graph.dimensions":["br_lang"],"graph.metrics":["visitors"]}', 1, 2, NULL, 'native', false, NULL, NULL, NULL, false, NULL, NULL, '[{"base_type":"type/Text","display_name":"Br Lang","name":"br_lang"},{"base_type":"type/Integer","display_name":"Visitors","name":"visitors"}]', '["/db/2/native/read/"]');
INSERT INTO public.report_card (id, created_at, updated_at, name, description, display, dataset_query, visualization_settings, creator_id, database_id, table_id, query_type, archived, collection_id, public_uuid, made_public_by_id, enable_embedding, embedding_params, cache_ttl, result_metadata, read_permissions) VALUES (4, '2018-11-05 16:49:16.598+00', '2018-11-06 09:41:11.998+00', 'browser', NULL, 'row', '{"database":2,"type":"native","native":{"query":"select * from recipes_basic.technology_browser;","template_tags":{}}}', '{"graph.dimensions":["Browser"],"graph.metrics":["Visits"]}', 1, 2, NULL, 'native', false, NULL, NULL, NULL, false, NULL, NULL, '[{"base_type":"type/Text","display_name":"Browser","name":"Browser"},{"base_type":"type/Integer","display_name":"Visits","name":"Visits"}]', '["/db/2/native/read/"]');


--
-- Data for Name: report_cardfavorite; Type: TABLE DATA; Schema: public; Owner: discovery
--



--
-- Data for Name: report_dashboard; Type: TABLE DATA; Schema: public; Owner: discovery
--

INSERT INTO public.report_dashboard (id, created_at, updated_at, name, description, creator_id, parameters, points_of_interest, caveats, show_in_getting_started, public_uuid, made_public_by_id, enable_embedding, embedding_params, archived, "position") VALUES (1, '2018-11-05 12:00:58.023+00', '2018-11-06 09:41:03.72+00', 'recipes_basic', 'example', 1, '[]', NULL, NULL, false, NULL, NULL, false, NULL, false, NULL);


--
-- Data for Name: report_dashboardcard; Type: TABLE DATA; Schema: public; Owner: discovery
--

INSERT INTO public.report_dashboardcard (id, created_at, updated_at, "sizeX", "sizeY", "row", col, card_id, dashboard_id, parameter_mappings, visualization_settings) VALUES (1, '2018-11-05 12:07:39.532+00', '2018-11-05 16:49:31.865+00', 4, 4, 0, 0, 1, 1, '[]', '{}');
INSERT INTO public.report_dashboardcard (id, created_at, updated_at, "sizeX", "sizeY", "row", col, card_id, dashboard_id, parameter_mappings, visualization_settings) VALUES (2, '2018-11-05 15:19:42.027+00', '2018-11-05 16:49:31.869+00', 4, 4, 0, 4, 2, 1, '[]', '{}');
INSERT INTO public.report_dashboardcard (id, created_at, updated_at, "sizeX", "sizeY", "row", col, card_id, dashboard_id, parameter_mappings, visualization_settings) VALUES (3, '2018-11-05 16:49:31.804+00', '2018-11-05 16:49:31.873+00', 4, 4, 0, 8, 4, 1, '[]', '{}');


--
-- Data for Name: revision; Type: TABLE DATA; Schema: public; Owner: discovery
--

INSERT INTO public.revision (id, model, model_id, user_id, "timestamp", object, is_reversion, is_creation, message) VALUES (1, 'Dashboard', 1, 1, '2018-11-05 12:00:58.051+00', '{"description":"example","name":"recipes_basic","cards":[]}', false, true, NULL);
INSERT INTO public.revision (id, model, model_id, user_id, "timestamp", object, is_reversion, is_creation, message) VALUES (2, 'Card', 1, 1, '2018-11-05 12:07:26.24+00', '{"description":null,"archived":false,"table_id":null,"result_metadata":[{"base_type":"type/DateTime","display_name":"Date","name":"Date"},{"base_type":"type/Integer","display_name":"Uni Ques","name":"Uniques"},{"base_type":"type/Integer","display_name":"Visits","name":"Visits"}],"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"native","name":"Uniques and visits by day","read_permissions":["/db/2/native/read/"],"creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"native","native":{"query":"select * from recipes_basic.uniques_and_visits_by_day;\n","template_tags":{}}},"id":1,"display":"table","visualization_settings":{},"public_uuid":null}', false, true, NULL);
INSERT INTO public.revision (id, model, model_id, user_id, "timestamp", object, is_reversion, is_creation, message) VALUES (3, 'Dashboard', 1, 1, '2018-11-05 12:07:39.585+00', '{"description":"example","name":"recipes_basic","cards":[{"sizeX":2,"sizeY":2,"row":0,"col":0,"id":1,"card_id":1,"series":[]}]}', false, false, NULL);
INSERT INTO public.revision (id, model, model_id, user_id, "timestamp", object, is_reversion, is_creation, message) VALUES (4, 'Dashboard', 1, 1, '2018-11-05 12:07:39.665+00', '{"description":"example","name":"recipes_basic","cards":[{"sizeX":4,"sizeY":4,"row":0,"col":0,"id":1,"card_id":1,"series":[]}]}', false, false, NULL);
INSERT INTO public.revision (id, model, model_id, user_id, "timestamp", object, is_reversion, is_creation, message) VALUES (5, 'Dashboard', 1, 1, '2018-11-05 12:07:39.683+00', '{"description":"example","name":"recipes_basic","cards":[{"sizeX":4,"sizeY":4,"row":0,"col":0,"id":1,"card_id":1,"series":[]}]}', false, false, NULL);
INSERT INTO public.revision (id, model, model_id, user_id, "timestamp", object, is_reversion, is_creation, message) VALUES (6, 'Card', 2, 1, '2018-11-05 12:19:38.255+00', '{"description":null,"archived":false,"table_id":null,"result_metadata":[{"base_type":"type/Text","display_name":"Br Lang","name":"br_lang"},{"base_type":"type/Integer","display_name":"Visitors","name":"visitors"}],"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"native","name":"visitors by language","read_permissions":["/db/2/native/read/"],"creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"native","native":{"query":"select * from recipes_basic.visitors_by_language;","template_tags":{}}},"id":2,"display":"bar","visualization_settings":{"graph.dimensions":["br_lang"],"graph.metrics":["visitors"]},"public_uuid":null}', false, true, NULL);
INSERT INTO public.revision (id, model, model_id, user_id, "timestamp", object, is_reversion, is_creation, message) VALUES (7, 'Dashboard', 1, 1, '2018-11-05 15:19:42.054+00', '{"description":"example","name":"recipes_basic","cards":[{"sizeX":4,"sizeY":4,"row":0,"col":0,"id":1,"card_id":1,"series":[]},{"sizeX":2,"sizeY":2,"row":0,"col":0,"id":2,"card_id":2,"series":[]}]}', false, false, NULL);
INSERT INTO public.revision (id, model, model_id, user_id, "timestamp", object, is_reversion, is_creation, message) VALUES (8, 'Dashboard', 1, 1, '2018-11-05 15:19:42.116+00', '{"description":"example","name":"recipes_basic","cards":[{"sizeX":4,"sizeY":4,"row":0,"col":0,"id":1,"card_id":1,"series":[]},{"sizeX":4,"sizeY":4,"row":0,"col":4,"id":2,"card_id":2,"series":[]}]}', false, false, NULL);
INSERT INTO public.revision (id, model, model_id, user_id, "timestamp", object, is_reversion, is_creation, message) VALUES (9, 'Dashboard', 1, 1, '2018-11-05 15:19:42.142+00', '{"description":"example","name":"recipes_basic","cards":[{"sizeX":4,"sizeY":4,"row":0,"col":0,"id":1,"card_id":1,"series":[]},{"sizeX":4,"sizeY":4,"row":0,"col":4,"id":2,"card_id":2,"series":[]}]}', false, false, NULL);
INSERT INTO public.revision (id, model, model_id, user_id, "timestamp", object, is_reversion, is_creation, message) VALUES (10, 'Card', 3, 1, '2018-11-05 16:48:32.522+00', '{"description":null,"archived":false,"table_id":null,"result_metadata":[{"base_type":"type/Text","display_name":"Os","name":"OS"},{"base_type":"type/Integer","display_name":"Visits","name":"Visits"}],"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"native","name":"Operative systems","read_permissions":["/db/2/native/read/"],"creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"native","native":{"query":"select * from recipes_basic.technology_os;","template_tags":{}}},"id":3,"display":"pie","visualization_settings":{},"public_uuid":null}', false, true, NULL);
INSERT INTO public.revision (id, model, model_id, user_id, "timestamp", object, is_reversion, is_creation, message) VALUES (11, 'Card', 4, 1, '2018-11-05 16:49:16.634+00', '{"description":null,"archived":false,"table_id":null,"result_metadata":[{"base_type":"type/Text","display_name":"Browser","name":"Browser"},{"base_type":"type/Integer","display_name":"Visits","name":"Visits"}],"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"native","name":"browser","read_permissions":["/db/2/native/read/"],"creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"native","native":{"query":"select * from recipes_basic.technology_browser;","template_tags":{}}},"id":4,"display":"row","visualization_settings":{"graph.dimensions":["Browser"],"graph.metrics":["Visits"]},"public_uuid":null}', false, true, NULL);
INSERT INTO public.revision (id, model, model_id, user_id, "timestamp", object, is_reversion, is_creation, message) VALUES (12, 'Dashboard', 1, 1, '2018-11-05 16:49:31.845+00', '{"description":"example","name":"recipes_basic","cards":[{"sizeX":4,"sizeY":4,"row":0,"col":0,"id":1,"card_id":1,"series":[]},{"sizeX":4,"sizeY":4,"row":0,"col":4,"id":2,"card_id":2,"series":[]},{"sizeX":2,"sizeY":2,"row":0,"col":0,"id":3,"card_id":4,"series":[]}]}', false, false, NULL);
INSERT INTO public.revision (id, model, model_id, user_id, "timestamp", object, is_reversion, is_creation, message) VALUES (13, 'Dashboard', 1, 1, '2018-11-05 16:49:31.888+00', '{"description":"example","name":"recipes_basic","cards":[{"sizeX":4,"sizeY":4,"row":0,"col":0,"id":1,"card_id":1,"series":[]},{"sizeX":4,"sizeY":4,"row":0,"col":4,"id":2,"card_id":2,"series":[]},{"sizeX":4,"sizeY":4,"row":0,"col":8,"id":3,"card_id":4,"series":[]}]}', false, false, NULL);
INSERT INTO public.revision (id, model, model_id, user_id, "timestamp", object, is_reversion, is_creation, message) VALUES (14, 'Dashboard', 1, 1, '2018-11-05 16:49:31.903+00', '{"description":"example","name":"recipes_basic","cards":[{"sizeX":4,"sizeY":4,"row":0,"col":0,"id":1,"card_id":1,"series":[]},{"sizeX":4,"sizeY":4,"row":0,"col":4,"id":2,"card_id":2,"series":[]},{"sizeX":4,"sizeY":4,"row":0,"col":8,"id":3,"card_id":4,"series":[]}]}', false, false, NULL);
INSERT INTO public.revision (id, model, model_id, user_id, "timestamp", object, is_reversion, is_creation, message) VALUES (15, 'Card', 5, 1, '2018-11-06 07:59:19.655+00', '{"description":null,"archived":false,"table_id":null,"result_metadata":[{"base_type":"type/Text","display_name":"Visit Duration","name":"Visit duration"},{"base_type":"type/Integer","display_name":"Number Of Visits","name":"Number of visits"}],"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"native","name":"Engagment visit duration","read_permissions":["/db/2/native/read/"],"creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"native","native":{"query":"select * from recipes_basic.engagement_visit_duration;\n","template_tags":{}}},"id":5,"display":"bar","visualization_settings":{"graph.dimensions":["Visit duration"],"graph.metrics":["Number of visits"]},"public_uuid":null}', false, true, NULL);
INSERT INTO public.revision (id, model, model_id, user_id, "timestamp", object, is_reversion, is_creation, message) VALUES (16, 'Dashboard', 1, 1, '2018-11-06 09:40:59.527+00', '{"description":"example","name":"recipes_basic","cards":[{"sizeX":4,"sizeY":4,"row":0,"col":0,"id":1,"card_id":1,"series":[]},{"sizeX":4,"sizeY":4,"row":0,"col":4,"id":2,"card_id":2,"series":[]},{"sizeX":4,"sizeY":4,"row":0,"col":8,"id":3,"card_id":4,"series":[]}]}', false, false, NULL);
INSERT INTO public.revision (id, model, model_id, user_id, "timestamp", object, is_reversion, is_creation, message) VALUES (17, 'Dashboard', 1, 1, '2018-11-06 09:41:03.74+00', '{"description":"example","name":"recipes_basic","cards":[{"sizeX":4,"sizeY":4,"row":0,"col":0,"id":1,"card_id":1,"series":[]},{"sizeX":4,"sizeY":4,"row":0,"col":4,"id":2,"card_id":2,"series":[]},{"sizeX":4,"sizeY":4,"row":0,"col":8,"id":3,"card_id":4,"series":[]}]}', false, false, NULL);


--
-- Data for Name: segment; Type: TABLE DATA; Schema: public; Owner: discovery
--



--
-- Data for Name: setting; Type: TABLE DATA; Schema: public; Owner: discovery
--

INSERT INTO public.setting (key, value) VALUES ('site-url', 'http://0.0.0.0:3000');
INSERT INTO public.setting (key, value) VALUES ('site-uuid', '32d6651d-284d-4cb7-a832-581e0e59b47c');
INSERT INTO public.setting (key, value) VALUES ('version-info', '{"latest":{"version":"v0.30.4","released":"2018-09-27T12:09:36.358Z","patch":true,"highlights":["Metabase fails to launch in Chinese","Fix token status checking","Fix BigQuery SQL parameters with encrypted DB details"]},"older":[{"version":"v0.30.3","released":"2018-09-13T12:09:36.358Z","patch":true,"highlights":["Localization for Chinese, Japanese, Turkish, Persian","Self referencing FK leads to exception","Security improvements"]},{"version":"v0.30.2","released":"2018-09-06T12:09:36.358Z","patch":true,"highlights":["Localization for French + Norwegian","Stability fixes for HTTP/2"]},{"version":"v0.30.1","released":"2018-08-08T12:09:36.358Z","patch":true,"highlights":["Localization for Portuguese","Timezone fix","SQL Template tag re-ordering fix"]},{"version":"v0.30.0","released":"2018-08-08T12:09:36.358Z","patch":false,"highlights":["App wide search","Enhanced Collection permissions","Comparison X-Rays"]},{"version":"v0.29.3","released":"2018-05-12T12:09:36.358Z","patch":true,"highlights":["Fix X-ray rules loading on Oracle JVM 8"]},{"version":"v0.29.2","released":"2018-05-10T12:09:36.358Z","patch":true,"highlights":["Fix Spark Driver"]},{"version":"v0.29.1","released":"2018-05-10T11:09:36.358Z","patch":true,"highlights":["Better heroku memory consumption","Fixed X-Ray Bugs","Drill through from line chart selects wrong date"]},{"version":"v0.29.0","released":"2018-05-01T11:09:36.358Z","patch":false,"highlights":["New and Improved X-Rays","Search field values","Spark SQL Support"]},{"version":"v0.28.6","released":"2018-04-12T11:09:36.358Z","patch":true,"highlights":["Fix chart rendering in pulses"]},{"version":"v0.28.5","released":"2018-04-04T11:09:36.358Z","patch":true,"highlights":["Fix memory consumption for SQL templates","Fix public dashboards parameter validation","Fix Unable to add cards to dashboards or search for cards, StackOverflowError on backend"]},{"version":"v0.28.4","released":"2018-03-29T11:09:36.358Z","patch":true,"highlights":["Fix broken embedded dashboards","Fix migration regression","Fix input typing bug"]},{"version":"v0.28.3","released":"2018-03-23T11:09:36.358Z","patch":true,"highlights":["Security improvements"]},{"version":"v0.28.2","released":"2018-03-20T11:09:36.358Z","patch":true,"highlights":["Security improvements","Sort on custom and saved metrics","Performance improvements for large numbers of questions and dashboards"]},{"version":"v0.28.1","released":"2018-02-09T11:09:36.358Z","patch":true,"highlights":["Fix admin panel update string","Fix pulse rendering bug","Fix CSV & XLS download bug"]},{"version":"v0.28.0","released":"2018-02-07T11:09:36.358Z","patch":false,"highlights":["Text Cards in Dashboards","Pulse + Alert attachments","Performance Improvements"]},{"version":"v0.27.2","released":"2017-12-12T11:09:36.358Z","patch":true,"highlights":["Migration bug fix"]},{"version":"v0.27.1","released":"2017-12-01T11:09:36.358Z","patch":true,"highlights":["Migration bug fix","Apply filters to embedded downloads"]},{"version":"v0.27.0","released":"2017-11-27T11:09:36.358Z","patch":false,"highlights":["Alerts","X-Ray insights","Charting improvements"]},{"version":"v0.26.2","released":"2017-09-27T11:09:36.358Z","patch":true,"highlights":["Update Redshift Driver","Support Java 9","Fix performance issue with fields listing"]},{"version":"v0.26.1","released":"2017-09-27T11:09:36.358Z","patch":true,"highlights":["Fix migration issue on MySQL"]},{"version":"v0.26.0","released":"2017-09-26T11:09:36.358Z","patch":true,"highlights":["Segment + Metric X-Rays and Comparisons","Better control over metadata introspection process","Improved Timezone support and bug fixes"]},{"version":"v0.25.2","released":"2017-08-09T11:09:36.358Z","patch":true,"highlights":["Bug and performance fixes"]},{"version":"v0.25.1","released":"2017-07-27T11:09:36.358Z","patch":true,"highlights":["After upgrading to 0.25, unknown protocol error.","Don''t show saved questions in the permissions database lists","Elastic beanstalk upgrades broken in 0.25 "]},{"version":"v0.25.0","released":"2017-07-25T11:09:36.358Z","patch":false,"highlights":["Nested questions","Enum and custom remapping support","LDAP authentication support"]},{"version":"v0.24.2","released":"2017-06-01T11:09:36.358Z","patch":true,"highlights":["Misc Bug fixes"]},{"version":"v0.24.1","released":"2017-05-10T11:09:36.358Z","patch":true,"highlights":["Fix upgrades with MySQL/Mariadb"]},{"version":"v0.24.0","released":"2017-05-10T11:09:36.358Z","patch":false,"highlights":["Drill-through + Actions","Result Caching","Presto Driver"]},{"version":"v0.23.1","released":"2017-03-30T11:09:36.358Z","patch":true,"highlights":["Filter widgets for SQL Template Variables","Fix spurious startup error","Java 7 startup bug fixed"]},{"version":"v0.23.0","released":"2017-03-21T11:09:36.358Z","patch":false,"highlights":["Public links for cards + dashboards","Embedding cards + dashboards in other applications","Encryption of database credentials"]},{"version":"v0.22.2","released":"2017-01-10T11:09:36.358Z","patch":true,"highlights":["Fix startup on OpenJDK 7"]},{"version":"v0.22.1","released":"2017-01-10T11:09:36.358Z","patch":true,"highlights":["IMPORTANT: Closed a Collections Permissions security hole","Improved startup performance","Bug fixes"]},{"version":"v0.22.0","released":"2017-01-10T11:09:36.358Z","patch":false,"highlights":["Collections + Collections Permissions","Multiple Aggregations","Custom Expressions"]},{"version":"v0.21.1","released":"2016-12-08T11:09:36.358Z","patch":true,"highlights":["BigQuery bug fixes","Charting bug fixes"]},{"version":"v0.21.0","released":"2016-12-08T11:09:36.358Z","patch":false,"highlights":["Google Analytics Driver","Vertica Driver","Better Time + Date Filters"]},{"version":"v0.20.3","released":"2016-10-26T11:09:36.358Z","patch":true,"highlights":["Fix H2->MySQL/PostgreSQL migrations, part 2"]},{"version":"v0.20.2","released":"2016-10-25T11:09:36.358Z","patch":true,"highlights":["Support Oracle 10+11","Fix H2->MySQL/PostgreSQL migrations","Revision timestamp fix"]},{"version":"v0.20.1","released":"2016-10-18T11:09:36.358Z","patch":true,"highlights":["Lots of bug fixes"]},{"version":"v0.20.0","released":"2016-10-11T11:09:36.358Z","patch":false,"highlights":["Data access permissions","Oracle Driver","Charting improvements"]},{"version":"v0.19.3","released":"2016-08-12T11:09:36.358Z","patch":true,"highlights":["fix Dashboard editing header"]},{"version":"v0.19.2","released":"2016-08-10T11:09:36.358Z","patch":true,"highlights":["fix Dashboard chart titles","fix pin map saving"]},{"version":"v0.19.1","released":"2016-08-04T11:09:36.358Z","patch":true,"highlights":["fix Dashboard Filter Editing","fix CSV Download of SQL Templates","fix Metabot enabled toggle"]},{"version":"v0.19.0","released":"2016-08-01T21:09:36.358Z","patch":false,"highlights":["SSO via Google Accounts","SQL Templates","Better charting controls"]},{"version":"v0.18.1","released":"2016-06-29T21:09:36.358Z","patch":true,"highlights":["Fix for Hour of day sorting bug","Fix for Column ordering bug in BigQuery","Fix for Mongo charting bug"]},{"version":"v0.18.0","released":"2016-06-022T21:09:36.358Z","patch":false,"highlights":["Dashboard Filters","Crate.IO Support","Checklist for Metabase Admins","Converting Metabase Questions -> SQL"]},{"version":"v0.17.1","released":"2016-05-04T21:09:36.358Z","patch":true,"highlights":["Fix for Line chart ordering bug","Fix for Time granularity bugs"]},{"version":"v0.17.0","released":"2016-05-04T21:09:36.358Z","patch":false,"highlights":["Tags + Search for Saved Questions","Calculated columns","Faster Syncing of Metadata","Lots of database driver improvements and bug fixes"]},{"version":"v0.16.1","released":"2016-05-04T21:09:36.358Z","patch":true,"highlights":["Fixes for several time alignment issues (timezones)","Resolved problem with SQL Server db connections"]},{"version":"v0.16.0","released":"2016-05-04T21:09:36.358Z","patch":false,"highlights":["Fullscreen (and fabulous) Dashboards","Say hello to Metabot in Slack"]}]}');


--
-- Data for Name: view_log; Type: TABLE DATA; Schema: public; Owner: discovery
--

INSERT INTO public.view_log (id, user_id, model, model_id, "timestamp") VALUES (1, 1, 'dashboard', 1, '2018-11-05 12:00:58.085+00');
INSERT INTO public.view_log (id, user_id, model, model_id, "timestamp") VALUES (2, 1, 'dashboard', 1, '2018-11-05 12:01:03.985+00');
INSERT INTO public.view_log (id, user_id, model, model_id, "timestamp") VALUES (3, 1, 'card', 1, '2018-11-05 12:07:26.238+00');
INSERT INTO public.view_log (id, user_id, model, model_id, "timestamp") VALUES (4, 1, 'dashboard', 1, '2018-11-05 12:07:35.184+00');
INSERT INTO public.view_log (id, user_id, model, model_id, "timestamp") VALUES (5, 1, 'dashboard', 1, '2018-11-05 12:07:39.708+00');
INSERT INTO public.view_log (id, user_id, model, model_id, "timestamp") VALUES (6, 1, 'card', 1, '2018-11-05 12:07:44.138+00');
INSERT INTO public.view_log (id, user_id, model, model_id, "timestamp") VALUES (7, 1, 'dashboard', 1, '2018-11-05 12:08:33.388+00');
INSERT INTO public.view_log (id, user_id, model, model_id, "timestamp") VALUES (8, 1, 'card', 2, '2018-11-05 12:19:38.254+00');
INSERT INTO public.view_log (id, user_id, model, model_id, "timestamp") VALUES (9, 1, 'dashboard', 1, '2018-11-05 12:19:44.548+00');
INSERT INTO public.view_log (id, user_id, model, model_id, "timestamp") VALUES (10, 1, 'dashboard', 1, '2018-11-05 12:24:21.547+00');
INSERT INTO public.view_log (id, user_id, model, model_id, "timestamp") VALUES (11, 1, 'dashboard', 1, '2018-11-05 12:24:26.834+00');
INSERT INTO public.view_log (id, user_id, model, model_id, "timestamp") VALUES (12, 1, 'dashboard', 1, '2018-11-05 12:24:45.357+00');
INSERT INTO public.view_log (id, user_id, model, model_id, "timestamp") VALUES (13, 1, 'dashboard', 1, '2018-11-05 15:19:07.855+00');
INSERT INTO public.view_log (id, user_id, model, model_id, "timestamp") VALUES (14, 1, 'card', 2, '2018-11-05 15:19:16.845+00');
INSERT INTO public.view_log (id, user_id, model, model_id, "timestamp") VALUES (15, 1, 'dashboard', 1, '2018-11-05 15:19:28.361+00');
INSERT INTO public.view_log (id, user_id, model, model_id, "timestamp") VALUES (16, 1, 'dashboard', 1, '2018-11-05 15:19:42.16+00');
INSERT INTO public.view_log (id, user_id, model, model_id, "timestamp") VALUES (17, 1, 'dashboard', 1, '2018-11-05 15:19:45.002+00');
INSERT INTO public.view_log (id, user_id, model, model_id, "timestamp") VALUES (18, 1, 'card', 3, '2018-11-05 16:48:32.515+00');
INSERT INTO public.view_log (id, user_id, model, model_id, "timestamp") VALUES (19, 1, 'dashboard', 1, '2018-11-05 16:48:37.264+00');
INSERT INTO public.view_log (id, user_id, model, model_id, "timestamp") VALUES (20, 1, 'card', 4, '2018-11-05 16:49:16.619+00');
INSERT INTO public.view_log (id, user_id, model, model_id, "timestamp") VALUES (21, 1, 'dashboard', 1, '2018-11-05 16:49:19.257+00');
INSERT INTO public.view_log (id, user_id, model, model_id, "timestamp") VALUES (22, 1, 'dashboard', 1, '2018-11-05 16:49:31.914+00');
INSERT INTO public.view_log (id, user_id, model, model_id, "timestamp") VALUES (23, 1, 'dashboard', 1, '2018-11-05 16:49:37.037+00');
INSERT INTO public.view_log (id, user_id, model, model_id, "timestamp") VALUES (24, 1, 'dashboard', 1, '2018-11-06 07:58:37.132+00');
INSERT INTO public.view_log (id, user_id, model, model_id, "timestamp") VALUES (25, 1, 'card', 5, '2018-11-06 07:59:19.57+00');
INSERT INTO public.view_log (id, user_id, model, model_id, "timestamp") VALUES (26, 1, 'dashboard', 1, '2018-11-06 07:59:23.094+00');
INSERT INTO public.view_log (id, user_id, model, model_id, "timestamp") VALUES (27, 1, 'dashboard', 1, '2018-11-06 09:41:11.903+00');


--
-- Name: activity_id_seq; Type: SEQUENCE SET; Schema: public; Owner: discovery
--

SELECT pg_catalog.setval('public.activity_id_seq', 10, true);


--
-- Name: card_label_id_seq; Type: SEQUENCE SET; Schema: public; Owner: discovery
--

SELECT pg_catalog.setval('public.card_label_id_seq', 1, false);


--
-- Name: collection_id_seq; Type: SEQUENCE SET; Schema: public; Owner: discovery
--

SELECT pg_catalog.setval('public.collection_id_seq', 1, false);


--
-- Name: collection_revision_id_seq; Type: SEQUENCE SET; Schema: public; Owner: discovery
--

SELECT pg_catalog.setval('public.collection_revision_id_seq', 1, false);


--
-- Name: computation_job_id_seq; Type: SEQUENCE SET; Schema: public; Owner: discovery
--

SELECT pg_catalog.setval('public.computation_job_id_seq', 1, false);


--
-- Name: computation_job_result_id_seq; Type: SEQUENCE SET; Schema: public; Owner: discovery
--

SELECT pg_catalog.setval('public.computation_job_result_id_seq', 1, false);


--
-- Name: core_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: discovery
--

SELECT pg_catalog.setval('public.core_user_id_seq', 1, true);


--
-- Name: dashboard_favorite_id_seq; Type: SEQUENCE SET; Schema: public; Owner: discovery
--

SELECT pg_catalog.setval('public.dashboard_favorite_id_seq', 1, false);


--
-- Name: dashboardcard_series_id_seq; Type: SEQUENCE SET; Schema: public; Owner: discovery
--

SELECT pg_catalog.setval('public.dashboardcard_series_id_seq', 1, false);


--
-- Name: dependency_id_seq; Type: SEQUENCE SET; Schema: public; Owner: discovery
--

SELECT pg_catalog.setval('public.dependency_id_seq', 1, false);


--
-- Name: dimension_id_seq; Type: SEQUENCE SET; Schema: public; Owner: discovery
--

SELECT pg_catalog.setval('public.dimension_id_seq', 1, false);


--
-- Name: label_id_seq; Type: SEQUENCE SET; Schema: public; Owner: discovery
--

SELECT pg_catalog.setval('public.label_id_seq', 1, false);


--
-- Name: metabase_database_id_seq; Type: SEQUENCE SET; Schema: public; Owner: discovery
--

SELECT pg_catalog.setval('public.metabase_database_id_seq', 2, true);


--
-- Name: metabase_field_id_seq; Type: SEQUENCE SET; Schema: public; Owner: discovery
--

SELECT pg_catalog.setval('public.metabase_field_id_seq', 1236, true);


--
-- Name: metabase_fieldvalues_id_seq; Type: SEQUENCE SET; Schema: public; Owner: discovery
--

SELECT pg_catalog.setval('public.metabase_fieldvalues_id_seq', 674, true);


--
-- Name: metabase_table_id_seq; Type: SEQUENCE SET; Schema: public; Owner: discovery
--

SELECT pg_catalog.setval('public.metabase_table_id_seq', 60, true);


--
-- Name: metric_id_seq; Type: SEQUENCE SET; Schema: public; Owner: discovery
--

SELECT pg_catalog.setval('public.metric_id_seq', 1, false);


--
-- Name: metric_important_field_id_seq; Type: SEQUENCE SET; Schema: public; Owner: discovery
--

SELECT pg_catalog.setval('public.metric_important_field_id_seq', 1, false);


--
-- Name: permissions_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: discovery
--

SELECT pg_catalog.setval('public.permissions_group_id_seq', 3, true);


--
-- Name: permissions_group_membership_id_seq; Type: SEQUENCE SET; Schema: public; Owner: discovery
--

SELECT pg_catalog.setval('public.permissions_group_membership_id_seq', 2, true);


--
-- Name: permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: discovery
--

SELECT pg_catalog.setval('public.permissions_id_seq', 5, true);


--
-- Name: permissions_revision_id_seq; Type: SEQUENCE SET; Schema: public; Owner: discovery
--

SELECT pg_catalog.setval('public.permissions_revision_id_seq', 1, false);


--
-- Name: pulse_card_id_seq; Type: SEQUENCE SET; Schema: public; Owner: discovery
--

SELECT pg_catalog.setval('public.pulse_card_id_seq', 1, false);


--
-- Name: pulse_channel_id_seq; Type: SEQUENCE SET; Schema: public; Owner: discovery
--

SELECT pg_catalog.setval('public.pulse_channel_id_seq', 1, false);


--
-- Name: pulse_channel_recipient_id_seq; Type: SEQUENCE SET; Schema: public; Owner: discovery
--

SELECT pg_catalog.setval('public.pulse_channel_recipient_id_seq', 1, false);


--
-- Name: pulse_id_seq; Type: SEQUENCE SET; Schema: public; Owner: discovery
--

SELECT pg_catalog.setval('public.pulse_id_seq', 1, false);


--
-- Name: query_execution_id_seq; Type: SEQUENCE SET; Schema: public; Owner: discovery
--

SELECT pg_catalog.setval('public.query_execution_id_seq', 61, true);


--
-- Name: raw_column_id_seq; Type: SEQUENCE SET; Schema: public; Owner: discovery
--

SELECT pg_catalog.setval('public.raw_column_id_seq', 1, false);


--
-- Name: raw_table_id_seq; Type: SEQUENCE SET; Schema: public; Owner: discovery
--

SELECT pg_catalog.setval('public.raw_table_id_seq', 1, false);


--
-- Name: report_card_id_seq; Type: SEQUENCE SET; Schema: public; Owner: discovery
--

SELECT pg_catalog.setval('public.report_card_id_seq', 5, true);


--
-- Name: report_cardfavorite_id_seq; Type: SEQUENCE SET; Schema: public; Owner: discovery
--

SELECT pg_catalog.setval('public.report_cardfavorite_id_seq', 1, false);


--
-- Name: report_dashboard_id_seq; Type: SEQUENCE SET; Schema: public; Owner: discovery
--

SELECT pg_catalog.setval('public.report_dashboard_id_seq', 1, true);


--
-- Name: report_dashboardcard_id_seq; Type: SEQUENCE SET; Schema: public; Owner: discovery
--

SELECT pg_catalog.setval('public.report_dashboardcard_id_seq', 3, true);


--
-- Name: revision_id_seq; Type: SEQUENCE SET; Schema: public; Owner: discovery
--

SELECT pg_catalog.setval('public.revision_id_seq', 17, true);


--
-- Name: segment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: discovery
--

SELECT pg_catalog.setval('public.segment_id_seq', 1, false);


--
-- Name: view_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: discovery
--

SELECT pg_catalog.setval('public.view_log_id_seq', 27, true);


--
-- Name: collection collection_slug_key; Type: CONSTRAINT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.collection
    ADD CONSTRAINT collection_slug_key UNIQUE (slug);


--
-- Name: core_user core_user_email_key; Type: CONSTRAINT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.core_user
    ADD CONSTRAINT core_user_email_key UNIQUE (email);


--
-- Name: report_cardfavorite idx_unique_cardfavorite_card_id_owner_id; Type: CONSTRAINT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.report_cardfavorite
    ADD CONSTRAINT idx_unique_cardfavorite_card_id_owner_id UNIQUE (card_id, owner_id);


--
-- Name: label label_slug_key; Type: CONSTRAINT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.label
    ADD CONSTRAINT label_slug_key UNIQUE (slug);


--
-- Name: permissions permissions_group_id_object_key; Type: CONSTRAINT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.permissions
    ADD CONSTRAINT permissions_group_id_object_key UNIQUE (group_id, object);


--
-- Name: activity pk_activity; Type: CONSTRAINT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.activity
    ADD CONSTRAINT pk_activity PRIMARY KEY (id);


--
-- Name: card_label pk_card_label; Type: CONSTRAINT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.card_label
    ADD CONSTRAINT pk_card_label PRIMARY KEY (id);


--
-- Name: collection pk_collection; Type: CONSTRAINT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.collection
    ADD CONSTRAINT pk_collection PRIMARY KEY (id);


--
-- Name: collection_revision pk_collection_revision; Type: CONSTRAINT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.collection_revision
    ADD CONSTRAINT pk_collection_revision PRIMARY KEY (id);


--
-- Name: computation_job pk_computation_job; Type: CONSTRAINT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.computation_job
    ADD CONSTRAINT pk_computation_job PRIMARY KEY (id);


--
-- Name: computation_job_result pk_computation_job_result; Type: CONSTRAINT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.computation_job_result
    ADD CONSTRAINT pk_computation_job_result PRIMARY KEY (id);


--
-- Name: core_session pk_core_session; Type: CONSTRAINT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.core_session
    ADD CONSTRAINT pk_core_session PRIMARY KEY (id);


--
-- Name: core_user pk_core_user; Type: CONSTRAINT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.core_user
    ADD CONSTRAINT pk_core_user PRIMARY KEY (id);


--
-- Name: dashboard_favorite pk_dashboard_favorite; Type: CONSTRAINT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.dashboard_favorite
    ADD CONSTRAINT pk_dashboard_favorite PRIMARY KEY (id);


--
-- Name: dashboardcard_series pk_dashboardcard_series; Type: CONSTRAINT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.dashboardcard_series
    ADD CONSTRAINT pk_dashboardcard_series PRIMARY KEY (id);


--
-- Name: data_migrations pk_data_migrations; Type: CONSTRAINT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.data_migrations
    ADD CONSTRAINT pk_data_migrations PRIMARY KEY (id);


--
-- Name: databasechangeloglock pk_databasechangeloglock; Type: CONSTRAINT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT pk_databasechangeloglock PRIMARY KEY (id);


--
-- Name: dependency pk_dependency; Type: CONSTRAINT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.dependency
    ADD CONSTRAINT pk_dependency PRIMARY KEY (id);


--
-- Name: dimension pk_dimension; Type: CONSTRAINT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.dimension
    ADD CONSTRAINT pk_dimension PRIMARY KEY (id);


--
-- Name: label pk_label; Type: CONSTRAINT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.label
    ADD CONSTRAINT pk_label PRIMARY KEY (id);


--
-- Name: metabase_database pk_metabase_database; Type: CONSTRAINT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.metabase_database
    ADD CONSTRAINT pk_metabase_database PRIMARY KEY (id);


--
-- Name: metabase_field pk_metabase_field; Type: CONSTRAINT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.metabase_field
    ADD CONSTRAINT pk_metabase_field PRIMARY KEY (id);


--
-- Name: metabase_fieldvalues pk_metabase_fieldvalues; Type: CONSTRAINT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.metabase_fieldvalues
    ADD CONSTRAINT pk_metabase_fieldvalues PRIMARY KEY (id);


--
-- Name: metabase_table pk_metabase_table; Type: CONSTRAINT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.metabase_table
    ADD CONSTRAINT pk_metabase_table PRIMARY KEY (id);


--
-- Name: metric pk_metric; Type: CONSTRAINT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.metric
    ADD CONSTRAINT pk_metric PRIMARY KEY (id);


--
-- Name: metric_important_field pk_metric_important_field; Type: CONSTRAINT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.metric_important_field
    ADD CONSTRAINT pk_metric_important_field PRIMARY KEY (id);


--
-- Name: permissions pk_permissions; Type: CONSTRAINT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.permissions
    ADD CONSTRAINT pk_permissions PRIMARY KEY (id);


--
-- Name: permissions_group pk_permissions_group; Type: CONSTRAINT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.permissions_group
    ADD CONSTRAINT pk_permissions_group PRIMARY KEY (id);


--
-- Name: permissions_group_membership pk_permissions_group_membership; Type: CONSTRAINT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.permissions_group_membership
    ADD CONSTRAINT pk_permissions_group_membership PRIMARY KEY (id);


--
-- Name: permissions_revision pk_permissions_revision; Type: CONSTRAINT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.permissions_revision
    ADD CONSTRAINT pk_permissions_revision PRIMARY KEY (id);


--
-- Name: pulse pk_pulse; Type: CONSTRAINT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.pulse
    ADD CONSTRAINT pk_pulse PRIMARY KEY (id);


--
-- Name: pulse_card pk_pulse_card; Type: CONSTRAINT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.pulse_card
    ADD CONSTRAINT pk_pulse_card PRIMARY KEY (id);


--
-- Name: pulse_channel pk_pulse_channel; Type: CONSTRAINT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.pulse_channel
    ADD CONSTRAINT pk_pulse_channel PRIMARY KEY (id);


--
-- Name: pulse_channel_recipient pk_pulse_channel_recipient; Type: CONSTRAINT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.pulse_channel_recipient
    ADD CONSTRAINT pk_pulse_channel_recipient PRIMARY KEY (id);


--
-- Name: query pk_query; Type: CONSTRAINT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.query
    ADD CONSTRAINT pk_query PRIMARY KEY (query_hash);


--
-- Name: query_cache pk_query_cache; Type: CONSTRAINT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.query_cache
    ADD CONSTRAINT pk_query_cache PRIMARY KEY (query_hash);


--
-- Name: query_execution pk_query_execution; Type: CONSTRAINT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.query_execution
    ADD CONSTRAINT pk_query_execution PRIMARY KEY (id);


--
-- Name: raw_column pk_raw_column; Type: CONSTRAINT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.raw_column
    ADD CONSTRAINT pk_raw_column PRIMARY KEY (id);


--
-- Name: raw_table pk_raw_table; Type: CONSTRAINT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.raw_table
    ADD CONSTRAINT pk_raw_table PRIMARY KEY (id);


--
-- Name: report_card pk_report_card; Type: CONSTRAINT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.report_card
    ADD CONSTRAINT pk_report_card PRIMARY KEY (id);


--
-- Name: report_cardfavorite pk_report_cardfavorite; Type: CONSTRAINT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.report_cardfavorite
    ADD CONSTRAINT pk_report_cardfavorite PRIMARY KEY (id);


--
-- Name: report_dashboard pk_report_dashboard; Type: CONSTRAINT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.report_dashboard
    ADD CONSTRAINT pk_report_dashboard PRIMARY KEY (id);


--
-- Name: report_dashboardcard pk_report_dashboardcard; Type: CONSTRAINT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.report_dashboardcard
    ADD CONSTRAINT pk_report_dashboardcard PRIMARY KEY (id);


--
-- Name: revision pk_revision; Type: CONSTRAINT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.revision
    ADD CONSTRAINT pk_revision PRIMARY KEY (id);


--
-- Name: segment pk_segment; Type: CONSTRAINT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.segment
    ADD CONSTRAINT pk_segment PRIMARY KEY (id);


--
-- Name: setting pk_setting; Type: CONSTRAINT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.setting
    ADD CONSTRAINT pk_setting PRIMARY KEY (key);


--
-- Name: view_log pk_view_log; Type: CONSTRAINT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.view_log
    ADD CONSTRAINT pk_view_log PRIMARY KEY (id);


--
-- Name: report_card report_card_public_uuid_key; Type: CONSTRAINT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.report_card
    ADD CONSTRAINT report_card_public_uuid_key UNIQUE (public_uuid);


--
-- Name: report_dashboard report_dashboard_public_uuid_key; Type: CONSTRAINT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.report_dashboard
    ADD CONSTRAINT report_dashboard_public_uuid_key UNIQUE (public_uuid);


--
-- Name: raw_column uniq_raw_column_table_name; Type: CONSTRAINT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.raw_column
    ADD CONSTRAINT uniq_raw_column_table_name UNIQUE (raw_table_id, name);


--
-- Name: raw_table uniq_raw_table_db_schema_name; Type: CONSTRAINT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.raw_table
    ADD CONSTRAINT uniq_raw_table_db_schema_name UNIQUE (database_id, schema, name);


--
-- Name: card_label unique_card_label_card_id_label_id; Type: CONSTRAINT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.card_label
    ADD CONSTRAINT unique_card_label_card_id_label_id UNIQUE (card_id, label_id);


--
-- Name: dashboard_favorite unique_dashboard_favorite_user_id_dashboard_id; Type: CONSTRAINT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.dashboard_favorite
    ADD CONSTRAINT unique_dashboard_favorite_user_id_dashboard_id UNIQUE (user_id, dashboard_id);


--
-- Name: dimension unique_dimension_field_id_name; Type: CONSTRAINT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.dimension
    ADD CONSTRAINT unique_dimension_field_id_name UNIQUE (field_id, name);


--
-- Name: metric_important_field unique_metric_important_field_metric_id_field_id; Type: CONSTRAINT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.metric_important_field
    ADD CONSTRAINT unique_metric_important_field_metric_id_field_id UNIQUE (metric_id, field_id);


--
-- Name: permissions_group_membership unique_permissions_group_membership_user_id_group_id; Type: CONSTRAINT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.permissions_group_membership
    ADD CONSTRAINT unique_permissions_group_membership_user_id_group_id UNIQUE (user_id, group_id);


--
-- Name: permissions_group unique_permissions_group_name; Type: CONSTRAINT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.permissions_group
    ADD CONSTRAINT unique_permissions_group_name UNIQUE (name);


--
-- Name: idx_activity_custom_id; Type: INDEX; Schema: public; Owner: discovery
--

CREATE INDEX idx_activity_custom_id ON public.activity USING btree (custom_id);


--
-- Name: idx_activity_timestamp; Type: INDEX; Schema: public; Owner: discovery
--

CREATE INDEX idx_activity_timestamp ON public.activity USING btree ("timestamp");


--
-- Name: idx_activity_user_id; Type: INDEX; Schema: public; Owner: discovery
--

CREATE INDEX idx_activity_user_id ON public.activity USING btree (user_id);


--
-- Name: idx_card_collection_id; Type: INDEX; Schema: public; Owner: discovery
--

CREATE INDEX idx_card_collection_id ON public.report_card USING btree (collection_id);


--
-- Name: idx_card_creator_id; Type: INDEX; Schema: public; Owner: discovery
--

CREATE INDEX idx_card_creator_id ON public.report_card USING btree (creator_id);


--
-- Name: idx_card_label_card_id; Type: INDEX; Schema: public; Owner: discovery
--

CREATE INDEX idx_card_label_card_id ON public.card_label USING btree (card_id);


--
-- Name: idx_card_label_label_id; Type: INDEX; Schema: public; Owner: discovery
--

CREATE INDEX idx_card_label_label_id ON public.card_label USING btree (label_id);


--
-- Name: idx_card_public_uuid; Type: INDEX; Schema: public; Owner: discovery
--

CREATE INDEX idx_card_public_uuid ON public.report_card USING btree (public_uuid);


--
-- Name: idx_cardfavorite_card_id; Type: INDEX; Schema: public; Owner: discovery
--

CREATE INDEX idx_cardfavorite_card_id ON public.report_cardfavorite USING btree (card_id);


--
-- Name: idx_cardfavorite_owner_id; Type: INDEX; Schema: public; Owner: discovery
--

CREATE INDEX idx_cardfavorite_owner_id ON public.report_cardfavorite USING btree (owner_id);


--
-- Name: idx_collection_slug; Type: INDEX; Schema: public; Owner: discovery
--

CREATE INDEX idx_collection_slug ON public.collection USING btree (slug);


--
-- Name: idx_dashboard_creator_id; Type: INDEX; Schema: public; Owner: discovery
--

CREATE INDEX idx_dashboard_creator_id ON public.report_dashboard USING btree (creator_id);


--
-- Name: idx_dashboard_favorite_dashboard_id; Type: INDEX; Schema: public; Owner: discovery
--

CREATE INDEX idx_dashboard_favorite_dashboard_id ON public.dashboard_favorite USING btree (dashboard_id);


--
-- Name: idx_dashboard_favorite_user_id; Type: INDEX; Schema: public; Owner: discovery
--

CREATE INDEX idx_dashboard_favorite_user_id ON public.dashboard_favorite USING btree (user_id);


--
-- Name: idx_dashboard_public_uuid; Type: INDEX; Schema: public; Owner: discovery
--

CREATE INDEX idx_dashboard_public_uuid ON public.report_dashboard USING btree (public_uuid);


--
-- Name: idx_dashboardcard_card_id; Type: INDEX; Schema: public; Owner: discovery
--

CREATE INDEX idx_dashboardcard_card_id ON public.report_dashboardcard USING btree (card_id);


--
-- Name: idx_dashboardcard_dashboard_id; Type: INDEX; Schema: public; Owner: discovery
--

CREATE INDEX idx_dashboardcard_dashboard_id ON public.report_dashboardcard USING btree (dashboard_id);


--
-- Name: idx_dashboardcard_series_card_id; Type: INDEX; Schema: public; Owner: discovery
--

CREATE INDEX idx_dashboardcard_series_card_id ON public.dashboardcard_series USING btree (card_id);


--
-- Name: idx_dashboardcard_series_dashboardcard_id; Type: INDEX; Schema: public; Owner: discovery
--

CREATE INDEX idx_dashboardcard_series_dashboardcard_id ON public.dashboardcard_series USING btree (dashboardcard_id);


--
-- Name: idx_data_migrations_id; Type: INDEX; Schema: public; Owner: discovery
--

CREATE INDEX idx_data_migrations_id ON public.data_migrations USING btree (id);


--
-- Name: idx_dependency_dependent_on_id; Type: INDEX; Schema: public; Owner: discovery
--

CREATE INDEX idx_dependency_dependent_on_id ON public.dependency USING btree (dependent_on_id);


--
-- Name: idx_dependency_dependent_on_model; Type: INDEX; Schema: public; Owner: discovery
--

CREATE INDEX idx_dependency_dependent_on_model ON public.dependency USING btree (dependent_on_model);


--
-- Name: idx_dependency_model; Type: INDEX; Schema: public; Owner: discovery
--

CREATE INDEX idx_dependency_model ON public.dependency USING btree (model);


--
-- Name: idx_dependency_model_id; Type: INDEX; Schema: public; Owner: discovery
--

CREATE INDEX idx_dependency_model_id ON public.dependency USING btree (model_id);


--
-- Name: idx_dimension_field_id; Type: INDEX; Schema: public; Owner: discovery
--

CREATE INDEX idx_dimension_field_id ON public.dimension USING btree (field_id);


--
-- Name: idx_field_table_id; Type: INDEX; Schema: public; Owner: discovery
--

CREATE INDEX idx_field_table_id ON public.metabase_field USING btree (table_id);


--
-- Name: idx_fieldvalues_field_id; Type: INDEX; Schema: public; Owner: discovery
--

CREATE INDEX idx_fieldvalues_field_id ON public.metabase_fieldvalues USING btree (field_id);


--
-- Name: idx_label_slug; Type: INDEX; Schema: public; Owner: discovery
--

CREATE INDEX idx_label_slug ON public.label USING btree (slug);


--
-- Name: idx_metabase_table_db_id_schema; Type: INDEX; Schema: public; Owner: discovery
--

CREATE INDEX idx_metabase_table_db_id_schema ON public.metabase_table USING btree (schema);


--
-- Name: idx_metabase_table_show_in_getting_started; Type: INDEX; Schema: public; Owner: discovery
--

CREATE INDEX idx_metabase_table_show_in_getting_started ON public.metabase_table USING btree (show_in_getting_started);


--
-- Name: idx_metric_creator_id; Type: INDEX; Schema: public; Owner: discovery
--

CREATE INDEX idx_metric_creator_id ON public.metric USING btree (creator_id);


--
-- Name: idx_metric_important_field_field_id; Type: INDEX; Schema: public; Owner: discovery
--

CREATE INDEX idx_metric_important_field_field_id ON public.metric_important_field USING btree (field_id);


--
-- Name: idx_metric_important_field_metric_id; Type: INDEX; Schema: public; Owner: discovery
--

CREATE INDEX idx_metric_important_field_metric_id ON public.metric_important_field USING btree (metric_id);


--
-- Name: idx_metric_show_in_getting_started; Type: INDEX; Schema: public; Owner: discovery
--

CREATE INDEX idx_metric_show_in_getting_started ON public.metric USING btree (show_in_getting_started);


--
-- Name: idx_metric_table_id; Type: INDEX; Schema: public; Owner: discovery
--

CREATE INDEX idx_metric_table_id ON public.metric USING btree (table_id);


--
-- Name: idx_permissions_group_id; Type: INDEX; Schema: public; Owner: discovery
--

CREATE INDEX idx_permissions_group_id ON public.permissions USING btree (group_id);


--
-- Name: idx_permissions_group_id_object; Type: INDEX; Schema: public; Owner: discovery
--

CREATE INDEX idx_permissions_group_id_object ON public.permissions USING btree (object);


--
-- Name: idx_permissions_group_membership_group_id; Type: INDEX; Schema: public; Owner: discovery
--

CREATE INDEX idx_permissions_group_membership_group_id ON public.permissions_group_membership USING btree (group_id);


--
-- Name: idx_permissions_group_membership_group_id_user_id; Type: INDEX; Schema: public; Owner: discovery
--

CREATE INDEX idx_permissions_group_membership_group_id_user_id ON public.permissions_group_membership USING btree (user_id);


--
-- Name: idx_permissions_group_membership_user_id; Type: INDEX; Schema: public; Owner: discovery
--

CREATE INDEX idx_permissions_group_membership_user_id ON public.permissions_group_membership USING btree (user_id);


--
-- Name: idx_permissions_group_name; Type: INDEX; Schema: public; Owner: discovery
--

CREATE INDEX idx_permissions_group_name ON public.permissions_group USING btree (name);


--
-- Name: idx_permissions_object; Type: INDEX; Schema: public; Owner: discovery
--

CREATE INDEX idx_permissions_object ON public.permissions USING btree (object);


--
-- Name: idx_pulse_card_card_id; Type: INDEX; Schema: public; Owner: discovery
--

CREATE INDEX idx_pulse_card_card_id ON public.pulse_card USING btree (card_id);


--
-- Name: idx_pulse_card_pulse_id; Type: INDEX; Schema: public; Owner: discovery
--

CREATE INDEX idx_pulse_card_pulse_id ON public.pulse_card USING btree (pulse_id);


--
-- Name: idx_pulse_channel_pulse_id; Type: INDEX; Schema: public; Owner: discovery
--

CREATE INDEX idx_pulse_channel_pulse_id ON public.pulse_channel USING btree (pulse_id);


--
-- Name: idx_pulse_channel_schedule_type; Type: INDEX; Schema: public; Owner: discovery
--

CREATE INDEX idx_pulse_channel_schedule_type ON public.pulse_channel USING btree (schedule_type);


--
-- Name: idx_pulse_creator_id; Type: INDEX; Schema: public; Owner: discovery
--

CREATE INDEX idx_pulse_creator_id ON public.pulse USING btree (creator_id);


--
-- Name: idx_query_cache_updated_at; Type: INDEX; Schema: public; Owner: discovery
--

CREATE INDEX idx_query_cache_updated_at ON public.query_cache USING btree (updated_at);


--
-- Name: idx_query_execution_query_hash_started_at; Type: INDEX; Schema: public; Owner: discovery
--

CREATE INDEX idx_query_execution_query_hash_started_at ON public.query_execution USING btree (started_at);


--
-- Name: idx_query_execution_started_at; Type: INDEX; Schema: public; Owner: discovery
--

CREATE INDEX idx_query_execution_started_at ON public.query_execution USING btree (started_at);


--
-- Name: idx_rawcolumn_raw_table_id; Type: INDEX; Schema: public; Owner: discovery
--

CREATE INDEX idx_rawcolumn_raw_table_id ON public.raw_column USING btree (raw_table_id);


--
-- Name: idx_rawtable_database_id; Type: INDEX; Schema: public; Owner: discovery
--

CREATE INDEX idx_rawtable_database_id ON public.raw_table USING btree (database_id);


--
-- Name: idx_report_dashboard_show_in_getting_started; Type: INDEX; Schema: public; Owner: discovery
--

CREATE INDEX idx_report_dashboard_show_in_getting_started ON public.report_dashboard USING btree (show_in_getting_started);


--
-- Name: idx_revision_model_model_id; Type: INDEX; Schema: public; Owner: discovery
--

CREATE INDEX idx_revision_model_model_id ON public.revision USING btree (model_id);


--
-- Name: idx_segment_creator_id; Type: INDEX; Schema: public; Owner: discovery
--

CREATE INDEX idx_segment_creator_id ON public.segment USING btree (creator_id);


--
-- Name: idx_segment_show_in_getting_started; Type: INDEX; Schema: public; Owner: discovery
--

CREATE INDEX idx_segment_show_in_getting_started ON public.segment USING btree (show_in_getting_started);


--
-- Name: idx_segment_table_id; Type: INDEX; Schema: public; Owner: discovery
--

CREATE INDEX idx_segment_table_id ON public.segment USING btree (table_id);


--
-- Name: idx_table_db_id; Type: INDEX; Schema: public; Owner: discovery
--

CREATE INDEX idx_table_db_id ON public.metabase_table USING btree (db_id);


--
-- Name: idx_view_log_timestamp; Type: INDEX; Schema: public; Owner: discovery
--

CREATE INDEX idx_view_log_timestamp ON public.view_log USING btree (model_id);


--
-- Name: idx_view_log_user_id; Type: INDEX; Schema: public; Owner: discovery
--

CREATE INDEX idx_view_log_user_id ON public.view_log USING btree (user_id);


--
-- Name: activity fk_activity_ref_user_id; Type: FK CONSTRAINT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.activity
    ADD CONSTRAINT fk_activity_ref_user_id FOREIGN KEY (user_id) REFERENCES public.core_user(id);


--
-- Name: report_card fk_card_collection_id; Type: FK CONSTRAINT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.report_card
    ADD CONSTRAINT fk_card_collection_id FOREIGN KEY (collection_id) REFERENCES public.collection(id);


--
-- Name: card_label fk_card_label_ref_card_id; Type: FK CONSTRAINT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.card_label
    ADD CONSTRAINT fk_card_label_ref_card_id FOREIGN KEY (card_id) REFERENCES public.report_card(id);


--
-- Name: card_label fk_card_label_ref_label_id; Type: FK CONSTRAINT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.card_label
    ADD CONSTRAINT fk_card_label_ref_label_id FOREIGN KEY (label_id) REFERENCES public.label(id);


--
-- Name: report_card fk_card_made_public_by_id; Type: FK CONSTRAINT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.report_card
    ADD CONSTRAINT fk_card_made_public_by_id FOREIGN KEY (made_public_by_id) REFERENCES public.core_user(id);


--
-- Name: report_card fk_card_ref_user_id; Type: FK CONSTRAINT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.report_card
    ADD CONSTRAINT fk_card_ref_user_id FOREIGN KEY (creator_id) REFERENCES public.core_user(id);


--
-- Name: report_cardfavorite fk_cardfavorite_ref_card_id; Type: FK CONSTRAINT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.report_cardfavorite
    ADD CONSTRAINT fk_cardfavorite_ref_card_id FOREIGN KEY (card_id) REFERENCES public.report_card(id);


--
-- Name: report_cardfavorite fk_cardfavorite_ref_user_id; Type: FK CONSTRAINT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.report_cardfavorite
    ADD CONSTRAINT fk_cardfavorite_ref_user_id FOREIGN KEY (owner_id) REFERENCES public.core_user(id);


--
-- Name: collection_revision fk_collection_revision_user_id; Type: FK CONSTRAINT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.collection_revision
    ADD CONSTRAINT fk_collection_revision_user_id FOREIGN KEY (user_id) REFERENCES public.core_user(id);


--
-- Name: computation_job fk_computation_job_ref_user_id; Type: FK CONSTRAINT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.computation_job
    ADD CONSTRAINT fk_computation_job_ref_user_id FOREIGN KEY (creator_id) REFERENCES public.core_user(id);


--
-- Name: computation_job_result fk_computation_result_ref_job_id; Type: FK CONSTRAINT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.computation_job_result
    ADD CONSTRAINT fk_computation_result_ref_job_id FOREIGN KEY (job_id) REFERENCES public.computation_job(id);


--
-- Name: dashboard_favorite fk_dashboard_favorite_dashboard_id; Type: FK CONSTRAINT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.dashboard_favorite
    ADD CONSTRAINT fk_dashboard_favorite_dashboard_id FOREIGN KEY (dashboard_id) REFERENCES public.report_dashboard(id) ON DELETE CASCADE;


--
-- Name: dashboard_favorite fk_dashboard_favorite_user_id; Type: FK CONSTRAINT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.dashboard_favorite
    ADD CONSTRAINT fk_dashboard_favorite_user_id FOREIGN KEY (user_id) REFERENCES public.core_user(id) ON DELETE CASCADE;


--
-- Name: report_dashboard fk_dashboard_made_public_by_id; Type: FK CONSTRAINT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.report_dashboard
    ADD CONSTRAINT fk_dashboard_made_public_by_id FOREIGN KEY (made_public_by_id) REFERENCES public.core_user(id);


--
-- Name: report_dashboard fk_dashboard_ref_user_id; Type: FK CONSTRAINT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.report_dashboard
    ADD CONSTRAINT fk_dashboard_ref_user_id FOREIGN KEY (creator_id) REFERENCES public.core_user(id);


--
-- Name: report_dashboardcard fk_dashboardcard_ref_card_id; Type: FK CONSTRAINT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.report_dashboardcard
    ADD CONSTRAINT fk_dashboardcard_ref_card_id FOREIGN KEY (card_id) REFERENCES public.report_card(id);


--
-- Name: report_dashboardcard fk_dashboardcard_ref_dashboard_id; Type: FK CONSTRAINT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.report_dashboardcard
    ADD CONSTRAINT fk_dashboardcard_ref_dashboard_id FOREIGN KEY (dashboard_id) REFERENCES public.report_dashboard(id);


--
-- Name: dashboardcard_series fk_dashboardcard_series_ref_card_id; Type: FK CONSTRAINT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.dashboardcard_series
    ADD CONSTRAINT fk_dashboardcard_series_ref_card_id FOREIGN KEY (card_id) REFERENCES public.report_card(id);


--
-- Name: dashboardcard_series fk_dashboardcard_series_ref_dashboardcard_id; Type: FK CONSTRAINT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.dashboardcard_series
    ADD CONSTRAINT fk_dashboardcard_series_ref_dashboardcard_id FOREIGN KEY (dashboardcard_id) REFERENCES public.report_dashboardcard(id);


--
-- Name: dimension fk_dimension_displayfk_ref_field_id; Type: FK CONSTRAINT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.dimension
    ADD CONSTRAINT fk_dimension_displayfk_ref_field_id FOREIGN KEY (human_readable_field_id) REFERENCES public.metabase_field(id) ON DELETE CASCADE;


--
-- Name: dimension fk_dimension_ref_field_id; Type: FK CONSTRAINT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.dimension
    ADD CONSTRAINT fk_dimension_ref_field_id FOREIGN KEY (field_id) REFERENCES public.metabase_field(id) ON DELETE CASCADE;


--
-- Name: metabase_field fk_field_parent_ref_field_id; Type: FK CONSTRAINT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.metabase_field
    ADD CONSTRAINT fk_field_parent_ref_field_id FOREIGN KEY (parent_id) REFERENCES public.metabase_field(id);


--
-- Name: metabase_field fk_field_ref_table_id; Type: FK CONSTRAINT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.metabase_field
    ADD CONSTRAINT fk_field_ref_table_id FOREIGN KEY (table_id) REFERENCES public.metabase_table(id);


--
-- Name: metabase_fieldvalues fk_fieldvalues_ref_field_id; Type: FK CONSTRAINT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.metabase_fieldvalues
    ADD CONSTRAINT fk_fieldvalues_ref_field_id FOREIGN KEY (field_id) REFERENCES public.metabase_field(id);


--
-- Name: metric_important_field fk_metric_important_field_metabase_field_id; Type: FK CONSTRAINT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.metric_important_field
    ADD CONSTRAINT fk_metric_important_field_metabase_field_id FOREIGN KEY (field_id) REFERENCES public.metabase_field(id);


--
-- Name: metric_important_field fk_metric_important_field_metric_id; Type: FK CONSTRAINT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.metric_important_field
    ADD CONSTRAINT fk_metric_important_field_metric_id FOREIGN KEY (metric_id) REFERENCES public.metric(id);


--
-- Name: metric fk_metric_ref_creator_id; Type: FK CONSTRAINT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.metric
    ADD CONSTRAINT fk_metric_ref_creator_id FOREIGN KEY (creator_id) REFERENCES public.core_user(id);


--
-- Name: metric fk_metric_ref_table_id; Type: FK CONSTRAINT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.metric
    ADD CONSTRAINT fk_metric_ref_table_id FOREIGN KEY (table_id) REFERENCES public.metabase_table(id);


--
-- Name: permissions_group_membership fk_permissions_group_group_id; Type: FK CONSTRAINT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.permissions_group_membership
    ADD CONSTRAINT fk_permissions_group_group_id FOREIGN KEY (group_id) REFERENCES public.permissions_group(id);


--
-- Name: permissions fk_permissions_group_id; Type: FK CONSTRAINT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.permissions
    ADD CONSTRAINT fk_permissions_group_id FOREIGN KEY (group_id) REFERENCES public.permissions_group(id);


--
-- Name: permissions_group_membership fk_permissions_group_membership_user_id; Type: FK CONSTRAINT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.permissions_group_membership
    ADD CONSTRAINT fk_permissions_group_membership_user_id FOREIGN KEY (user_id) REFERENCES public.core_user(id);


--
-- Name: permissions_revision fk_permissions_revision_user_id; Type: FK CONSTRAINT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.permissions_revision
    ADD CONSTRAINT fk_permissions_revision_user_id FOREIGN KEY (user_id) REFERENCES public.core_user(id);


--
-- Name: pulse_card fk_pulse_card_ref_card_id; Type: FK CONSTRAINT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.pulse_card
    ADD CONSTRAINT fk_pulse_card_ref_card_id FOREIGN KEY (card_id) REFERENCES public.report_card(id);


--
-- Name: pulse_card fk_pulse_card_ref_pulse_id; Type: FK CONSTRAINT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.pulse_card
    ADD CONSTRAINT fk_pulse_card_ref_pulse_id FOREIGN KEY (pulse_id) REFERENCES public.pulse(id);


--
-- Name: pulse_channel_recipient fk_pulse_channel_recipient_ref_pulse_channel_id; Type: FK CONSTRAINT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.pulse_channel_recipient
    ADD CONSTRAINT fk_pulse_channel_recipient_ref_pulse_channel_id FOREIGN KEY (pulse_channel_id) REFERENCES public.pulse_channel(id);


--
-- Name: pulse_channel_recipient fk_pulse_channel_recipient_ref_user_id; Type: FK CONSTRAINT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.pulse_channel_recipient
    ADD CONSTRAINT fk_pulse_channel_recipient_ref_user_id FOREIGN KEY (user_id) REFERENCES public.core_user(id);


--
-- Name: pulse_channel fk_pulse_channel_ref_pulse_id; Type: FK CONSTRAINT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.pulse_channel
    ADD CONSTRAINT fk_pulse_channel_ref_pulse_id FOREIGN KEY (pulse_id) REFERENCES public.pulse(id);


--
-- Name: pulse fk_pulse_ref_creator_id; Type: FK CONSTRAINT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.pulse
    ADD CONSTRAINT fk_pulse_ref_creator_id FOREIGN KEY (creator_id) REFERENCES public.core_user(id);


--
-- Name: raw_column fk_rawcolumn_fktarget_ref_rawcolumn; Type: FK CONSTRAINT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.raw_column
    ADD CONSTRAINT fk_rawcolumn_fktarget_ref_rawcolumn FOREIGN KEY (fk_target_column_id) REFERENCES public.raw_column(id);


--
-- Name: raw_column fk_rawcolumn_tableid_ref_rawtable; Type: FK CONSTRAINT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.raw_column
    ADD CONSTRAINT fk_rawcolumn_tableid_ref_rawtable FOREIGN KEY (raw_table_id) REFERENCES public.raw_table(id);


--
-- Name: report_card fk_report_card_ref_database_id; Type: FK CONSTRAINT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.report_card
    ADD CONSTRAINT fk_report_card_ref_database_id FOREIGN KEY (database_id) REFERENCES public.metabase_database(id);


--
-- Name: report_card fk_report_card_ref_table_id; Type: FK CONSTRAINT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.report_card
    ADD CONSTRAINT fk_report_card_ref_table_id FOREIGN KEY (table_id) REFERENCES public.metabase_table(id);


--
-- Name: revision fk_revision_ref_user_id; Type: FK CONSTRAINT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.revision
    ADD CONSTRAINT fk_revision_ref_user_id FOREIGN KEY (user_id) REFERENCES public.core_user(id);


--
-- Name: segment fk_segment_ref_creator_id; Type: FK CONSTRAINT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.segment
    ADD CONSTRAINT fk_segment_ref_creator_id FOREIGN KEY (creator_id) REFERENCES public.core_user(id);


--
-- Name: segment fk_segment_ref_table_id; Type: FK CONSTRAINT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.segment
    ADD CONSTRAINT fk_segment_ref_table_id FOREIGN KEY (table_id) REFERENCES public.metabase_table(id);


--
-- Name: core_session fk_session_ref_user_id; Type: FK CONSTRAINT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.core_session
    ADD CONSTRAINT fk_session_ref_user_id FOREIGN KEY (user_id) REFERENCES public.core_user(id);


--
-- Name: metabase_table fk_table_ref_database_id; Type: FK CONSTRAINT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.metabase_table
    ADD CONSTRAINT fk_table_ref_database_id FOREIGN KEY (db_id) REFERENCES public.metabase_database(id);


--
-- Name: view_log fk_view_log_ref_user_id; Type: FK CONSTRAINT; Schema: public; Owner: discovery
--

ALTER TABLE ONLY public.view_log
    ADD CONSTRAINT fk_view_log_ref_user_id FOREIGN KEY (user_id) REFERENCES public.core_user(id);


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

