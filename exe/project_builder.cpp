#include <iostream>
#include <cstdlib>  // For system()
#include <fstream>  // For logging
#include <vector>
#include <string>

#ifdef _WIN32
    #define VIVADO_CMD "vivado -mode tcl -source "
    #define LOG_FILE "vivado_log.txt"
#else
    #define VIVADO_CMD "/opt/Xilinx/Vivado/202X.Y/bin/vivado -mode tcl -source "
    #define LOG_FILE "vivado_log.txt"
#endif

// Function to run a TCL script and log output
void runTclScript(const std::string& script) {
    std::string command = VIVADO_CMD + script + " 2>&1 | tee -a " + LOG_FILE;
    std::cout << "Executing: " << command << std::endl;
    int result = std::system(command.c_str());

    if (result != 0) {
        std::cerr << "Error executing: " << script << std::endl;
    }
}

int main() {
    // List of TCL scripts to execute
    std::vector<std::string> scripts = {
        "create_project.tcl",
        "add_files.tcl",
        "gen_ip.tcl",
        "compile.tcl"
    };

    std::ofstream logFile(LOG_FILE, std::ios::out);
    if (!logFile) {
        std::cerr << "Failed to create log file: " << LOG_FILE << std::endl;
        return 1;
    }
    logFile.close();

    std::cout << "Starting Vivado TCL script execution..." << std::endl;

    for (const auto& script : scripts) {
        runTclScript(script);
    }

    std::cout << "All scripts executed. Check " << LOG_FILE << " for details." << std::endl;
    return 0;
}
