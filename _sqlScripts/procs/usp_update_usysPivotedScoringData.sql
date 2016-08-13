

CREATE PROCEDURE [dbo].[usp_update_usysPivotedScoringData]
    @EventTurnID INT
AS 
    BEGIN

        DELETE FROM usys_tblPivotedScoringData WHERE EventTurnID = @EventTurnID
        
        INSERT INTO usys_tblPivotedScoringData 
            SELECT 
                  [JudgeAlias]                    
                 ,[JudgeName]                     
                 ,[JudgeID]                       
                 ,[EventTurnID]                   
                 ,[EventTurnJudgeID]              
                 ,[RawScore]                      
                 ,[Criteria_1]                    
                 ,[Criteria_1_Exec]               
                 ,[Criteria_2]                    
                 ,[Criteria_2_Exec]               
                 ,[Criteria_3]                    
                 ,[Criteria_3_Exec]               
                 ,[Criteria_4]                    
                 ,[Criteria_4_Exec]               
                 ,[Criteria_5]                    
                 ,[Criteria_5_Exec]               
                 ,[Criteria_6]                    
                 ,[Criteria_6_Exec]               
                 ,[Criteria_7]                    
                 ,[Criteria_7_Exec]               
                 ,[Criteria_8]                    
                 ,[Criteria_8_Exec]               
                 ,[Criteria_9]                    
                 ,[Criteria_9_Exec]               
                 ,[Criteria_10]                   
                 ,[Criteria_10_Exec]              
                 ,[Criteria_11]                   
                 ,[Criteria_11_Exec]              
                 ,[Criteria_12]                   
                 ,[Criteria_12_Exec]       
                 ,[Criteria_13]                    
                 ,[Criteria_13_Exec]               
                 ,[Criteria_14]                   
                 ,[Criteria_14_Exec]              
                 ,[Criteria_15]                   
                 ,[Criteria_15_Exec]              
                 ,[Criteria_16]                   
                 ,[Criteria_16_Exec]                    
                 ,[Criteria_17]                   
                 ,[Criteria_17_Exec]                    

                 FROM vw_GetTabularScoringDataGeneric WHERE EventTurnID = @EventTurnID
    
    END

