Function Logged-In($computer) {

    
    $result = get-wmiobject -computername $computer -class win32_computersystem | select-object username
    $message = 'Logged in User on '+$computer+' is '+$result

    Add-Type -assembly System.Windows.Forms
    Add-Type -AssemblyName System.Drawing

    $loggedin_resultform = New-Object System.Windows.Forms.Form

    $loggedin_resultform.Text = $message
    $loggedin_resultform.Width = 600
    $loggedin_resultform.Height = 400
    $loggedin_resultform.Autosize = $true

    [System.Windows.MessageBox]::Show($message)


    #$loggedin_resultform.Controls.Add($result_label)
    #$loggedin_resultform.ShowDialog()

}


Function Logged-In-Menu {

    Add-Type -assembly System.Windows.Forms
    Add-Type -AssemblyName System.Drawing

    $button1_form = New-Object System.Windows.Forms.Form

    $button1_form.Text = 'Get Logged in User'
    $button1_form.Width = 500
    $button1_form.Height = 100
    $button1_form.Autosize = $true

    $text_box_label = New-Object System.Windows.Forms.Label
    $text_box_label.Left = 25
    $text_box_label.Top = 15
    $text_box_label.Text = 'Enter Target PC Name'

    $target_text_box = New-Object System.Windows.Forms.TextBox
    $target_text_box.Left = 150
    $target_text_box.Top = 10
    $target_text_box.Width = 200
    $target_text_box.Text = $defaultValue

    $ok_button = New-Object System.Windows.Forms.Button
    $ok_button.Top = 10
    $ok_button.Left = 360
    $ok_button.Width = 100
    $ok_button.Text = 'Run'
    $ok_button.Add_Click({Logged-In($target_text_box.Text);$button1_form.Close()})

    
    $button1_form.Controls.Add($text_box_label)
    $button1_form.Controls.Add($target_text_box)
    $button1_form.Controls.Add($ok_button)

    $button1_form.ShowDialog() 


}

Function Turn-On-Remote-Registry-Menu {

    Add-Type -assembly System.Windows.Forms
    Add-Type -AssemblyName System.Drawing

    $button2_form = New-Object System.Windows.Forms.Form

    $button2_form.Text = 'Turn on Remote Registry'
    $button2_form.Width = 500
    $button2_form.Height = 100
    $button2_form.Autosize = $true

    $text_box_label = New-Object System.Windows.Forms.Label
    $text_box_label.Left = 25
    $text_box_label.Top = 15
    $text_box_label.Text = 'Enter Target PC Name'

    $target_text_box = New-Object System.Windows.Forms.TextBox
    $target_text_box.Left = 150
    $target_text_box.Top = 10
    $target_text_box.Width = 200
    $target_text_box.Text = $defaultValue

    $ok_button = New-Object System.Windows.Forms.Button
    $ok_button.Top = 10
    $ok_button.Left = 360
    $ok_button.Width = 100
    $ok_button.Text = 'Run'
    $ok_button.Add_Click({Turn-On-Remote-Registry($target_text_box.Text);$button2_form.Close()})

    
    $button2_form.Controls.Add($text_box_label)
    $button2_form.Controls.Add($target_text_box)
    $button2_form.Controls.Add($ok_button)

    $button2_form.ShowDialog() 


}

Function Check-Remote-Registry ($computer) {


   invoke-command -computername $computer  -scriptblock {

     $service_name = 'remote registry'

    $my_service = Get-Service -Name remoteregistry 

        if ($my_service.Status -eq 'Running') {

            return 1

        }

        else {

            return 0

        }
                
    } 



}

Function Turn-On-Remote-Registry($computer) {

  if (Test-Connection -Computername $computer -BufferSize 16 -Count 1 -Quiet) {

   invoke-command -computername $computer  -scriptblock {

        set-service remoteregistry -StartupType Automatic

        start-service remoteregistry
                
    }

        if (Check-Remote-Registry($computer)) {

        $message = 'Remote Registry on '+$computer+' is turned on'

        Add-Type -assembly System.Windows.Forms
        Add-Type -AssemblyName System.Drawing

        $loggedin_resultform = New-Object System.Windows.Forms.Form

        $loggedin_resultform.Text = $message
        $loggedin_resultform.Width = 600
        $loggedin_resultform.Height = 400
        $loggedin_resultform.Autosize = $true

    [System.Windows.MessageBox]::Show($message)

    }

    else {

        $message = 'Remote Registry on '+$computer+' could not be started'

        Add-Type -assembly System.Windows.Forms
        Add-Type -AssemblyName System.Drawing

        $loggedin_resultform = New-Object System.Windows.Forms.Form

        $loggedin_resultform.Text = $message
        $loggedin_resultform.Width = 600
        $loggedin_resultform.Height = 400
        $loggedin_resultform.Autosize = $true

    [System.Windows.MessageBox]::Show($message)

    }

}

    else {
    
    $message = $computer+' could not be contacted' 

    

    Add-Type -assembly System.Windows.Forms
    Add-Type -AssemblyName System.Drawing

    $loggedin_resultform = New-Object System.Windows.Forms.Form

    $loggedin_resultform.Text = $message
    $loggedin_resultform.Width = 600
    $loggedin_resultform.Height = 400
    $loggedin_resultform.Autosize = $true

    [System.Windows.MessageBox]::Show($message)

    }


}

Function Generate-Form {

    Add-Type -assembly System.Windows.Forms
    Add-Type -AssemblyName System.Drawing

    $main_form = New-Object System.Windows.Forms.Form

    $main_form.Text = 'Powershell Scripts'
    $main_form.Width = 600
    $main_form.Height = 400
    $main_form.Autosize = $true

    $button1 = New-Object System.Windows.Forms.Button
    $button1.Location = New-Object System.Drawing.Size(35,35)
    $button1.Size = New-Object System.Drawing.Size(500,50)
    $button1.Text = "Show logged in user on a target"

    $button2 = New-Object System.Windows.Forms.Button
    $button2.Location = New-Object System.Drawing.Size(35,90)
    $button2.Size = New-Object System.Drawing.Size(500,50)
    $button2.Text = "Turn on Remote Registry"

    $main_form.Controls.Add($button1)
    $main_form.Controls.Add($button2)

    $button1.Add_Click({Logged-In-Menu})
    $button2.Add_Click({Turn-On-Remote-Registry-Menu})

    $main_form.ShowDialog()

}

Generate-Form

