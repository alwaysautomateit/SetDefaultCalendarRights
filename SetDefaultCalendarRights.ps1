function Set-DefaultCalendarRights {
    param (
        [string[]]$Mailboxes,
        [ValidateSet("AvailabilityOnly","LimitedDetails")][string]$AccessRights
    )

    <#
    .SYNOPSiS
    Sets the input mailboxes default calendar rights

    .PARAMETER Mailboxes
    Specifies either a single or array of mailbox UPNs

    .PARAMETER AccessRights
    Specifies the value the calendar should be set to.

    .EXAMPLE
    Set-DefaultCalendarRights -Mailboxes (Get-Mailbox | Select UserPrincipalName) -AccessRights LimitedDetails

    #>

    Foreach ($Mailbox in $Mailboxes) {
        $CalendarFolder = Get-MailboxFolderStatistics $Mailbox | Where-Object {$_.FolderType -eq "Calendar"}
        if ($CalendarFolder) {
            $Folder = $mailbox.alias + ":\" + $CalendarFolder.Name
            Set-MailboxFolderPermission -Identity $Folder  -User default -AccessRights AvailabilityOnly # -Whatif
        }
    }
}

# Example: load a set of mailboxes and set the access rights.

$Mailboxes = get-mailbox -OrganizationalUnit "OU=Users,DC=jaaplab,DC=nl"

Set-DefaultCalendarRights -Mailboxes $Mailboxes -AccessRights LimitedDetails

