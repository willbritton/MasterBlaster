
void InterruptHandler(void)
{
	// numinterrupts++;
}

void InitConsole()
{
    // La consola
	SMS_init();
	
	// We need this
	SMS_getKeysStatus();
	
	// Advanced frameskipping
	SMS_setLineInterruptHandler(&InterruptHandler);
	SMS_setLineCounter (192);
	SMS_enableLineInterrupt();
	
	// Kagesan asked for this ;)
	SMS_VDPturnOnFeature(VDPFEATURE_LEFTCOLBLANK);
}