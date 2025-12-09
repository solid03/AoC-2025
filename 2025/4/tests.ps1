Describe Solution {
    It 'Part 1' {
        & "$PSScriptRoot\part1.ps1" .\example.txt | Should -Be 13
    }

    It 'Part 2' {
        & "$PSScriptRoot\part2.ps1" .\example.txt | Should -Be 43
    }
}
