

if object_id(dbo.FillGrandChampionsTable) is not null
	drop procedure dbo.FillGrandChampionsTable




-- ==========================================================================================
-- Author:		Seth Spearman
-- Create date: 5/30/2008
-- Description:	This procedure is used to fill the Grand Champions temp table (usysProgramChampions) 
--				using server side cursors so that the GrandChampions report will print.   

--The following is pseudo-code for the procedure:
--		Step-1 : Delete from usysProgramChampions.
--		Step-2 : Open a cursor by Customers for the ones at this event who have >=MinSmallTeams and <MinLargeTeams number of divisions.  
--		Step-3 : For each customer in the cursor insert the top 3 scores by division for this event.
--		Step-4 : Open a cursor by Customers for the ones at this event who have >=MinLargeTeams number of divisions.  
--		Step-5 : For each customer in the cursor insert the top 3 scores by division for this event.

-- TEST  : EXEC [dbo].[FillGrandChampionsTable] 3,3,4
-- ==========================================================================================
	
CREATE PROCEDURE [dbo].[FillGrandChampionsTable]
    @EventID INT,
    @MinSmallTeams INT,
    @MinLargeTeams INT,
    @ErrMessage VARCHAR(1000) = '' OUTPUT
AS 
    BEGIN

	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
        SET NOCOUNT ON ;
	
	--Step-1 : Delete from usysProgramChampions.
        DELETE  FROM dbo.usysGrandChampions ;

    END



-- grant execute on FillGrandChampionsTable to myUser
