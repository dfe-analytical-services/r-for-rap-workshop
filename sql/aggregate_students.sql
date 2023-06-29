SELECT year,
   school,
   sex,
   age,
   count(*) AS students,
   avg(G1) AS g1_mean,
   avg(G2) AS g2_mean,
   avg(G3) AS g3_mean
INTO dbo.sd_sandbox_student_results_aggregated
FROM dbo.sd_sandbox_student_results
GROUP BY year, school, sex, age
