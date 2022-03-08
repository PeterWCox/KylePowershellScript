# Variables 
$humanNames = Get-Content -Path @("C:\Users\PeterCox\Desktop\KylePowershellScript\names.csv")
$imageFolders = @(
    "C:\Users\PeterCox\Desktop\KylePowershellScript\Folder1\",
    "C:\Users\PeterCox\Desktop\KylePowershellScript\Folder2\"
)
$outputFolder = "C:\Users\PeterCox\Desktop\KylePowershellScript\Output\"
$index = 0
$numberOfFiles = 0

# If the output folder doesn't exist, create it
if (!(Test-Path $outputFolder)) {
    New-Item -Path $outputFolder
}
else {
    # If the output folder does exist, delete all files in it
    $files = Get-ChildItem -Path $outputFolder
    foreach ($file in $files) {
        Remove-Item -Path $outputFolder -Recurse -Force
    }
}



# Get number of files in all imageFolders
$numberOfFiles = (Get-ChildItem -Path $imageFolders -Recurse -File | Where-Object {$_.Extension -eq ".png"}).Count


foreach ($folder in $imageFolders) {

    # Get array of file locations in folder
    $files = Get-ChildItem -Path $folder -Recurse -File 

    foreach ($file in $files) {
        $outputFilePath = $outputFolder + $humanNames[$index]
        Copy-Item $file.FullName "$outputFilePath.png"
        $index++

        Write-Host "$index / $numberOfFiles - Copied $file to $outputFilePath" -ForegroundColor Green
    }

}