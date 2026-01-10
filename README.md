# USB Read-Only Toggle

A lightweight Windows utility that protects USB flash drives by enabling or disabling write protection at the disk level.

## Key Features

- Toggle USB drives between read-only (protected) and writable modes
- Real-time status display with color-coded indicators
- Prevents virus infections when using USB drives on untrusted computers
- Automatic USB drive detection with refresh capability
- Confirmation prompts before making changes
- Clean, user-friendly interface

## Use Cases

- Protect flash drives from malware on public/shared computers
- Prevent accidental file deletion or modification
- Secure data transfer in high-risk environments
- Create write-protected bootable USB drives

## Requirements

- Windows operating system
- Administrator privileges

~~Installation (Old Method)~~

~~1. Download USB-Toggle.exe from the Releases page~~ 
~~2. Run the executable (will request admin privileges automatically)~~ 
~~3. Select your USB drive and toggle protection as needed~~

~~Convert to EXE (stand alone)~~

~~1. Open Powershell as Administrator~~ 
~~2. Install-Module ps2exe -Scope CurrentUser~~ 
~~3. Invoke-PS2EXE "Make Read-Only.ps1" "USB-Toggle.exe" -noConsole -requireAdmin -title "USB Read-Only Toggle (2025)"~~


### 🚀 Recommended Installation (NTFS Method)
Since the old method was not reliable and didn't work for removable drives, please use this second method instead.

**Requirements:**
* The flash drive or external hard disk **must be formatted to NTFS** for this to work.

**Files Needed:**
* `Click to Open.bat` (The launcher)
* `Read.Only.[NTFS].ps1` (The script)

**How to use:**
1. Locate the files in the repository and download as ZIP file
2. Run **`Click to Open.bat`**. This file acts as the launcher for the PowerShell script and will handle the necessary permissions automatically.

---




