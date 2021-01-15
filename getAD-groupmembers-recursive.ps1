#Get groups starting with BI-*
$g= get-adgroup -Filter {name -like "BI-*"} -Properties * |select name, description, SamAccountName
$g | export-csv -Path d:\temp\ALL-Bi-groups.csv -NoTypeInformation


#Recursively get all members of the groups from above separated into individual CSVs.
foreach ($group in $g){
$group.name
$filename = "d:\temp\BI\" + $group.name + ".csv"

Get-ADGroupmember -identity $group.name -Recursive| % { get-aduser $_.samaccountname | select name,userprincipalname } | export-csv -path $filename -notypeinformation

}
