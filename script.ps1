# Variables 
$humanNames = Get-Content -Path @("C:\Users\PeterCox\Desktop\KylePowershellScript\names.csv") 
$imageFolders = @(
    "C:\Users\PeterCox\Desktop\KylePowershellScript\Folder1\",
    "C:\Users\PeterCox\Desktop\KylePowershellScript\Folder2\"
)
$outputFolder = "C:\Users\PeterCox\Desktop\KylePowershellScript\Output\"
$index = 0

# Shuffle Array
$humanNames = $humanNames | Sort-Object {Get-Random}

# Delete output folder if it exists
if (Test-Path $outputFolder) {
    Remove-Item $outputFolder -Recurse -Force
}

# Create output folder
New-Item $outputFolder -ItemType Directory

# # Get number of files in all imageFolders
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