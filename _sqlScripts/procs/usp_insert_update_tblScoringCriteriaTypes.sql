

if object_id(dbo.usp_insert_update_tblScoringCriteriaTypes) is not null
	drop procedure dbo.usp_insert_update_tblScoringCriteriaTypes




CREATE PROCEDURE dbo.usp_insert_update_tblScoringCriteriaTypes
	@ScoringCriteriaTypeID int,
	@ScoringCriteriaType nvarchar(255),
	@DanceNational bit,
	@ProgramChamps bit,
	@ProgramChampsDance bit,
	@EventPanelTypeID int,
	@DeductionScoreSheet bit,
    @skipUpdate bit = NULL
AS 
    BEGIN
   
        IF @skipUpdate Is Null SET @skipUpdate=0
        
        IF NOT EXISTS (SELECT 1 FROM tblScoringCriteriaTypes WHERE ScoringCriteriaTypeID = @ScoringCriteriaTypeID)  

                INSERT INTO dbo.tblScoringCriteriaTypes (
                    ScoringCriteriaTypeID,
                    ScoringCriteriaType,
                    DanceNational,
                    ProgramChamps,
                    ProgramChampsDance,
                    EventPanelTypeID,
                    DeductionScoreSheet )
                    VALUES (
                    @ScoringCriteriaTypeID,
                    @ScoringCriteriaType,
                    @DanceNational,
                    @ProgramChamps,
                    @ProgramChampsDance,
                    @EventPanelTypeID,
                    @DeductionScoreSheet )

        ELSE --INSERT
            IF @skipUpdate=0 --UPDATE
                UPDATE dbo.tblScoringCriteriaTypes SET
                        ScoringCriteriaType = @ScoringCriteriaType,
                        DanceNational = @DanceNational,
                        ProgramChamps = @ProgramChamps,
                        ProgramChampsDance = @ProgramChampsDance,
                        EventPanelTypeID = @EventPanelTypeID,
                        DeductionScoreSheet = @DeductionScoreSheet
                    WHERE
                        ScoringCriteriaTypeID = @ScoringCriteriaTypeID
                
    END


-- grant execute on usp_insert_update_tblScoringCriteriaTypes to myUser
