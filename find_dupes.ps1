
$content = Get-Content "lib\App\Translation.dart" -Raw

# Helper function to find duplicates in a block
function Find-Dupes {
    param($block, $name)
    $matches = [regex]::Matches($block, '"(.*?)"\s*:')
    $keys = $matches | ForEach-Object { $_.Groups[1].Value }
    $dupes = $keys | Group-Object | Where-Object { $_.Count -gt 1 }
    foreach ($d in $dupes) {
        Write-Output "$name duplicate: $($d.Name)"
    }
}

# Find en_US block
if ($content -match "'en_US':\s*\{(.*?)\},") {
    Find-Dupes $matches[1] "en_US"
}

# Find pl_PL block
if ($content -match "'pl_PL':\s*\{(.*?)\},") {
    Find-Dupes $matches[1] "pl_PL"
}
