# PowerShell Script for Configuration Maintenance

This repository hosts a PowerShell script designed for the upkeep of configuration files on a Windows system.

## Functionality

The script carries out assessments on a range of configuration files, ensuring these files encompass certain expected values. If these necessary values are not present, the script copies predetermined configuration files from the directory `C:\Windows\BCD\Fix\`. This ensures the system or application operates as intended with the correct configurations.

The script is specifically designed to work with a particular application that retains its configuration files in `C:\Program Files*\jDummy\I*\Config\` and `C:\WebA\` directories.

## How to Run

1. Clone the repository to your local machine.
2. Open a PowerShell window.
3. Navigate to the directory containing the script.
4. Execute the script using the command `.\script_name.ps1`, replacing `script_name.ps1` with the actual script name.

## Logging

The script generates logs that are stored in `C:\Windows\BCD\Fix\Logs\`. It logs the start time, end time, and any discrepancies found within the configuration files.

## License

This project is licensed under the terms of the MIT license.

## Contribution

Contributions are welcome! Please feel free to submit a Pull Request.
