/* Use case name: BATCH JOB EXECUTION SQL Program
: Create an SQL Program that can decipher the dependencies and print out the UNIT_NBR and STEP_PROG_NAME in the correct sequence
Assumptions:
1. STEP_DEP_ID = 0 means no job dependency
2. A step can only start after ALL its dependencies have completed
3. UNIT_NBR =1 is one batch inside this we are having 1 to 13 programs(STEP_SEQ_ID) to execute
3. If EXEC_LEVEL is same for any STEP_SEQ_ID then  those program will run in parallel.
5. Mapping table used: PROG_NAME and DEPENDENCY_RULES
*/

--Start of code
--CTE to find STEP_SEQ_ID which has zero job dependency (STEP_DEP_ID = 0) i.e. Execution group number
WITH level_1 AS (
    SELECT
        UNIT_NBR,
        STEP_SEQ_ID,
        1 AS exec_level
    FROM DEPENDENCY_RULES
    WHERE STEP_DEP_ID = 0
),

-- CTE to find next Execution group number by matching STEP_DEP_ID from DEPENDENCY_RULES table with previous level STEP_SEQ_ID's
level_2 AS (
    SELECT
        dr.UNIT_NBR,
        dr.STEP_SEQ_ID,
        l1.exec_level + 1 AS exec_level
    FROM DEPENDENCY_RULES dr
    JOIN level_1 l1
        ON  dr.UNIT_NBR    = l1.UNIT_NBR
        AND dr.STEP_DEP_ID = l1.STEP_SEQ_ID
    WHERE dr.STEP_DEP_ID <> 0
),

-- CTE to find next Execution group number by matching STEP_DEP_ID from DEPENDENCY_RULES table with previous level STEP_SEQ_ID's
level_3 AS (
    SELECT
        dr.UNIT_NBR,
        dr.STEP_SEQ_ID,
        l2.exec_level + 1 AS exec_level
    FROM DEPENDENCY_RULES dr
    JOIN level_2 l2
        ON  dr.UNIT_NBR    = l2.UNIT_NBR
        AND dr.STEP_DEP_ID = l2.STEP_SEQ_ID
    WHERE dr.STEP_DEP_ID <> 0
),

-- CTE to find next Execution group number by matching STEP_DEP_ID from DEPENDENCY_RULES table with previous level STEP_SEQ_ID's
level_4 AS (
    SELECT
        dr.UNIT_NBR,
        dr.STEP_SEQ_ID,
        l3.exec_level + 1 AS exec_level
    FROM DEPENDENCY_RULES dr
    JOIN level_3 l3
        ON  dr.UNIT_NBR    = l3.UNIT_NBR
        AND dr.STEP_DEP_ID = l3.STEP_SEQ_ID
    WHERE dr.STEP_DEP_ID <> 0
),
-- CTE to find next Execution group number by matching STEP_DEP_ID from DEPENDENCY_RULES table with previous level STEP_SEQ_ID's
level_5 AS (
    SELECT
        dr.UNIT_NBR,
        dr.STEP_SEQ_ID,
        l4.exec_level + 1 AS exec_level
    FROM DEPENDENCY_RULES dr
    JOIN level_4 l4
        ON  dr.UNIT_NBR    = l4.UNIT_NBR
        AND dr.STEP_DEP_ID = l4.STEP_SEQ_ID
    WHERE dr.STEP_DEP_ID <> 0
),

-- CTE to find next Execution group number by matching STEP_DEP_ID from DEPENDENCY_RULES table with previous level STEP_SEQ_ID's
level_6 AS (
    SELECT
        dr.UNIT_NBR,
        dr.STEP_SEQ_ID,
        l5.exec_level + 1 AS exec_level
    FROM DEPENDENCY_RULES dr
    JOIN level_5 l5
        ON  dr.UNIT_NBR    = l5.UNIT_NBR
        AND dr.STEP_DEP_ID = l5.STEP_SEQ_ID
    WHERE dr.STEP_DEP_ID <> 0
),

