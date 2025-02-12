# Service-Inspector
*****Add-Type -AssemblyName System.Windows.Forms

$FormObject = [System.Windows.Forms.Form]
$Labelobject = [System.Windows.Forms.Label]
$ComboBoxObject = [System.Windows.Forms.ComboBox]

$DefaultFont = 'Verdana,11'

# Set up Base Form
$AppForm = New-Object $FormObject
$AppForm.ClientSize = '800,300'  # Anpassen der Form-Größe
$AppForm.Text = 'Service Inspector'
$AppForm.BackColor = '#ffffff'
$AppForm.Font = $DefaultFont

# Building the Form

$lblService = New-Object $Labelobject
$lblService.Text = 'Services:'
$lblService.AutoSize = $true
$lblService.Location = New-Object System.Drawing.Point(20, 20)

$ddlService = New-Object $ComboBoxObject
$ddlService.Width = 300
$ddlService.Location = New-Object System.Drawing.Point(125, 20)

# AutoComplete-Funktion aktivieren
$ddlService.DropDownStyle = [System.Windows.Forms.ComboBoxStyle]::DropDown
$ddlService.AutoCompleteMode = [System.Windows.Forms.AutoCompleteMode]::SuggestAppend
$ddlService.AutoCompleteSource = [System.Windows.Forms.AutoCompleteSource]::ListItems

# Load Dropdownlist with Services
$services = Get-Service | Select-Object -ExpandProperty Name  # Liste der Dienste laden

# Alle Dienste zum Dropdown hinzufügen
$services | ForEach-Object {
    $ddlService.Items.Add($_)
}

$ddlService.Text = 'Pick a Service'

$lblForName = New-Object $Labelobject
$lblForName.Text = 'Service Friendly Name:'
$lblForName.AutoSize = $true
$lblForName.Location = New-Object System.Drawing.Point(20, 80)

$lblName = New-Object $Labelobject
$lblName.Text = ''
$lblName.AutoSize = $true
$lblName.Location = New-Object System.Drawing.Point(220, 80)

$lblForStatus = New-Object $Labelobject
$lblForStatus.Text = 'Status:'
$lblForStatus.AutoSize = $true
$lblForStatus.Location = New-Object System.Drawing.Point(20, 140)

$lblStatus = New-Object $Labelobject
$lblStatus.Text = ''
$lblStatus.AutoSize = $true
$lblStatus.Location = New-Object System.Drawing.Point(220, 140)

$AppForm.Controls.AddRange(@($lblService, $ddlService, $lblForName, $lblName, $lblForStatus, $lblStatus))

# Function to Get Service Details
function GetServiceDetails {
    $ServiceName = $ddlService.SelectedItem
    if ($ServiceName) {
        $details = Get-Service -Name $ServiceName | Select-Object *
        $lblName.Text = $details.DisplayName
        $lblStatus.Text = $details.Status

        if ($lblstatus.text -eq 'Running') {
            $lblStatus.ForeColor = 'Green'
        }
        else {
            $lblStatus.ForeColor = 'Red'
        }
    }
}

# Event Handler for ComboBox
$ddlService.Add_SelectedIndexChanged({
    GetServiceDetails
})

# Show the form
$AppForm.ShowDialog()

# Garbage Collection
$AppForm.Dispose()
This is an PowerShell script that can check if any Service is running Use either the DropDown menu or the Search Bar****

![image](https://github.com/user-attachments/assets/25e2445d-d056-4d51-8361-6b6320cbd167)




![image](https://github.com/user-attachments/assets/4b765b8b-21fb-483a-a0f9-962d08c6f11f)

