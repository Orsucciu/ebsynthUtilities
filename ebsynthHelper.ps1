Function Get-FileName($initialDirectory)
{
    [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null
    [System.Windows.Forms.Application]::EnableVisualStyles()
    
    $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
    $OpenFileDialog.initialDirectory = $initialDirectory
    $OpenFileDialog.ShowDialog() | Out-Null
    $OpenFileDialog.filename
}

Write-Host "Hello! I will take your video file as argument, and output its frames and masks for you to use with ebsynth"
Write-Host "I need to be in the same folder as ffmpeg, ebsynth, and my python script. Alternatively, you could also modify my path vars"

$videoFile = Get-FileName "."
$folderName = 'ProjectFiles' + ([System.IO.Path]::GetFileNameWithoutExtension($videoFile))
New-Item -Name $folderName -ItemType Directory
'keys','video','masks' | ForEach-Object {New-Item -Name ".\$folderName\$_" -ItemType 'Directory'}

Write-Host "folders created..."

Write-Host "extracting frames..."
#path to ffmpeg
Invoke-Expression ("ffmpeg\bin\ffmpeg.exe -i " + $videoFile + " -r 1/1 " + $folderName + "\video\$filename%03d.png")

#we can't parallelise this, cause ffmpeg does its thing all at once
Write-Host "generating mask. This step will be long"
Get-ChildItem "$folderName\video\" | ForEach-Object {

    Write-Host "file..." $_ 
    Invoke-Expression ("python\main\main.exe $folderName\video\$_ $folderName\masks\ python\model.yml")
}


#open ebsynth now
Invoke-Expression ("ebsynth\EbSynth.exe")