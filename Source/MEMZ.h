#define UNICODE

#include <windows.h>
#include <shlwapi.h>
#include <psapi.h>
#include <commctrl.h>

#include "../Build/Data.h"
#include "Payloads/Payloads.h"
#include "Utils/Utils.h"

void start();

LRESULT CALLBACK WindowProc(HWND hwnd, UINT uMsg, WPARAM wParam, LPARAM lParam);
