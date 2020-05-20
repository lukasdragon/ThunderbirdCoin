// Copyright (c) 2018, The TurtleCoin Developers
//
// Please see the included LICENSE file for more information

#pragma once

#include <string>

const std::string windowsAsciiArt =
"___________.__                      .___          ___.   .__           .___\n"
    "\\__    ___/|  |__  __ __  ____    __| _/__________\\_ |__ |__|______  __| _/\n"
    "  |    |   |  |  \\|  |  \\/    \\  / __ |/ __ \\_  __ \\ __ \\|  \\_  __ \\/ __ | \n"
    "  |    |   |   Y  \\  |  /   |  \\/ /_/ \\  ___/|  | \\/ \\_\\ \\  ||  | \\/ /_/ | \n"
    "  |____|   |___|  /____/|___|  /\\____ |\\___  >__|  |___  /__||__|  \\____ | \n"
    "                \\/           \\/      \\/    \\/          \\/               \\/ \n"
    "_________        .__        \n"
    "\\_   ___ \\  ____ |__| ____  \n"
    "/    \\  \\/ /  _ \\|  |/    \\ \n"
    "\\     \\___(  <_> )  |   |  \\\n"
    " \\______  /\\____/|__|___|  /\n"
    "        \\/               \\/ ";







const std::string nonWindowsAsciiArt =
"                                                                                                                           \n"
    "████████╗██╗  ██╗██╗   ██╗███╗   ██╗██████╗ ███████╗██████╗ ██████╗ ██╗██████╗ ██████╗      ██████╗ ██████╗ ██╗███╗   ██╗\n"
    "╚══██╔══╝██║  ██║██║   ██║████╗  ██║██╔══██╗██╔════╝██╔══██╗██╔══██╗██║██╔══██╗██╔══██╗    ██╔════╝██╔═══██╗██║████╗  ██║\n"
    "   ██║   ███████║██║   ██║██╔██╗ ██║██║  ██║█████╗  ██████╔╝██████╔╝██║██████╔╝██║  ██║    ██║     ██║   ██║██║██╔██╗ ██║\n"
    "   ██║   ██╔══██║██║   ██║██║╚██╗██║██║  ██║██╔══╝  ██╔══██╗██╔══██╗██║██╔══██╗██║  ██║    ██║     ██║   ██║██║██║╚██╗██║\n"
    "   ██║   ██║  ██║╚██████╔╝██║ ╚████║██████╔╝███████╗██║  ██║██████╔╝██║██║  ██║██████╔╝    ╚██████╗╚██████╔╝██║██║ ╚████║\n"
    "   ╚═╝   ╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚═════╝ ╚══════╝╚═╝  ╚═╝╚═════╝ ╚═╝╚═╝  ╚═╝╚═════╝      ╚═════╝ ╚═════╝ ╚═╝╚═╝  ╚═══╝\n";




/* Windows has some characters it won't display in a terminal. If your ascii
   art works fine on Windows and Linux terminals, just replace 'asciiArt' with
   the art itself, and remove these two #ifdefs and above ascii arts */
#ifdef _WIN32

const std::string asciiArt = windowsAsciiArt;

#else
const std::string asciiArt = nonWindowsAsciiArt;
#endif
