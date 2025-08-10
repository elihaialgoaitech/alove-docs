--
-- Schemas and Core Tables
-- This file contains schema definitions and basic lookup tables
--

-- Create schemas
CREATE SCHEMA events;
CREATE SCHEMA matchmakers;

-- Core lookup tables
CREATE TABLE public.profile_status (
    id smallint NOT NULL,
    name character varying NOT NULL
);

CREATE TABLE public.unit (
    id smallint NOT NULL,
    name character varying(30) NOT NULL
);

CREATE TABLE public.asset_status (
    id smallint NOT NULL,
    name character varying NOT NULL
);

CREATE TABLE public.asset_type (
    asset_id smallint NOT NULL,
    asset_name character varying NOT NULL
);

CREATE TABLE public.factor (
    id smallint NOT NULL,
    name character varying NOT NULL
);

CREATE TABLE public.brand (
    id smallint NOT NULL,
    name character varying NOT NULL,
    contact_email character varying,
    user_pool_id character varying,
    avatar character varying,
    folder character varying,
    userpool_client_id character varying,
    is_active boolean DEFAULT true
);

CREATE TABLE public.role (
    id smallint NOT NULL,
    name character varying NOT NULL
);

CREATE TABLE public.workflow_status (
    id smallint NOT NULL,
    name character varying(50) NOT NULL
);

CREATE TABLE public.response_types (
    id integer NOT NULL,
    name character varying(50)
);

CREATE TABLE public.question_state (
    id smallint NOT NULL,
    name character varying NOT NULL,
    created timestamp without time zone DEFAULT timezone('utc'::text, now()) NOT NULL
);

CREATE TABLE public.question_type (
    id smallint NOT NULL,
    name character varying NOT NULL,
    created timestamp without time zone DEFAULT timezone('utc'::text, now()) NOT NULL
);

CREATE TABLE public.introduction_status (
    id smallint NOT NULL,
    name character varying NOT NULL,
    isfinal boolean NOT NULL
);

CREATE TABLE public.introduction_decline_reasons (
    id smallint NOT NULL,
    decline_reason_txt character varying NOT NULL
);

CREATE TABLE public.profile_report_reason (
    id smallint NOT NULL,
    name character varying NOT NULL
);

CREATE TABLE public.snooze_reason (
    id smallint NOT NULL,
    name character varying NOT NULL
);

CREATE TABLE public.predictor (
    id smallint NOT NULL,
    name character varying NOT NULL,
    is_negative character varying DEFAULT false NOT NULL
); 