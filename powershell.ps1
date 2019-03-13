Param( [String]$Att,
       [String]$subj,
       [String]$Body
       )
Function Send-Email {

    Param(
            [Parameter(`
            Mandatory=$true)]
        [String]$To,
            [Parameter(`
            Mandatory=$true)]
        [String]$From,
            [Parameter(`
            Mandatory=$true)]
        [String]$Password,
            [Parameter(`
            Mandatory=$true)]
        [String]$Subject,
            [Parameter(`
            Mandatory=$true)]
        [String]$Body,
            [Parameter(`
            Mandatory=$true)]
        [String]$attachment
        )

try
{
    $Msg = New-Object System.Net.Mail.MailMessage($From, $To, $Subject, $Body)
    $Srv = "smtp.gmail.com"
    if($attachment -ne $null){
        try{
            $attachment = $attachment -split ("\:\:");
            
            ForEach($val in $attachment){
                $attch = New-Object System.Net.Mail.Attachment($val)
                $Msg.Attachments.Add($attch)
                }
            }
            catch {
                exit 2;
                }
            $Client = New-Object net.Mail.SmtpClient($Srv, 587)
            $Client.EnableSsl = $true
            $Client.Credentials = New-Object System.Net.NetworkCredential($From.Split("@")[0], $Password);
            $Client.Send($Msg)
            Remove-Variable -Name Client
            Remove-Variable -Name Password
            exit 7;

        }
    } 
    catch {
        exit 3;
    }
}

try{
    Send-Email
        -attachment $Att
        -To "Adss of the recipient"
        -Body $Body
        -Subject $subj
        -password "sdsdf"
        -From "Address f the sender"

} catch {
    exit 4;
}