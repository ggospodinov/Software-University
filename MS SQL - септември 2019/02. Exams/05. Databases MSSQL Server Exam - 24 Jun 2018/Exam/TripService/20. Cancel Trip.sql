CREATE TRIGGER tr_DeletedTrips ON [dbo].[Trips] INSTEAD OF DELETE
AS
BEGIN
	UPDATE [dbo].[Trips]
	   SET
	       [dbo].[Trips].[CancelDate] = GETDATE()
	 WHERE [dbo].[Trips].[Id] IN (SELECT [d].[Id] FROM [DELETED] AS d WHERE [d].[CancelDate] IS NULL)
END