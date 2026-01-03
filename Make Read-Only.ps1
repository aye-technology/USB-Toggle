# Suppress all output when compiled to EXE
$ErrorActionPreference = "SilentlyContinue"
[void][System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
[void][System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")

# Automatically request Admin privileges (only needed when running as .ps1)
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Start-Process powershell.exe "-WindowStyle Hidden -NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

# Create form
$form = New-Object System.Windows.Forms.Form
$form.Text = "USB Read-Only Toggle (2025)"
$form.Size = New-Object System.Drawing.Size(450,300)
$form.StartPosition = "CenterScreen"
$form.FormBorderStyle = "FixedDialog"
$form.MaximizeBox = $false

# Label
$label = New-Object System.Windows.Forms.Label
$label.Text = "Select your USB Drive:"
$label.Location = New-Object System.Drawing.Point(10,10)
$label.AutoSize = $true
$form.Controls.Add($label)

# ListBox
$listBox = New-Object System.Windows.Forms.ListBox
$listBox.Location = New-Object System.Drawing.Point(10,40)
$listBox.Size = New-Object System.Drawing.Size(410,100)
$form.Controls.Add($listBox)

# Status label
$statusLabel = New-Object System.Windows.Forms.Label
$statusLabel.Text = "No drive selected"
$statusLabel.Location = New-Object System.Drawing.Point(10,150)
$statusLabel.Size = New-Object System.Drawing.Size(410,20)
$statusLabel.Font = New-Object System.Drawing.Font("Segoe UI",9,[System.Drawing.FontStyle]::Bold)
$form.Controls.Add($statusLabel)

# Function to refresh drive list
function RefreshDrives {
    $listBox.Items.Clear()
    $script:disks = Get-Disk | Where-Object { $_.BusType -eq "USB" }
    
    if ($script:disks.Count -eq 0) {
        $listBox.Items.Add("No USB drives detected")
        $btnLock.Enabled = $false
        $btnUnlock.Enabled = $false
        $statusLabel.Text = "No USB drives found"
        $statusLabel.ForeColor = [System.Drawing.Color]::Gray
    } else {
        foreach ($disk in $script:disks) {
            $status = if ($disk.IsReadOnly) { "[READ-ONLY]" } else { "[WRITABLE]" }
            $listBox.Items.Add("$($disk.Number): $($disk.FriendlyName) ($([math]::round($disk.Size/1GB, 2)) GB) $status")
        }
        $btnLock.Enabled = $false
        $btnUnlock.Enabled = $false
        $statusLabel.Text = "Select a drive to view status"
        $statusLabel.ForeColor = [System.Drawing.Color]::Black
    }
}

# Function to update status display
function UpdateStatus {
    $sel = $listBox.SelectedItem
    if ($sel -and $sel -ne "No USB drives detected") {
        $dNum = [int]$sel.Split(":")[0]
        $disk = Get-Disk -Number $dNum
        
        if ($disk.IsReadOnly) {
            $statusLabel.Text = "Status: READ-ONLY (Protected from writes)"
            $statusLabel.ForeColor = [System.Drawing.Color]::Green
            $btnLock.Enabled = $false
            $btnUnlock.Enabled = $true
        } else {
            $statusLabel.Text = "Status: WRITABLE (Can be modified)"
            $statusLabel.ForeColor = [System.Drawing.Color]::DarkOrange
            $btnLock.Enabled = $true
            $btnUnlock.Enabled = $false
        }
    }
}

# ListBox selection event
$listBox.Add_SelectedIndexChanged({
    UpdateStatus
})

# Lock button
$btnLock = New-Object System.Windows.Forms.Button
$btnLock.Text = "Set Read-Only"
$btnLock.Location = New-Object System.Drawing.Point(10,185)
$btnLock.Size = New-Object System.Drawing.Size(130,35)
$btnLock.Enabled = $false
$btnLock.Add_Click({
    $sel = $listBox.SelectedItem
    if (!$sel -or $sel -eq "No USB drives detected") {
        [System.Windows.Forms.MessageBox]::Show("Please select a drive first.", "No Selection", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Warning)
        return
    }
    
    $dNum = [int]$sel.Split(":")[0]
    $result = [System.Windows.Forms.MessageBox]::Show(
        "Are you sure you want to set Disk $dNum to READ-ONLY?`n`nThis will protect it from all write operations.",
        "Confirm Read-Only",
        [System.Windows.Forms.MessageBoxButtons]::YesNo,
        [System.Windows.Forms.MessageBoxIcon]::Question
    )
    
    if ($result -eq [System.Windows.Forms.DialogResult]::Yes) {
        try {
            Set-Disk -Number $dNum -IsReadOnly $true
            [System.Windows.Forms.MessageBox]::Show("Disk $dNum is now READ-ONLY.", "Success", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
            RefreshDrives
            # Reselect the disk after refresh
            for ($i = 0; $i -lt $listBox.Items.Count; $i++) {
                if ($listBox.Items[$i] -match "^$dNum`:") {
                    $listBox.SelectedIndex = $i
                    break
                }
            }
        } catch {
            [System.Windows.Forms.MessageBox]::Show("Failed to set disk to read-only.`n`nError: $_", "Error", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error)
        }
    }
})
$form.Controls.Add($btnLock)

# Unlock button
$btnUnlock = New-Object System.Windows.Forms.Button
$btnUnlock.Text = "Set Writable"
$btnUnlock.Location = New-Object System.Drawing.Point(150,185)
$btnUnlock.Size = New-Object System.Drawing.Size(130,35)
$btnUnlock.Enabled = $false
$btnUnlock.Add_Click({
    $sel = $listBox.SelectedItem
    if (!$sel -or $sel -eq "No USB drives detected") {
        [System.Windows.Forms.MessageBox]::Show("Please select a drive first.", "No Selection", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Warning)
        return
    }
    
    $dNum = [int]$sel.Split(":")[0]
    $result = [System.Windows.Forms.MessageBox]::Show(
        "Are you sure you want to set Disk $dNum to WRITABLE?`n`nThis will allow modification of the drive.",
        "Confirm Writable",
        [System.Windows.Forms.MessageBoxButtons]::YesNo,
        [System.Windows.Forms.MessageBoxIcon]::Warning
    )
    
    if ($result -eq [System.Windows.Forms.DialogResult]::Yes) {
        try {
            Set-Disk -Number $dNum -IsReadOnly $false
            [System.Windows.Forms.MessageBox]::Show("Disk $dNum is now WRITABLE.", "Success", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
            RefreshDrives
            # Reselect the disk after refresh
            for ($i = 0; $i -lt $listBox.Items.Count; $i++) {
                if ($listBox.Items[$i] -match "^$dNum`:") {
                    $listBox.SelectedIndex = $i
                    break
                }
            }
        } catch {
            [System.Windows.Forms.MessageBox]::Show("Failed to set disk to writable.`n`nError: $_", "Error", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error)
        }
    }
})
$form.Controls.Add($btnUnlock)

# Refresh button
$btnRefresh = New-Object System.Windows.Forms.Button
$btnRefresh.Text = "Refresh"
$btnRefresh.Location = New-Object System.Drawing.Point(290,185)
$btnRefresh.Size = New-Object System.Drawing.Size(130,35)
$btnRefresh.Add_Click({
    RefreshDrives
    [System.Windows.Forms.MessageBox]::Show("Drive list refreshed.", "Refresh", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
})
$form.Controls.Add($btnRefresh)

# Initial load
RefreshDrives

# Show form and suppress output
$null = $form.ShowDialog()
[System.GC]::Collect()
[System.GC]::WaitForPendingFinalizers()