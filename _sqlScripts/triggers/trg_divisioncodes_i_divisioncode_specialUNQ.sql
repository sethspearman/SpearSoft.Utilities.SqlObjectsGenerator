

CREATE TRIGGER [dbo].[trg_divisioncodes_i_divisioncode_specialUNQ] ON [dbo].[tblDivisions]
    FOR INSERT, UPDATE
AS
    IF EXISTS ( SELECT  I.DivisionCode
                FROM    inserted AS I
                        JOIN dbo.tblDivisions AS C ON I.DivisionCode = C.DivisionCode
                WHERE   I.DivisionCode IS NOT NULL
                GROUP BY I.DivisionCode
                HAVING  COUNT(*) > 1 ) 
        BEGIN
            RAISERROR ( 'Duplicates found. Transaction rolled back.', 10, 1 )
            ROLLBACK TRAN
        END


