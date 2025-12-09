Describe 'Solution' {
    It 'Part 1' {
        & "$PSScriptRoot\part1.ps1" .\example.txt | Should -Be 3
    }

    It 'Part 2' {
        & "$PSScriptRoot\Part2.ps1" .\example.txt | Should -Be 14
    }

    It 'Part 2 edge case' {
        & "$PSScriptRoot\Part2.ps1" .\example2.txt | Should -Be 88
    }

    It 'Part 2 edge case 2' {
        & "$PSScriptRoot\Part2.ps1" .\example3.txt | Should -Be 13
    }

    It 'Part 2 edge case 3' {
        & "$PSScriptRoot\Part2.ps1" .\example4.txt | Should -Be 12
    }
}