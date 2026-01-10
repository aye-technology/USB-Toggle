# Suppress ALL output
$ErrorActionPreference = 'SilentlyContinue'
$null = [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
$null = [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")

# Language strings
$script:CurrentLanguage = "English"
$script:Strings = @{
    English = @{
        Title = "NTFS Security Lock (Cross-PC)"
        SelectDrive = "Select NTFS USB Drive to Lock/Unlock:"
        SelectStatus = "Select a drive to see its status"
        Locked = "[LOCKED] Status: READ-ONLY - Protected"
        Unlocked = "[UNLOCKED] Status: FULL ACCESS"
        NA = "[N/A] Non-NTFS drives cannot be locked"
        Unknown = "[UNKNOWN] Cannot determine status"
        LockBtn = "Lock (Read-Only)"
        UnlockBtn = "Unlock (Full Access)"
        RefreshBtn = "Refresh Drive List"
        FormatBtn = "Format to NTFS"
        LanguageBtn = "አማርኛ (Amharic)"
        FormatWarning = "WARNING: Format will erase ALL data on the selected drive!"
        AlreadyNTFS = "Drive {0} is already formatted as NTFS."
        AlreadyNTFSTitle = "Already NTFS"
        FormatConfirm1 = "WARNING: This will ERASE ALL DATA on drive {0}:`n`nCurrent Format: {1}`nCurrent Label: {2}`n`nAre you ABSOLUTELY SURE you want to format to NTFS?"
        FormatTitle1 = "FORMAT WARNING - ALL DATA WILL BE LOST!"
        FormatConfirm2 = "FINAL WARNING!`n`nDrive {0} will be formatted to NTFS.`nALL FILES WILL BE PERMANENTLY DELETED.`n`nClick OK to confirm."
        FormatTitle2 = "LAST CHANCE - Confirm Format"
        Formatting = "Formatting drive {0} to NTFS...`n`nThis may take several minutes. Please wait."
        FormattingTitle = "Formatting..."
        FormatSuccess = "Drive {0} has been successfully formatted to NTFS!`n`nYou can now use the Lock feature."
        FormatSuccessTitle = "Format Complete"
        FormatError = "Format failed: {0}"
        FormatErrorTitle = "Format Error"
        NoSelection = "Please select a drive first."
        NoSelectionTitle = "No Drive Selected"
        MustBeNTFS = "Error: Drive must be NTFS."
        FormatErrorTitle2 = "Format Error"
    }
    Amharic = @{
        Title = "የኤን-ቲ-ኤፍ-ኤስ ደህንነት መቆለፊያ"
        SelectDrive = "ለመቆለፍ/ለመክፈት የኤን-ቲ-ኤፍ-ኤስ ፍላሸን ይምረጡ:"
        SelectStatus = "ሁኔታውን ለማየት ፍላሽ ይምረጡ"
        Locked = "[ተቆልፏል] ሁኔታ: ለማንበብ ብቻ - ተጠብቋል"
        Unlocked = "[ተከፍቷል] ሁኔታ: ሙሉ መዳረሻ"
        NA = "[አይገኝም] ኤንቲኤፍኤስ ያልሆኑ ፍላሽዎች መቆለፍ አይችሉም"
        Unknown = "[አይታወቅም] ሁኔታ መወሰን አይቻልም"
        LockBtn = "ቆልፍ (ለማንበብ ብቻ)"
        UnlockBtn = "ክፈት (ሙሉ መዳረሻ)"
        RefreshBtn = "የፍላሽዎች ዝርዝር አድስ"
        FormatBtn = "ወደ NTFS ቀይር"
        LanguageBtn = "English"
        FormatWarning = "ማስጠንቀቂያ: ፎርማት ማድረግ በተመረጠው ፍላሽ ላይ ያሉትን ሁሉንም መረጃዎች ይሰርዛል!"
        AlreadyNTFS = "ፍላሽ {0} አስቀድሞ እንደ NTFS ተቀርጿል።"
        AlreadyNTFSTitle = "አስቀድሞ NTFS ነው"
        FormatConfirm1 = "ማስጠንቀቂያ: ይህ በፍላሽ {0} ላይ ያሉትን ሁሉንም መረጃዎች ይሰርዛል:`n`nአሁን ያለው ፎርማት: {1}`nአሁን ያለው ስያሜ: {2}`n`nወደ NTFS ለመቀየር በእርግጠኝነት ይፈልጋሉ?"
        FormatTitle1 = "የፎርማት ማስጠንቀቂያ - ሁሉም መረጃዎች ይጠፋሉ!"
        FormatConfirm2 = "የመጨረሻ ማስጠንቀቂያ!`n`nፍላሽ {0} ወደ NTFS ይቀየራል።`nሁሉም ፋይሎች እስከመጨረሻው ይሰረዛሉ።`n`nለማረጋገጥ እሺ ይጫኑ።"
        FormatTitle2 = "የመጨረሻ እድል - ፎርማትን አረጋግጥ"
        Formatting = "ፍላሽ {0} ወደ NTFS በመቀየር ላይ...`n`nይህ ብዙ ደቂቃዎችን ሊወስድ ይችላል። እባክዎ ይጠብቁ።"
        FormattingTitle = "በመቀየር ላይ..."
        FormatSuccess = "ፍላሽ {0} በተሳካ ሁኔታ ወደ NTFS ተቀይሯል!`n`nአሁን የመቆለፍ ባህሪውን መጠቀም ይችላሉ።"
        FormatSuccessTitle = "ፎርማት ተጠናቋል"
        FormatError = "ፎርማት አልተሳካም: {0}"
        FormatErrorTitle = "የፎርማት ስህተት"
        NoSelection = "እባክዎ መጀመሪያ ፍላሽ ይምረጡ።"
        NoSelectionTitle = "ምንም ፍላሽ አልተመረጠም"
        MustBeNTFS = "ስህተት: ፍላሽ NTFS መሆን አለበት።"
        FormatErrorTitle2 = "የፎርማት ስህተት"
    }
}

function Get-String($key) {
    return $script:Strings[$script:CurrentLanguage][$key]
}

function Update-Language {
    $form.Text = Get-String "Title"
    $label.Text = Get-String "SelectDrive"
    $btnLock.Text = Get-String "LockBtn"
    $btnUnlock.Text = Get-String "UnlockBtn"
    $btnRefresh.Text = Get-String "RefreshBtn"
    $btnFormat.Text = Get-String "FormatBtn"
    $btnLanguage.Text = Get-String "LanguageBtn"
    $warningLabel.Text = Get-String "FormatWarning"
    
    # Update status if a drive is selected
    if ($listBox.SelectedIndex -ge 0) {
        UpdateStatus
    } else {
        $statusLabel.Text = Get-String "SelectStatus"
    }
    
    RefreshDrives
}

# Request Admin Privileges
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    $psi = New-Object System.Diagnostics.ProcessStartInfo
    $psi.FileName = "powershell.exe"
    $psi.Arguments = "-WindowStyle Hidden -NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`""
    $psi.Verb = "runas"
    $psi.WindowStyle = "Hidden"
    $null = [System.Diagnostics.Process]::Start($psi)
    exit
}

$form = New-Object System.Windows.Forms.Form
$form.Text = Get-String "Title"
$form.Size = New-Object System.Drawing.Size(450,460)
$form.StartPosition = "CenterScreen"
$form.FormBorderStyle = "FixedDialog"

$label = New-Object System.Windows.Forms.Label
$label.Text = Get-String "SelectDrive"
$label.Location = New-Object System.Drawing.Point(10,10)
$label.AutoSize = $true
$null = $form.Controls.Add($label)

$listBox = New-Object System.Windows.Forms.ListBox
$listBox.Location = New-Object System.Drawing.Point(10,40)
$listBox.Size = New-Object System.Drawing.Size(410,100)
$null = $form.Controls.Add($listBox)

$statusLabel = New-Object System.Windows.Forms.Label
$statusLabel.Location = New-Object System.Drawing.Point(10,145)
$statusLabel.Size = New-Object System.Drawing.Size(410,40)
$statusLabel.Font = New-Object System.Drawing.Font("Arial",10,[System.Drawing.FontStyle]::Bold)
$statusLabel.Text = Get-String "SelectStatus"
$statusLabel.ForeColor = [System.Drawing.Color]::Gray
$null = $form.Controls.Add($statusLabel)

function Test-IsNTFS($driveLetter) {
    $vol = Get-Volume -DriveLetter $driveLetter -ErrorAction SilentlyContinue
    return ($vol.FileSystem -eq "NTFS")
}

function Get-DriveStatus($driveLetter) {
    try {
        # Check if it's NTFS first
        if (!(Test-IsNTFS $driveLetter)) {
            return "N/A"
        }
        
        $path = $driveLetter + ":\"
        $acl = Get-Acl -Path $path
        
        # Look for Everyone (S-1-1-0) permissions
        $everyoneRule = $acl.Access | Where-Object { 
            $_.IdentityReference.Value -eq "S-1-1-0" -or 
            $_.IdentityReference -like "*Everyone*"
        }
        
        if ($everyoneRule) {
            # Check if ANY rule grants Write/Modify/FullControl
            foreach ($rule in $everyoneRule) {
                if ($rule.AccessControlType -eq "Allow") {
                    $rights = $rule.FileSystemRights.ToString()
                    # Check if it has write permissions
                    if ($rights -match "FullControl|Modify|Write|AppendData|CreateFiles|CreateDirectories|DeleteSubdirectoriesAndFiles|Delete") {
                        return "UNLOCKED"
                    }
                }
            }
            # If we get here, Everyone exists but has no write permissions
            return "LOCKED"
        }
        
        # No Everyone rule found - check if anyone else has write access
        $hasWriters = $acl.Access | Where-Object {
            $_.AccessControlType -eq "Allow" -and
            $_.FileSystemRights -match "FullControl|Modify|Write"
        }
        
        return if ($hasWriters) { "UNLOCKED" } else { "LOCKED" }
    }
    catch { return "UNKNOWN" }
}

function UpdateStatus {
    if ($listBox.SelectedItem -match "([A-Z]):") {
        $dl = $matches[1]
        $status = Get-DriveStatus $dl
        
        # Enable/disable Format button based on filesystem
        $isNTFS = Test-IsNTFS $dl
        $btnFormat.Enabled = -not $isNTFS
        
        if ($status -eq "LOCKED") {
            $statusLabel.Text = Get-String "Locked"
            $statusLabel.ForeColor = [System.Drawing.Color]::Red
        }
        elseif ($status -eq "UNLOCKED") {
            $statusLabel.Text = Get-String "Unlocked"
            $statusLabel.ForeColor = [System.Drawing.Color]::Green
        }
        elseif ($status -eq "N/A") {
            $statusLabel.Text = Get-String "NA"
            $statusLabel.ForeColor = [System.Drawing.Color]::Gray
        }
        else {
            $statusLabel.Text = Get-String "Unknown"
            $statusLabel.ForeColor = [System.Drawing.Color]::Orange
        }
        
        # Enable/disable Lock and Unlock buttons based on filesystem
        $btnLock.Enabled = $isNTFS
        $btnUnlock.Enabled = $isNTFS
    }
}

function RefreshDrives {
    $null = $listBox.Items.Clear()
    $drives = Get-Volume | Where-Object { $_.DriveType -eq "Removable" }
    foreach ($d in $drives) {
        if ($d.DriveLetter) {
            $fs = $d.FileSystem
            $status = Get-DriveStatus $d.DriveLetter
            
            if ($status -eq "N/A") {
                $statusIcon = "[N/A]"
            } elseif ($status -eq "LOCKED") {
                $statusIcon = "[LOCKED]"
            } else {
                $statusIcon = "[UNLOCKED]"
            }
            
            $null = $listBox.Items.Add("$statusIcon $($d.DriveLetter): [$($d.FileSystemLabel)] ($fs)")
        }
    }
}

$null = $listBox.Add_SelectedIndexChanged({ UpdateStatus })

$btnLock = New-Object System.Windows.Forms.Button
$btnLock.Text = Get-String "LockBtn"
$btnLock.Location = New-Object System.Drawing.Point(10,195)
$btnLock.Size = New-Object System.Drawing.Size(200,40)
$btnLock.BackColor = [System.Drawing.Color]::LightCoral

$btnUnlock = New-Object System.Windows.Forms.Button
$btnUnlock.Text = Get-String "UnlockBtn"
$btnUnlock.Location = New-Object System.Drawing.Point(220,195)
$btnUnlock.Size = New-Object System.Drawing.Size(200,40)
$btnUnlock.BackColor = [System.Drawing.Color]::LightGreen

$btnRefresh = New-Object System.Windows.Forms.Button
$btnRefresh.Text = Get-String "RefreshBtn"
$btnRefresh.Location = New-Object System.Drawing.Point(10,245)
$btnRefresh.Size = New-Object System.Drawing.Size(200,30)

$btnFormat = New-Object System.Windows.Forms.Button
$btnFormat.Text = Get-String "FormatBtn"
$btnFormat.Location = New-Object System.Drawing.Point(220,245)
$btnFormat.Size = New-Object System.Drawing.Size(200,30)
$btnFormat.BackColor = [System.Drawing.Color]::Orange
$btnFormat.ForeColor = [System.Drawing.Color]::White

$btnLanguage = New-Object System.Windows.Forms.Button
$btnLanguage.Text = Get-String "LanguageBtn"
$btnLanguage.Location = New-Object System.Drawing.Point(10,285)
$btnLanguage.Size = New-Object System.Drawing.Size(410,30)
$btnLanguage.BackColor = [System.Drawing.Color]::LightBlue

$warningLabel = New-Object System.Windows.Forms.Label
$warningLabel.Text = Get-String "FormatWarning"
$warningLabel.Location = New-Object System.Drawing.Point(10,325)
$warningLabel.Size = New-Object System.Drawing.Size(410,40)
$warningLabel.ForeColor = [System.Drawing.Color]::Red
$warningLabel.Font = New-Object System.Drawing.Font("Arial",9,[System.Drawing.FontStyle]::Bold)
$null = $form.Controls.Add($warningLabel)

$null = $btnLock.Add_Click({
    if ($listBox.SelectedItem -match "([A-Z]):") {
        $dl = $matches[1]
        if (!(Test-IsNTFS $dl)) {
            $null = [System.Windows.Forms.MessageBox]::Show((Get-String "MustBeNTFS"), (Get-String "FormatErrorTitle2"))
            return
        }
        $root = $dl + ":\"
        
        # Remove ALL inherited permissions
        icacls $root /inheritance:r /q 2>&1 | Out-Null
        
        # REPLACE with ONLY Everyone (SID format) read-only
        icacls $root /grant:r "*S-1-1-0:(OI)(CI)RX" /t /c /l /q 2>&1 | Out-Null
        
        # Show success message
        $null = [System.Windows.Forms.MessageBox]::Show(
            "Drive $dl is now LOCKED (Read-Only).`n`nFiles are protected from modification.",
            "Drive Locked",
            [System.Windows.Forms.MessageBoxButtons]::OK,
            [System.Windows.Forms.MessageBoxIcon]::Information
        )
        
        RefreshDrives
        UpdateStatus
    }
})

$null = $btnUnlock.Add_Click({
    if ($listBox.SelectedItem -match "([A-Z]):") {
        $dl = $matches[1]
        $root = $dl + ":\"
        
        # Grant full control using SID format (matches lock format)
        icacls $root /grant:r "*S-1-1-0:(OI)(CI)F" /t /c /l /q 2>&1 | Out-Null
        
        # Show success message
        $null = [System.Windows.Forms.MessageBox]::Show(
            "Drive $dl is now UNLOCKED (Full Access).`n`nYou can now add or modify files.",
            "Drive Unlocked",
            [System.Windows.Forms.MessageBoxButtons]::OK,
            [System.Windows.Forms.MessageBoxIcon]::Information
        )
        
        RefreshDrives
        UpdateStatus
    }
})

$null = $btnRefresh.Add_Click({ RefreshDrives })

$null = $btnFormat.Add_Click({
    if ($listBox.SelectedItem -match "([A-Z]):") {
        $dl = $matches[1]
        
        # Check if it's already NTFS
        if (Test-IsNTFS $dl) {
            $msg = (Get-String "AlreadyNTFS") -f $dl
            $null = [System.Windows.Forms.MessageBox]::Show($msg, (Get-String "AlreadyNTFSTitle"), [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
            return
        }
        
        # Get volume info
        $vol = Get-Volume -DriveLetter $dl -ErrorAction SilentlyContinue
        if (-not $vol) {
            $null = [System.Windows.Forms.MessageBox]::Show("Cannot access drive $dl", "Error", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error)
            return
        }
        
        $label = if ($vol.FileSystemLabel) { $vol.FileSystemLabel } else { "USB_DRIVE" }
        
        # Confirm with user - First warning
        $msg1 = (Get-String "FormatConfirm1") -f $dl, $vol.FileSystem, $label
        $result1 = [System.Windows.Forms.MessageBox]::Show(
            $msg1,
            (Get-String "FormatTitle1"),
            [System.Windows.Forms.MessageBoxButtons]::YesNo,
            [System.Windows.Forms.MessageBoxIcon]::Warning
        )
        
        if ($result1 -ne [System.Windows.Forms.DialogResult]::Yes) {
            return
        }
        
        # Second confirmation
        $msg2 = (Get-String "FormatConfirm2") -f $dl
        $result2 = [System.Windows.Forms.MessageBox]::Show(
            $msg2,
            (Get-String "FormatTitle2"),
            [System.Windows.Forms.MessageBoxButtons]::OKCancel,
            [System.Windows.Forms.MessageBoxIcon]::Exclamation
        )
        
        if ($result2 -ne [System.Windows.Forms.DialogResult]::OK) {
            return
        }
        
        # Create progress form
        $progressForm = New-Object System.Windows.Forms.Form
        $progressForm.Text = "Formatting..."
        $progressForm.Size = New-Object System.Drawing.Size(400,150)
        $progressForm.StartPosition = "CenterScreen"
        $progressForm.FormBorderStyle = "FixedDialog"
        $progressForm.ControlBox = $false
        $progressForm.TopMost = $true
        
        $progressLabel = New-Object System.Windows.Forms.Label
        $progressLabel.Text = "Formatting drive $dl to NTFS...`n`nPlease wait, this may take 30-60 seconds."
        $progressLabel.Location = New-Object System.Drawing.Point(20,20)
        $progressLabel.Size = New-Object System.Drawing.Size(360,60)
        $progressLabel.Font = New-Object System.Drawing.Font("Arial",10)
        $null = $progressForm.Controls.Add($progressLabel)
        
        $progressBar = New-Object System.Windows.Forms.ProgressBar
        $progressBar.Location = New-Object System.Drawing.Point(20,90)
        $progressBar.Size = New-Object System.Drawing.Size(360,20)
        $progressBar.Style = "Marquee"
        $progressBar.MarqueeAnimationSpeed = 30
        $null = $progressForm.Controls.Add($progressBar)
        
        # Show progress form
        $progressForm.Show()
        $progressForm.Refresh()
        [System.Windows.Forms.Application]::DoEvents()
        
        # Perform the format in background
        try {
            # Format using diskpart (more reliable than Format-Volume)
            $diskpartScript = @"
select volume $dl
format fs=ntfs label="$label" quick
"@
            $diskpartScript | diskpart.exe | Out-Null
            
            Start-Sleep -Seconds 1
            
            # Close progress form
            $progressForm.Close()
            $progressForm.Dispose()
            
            # Verify format succeeded
            $vol = Get-Volume -DriveLetter $dl -ErrorAction SilentlyContinue
            if ($vol.FileSystem -eq "NTFS") {
                $msgSuccess = (Get-String "FormatSuccess") -f $dl
                $null = [System.Windows.Forms.MessageBox]::Show($msgSuccess, (Get-String "FormatSuccessTitle"), [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
            } else {
                $null = [System.Windows.Forms.MessageBox]::Show("Format completed but verification failed. Please check drive $dl manually.", "Format Warning", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Warning)
            }
            
            RefreshDrives
            UpdateStatus
        }
        catch {
            # Close progress form if still open
            if ($progressForm -and -not $progressForm.IsDisposed) {
                $progressForm.Close()
                $progressForm.Dispose()
            }
            
            $msgError = (Get-String "FormatError") -f $_.Exception.Message
            $null = [System.Windows.Forms.MessageBox]::Show($msgError, (Get-String "FormatErrorTitle"), [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error)
        }
    }
    else {
        $null = [System.Windows.Forms.MessageBox]::Show((Get-String "NoSelection"), (Get-String "NoSelectionTitle"), [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Warning)
    }
})

$null = $btnLanguage.Add_Click({
    # Toggle language
    if ($script:CurrentLanguage -eq "English") {
        $script:CurrentLanguage = "Amharic"
    } else {
        $script:CurrentLanguage = "English"
    }
    Update-Language
})

$null = $form.Controls.AddRange(@($btnLock, $btnUnlock, $btnRefresh, $btnFormat, $btnLanguage))
RefreshDrives
$null = $form.ShowDialog()