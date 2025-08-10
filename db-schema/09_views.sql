--
-- Database Views
-- This file contains all database views
--

CREATE VIEW public.profile_responses_current AS
 WITH current_responses AS (
         SELECT pr.id,
            pr.profile_id,
            pr.batch_content_id,
            pr.response,
            pr.reported,
            pr.created,
            pr.score,
            pr.language_id,
            pr.skip_reason_id,
            row_number() OVER (PARTITION BY pr.profile_id, pr.batch_content_id ORDER BY pr.created DESC) AS rn
           FROM public.profile_responses pr
          WHERE (pr.skip_reason_id < 2)
        )
 SELECT current_responses.id,
    current_responses.profile_id,
    current_responses.batch_content_id,
    current_responses.response,
    current_responses.reported,
    current_responses.created,
    current_responses.score,
    current_responses.language_id,
    current_responses.skip_reason_id
   FROM current_responses
  WHERE (current_responses.rn = 1);

CREATE VIEW public.showprofile_core AS
 SELECT p.profile_id,
    p.user_id,
    p.is_internal,
    ps.name AS profile_status,
    p.snoozed_until,
    p.created,
    p.attributes_values,
    p.last_successful_login,
    p.last_introduction_request,
    (p.attributes_values -> 'livingPlace'::text) AS living_place,
    pr.comment AS report
   FROM ((public.profiles p
     JOIN public.profile_status ps ON ((ps.id = p.status_id)))
     LEFT JOIN public.profile_reports pr ON ((pr.profile_id = p.profile_id)));

CREATE VIEW public.showprofile_introductions AS
 SELECT i.introduction_id,
    i.created,
    is2.name AS introduction_status,
    i.initiator_profile_id,
    i.responder_profile_id,
    i.updated,
    age(date_trunc('seconds'::text,
        CASE
            WHEN (i.status_id = ANY (ARRAY[1, 2])) THEN CURRENT_TIMESTAMP
            ELSE (i.updated)::timestamp with time zone
        END), (date_trunc('seconds'::text, i.created))::timestamp with time zone) AS duration,
    (i.status_id = ANY (ARRAY[1, 2])) AS introduction_active
   FROM (public.introductions i
     JOIN public.introduction_status is2 ON ((is2.id = i.status_id)))
  ORDER BY i.created DESC;

CREATE VIEW public.showprofile_reports AS
 SELECT pr.profile_report_id,
    pr.profile_id,
    pr.created,
    prr.name AS report_reason,
    pr.reported_by,
    pr.comment,
    (COALESCE(reporters.cases, (0)::bigint) > 0) AS mutual_report
   FROM ((public.profile_reports pr
     JOIN public.profile_report_reason prr ON ((prr.id = pr.reason_id)))
     LEFT JOIN ( SELECT pr2.profile_id,
            pr2.reported_by,
            count(*) AS cases
           FROM public.profile_reports pr2
          GROUP BY pr2.profile_id, pr2.reported_by) reporters ON (((reporters.profile_id = pr.reported_by) AND (reporters.reported_by = pr.profile_id))))
  ORDER BY pr.profile_id, pr.created DESC; 