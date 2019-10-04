CREATE PROCEDURE usp_SwitchRoom(@TripId INT, @TargetRoomId INT)
AS
BEGIN
	DECLARE @roomHotel INT = (SELECT [h].[Id]
                                FROM [dbo].[Rooms] AS r
                                JOIN [dbo].[Hotels] AS [h] ON [r].[HotelId] = [h].[Id]
                               WHERE [r].[Id] = @TargetRoomId)

	DECLARE @tripRoomHotel INT = (SELECT [h].[Id]
                                    FROM [dbo].[Trips] AS t
                                    JOIN [dbo].[Rooms] AS [r] ON [t].[RoomId] = [r].[Id]
                                    JOIN [dbo].[Hotels] AS [h] ON [r].[HotelId] = [h].[Id]
                                   WHERE [t].[Id] = @TripId)

	IF(@roomHotel <> @tripRoomHotel)
	BEGIN
		RAISERROR('Target room is in another hotel!', 16, 1)
		RETURN
	END

	DECLARE @peopleCount INT = (SELECT COUNT(*)
                                  FROM [dbo].[AccountsTrips] AS [at]
                                 WHERE [at].[TripId] = @TripId)
	DECLARE @bedsCount INT = (SELECT [r].[Beds]
                                FROM [dbo].[Rooms] AS r
                               WHERE [r].[Id] = @TargetRoomId)

	IF(@bedsCount < @peopleCount)
	BEGIN
		RAISERROR('Not enough beds in target room!', 16, 2)
		RETURN
	END

	UPDATE [dbo].[Trips]
	   SET
	       [dbo].[Trips].[RoomId] = @TargetRoomId
	 WHERE [dbo].[Trips].[Id] = @TripId
END

EXEC usp_SwitchRoom 10, 7
EXEC usp_SwitchRoom 10, 8
EXEC usp_SwitchRoom 10, 11
SELECT RoomId FROM Trips WHERE Id = 10