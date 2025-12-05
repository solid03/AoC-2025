[CmdletBinding()]
param (
    [switch] $Part2
)
function Convert_ElfInput {
    [CmdletBinding()]
    param(
        [string] $InputObject
    )
    end {
        try {
            foreach ($Pair in ($InputObject -split ',')) {
                $Range = $Pair -split '-'
                for ([int64] $i = $Range[0]; $i -le $Range[1]; $i++) { $i }
            }
        } catch { throw $PSCmdlet.ThrowTerminatingError($_) }
    }
}

filter Test_BadElfId {
    [string] $s = $_.ToString()
    if ($s.Length % 2) { return } ## early return for non-symetrical string

    $Middle = $s.Length / 2
    if ($s.Substring(0, $Middle) -eq $s.Substring($Middle, $Middle)) { $_ }
}

filter Test_BadElfId2 {
    [string] $s = $_.ToString()

    for ($i = 1; $i -le $s.Length / 2; $i++) {
        if (-not ($s -replace $s.Substring(0, $i))) { return $_ }
    }
}

$Range = Convert_ElfInput -InputObject (Get-Content -Path "$PSScriptRoot\input.txt")
$BadIDs = $Part2 ? ($Range | Test_BadElfId2) : ($Range | Test_BadElfId)

$BadIDs | Measure-Object -Sum
