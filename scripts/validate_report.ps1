# $xmlFilePath = "..\myApp\reports\report"
$xmlFilePath = Resolve-Path "..\myApp\reports\report.xml"

# Read the XML file content
$xmlContent = Get-Content -Path $xmlFilePath -Raw

# Parse the XML content
[xml]$xmlObject = $xmlContent

$IssuesSev = $xmlObject.Report.Issues.Project.IssueTypes.Severity
$issues    = $xmlObject.Report.Issues.Project.Issue.Message

If(($IssuesSev -Contains "Error") -or ($IssuesSev -Contains "Warning")){
    Throw $($issues -join "`n")
}else{
    Write-Host "No High Severity Issues Found."
    Write-Host $issues -Separator "`n"
    exit 0
}