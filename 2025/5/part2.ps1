param (
    [System.IO.FileInfo] $Path = "$PSScriptRoot\input.txt"
)

[string[]] $DB = Get-Content -Path $Path
$Delimiter = $DB.IndexOf('')

function ConvertTo-Tuple([int64] $Start, [int64] $End) {
    $Count = [System.Math]::Max([int64] 0, ($End - $Start + 1))
    [Tuple]::Create([int64] $Start, [int64] $End, [int64] $Count)
}

## Build fresh list
[System.Collections.ArrayList] $Fresh = $DB[0..($Delimiter - 1)] | ForEach-Object {
    $Range = $_ -split '-'
    ConvertTo-Tuple -Start $Range[0] -End $Range[1]
} | Sort-Object -Property Item1

## Deduplicate fresh list
for ($i = 0; $i -lt $Fresh.Count - 1; $i++) {
    ## Keep looping until next element contains ingredients
    for ($j = 1; $j + $i -lt $Fresh.Count; $j++) {
        if ($Fresh[$i].Item2 -ge $Fresh[$i + $j].Item1) {
            $Fresh[$i + $j] = ConvertTo-Tuple -Start ($Fresh[$i].Item2 + 1) -End $Fresh[$i + $j].Item2
        }
        ## Then skip to that element
        if ($Fresh[$i + $j].Item3 -ne 0) { $i += ($j - 1); break }
    }
}

[System.Linq.Enumerable]::Sum(([int64[]]$Fresh.Item3))
