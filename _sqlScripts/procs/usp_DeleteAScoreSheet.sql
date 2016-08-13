

CREATE PROCEDURE [dbo].[usp_DeleteAScoreSheet]
    @EventPanelTypeID INT,
    @ErrMessage VARCHAR(1000) = '' OUTPUT
AS 
    BEGIN
    
        IF (@EventPanelTypeID IN (1,2))
            BEGIN
                SET @ErrMessage = 'Cannot remove All-Star Cheer or Dance Scoresheets' ; 
                RETURN ;
            END
            
        BEGIN TRANSACTION
        
        BEGIN TRY
            DELETE FROM tblJudgingCriteria WHERE ScoringCriteriaTypeID IN (SELECT ScoringCriteriaTypeID FROM tblScoringCriteriaTypes WHERE EventPanelTypeID=@EventPanelTypeID)
            DELETE FROM tblDeductionSystem WHERE ScoringCriteriaTypeID IN (SELECT ScoringCriteriaTypeID FROM tblScoringCriteriaTypes WHERE EventPanelTypeID=@EventPanelTypeID)
            DELETE FROM tblScoringCategoryDivisors WHERE ScoringCategoryID IN (SELECT ScoringCategoryID FROM tblScoringCategories WHERE ScoringCriteriaTypeID IN (SELECT ScoringCriteriaTypeID FROM tblScoringCriteriaTypes WHERE EventPanelTypeID=@EventPanelTypeID))
            DELETE FROM tblScoringCategories WHERE ScoringCriteriaTypeID IN (SELECT ScoringCriteriaTypeID FROM tblScoringCriteriaTypes WHERE EventPanelTypeID=@EventPanelTypeID)
            DELETE FROM tblJudgeTypes WHERE JudgeTypeID IN (SELECT ScoringCriteriaTypeID FROM tblScoringCriteriaTypes WHERE EventPanelTypeID=@EventPanelTypeID)
            DELETE FROM tblScoringCriteriaTypes WHERE EventPanelTypeID=@EventPanelTypeID

            DELETE FROM tblEventPanels WHERE EventPanelTypeID=@EventPanelTypeID
            DELETE FROM tblDivisions WHERE EventPanelTypeID=@EventPanelTypeID
            DELETE FROM tblScoresheetLevelMaxValues WHERE EventPanelTypeID=@EventPanelTypeID
            DELETE FROM tblEventPanelTypes WHERE EventPanelTypeID=@EventPanelTypeID

		END TRY
		BEGIN CATCH
			ROLLBACK TRANSACTION
			SET @ErrMessage=ERROR_MESSAGE()     --'AN ERROR OCCURRED WHILE TRYING TO SETUP SCORING TABLES.  TRANSACTIONS WERE ROLLED BACK' ;
			RETURN
		END CATCH
		
		SET @ErrMessage=''
		COMMIT TRANSACTION
		RETURN
    
    END

