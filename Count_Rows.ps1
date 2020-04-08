Add-Type -AssemblyName System.Windows.Forms
$FileBrowser = New-Object System.Windows.Forms.OpenFileDialog -Property @{
    Multiselect = $false # Multiple files can not be chosen
    InitialDirectory = [Environment]::GetFolderPath('Desktop') 
    Filter = 'Text File (*.csv)|*.csv' # Specified file type
    Title = 'Select CSV File to Count the number of its rows' # Title of the Browser Dialogue Box 
}
 
[void]$FileBrowser.ShowDialog()

$file = $FileBrowser.FileName;

If($FileBrowser.FileNames -like "*\*") { # Ensuring that the File Browser Dialogue Box returned a file
	$csv= Import-Csv $FileBrowser.FileName -Header h1 #specificying a dummy header prevents treating first row as a header
	$MeasureArray= $csv| Measure| select count
	write-host ("Number of rows in this file is") $MeasureArray.count -ForegroundColor red -BackgroundColor Black
	
}

else {
    Write-Host "You didn't select a file" # in case that the user canceled
}