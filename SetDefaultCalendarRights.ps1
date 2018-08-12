function Set-DefaultCalendarRights {
    param (
        [string[]]$Mailboxes,
        [ValidateSet("AvailabilityOnly","LimitedDetails")][string]$AccessRights
    )

    Foreach ($Mailbox in $Mailboxes) {
        $CalendarFolder = Get-MailboxFolderStatistics $Mailbox | Where-Object {$_.FolderType -eq "Calendar"}
        if ($CalendarFolder) {
            $Folder = $mailbox.alias + ":\" + $CalendarFolder.Name
            Set-MailboxFolderPermission -Identity $Folder  -User default -AccessRights AvailabilityOnly # -Whatif
        }
    }
}

# Examples

$Mailboxes = get-mailbox -OrganizationalUnit "OU=Users,DC=jaaplab,DC=nl"

Set-DefaultCalendarRights -Mailboxes $Mailboxes -AccessRights LimitedDetails

