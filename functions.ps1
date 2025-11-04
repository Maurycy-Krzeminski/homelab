function Import-DotEnv-Value {
    param (
        [Parameter(Mandatory=$true)]
        [string]$Path
    )

    if (-Not (Test-Path $Path)) {
        Write-Error "File not found: $Path"
        return
    }

    Get-Content $Path | ForEach-Object {
        $line = $_.Trim()
        # Ignore comments and empty lines
        if ($line -and -not ($line.StartsWith('#'))) {
            $parts = $line -split '=', 2
            if ($parts.Count -eq 2) {
                $name = $parts[0].Trim()
                $value = $parts[1].Trim().Trim('"').Trim("'")
                # Set the environment variable for current process
                # [System.Environment]::SetEnvironmentVariable($name, $value, "Process")
                # Set a normal variable in current scope
                Set-Variable -Name $name -Value $value -Scope Script
            }
        }
    }
}



function Import-DotEnv-Environment-Value {
    param (
        [Parameter(Mandatory=$true)]
        [string]$Path
    )

    if (-Not (Test-Path $Path)) {
        Write-Error "File not found: $Path"
        return
    }

    Get-Content $Path | ForEach-Object {
        $line = $_.Trim()
        # Ignore comments and empty lines
        if ($line -and -not ($line.StartsWith('#'))) {
            $parts = $line -split '=', 2
            if ($parts.Count -eq 2) {
                $name = $parts[0].Trim()
                $value = $parts[1].Trim().Trim('"').Trim("'")
                # Set the environment variable for current process
                [System.Environment]::SetEnvironmentVariable($name, $value, "Process")
            }
        }
    }
}