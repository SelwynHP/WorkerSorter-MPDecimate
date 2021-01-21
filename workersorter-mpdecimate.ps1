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
        ffmpeg -i $var.FullName -vf mpdecimate -c:v hevc_nvenc -preset losslesshp -tune lossless -c:a copy -vsync vfr $($path+'\'+$tempName)
        $tempFile = Get-ChildItem $($path+'\'+$tempName)
        if($tempFile.Length -gt 0)
        {
            Remove-Item $var.FullName
        Rename-Item $($path+'\'+$tempName).Replace("[", "``[").replace("]", "``]") $ogName
        }
        else
        {
            Remove-Item $tempFile.FullName
        }
    }
}
#
$files