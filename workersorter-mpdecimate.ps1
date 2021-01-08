$path = $('.\'+'MPDecimate')
if($(Test-Path $path) -ne $true){New-Item -Path $path -ItemType Directory}
else
{
    $files = (Get-ChildItem -Path $path)
    foreach($var in $files)
    {
        $ogName = $var.Name
        $tempName = ($var.BaseName + ".temp" + $var.Extension)
        $ogName
        $tempName
        #Move-Item $ogName $($path+'\'+$tempName)
        ffmpeg -i $var.FullName -vf mpdecimate -c:v hevc_nvenc -preset 11 -c:a copy -vsync vfr $($path+'\'+$tempName)
        Remove-Item $var.FullName
        Rename-Item $($path+'\'+$tempName).Replace("[", "``[").replace("]", "``]") $ogName
    }
}
$files