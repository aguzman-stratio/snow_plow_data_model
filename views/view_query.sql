
-- Uniques and visits by day;
select * from recipes_basic.uniques_and_visits_by_day;

-- Pageviews by day;

select * from recipes_basic.pageviews_by_day;

-- Events by day by type;
select * from  recipes_basic.events_by_day;

-- Pages per visit (frequency table for last month of data);

select * from recipes_basic.pages_per_visit;

-- Bounce rate by day;
select* from recipes_basic.bounce_rate_by_day;

-- % New visits fraction_new_visits==0 pq?;
select * from recipes_basic.fraction_new_visits_by_day;

-- Average visit duration;
select * from recipes_basic.avg_visit_duration_by_day ;

-- Demographics: language;
select * from recipes_basic.visitors_by_language;

-- Demographics: location;

select * from recipes_basic.visits_by_country;

-- NEW vs Returning;
select * from recipes_basic.new_vs_returning;

--frequency;

select * from recipes_basic.behavior_frequency;

-- Behavior: recency;

select * from recipes_basic.behavior_recency;

-- Behavior: engagement - visit duration;
select * from recipes_basic.engagement_visit_duration;

-- Behavior: engagement - page views per visit;
select * from recipes_basic.engagement_pageviews_per_visit;


-- Technology: browser;
select * from recipes_basic.technology_browser;


-- Technology: Operating System;

select * from recipes_basic.technology_os;

-- Technology: mobile;
select * from recipes_basic.technology_mobile;

