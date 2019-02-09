#include <a_npc>

#define VEHICLE		PLAYER_RECORDING_TYPE_DRIVER
#define WALK		PLAYER_RECORDING_TYPE_ONFOOT

#define REC_FILE			"shovel"
#define RECORDING_TYPE		WALK
#define PLAYING_LOOP		true

#if PLAYING_LOOP
public OnRecordingPlaybackEnd()
	StartRecordingPlayback(RECORDING_TYPE, REC_FILE);
#endif
#if RECORDING_TYPE == 1
	public OnNPCEnterVehicle(vehicleid, seatid)
		StartRecordingPlayback(RECORDING_TYPE, REC_FILE);
	public OnNPCExitVehicle()
		StopRecordingPlayback();
#else
	public OnNPCSpawn()
		StartRecordingPlayback(RECORDING_TYPE, REC_FILE);
#endif
