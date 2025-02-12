Add-Type -AssemblyName System.Windows.Forms

$FormObject = [System.Windows.Forms.Form]
$Labelobject = [System.Windows.Forms.Label]
$ComboBoxObject = [System.Windows.Forms.ComboBox]

$DefaultFont = 'Verdana,11'

#Set up Base Form
$AppForm = New-Object $FormObject
$AppForm.ClientSize = '800,300'
$AppForm.Text = 'Service Inspector'
$AppForm.BackColor = '#ffffff'
$AppForm.Font = $DefaultFont

#Building the Form

$lblService = New-Object $Labelobject
$lblService.Text = 'Services:'
$lblService.AutoSize = $true
$lblService.Location = New-Object System.Drawing.Point(20, 20)

$ddlService = New-Object $ComboBoxObject
$ddlService.width = '300'
$ddlService.Location = New-Object System.Drawing.Point(125, 20)

#Load Dropdownlist with Services
Get-Service | ForEach-Object {
    $ddlService.Items.Add($_.Name)
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
$lblForStatus.Text = 'Status :'
$lblForStatus.AutoSize = $true
$lblForStatus.Location = New-Object System.Drawing.Point(20, 140)

$lblStatus = New-Object $Labelobject
$lblStatus.Text = ''
$lblStatus.AutoSize = $true
$lblStatus.Location = New-Object System.Drawing.Point(220, 140)


$AppForm.Controls.AddRange(@($lblService, $ddlService, $lblForName, $lblName, $lblForStatus, $lblStatus))

#Add some functions to the form

function GetServiceDetails {
    $ServiceName = $ddlService.SelectedItem
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


#Add functions to the controls

$ddlService.Add_SelectedIndexChanged({
        GetServiceDetails
    })	

#Show the form
$AppForm.ShowDialog()

 
#Garbage Collection
$AppForm.Dispose()

