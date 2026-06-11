
-- 1)Which industries face highest automation risk on average?
   select industry_sector ,
   round(AVG(sector_automation_risk_score),3) as avg_automation_risk ,
   count(*) as total_records 
   from workforce_ai_impact
   group by industry_sector
   order by avg_automation_risk desc;
   
   -- 2) Which countries face highest automation risk?
   select country,iso3_code ,
   round( avg(sector_automation_risk_score),3) as avg_risk,
    round(avg(ai_adoption_index), 3) as avg_ai_adoption,
    round(avg(gdp_per_capita_usd),0) as avg_gdp
    from workforce_ai_impact
    group by country, iso3_code 
    order by avg_risk desc
    limit 10 ;
    
    -- 3)How does India compare sector by sector?
    select industry_sector,
    round(avg(sector_automation_risk_score),2) as india_risk_score,
    round(avg(pct_sector_workforce_displaced),2) as india_displaced_pct,
    round(avg(ai_skill_wage_premium_pct),2) as india_wage_premium_pct,
    round(avg(reskilling_programs_count), 0) as india_reskilling_programs
    from workforce_ai_impact
    where iso3_code= 'IND'
    group by industry_sector
    order by india_risk_score desc; 
    
    -- 4)Which sectors show biggest gender gap in displacement?
    select industry_sector,
    round(avg(pct_workforce_female),2) as female_workforce_pct,
    round(avg(pct_displaced_roles_female),2) as female_displaced_pct,
    round(avg(pct_sector_workforce_displaced),2) as overall_displaced_pct,
    round(avg(pct_displaced_roles_female) - avg(pct_sector_workforce_displaced),2) as gender_gap
    from workforce_ai_impact
    group by industry_sector
    order by gender_gap desc;
    
    -- 5)Which sectors are most underserved by reskilling programs?
SELECT 
    industry_sector,
    ROUND(AVG(sector_automation_risk_score), 3)  AS automation_risk,
    ROUND(AVG(reskilling_programs_count), 1)      AS reskilling_programs,
    ROUND(AVG(sector_automation_risk_score) / 
          AVG(reskilling_programs_count), 4)       AS risk_per_program
FROM workforce_ai_impact
GROUP BY industry_sector
ORDER BY risk_per_program DESC;

-- Do countries with better AI policy have less displacement?
SELECT 
    CASE 
        WHEN govt_ai_policy_score_1_to_10 >= 7 THEN 'Strong Policy'
        WHEN govt_ai_policy_score_1_to_10 >= 4 THEN 'Moderate Policy'
        ELSE 'Weak Policy'
    END AS policy_category,
    COUNT(DISTINCT country)                              AS num_countries,
    ROUND(AVG(pct_sector_workforce_displaced), 3)        AS avg_displacement,
    ROUND(AVG(reskilling_programs_count), 1)             AS avg_reskilling,
    ROUND(AVG(net_workforce_change_pct), 3)              AS avg_net_change
FROM workforce_ai_impact
GROUP BY policy_category
ORDER BY avg_displacement DESC;
 
 -- India specific 
 SELECT 
    country,
    ROUND(AVG(govt_ai_policy_score_1_to_10), 1)   AS policy_score,
    ROUND(AVG(reskilling_programs_count), 1)        AS reskilling,
    ROUND(AVG(pct_sector_workforce_displaced), 3)   AS displacement,
    ROUND(AVG(net_workforce_change_pct), 3)         AS net_change,
    CASE
        WHEN AVG(govt_ai_policy_score_1_to_10) >= 7 
        THEN 'Strong Policy'
        WHEN AVG(govt_ai_policy_score_1_to_10) >= 4 
        THEN 'Moderate Policy'
        ELSE 'Weak Policy'
    END AS policy_category
FROM workforce_ai_impact
WHERE iso3_code = 'IND'
GROUP BY country;
    
-- Is automation risk increasing over time?
select quarter_label,
round(avg(sector_automation_risk_score),2) as avg_risk_score,
ROUND(AVG(reskilling_programs_count), 1)        AS reskilling,
ROUND(AVG(pct_sector_workforce_displaced), 2)   AS displacement,
ROUND(AVG(net_workforce_change_pct), 2)         AS net_change
from workforce_ai_impact
group by quarter_label
order by avg_risk_score desc;

-- Do sectors with high wage premium also face high displacement?
select industry_sector,
round(avg(sector_automation_risk_score),2) as avg_risk_score,
round(avg(ai_skill_wage_premium_pct),2) as avg_wage_premium
from workforce_ai_impact
group by industry_sector
order by avg_wage_premium desc;

-- Which countries are best prepared for AI disruption?
SELECT 
    country,
    ROUND(AVG(govt_ai_policy_score_1_to_10), 1)        AS policy_score,
    ROUND(AVG(reskilling_programs_count), 1)            AS reskilling_count,
    ROUND(AVG(ai_adoption_index), 3)                    AS ai_adoption,
    ROUND(AVG(pct_sector_workforce_displaced), 3)       AS displacement_pct,
    ROUND(
        (AVG(govt_ai_policy_score_1_to_10) * 0.4) +
        (AVG(reskilling_programs_count) * 0.3) +
        (AVG(ai_adoption_index) * 0.3)
    , 3)                                                AS readiness_score
FROM workforce_ai_impact
GROUP BY country
ORDER BY readiness_score DESC
LIMIT 15;

-- Full picture — every sector's complete AI impact profile
SELECT 
    industry_sector,
    ROUND(AVG(sector_automation_risk_score), 3)              AS risk_score,
    ROUND(AVG(pct_sector_workforce_displaced), 3)             AS displaced_pct,
    ROUND(AVG(pct_sector_workforce_new_roles_created), 3)     AS new_roles_pct,
    ROUND(AVG(net_workforce_change_pct), 3)                   AS net_change,
    ROUND(AVG(pct_displaced_roles_female), 3)                        AS female_displaced,
    ROUND(AVG(reskilling_programs_count), 1)                  AS reskilling_programs,
    ROUND(AVG(ai_skill_wage_premium_pct), 3)                  AS wage_premium,
    CASE
        WHEN AVG(sector_automation_risk_score) >= 0.7 
        THEN 'CRITICAL'
        WHEN AVG(sector_automation_risk_score) >= 0.5 
        THEN 'HIGH'
        WHEN AVG(sector_automation_risk_score) >= 0.3 
        THEN 'MEDIUM'
        ELSE 'LOW'
    END AS risk_category
FROM workforce_ai_impact
GROUP BY industry_sector
ORDER BY risk_score DESC;
