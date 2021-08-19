#3dsmax 2022 == 24.0
#3dsmax 2021 == 23.0
#3dsmax 2020 == 22.0
#3dsmax 2019 == 21.0

#calc 2019-1998=21

$data = @(2019,2020,2021,2022,2023)

$data | ForEach-Object {"3dsMax: $PSItem, ID: $($PSItem - 1998)"}
#write-host $data