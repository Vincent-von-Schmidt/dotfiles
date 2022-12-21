rm -r ~/AppData/Local/nvim
rm -r ~/AppData/Local/nvim-data

$wingetinstall = New-Object System.Collections.Generic.List[System.Object]
$wingetisntall.Add("OpenJS.NodeJS")
$wingetintsall.Add("Neovim.Neovim")

# Install all winget programs in new window
        $wingetinstall.ToArray()
        # Define Output variable
        foreach ( $node in $wingetinstall ) {
            try {
                Start-Process powershell.exe -Verb RunAs -ArgumentList "-command winget install -e --accept-source-agreements --accept-package-agreements --silent $node | Out-Host" -WindowStyle Normal
                Start-Sleep -s 3
                Wait-Process winget -Timeout 90 -ErrorAction SilentlyContinue
            }
            catch [System.InvalidOperationException] {
                Write-Warning "Allow Yes on User Access Control to Install"
            }
            catch {
                Write-Error $_.Exception
            }
        }