-- CTE to find next Execution group number by matching STEP_DEP_ID from DEPENDENCY_RULES table with previous level STEP_SEQ_ID's
level_7 AS (
    SELECT
        dr.UNIT_NBR,
        dr.STEP_SEQ_ID,
        l6.exec_level + 1 AS exec_level
    FROM DEPENDENCY_RULES dr
    JOIN level_6 l6
        ON  dr.UNIT_NBR    = l6.UNIT_NBR
        AND dr.STEP_DEP_ID = l6.STEP_SEQ_ID
    WHERE dr.STEP_DEP_ID <> 0
),

-- CTE to find next Execution group number by matching STEP_DEP_ID from DEPENDENCY_RULES table with previous level STEP_SEQ_ID's
level_8 AS (
    SELECT
        dr.UNIT_NBR,
        dr.STEP_SEQ_ID,
        l7.exec_level + 1 AS exec_level
    FROM DEPENDENCY_RULES dr
    JOIN level_7 l7
        ON  dr.UNIT_NBR    = l7.UNIT_NBR
        AND dr.STEP_DEP_ID = l7.STEP_SEQ_ID
    WHERE dr.STEP_DEP_ID <> 0
),


-- CTE to find next Execution group number by matching STEP_DEP_ID from DEPENDENCY_RULES table with previous level STEP_SEQ_ID's
level_9 AS (
    SELECT
        dr.UNIT_NBR,
        dr.STEP_SEQ_ID,
        l8.exec_level + 1 AS exec_level
    FROM DEPENDENCY_RULES dr
    JOIN level_8 l8
        ON  dr.UNIT_NBR    = l8.UNIT_NBR
        AND dr.STEP_DEP_ID = l8.STEP_SEQ_ID
    WHERE dr.STEP_DEP_ID <> 0
),


-- CTE to find next Execution group number by matching STEP_DEP_ID from DEPENDENCY_RULES table with previous level STEP_SEQ_ID's
level_10 AS (
    SELECT
        dr.UNIT_NBR,
        dr.STEP_SEQ_ID,
        l9.exec_level + 1 AS exec_level
    FROM DEPENDENCY_RULES dr
    JOIN level_9 l9
        ON  dr.UNIT_NBR    = l9.UNIT_NBR
        AND dr.STEP_DEP_ID = l9.STEP_SEQ_ID
    WHERE dr.STEP_DEP_ID <> 0
),


-- CTE to find next Execution group number by matching STEP_DEP_ID from DEPENDENCY_RULES table with previous level STEP_SEQ_ID's
level_11 AS (
    SELECT
        dr.UNIT_NBR,
        dr.STEP_SEQ_ID,
        l10.exec_level + 1 AS exec_level
    FROM DEPENDENCY_RULES dr
    JOIN level_10 l10
        ON  dr.UNIT_NBR    = l10.UNIT_NBR
        AND dr.STEP_DEP_ID = l10.STEP_SEQ_ID
    WHERE dr.STEP_DEP_ID <> 0
),


-- CTE to find next Execution group number by matching STEP_DEP_ID from DEPENDENCY_RULES table with previous level STEP_SEQ_ID's
level_12 AS (
    SELECT
        dr.UNIT_NBR,
        dr.STEP_SEQ_ID,
        l11.exec_level + 1 AS exec_level
    FROM DEPENDENCY_RULES dr
    JOIN level_11 l11
        ON  dr.UNIT_NBR    = l11.UNIT_NBR
        AND dr.STEP_DEP_ID = l11.STEP_SEQ_ID
    WHERE dr.STEP_DEP_ID <> 0
),

  -- CTE to find next Execution group number by matching STEP_DEP_ID from DEPENDENCY_RULES table with previous level STEP_SEQ_ID's
