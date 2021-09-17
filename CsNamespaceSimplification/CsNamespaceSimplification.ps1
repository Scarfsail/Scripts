param ([string] $path = ".")
    

function Convert-RemoveFourLeadingSpacesFromEachLine {
    param ([Parameter(Mandatory)][string] $value)
    
    return $value -replace "(?ms)(^ {4})", ''
}

function  Convert-CsOldNameSpaceToSimple {
    param ([Parameter(Mandatory)][string] $value)

    $result = $value -replace '(namespace[ ]+)+([^\s]+)(([ ]+)?([\r\n]+)?{)', ('$1$2;' + "`r`n")
    if ($result -ne $value) {
        $result = $result -replace "(?s)(.*)(})(.*)?", '$1'
        $result = Convert-RemoveFourLeadingSpacesFromEachLine $result
    }
    return $result   
}


Get-ChildItem -Path ($path + "\\*.cs") -Recurse | ForEach-Object {
    $content = Get-Content $_.FullName -Raw
    $converted = Convert-CsOldNameSpaceToSimple $content
    ("Processing: " + $_.FullName)
    if ($content -ne $converted) {
        Out-File -FilePath $_.FullName -InputObject $converted -NoNewline
    }
}
