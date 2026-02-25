SELECT
   c.ems_firm_id,
   a.clientid,
   FORMAT(a.date, 'yyyy-MM') AS month,
   SUM(a.docsadded) AS total_docs_added,
   SUM(a.wfadded) AS total_workflows_added
FROM
   daily_client_usage a
JOIN
   client c
   ON a.clientid = c.cid
WHERE
   a.date >= DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()) - 12, 0)
   AND a.date < DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()), 0)
GROUP BY
   c.ems_firm_id,
   a.clientid,
   FORMAT(a.date, 'yyyy-MM')
ORDER BY
   c.ems_firm_id,
   a.clientid,
   month;