level_13 AS (
    SELECT
        dr.UNIT_NBR,
        dr.STEP_SEQ_ID,
        l12.exec_level + 1 AS exec_level
    FROM DEPENDENCY_RULES dr
    JOIN level_12 l12
        ON  dr.UNIT_NBR    = l12.UNIT_NBR
        AND dr.STEP_DEP_ID = l12.STEP_SEQ_ID
    WHERE dr.STEP_DEP_ID <> 0
),


-- CTE for all_levels consolidation so we can compute the MAX level,It may have duplicate records

all_levels AS (
    
    SELECT UNIT_NBR, STEP_SEQ_ID, exec_level FROM level_1
    UNION ALL
    SELECT UNIT_NBR, STEP_SEQ_ID, exec_level FROM level_2
    UNION ALL
    SELECT UNIT_NBR, STEP_SEQ_ID, exec_level FROM level_3
    UNION ALL
    SELECT UNIT_NBR, STEP_SEQ_ID, exec_level FROM level_4
    UNION ALL
    SELECT UNIT_NBR, STEP_SEQ_ID, exec_level FROM level_5
    UNION ALL
    SELECT UNIT_NBR, STEP_SEQ_ID, exec_level FROM level_6
    UNION ALL
    SELECT UNIT_NBR, STEP_SEQ_ID, exec_level FROM level_7
    UNION ALL
    SELECT UNIT_NBR, STEP_SEQ_ID, exec_level FROM level_8
    UNION ALL
    SELECT UNIT_NBR, STEP_SEQ_ID, exec_level FROM level_9
    UNION ALL
    SELECT UNIT_NBR, STEP_SEQ_ID, exec_level FROM level_10
    UNION ALL
    SELECT UNIT_NBR, STEP_SEQ_ID, exec_level FROM level_11
    UNION ALL
    SELECT UNIT_NBR, STEP_SEQ_ID, exec_level FROM level_12
    UNION ALL
    SELECT UNIT_NBR, STEP_SEQ_ID, exec_level FROM level_13
    
),

  
-- CTE to make one row per STEP_SEQ_ID by using max(exec_level) 

execution_levels_grouping AS (
    SELECT
        UNIT_NBR,
        STEP_SEQ_ID,
        MAX(exec_level) AS exec_level
    FROM all_levels
    GROUP BY UNIT_NBR, STEP_SEQ_ID
)


-- FINAL SELECT
-- Join groupby_execution_levels with PROG_NAME table to display procedure name, then order by UNIT_NBR and EXEC_LEVEL so the output represents the correct sequential (and parallel) order

SELECT
    g.UNIT_NBR,
    g.exec_level,
    g.STEP_SEQ_ID,
    p.STEP_PROG_NAME
FROM execution_levels_grouping g
JOIN PROG_NAME p
    ON  g.UNIT_NBR    = p.UNIT_NBR
    AND g.STEP_SEQ_ID = p.STEP_SEQ_ID
ORDER BY
    g.UNIT_NBR,
    g.exec_level,
    g.STEP_SEQ_ID ;

--End of code



/* 
SQL to Test Data: We can Perform below test to verify the output of execution_levels_grouping CTE
*/

--Test1: STEP_DEP_ID = 0 must be at EXEC_LEVEL 1.
-- Expected: count = 1 row for UNIT_NBR=1, STEP_SEQ_ID=1, EXEC_LEVEL=1

SELECT UNIT_NBR, STEP_SEQ_ID, exec_level
FROM execution_levels_grouping
WHERE STEP_SEQ_ID IN (
    SELECT STEP_SEQ_ID FROM DEPENDENCY_RULES WHERE STEP_DEP_ID = 0
);

--Test2 : Every STEP_SEQ_ID in PROG_NAME must appear in the output of execution_levels_grouping CTE
-- Expected: count = 0

SELECT COUNT(*) AS missing_steps
FROM PROG_NAME p
LEFT JOIN execution_levels_grouping g
    ON p.UNIT_NBR    = g.UNIT_NBR
   AND p.STEP_SEQ_ID = g.STEP_SEQ_ID
WHERE g.STEP_SEQ_ID IS NULL;



