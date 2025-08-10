--
-- Content Tables
-- This file contains content, translations, popups, and communication related tables
--

CREATE TABLE public.contents (
    id bigint NOT NULL,
    language_id character varying DEFAULT 'en'::character varying NOT NULL,
    text text,
    link text,
    image text,
    category_id smallint,
    brand_id smallint NOT NULL,
    status_id smallint DEFAULT 1 NOT NULL,
    name text,
    created timestamp without time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    updated timestamp without time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    tags jsonb,
    type smallint DEFAULT 1 NOT NULL
);

CREATE TABLE public.comms (
    id bigint NOT NULL,
    email jsonb,
    event character varying,
    param jsonb,
    brand_id smallint DEFAULT 101 NOT NULL,
    category_id smallint,
    template character varying,
    push jsonb,
    sms jsonb,
    name character varying,
    wa jsonb,
    inapp jsonb,
    chat jsonb,
    pre_validation jsonb,
    languages jsonb
);

CREATE TABLE public.translations (
    language_id character varying(5) NOT NULL,
    entity_id character varying NOT NULL,
    txt character varying,
    brand_id smallint NOT NULL,
    created timestamp without time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    created_by integer,
    updated timestamp without time zone DEFAULT timezone('utc'::text, now()),
    updated_by integer,
    "position" jsonb,
    pre_validated character varying,
    auto_generated boolean,
    status smallint DEFAULT 3 NOT NULL,
    CONSTRAINT translations_no_spaces CHECK (((entity_id)::text !~ '\s'::text))
);

COMMENT ON COLUMN public.translations.status IS '1. draft
2. waiting approval
3. published
4. new (New content from a-love)';

CREATE TABLE public.translations_language (
    id smallint NOT NULL,
    name character varying NOT NULL,
    code character varying NOT NULL,
    is_completed boolean DEFAULT false,
    brand_id smallint DEFAULT 101,
    local_name character varying,
    flag character varying NOT NULL,
    rtl boolean DEFAULT false NOT NULL
);

CREATE TABLE public.translations_positions (
    id integer NOT NULL,
    position_name character varying,
    created_by integer,
    updated_by integer,
    created timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    is_active boolean DEFAULT true NOT NULL,
    img character varying,
    "for" character varying,
    parent_id bigint
);

CREATE TABLE public.popup_categories (
    id smallint NOT NULL,
    name character varying NOT NULL,
    brand_id smallint NOT NULL
);

CREATE TABLE public.popups (
    id bigint NOT NULL,
    event character varying NOT NULL,
    title character varying,
    body character varying,
    button1_title character varying,
    button2_title character varying,
    cancel_title character varying,
    note character varying,
    image character varying,
    brand_id smallint NOT NULL,
    param character varying,
    type smallint DEFAULT 0 NOT NULL,
    category_id smallint,
    fields_order character varying,
    action_url character varying,
    styles jsonb,
    status_id smallint DEFAULT 2 NOT NULL,
    name character varying,
    subtitle character varying,
    next_event_type character varying,
    action_url2 character varying,
    next_event_type2 character varying,
    extra jsonb,
    languages jsonb,
    pre_validation jsonb
);

COMMENT ON COLUMN public.popups.type IS '0 = Popup
1 = Bottom Modal';

CREATE TABLE public.general_codes (
    id smallint NOT NULL,
    name character varying NOT NULL,
    type character varying NOT NULL,
    parent_id smallint,
    extra jsonb,
    brand_id smallint,
    ordinal smallint,
    is_active boolean DEFAULT true NOT NULL
);

CREATE TABLE public.settings (
    brand_id smallint NOT NULL,
    param_name character varying DEFAULT false NOT NULL,
    param_value character varying,
    param_type character varying,
    for_client boolean DEFAULT false,
    description character varying,
    prevalidated_param_value character varying,
    "position" jsonb,
    belongs character varying,
    category_id smallint
);

CREATE TABLE public.settings_communications (
    profile_id uuid NOT NULL,
    channel_id smallint NOT NULL,
    category_id smallint NOT NULL,
    state boolean NOT NULL,
    updated timestamp without time zone DEFAULT timezone('UTC'::text, now()),
    created timestamp without time zone DEFAULT timezone('UTC'::text, now())
); 