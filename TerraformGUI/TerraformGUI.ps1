# Load Assembly ( WPF - Windows Presentation Framework )
Add-Type -AssemblyName PresentationFramework

# Init Synchronized HashTable for RunSpaces AKA MultiThreading
$SyncHash = [hashtable]::Synchronized(@{})
$SyncHash.Host = $Host

# Init  ( WPF - Windows Presentation Framework ) XAML Config
$XAML = [XML]@'
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation" Title="Terraform GUI v1.0" Width="1000" Height="700" WindowStartupLocation ="CenterScreen" VerticalAlignment="Top" ShowInTaskbar = "True" >
    <Grid Background="#FFE5E5E5">
        <Label Name="LabelOrgName" Content="Org Name" Margin="20,30,0,0" Height="28" HorizontalAlignment="Left" VerticalAlignment="Top" Visibility="Visible" />
        <Label Name="LabelUserName" Content="User Name" Margin="20,60,0,0" Height="28" HorizontalAlignment="Left" VerticalAlignment="Top" Visibility="Visible" />
        <Label Name="LabelPassword" Content="User Password" Margin="20,90,0,0" Height="28" HorizontalAlignment="Left" VerticalAlignment="Top" Visibility="Visible" />
        <Label Name="LabelVDC" Content="VDC Name" Margin="20,60,0,0" Height="28" HorizontalAlignment="Left" VerticalAlignment="Top" Visibility="Hidden" />
        <Label Name="LabelOrgNet" Content="Org Net Name" Margin="20,90,0,0" Height="28" HorizontalAlignment="Left" VerticalAlignment="Top" Visibility="Hidden"  />
        <Label Name="LabelWindowsTemplate" Content="Template Name" Margin="20,120,0,0" Height="28" HorizontalAlignment="Left" VerticalAlignment="Top" Visibility="Hidden" />
        <Label Name="LabelVappName" Content="VAPP Name:" Margin="20,150,0,0" Height="28" HorizontalAlignment="Left" VerticalAlignment="Top" Visibility="Hidden" />
        <Label Name="LabelVmNamePrefix" Content="VM Name Prefix:" Margin="20,180,0,0" Height="28" HorizontalAlignment="Left" VerticalAlignment="Top" Visibility="Hidden" />
        <TextBox Name="TextBoxOrgName" Margin="120,34,0,0" Width="240" Height="22" HorizontalAlignment="Left" VerticalAlignment="Top" Visibility="Visible" />
        <TextBox Name="TextBoxUserName" Margin="120,64,0,0" Width="240" Height="22" HorizontalAlignment="Left" VerticalAlignment="Top" Visibility="Visible" />
        <PasswordBox Name="PasswordBoxPassword" Margin="120,94,0,0" Width="240" Height="22" HorizontalAlignment="Left" VerticalAlignment="Top" Visibility="Visible" />
        <ComboBox Name="ComboBoxVDC" Margin="120,64,0,0" Width="240" Height="22" HorizontalAlignment="Left" VerticalAlignment="Top" Visibility="Hidden" />
        <ComboBox Name="ComboBoxOrgNet" Margin="120,94,0,0" Width="240" Height="22" HorizontalAlignment="Left" VerticalAlignment="Top" Visibility="Hidden" />
        <ComboBox Name="ComboBoxWindowsTemplate" Margin="120,124,0,0" Width="240" Height="22" HorizontalAlignment="Left" VerticalAlignment="Top" Visibility="Hidden" />
        <TextBox Name="TextBoxVappName" Margin="120,154,0,0" Width="240" Height="22" HorizontalAlignment="Left" VerticalAlignment="Top" Visibility="Hidden" />
        <TextBox Name="TextBoxVmNamePrefix" Margin="120,184,0,0" Width="240" Height="22" HorizontalAlignment="Left" VerticalAlignment="Top" Visibility="Hidden" />
        <TextBlock Name="TextBlock" HorizontalAlignment="Left" Margin="630,24,5,5" VerticalAlignment="Top" FontSize="20" TextWrapping="Wrap" />
        <Border Name="BorderLogin" CornerRadius="20" Padding="5,5,5,5" Width="200" Height="130" VerticalAlignment="Top" HorizontalAlignment="Left"  Margin="400,20,0,0" ToolTip="Push It real Good" ToolTipService.ShowDuration="1000" IsEnabled="True" Visibility="Visible" >
            <Border.Background>
                <LinearGradientBrush StartPoint="0,0" EndPoint="0,1">
				    <GradientStop Color="White" Offset="0.1" />
				    <GradientStop Color="Silver" Offset="0.9" />
                </LinearGradientBrush>
            </Border.Background>
            <Button Name="ButtonLogin" BorderBrush="Transparent" Background="Green" Foreground="DarkBlue" FontSize="40" FontWeight="Bold" >
                <AccessText Text=" Login " TextWrapping="Wrap" TextAlignment="Center"/>
                <Button.Resources>
                    <Style TargetType="Border" >
                        <Setter Property="CornerRadius" Value="20" />
                    </Style>
                </Button.Resources>
            </Button>
        </Border>
        <Border Name="BorderSelectVDC" CornerRadius="20" Padding="5,5,5,5" Width="200" Height="100" VerticalAlignment="Top" HorizontalAlignment="Left"  Margin="400,20,0,0" ToolTip="Push It real Good" ToolTipService.ShowDuration="1000" IsEnabled="False" Visibility="Hidden" >
            <Border.Background>
                <LinearGradientBrush StartPoint="0,0" EndPoint="0,1">
				    <GradientStop Color="White" Offset="0.1" />
				    <GradientStop Color="Silver" Offset="0.9" />
                </LinearGradientBrush>
            </Border.Background>
            <Button Name="ButtonSelectVDC" BorderBrush="Transparent" Background="Green" Foreground="DarkBlue" FontSize="40" FontWeight="Bold" >
                <AccessText Text="Continue" TextWrapping="Wrap" TextAlignment="Center"/>
                <Button.Resources>
                    <Style TargetType="Border" >
                        <Setter Property="CornerRadius" Value="20" />
                    </Style>
                </Button.Resources>
            </Button>
        </Border>
        <Border Name="BorderSelectOrgNet" CornerRadius="20" Padding="5,5,5,5" Width="200" Height="210" VerticalAlignment="Top" HorizontalAlignment="Left"  Margin="400,20,0,0" ToolTip="Push It real Good" ToolTipService.ShowDuration="1000" IsEnabled="False" Visibility="Hidden" >
            <Border.Background>
                <LinearGradientBrush StartPoint="0,0" EndPoint="0,1">
				    <GradientStop Color="White" Offset="0.1" />
				    <GradientStop Color="Silver" Offset="0.9" />
                </LinearGradientBrush>
            </Border.Background>
            <Button Name="ButtonSelectOrgNet" BorderBrush="Transparent" Background="Green" Foreground="DarkBlue" FontSize="40" FontWeight="Bold" >
                <AccessText Text="Validate" TextWrapping="Wrap" TextAlignment="Center"/>
                <Button.Resources>
                    <Style TargetType="Border" >
                        <Setter Property="CornerRadius" Value="20" />
                    </Style>
                </Button.Resources>
            </Button>
        </Border>
        <Border Name="BorderDeploy" CornerRadius="20" Padding="5,5,5,5" Width="200" Height="210" VerticalAlignment="Top" HorizontalAlignment="Left"  Margin="400,20,0,0" ToolTip="Push It real Good" ToolTipService.ShowDuration="1000" IsEnabled="False" Visibility="Hidden" >
            <Border.Background>
                <LinearGradientBrush StartPoint="0,0" EndPoint="0,1">
				    <GradientStop Color="White" Offset="0.1" />
				    <GradientStop Color="Silver" Offset="0.9" />
                </LinearGradientBrush>
            </Border.Background>
            <Button Name="ButtonDeploy" BorderBrush="Transparent" Background="Green" Foreground="DarkBlue" FontSize="40" FontWeight="Bold" >
                <AccessText Text="Deploy" TextWrapping="Wrap" TextAlignment="Center"/>
                <Button.Resources>
                    <Style TargetType="Border" >
                        <Setter Property="CornerRadius" Value="20" />
                    </Style>
                </Button.Resources>
            </Button>
        </Border>
        <ScrollViewer Margin="5,320,5,40" VerticalScrollBarVisibility="Auto" HorizontalScrollBarVisibility="Auto" >
            <TextBox Name="TextBoxOutput" Text="" IsReadOnly="True" Background="#FF0800AE" Foreground="#FFF5EA04"/>
        </ScrollViewer>

        <StatusBar Name="StatusBar" Margin="5,630,5,5" Width="990" HorizontalAlignment="Left"  VerticalAlignment="Top" Background="#FFD6D2B0" >
            <Label Name="LabelStatus" Content="In Progress " Height="25"  FontSize="12" VerticalAlignment="Center" HorizontalAlignment="Center" Visibility="Hidden" />
            <ProgressBar Name="ProgressBar" Width="875" Height="15" Value="0" Visibility="Hidden" />
        </StatusBar>
                
    </Grid>
</Window>
'@

# Init ( WPF - Windows Presentation Framework )
$SyncHash.Window=[Windows.Markup.XamlReader]::Load( [System.Xml.XmlNodeReader]::new($XAML) )

# AutoFind ( WPF - Windows Presentation Framework ) Name - Add Name to Synchronized HashTable
$XAML.SelectNodes("//*[@Name]") | ForEach-Object { $SyncHash.Add($PsItem.Name, $SyncHash.Window.Findname($PsItem.Name)) }

# Init welcome messages
$SyncHash.TextBoxOutput.Text = "`n Dear $env:UserName,`n Thank you for choosing the Terraform GUI created by ClearMedia NV."
$SyncHash.TextBlock.Text = "Please Login in BizzCloud`nEnter Org Name and Credentials`n`nPush the Login Button"

# Init ( WPF - Windows Presentation Framework ) Functions
Function Login {
    Param($SyncHash)
	$Runspace = [runspacefactory]::CreateRunspace()
	$Runspace.ApartmentState = 'STA'
	$Runspace.ThreadOptions = 'ReuseThread'
	$Runspace.Open()
	$Runspace.SessionStateProxy.SetVariable("SyncHash", $SyncHash )
	$Runspace.SessionStateProxy.SetVariable("OrgName", $SyncHash.TextBoxOrgName.Text )
	$Runspace.SessionStateProxy.SetVariable("UserName",$SyncHash.TextBoxUserName.Text )
	$Runspace.SessionStateProxy.SetVariable("Password",$SyncHash.PasswordBoxPassword.SecurePassword )
    [ScriptBlock]$Code = {
        # Deploy VmWare VCloud Module
        Try { Get-PackageProvider -Name 'NuGet' -ListAvailable -ErrorAction Stop}
            Catch {
                # Install Extra PackageProvider - Module
		        $SyncHash.Window.Dispatcher.invoke( { $SyncHash.TextBoxOutput.AddText(" Install NuGet `n") } )
                Install-PackageProvider -Name 'NuGet' -Scope CurrentUser -Force
                }
        If ( ( Get-Module -Name VMware.VimAutomation.Cloud -ListAvailable ).Version.Major -ge 13 ) {
            $SyncHash.Window.Dispatcher.invoke( { $SyncHash.TextBoxOutput.AddText(" VCloud Module allready Installed `n") } )
            } 
            Else {
		        $SyncHash.Window.Dispatcher.invoke( { $SyncHash.TextBoxOutput.AddText(" Install VCloud Module`n") } )
                $Error.Clear()
                Install-Module -Name VMware.VimAutomation.Cloud -MinimumVersion 13.0.0.0 -Scope CurrentUser -Force -AllowClobber
                If ( $Error ) {
			        $SyncHash.Window.Dispatcher.invoke( [action]{ $SyncHash.LabelStatus.Content = "Error Installing PowerShell Module VCloud." } )
			        $SyncHash.Window.Dispatcher.invoke( [action]{ $SyncHash.BorderLogin.IsEnabled = $True } )
			        $SyncHash.Window.Dispatcher.invoke( [action]{ $SyncHash.BorderLogin.Visibility = "Visible"  } )
                    Return
                    }
                }
        $SyncHash.Window.Dispatcher.invoke( { $SyncHash.TextBoxOutput.AddText(" Import VCloud Module`n") } )
        $Error.Clear()
        Import-Module -Name VMware.VimAutomation.Cloud  -MinimumVersion 13.0.0.0 -Scope Local -Force
        If ( $Error ) {
			$SyncHash.Window.Dispatcher.invoke( [action]{ $SyncHash.LabelStatus.Content = "Error Importing PowerShell Module VCloud." } )
			$SyncHash.Window.Dispatcher.invoke( [action]{ $SyncHash.BorderLogin.IsEnabled = $True } )
			$SyncHash.Window.Dispatcher.invoke( [action]{ $SyncHash.BorderLogin.Visibility = "Visible"  } )
            Return
            }        
        # Connect BizzCloud
        $SyncHash.Window.Dispatcher.invoke( [action]{ $SyncHash.TextBoxOutput.AddText("`n Connect to BizzCloud`n") } )
        $Credentials = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList ( $UserName , $Password )
        $Error.Clear()
        $CIServer = 'my.bizzcloud.be'
        $ConnectCiServer = Connect-CIServer -Server $CIServer -Org $OrgName -Credential $Credentials -ErrorAction SilentlyContinue
        If ( $Error ) {
			$SyncHash.Window.Dispatcher.invoke( [action]{ $SyncHash.LabelStatus.Content = "Connection Failure$(' '*4)$(' .'*90)$(' '*10)Please check OrgName - Username - Password" } )
			$SyncHash.Window.Dispatcher.invoke( [action]{ $SyncHash.BorderLogin.IsEnabled = $True } )
			$SyncHash.Window.Dispatcher.invoke( [action]{ $SyncHash.BorderLogin.Visibility = "Visible"  } )
            Return
            }
        $SyncHash.Window.Dispatcher.invoke( [action]{ $SyncHash.TextBoxOutput.AddText(" Connected to $ConnectCiServer `n") } )
        # Get BizzCloud VDClist
        $SyncHash.Window.Dispatcher.invoke( [action]{ $SyncHash.TextBoxOutput.AddText(" Get Org VDC List `n") } )
        Try {
            $SyncHash.Window.Dispatcher.invoke( [action]{ $SyncHash.ComboBoxVDC.Items.Clear() } )
            ( Get-OrgVdc ).Name | ForEach-Object { $SyncHash.Window.Dispatcher.invoke( [action]{ $SyncHash.ComboBoxVDC.Items.Add( $PsItem ) } ) }
            $SyncHash.Window.Dispatcher.invoke( [action]{ $SyncHash.ComboBoxVDC.SelectedIndex = 0 } )
            }
            Catch { }
        # Get BizzCloudWindowsTemplate
        $SyncHash.Window.Dispatcher.invoke( [action]{ $SyncHash.TextBoxOutput.AddText(" Get Windows Server Template List `n") } )
        Try {
            $SyncHash.Window.Dispatcher.invoke( [action]{ $SyncHash.ComboBoxWindowsTemplate.Items.Clear() } )
            ( Get-CIVAppTemplate -Name 'Win20??Template' -Catalog 'Public_Catalog' ).Name | ForEach-Object { $SyncHash.Window.Dispatcher.invoke( [action]{ $SyncHash.ComboBoxWindowsTemplate.Items.Add( $PsItem ) } ) }
            $SyncHash.Window.Dispatcher.invoke( [action]{ $SyncHash.ComboBoxWindowsTemplate.SelectedIndex = 2 } )
            }
            Catch { }
		$SyncHash.Window.Dispatcher.invoke( [action]{
            $SyncHash.TextBlock.Text = "Please select the VDC Name `n`nPush the Continue Button"
            $SyncHash.LabelStatus.Visibility = "Hidden"
            $SyncHash.LabelOrgName.Visibility = "Visible"
            $SyncHash.TextBoxOrgName.Visibility = "Visible"
            $SyncHash.TextBoxOrgName.IsReadOnly = $True
            $SyncHash.TextBoxOrgName.IsEnabled = $False
            $SyncHash.LabelUserName.Visibility = "Hidden"
            $SyncHash.TextBoxUserName.Visibility = "Hidden"
            $SyncHash.LabelPassword.Visibility = "Hidden"
            $SyncHash.PasswordBoxPassword.Visibility = "Hidden"
            $SyncHash.LabelVDC.Visibility = "Visible"
            $SyncHash.LabelOrgNet.Visibility = "Hidden"
            $SyncHash.LabelWindowsTemplate.Visibility = "Hidden"
            $SyncHash.ComboBoxVDC.Visibility = "Visible"
            $SyncHash.ComboBoxOrgNet.Visibility = "Hidden"
            $SyncHash.ComboBoxWindowsTemplate.Visibility = "Hidden"
            $SyncHash.LabelVappName.Visibility = "Hidden"
            $SyncHash.TextBoxVappName.Visibility = "Hidden"
            $SyncHash.LabelVmNamePrefix.Visibility = "Hidden"
            $SyncHash.TextBoxVmNamePrefix.Visibility = "Hidden"
            $SyncHash.BorderLogin.IsEnabled = $False
            $SyncHash.BorderLogin.Visibility = "Hidden"
            $SyncHash.BorderSelectVDC.IsEnabled = $True
            $SyncHash.BorderSelectVDC.Visibility = "Visible"
            } )
        }
	$PSinstance = [powershell]::Create().AddScript($Code)
    $PSinstance.Runspace = $Runspace
	$PSinstance.BeginInvoke()
    }
Function SelectVDC {
    Param($SyncHash)
	$Runspace = [runspacefactory]::CreateRunspace()
	$Runspace.Open()
	$Runspace.SessionStateProxy.SetVariable("SyncHash", $SyncHash )
	$Runspace.SessionStateProxy.SetVariable("OrgName", $SyncHash.TextBoxOrgName.Text )
	$Runspace.SessionStateProxy.SetVariable("UserName",$SyncHash.TextBoxUserName.Text )
	$Runspace.SessionStateProxy.SetVariable("Password",$SyncHash.PasswordBoxPassword.SecurePassword )
	$Runspace.SessionStateProxy.SetVariable("VdcName",$SyncHash.ComboBoxVDC.SelectedValue )
	$Runspace.SessionStateProxy.SetVariable("OrgNetName",$SyncHash.ComboBoxOrgNet.SelectedValue )
	$Runspace.SessionStateProxy.SetVariable("WindowsTemplateName",$SyncHash.ComboBoxWindowsTemplate.SelectedValue )
	$Runspace.SessionStateProxy.SetVariable("vAppName",$SyncHash.TextBoxVappName.Text )
	$Runspace.SessionStateProxy.SetVariable("VmNamePrefix",$SyncHash.TextBoxVmNamePrefix.Text )
    [ScriptBlock]$Code = {
        # Connect BizzCloud
        $SyncHash.Window.Dispatcher.invoke( [action]{ $SyncHash.TextBoxOutput.AddText("`n Connect to BizzCloud`n") } )
        Import-Module -Name VMware.VimAutomation.Cloud  -MinimumVersion 13.0.0.0 -Scope Local -Force
        $Credentials = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList ( $UserName , $Password )
        $CIServer = 'my.bizzcloud.be'
        $ConnectCiServer = Connect-CIServer -Server $CIServer -Org $OrgName -Credential $Credentials -ErrorAction SilentlyContinue
        If ( $Error ) {
			$SyncHash.Window.Dispatcher.invoke( [action]{ $SyncHash.LabelStatus.Content = "Connection Failure$(' '*4)$(' .'*90)$(' '*10)Please check OrgName - Username - Password" } )
			$SyncHash.Window.Dispatcher.invoke( [action]{ $SyncHash.BorderSelectVDC.IsEnabled = $True } )
			$SyncHash.Window.Dispatcher.invoke( [action]{ $SyncHash.BorderSelectVDC.Visibility = "Visible"  } )
            Return
            }
        $SyncHash.Window.Dispatcher.invoke( [action]{ $SyncHash.TextBoxOutput.AddText(" Connected to $ConnectCiServer `n") } )
        # Get BizzCloud OrgNetlist
        $SyncHash.Window.Dispatcher.invoke( [action]{ $SyncHash.TextBoxOutput.AddText(" Get Org Net List `n") } )
        Try {
            $SyncHash.Window.Dispatcher.invoke( [action]{ $SyncHash.ComboBoxOrgNet.Items.Clear() } )
            ( Get-OrgVdcNetwork -OrgVdc $VdcName ).Name | ForEach-Object { $SyncHash.Window.Dispatcher.invoke( [action]{ $SyncHash.ComboBoxOrgNet.Items.Add( $PsItem ) } ) }
            $SyncHash.Window.Dispatcher.invoke( [action]{ $SyncHash.ComboBoxOrgNet.SelectedIndex = 0 } )
            }
            Catch { }
		$SyncHash.Window.Dispatcher.invoke( [action]{
            $SyncHash.TextBlock.Text = "Please select the Org Net Name `nPlease select the Template Name `n`nEnter the VAPP Name `nEnter or leave the VM Name Prefix`n`nPush the Validate Button"
            $SyncHash.LabelStatus.Visibility = "Hidden"
            $SyncHash.LabelOrgName.Visibility = "Visible"
            $SyncHash.TextBoxOrgName.Visibility = "Visible"
            $SyncHash.TextBoxOrgName.IsReadOnly = $True
            $SyncHash.TextBoxOrgName.IsEnabled = $False
            $SyncHash.LabelUserName.Visibility = "Hidden"
            $SyncHash.TextBoxUserName.Visibility = "Hidden"
            $SyncHash.LabelPassword.Visibility = "Hidden"
            $SyncHash.PasswordBoxPassword.Visibility = "Hidden"
            $SyncHash.LabelVDC.Visibility = "Visible"
            $SyncHash.LabelOrgNet.Visibility = "Visible"
            $SyncHash.LabelWindowsTemplate.Visibility = "Visible"
            $SyncHash.ComboBoxVDC.Visibility = "Visible"
            $SyncHash.ComboBoxVDC.IsEnabled = $False
            $SyncHash.ComboBoxOrgNet.Visibility = "Visible"
            $SyncHash.ComboBoxOrgNet.IsEnabled = $True
            $SyncHash.ComboBoxWindowsTemplate.Visibility = "Visible"
            $SyncHash.ComboBoxWindowsTemplate.IsEnabled = $True
            $SyncHash.LabelVappName.Visibility = "Visible"
            $SyncHash.TextBoxVappName.Visibility = "Visible"
            $SyncHash.TextBoxVappName.IsEnabled = $True
            $SyncHash.LabelVmNamePrefix.Visibility = "Visible"
            $SyncHash.TextBoxVmNamePrefix.Visibility = "Visible"
            $SyncHash.TextBoxVmNamePrefix.IsEnabled = $True
            $SyncHash.BorderLogin.IsEnabled = $False
            $SyncHash.BorderLogin.Visibility = "Hidden"
            $SyncHash.BorderSelectVDC.IsEnabled = $Falde
            $SyncHash.BorderSelectVDC.Visibility = "Hidden"
            $SyncHash.BorderSelectOrgNet.IsEnabled = $True
            $SyncHash.BorderSelectOrgNet.Visibility = "Visible"
            } )
        }
	$PSinstance = [powershell]::Create().AddScript($Code)
    $PSinstance.Runspace = $Runspace
	$PSinstance.BeginInvoke()
    }
Function Validate {
    Param($SyncHash)
	$Runspace = [runspacefactory]::CreateRunspace()
	$Runspace.Open()
	$Runspace.SessionStateProxy.SetVariable("SyncHash", $SyncHash )
	$Runspace.SessionStateProxy.SetVariable("OrgName", $SyncHash.TextBoxOrgName.Text )
	$Runspace.SessionStateProxy.SetVariable("UserName",$SyncHash.TextBoxUserName.Text )
	$Runspace.SessionStateProxy.SetVariable("Password",$SyncHash.PasswordBoxPassword.SecurePassword )
	$Runspace.SessionStateProxy.SetVariable("VdcName",$SyncHash.ComboBoxVDC.SelectedValue )
	$Runspace.SessionStateProxy.SetVariable("OrgNetName",$SyncHash.ComboBoxOrgNet.SelectedValue )
	$Runspace.SessionStateProxy.SetVariable("WindowsTemplateName",$SyncHash.ComboBoxWindowsTemplate.SelectedValue )
	$Runspace.SessionStateProxy.SetVariable("vAppName",$SyncHash.TextBoxVappName.Text )
	$Runspace.SessionStateProxy.SetVariable("VmNamePrefix",$SyncHash.TextBoxVmNamePrefix.Text )
    [ScriptBlock]$Code = {
        # Connect BizzCloud
        $SyncHash.Window.Dispatcher.invoke( [action]{ $SyncHash.TextBoxOutput.AddText("`n Connect to BizzCloud`n") } )
        Import-Module -Name VMware.VimAutomation.Cloud  -MinimumVersion 13.0.0.0 -Scope Local -Force
        $Credentials = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList ( $UserName , $Password )
        $CIServer = 'my.bizzcloud.be'
        $Error.Clear()
        $ConnectCiServer = Connect-CIServer -Server $CIServer -Org $OrgName -Credential $Credentials -ErrorAction SilentlyContinue
        $SyncHash.Window.Dispatcher.invoke( [action]{ $SyncHash.TextBoxOutput.AddText(" Connected to $ConnectCiServer `n") } )
        $SyncHash.Window.Dispatcher.invoke( [action]{ $SyncHash.TextBoxOutput.AddText(" Fetch Org Name $OrgName `n") } )
        $ProdOrgName = ( Get-Org ).Name
        If (  $OrgName -cne  $ProdOrgName ) {
            $SyncHash.Window.Dispatcher.invoke( [action]{ $SyncHash.TextBoxOutput.AddText(" Case Mitchmach Org Name, correcting Org Name $ProdOrgName `n") } )
            $SyncHash.Window.Dispatcher.invoke( [action]{ $SyncHash.TextBoxOrgName.Text = "$ProdOrgName" } )
            }
        If ( -not $vAppName ) {
            $SyncHash.Window.Dispatcher.invoke( [action]{
			    $SyncHash.LabelStatus.Content = "VAPP Name empty $(' '*4)$(' .'*110)$(' '*10)Please Enter VAPP NAme"
                $SyncHash.BorderSelectOrgNet.IsEnabled = $True
                $SyncHash.BorderSelectOrgNet.Visibility = "Visible"
                } )
            Return
            }
        $SyncHash.Window.Dispatcher.invoke( [action]{ $SyncHash.TextBoxOutput.AddText(" Fetch vApp Name $vAppName `n") } )
        $CIVapp = Get-CIVapp -Name "$vAppName" -ErrorAction SilentlyContinue
        If ( $CIVapp ) {
            $SyncHash.Window.Dispatcher.invoke( [action]{
			    $SyncHash.LabelStatus.Content = "VAPP already exists$(' '*4)$(' .'*110)$(' '*10)Please check BizzCloud"
                $SyncHash.BorderSelectOrgNet.IsEnabled = $True
                $SyncHash.BorderSelectOrgNet.Visibility = "Visible"
                $SyncHash.LabelVappName.Visibility = "Visible"
                $SyncHash.TextBoxVappName.Visibility = "Visible"
                $SyncHash.TextBoxVappName.IsEnabled = $True
                $SyncHash.LabelVmNamePrefix.Visibility = "Visible"
                $SyncHash.TextBoxVmNamePrefix.Visibility = "Visible"
                $SyncHash.TextBoxVmNamePrefix.IsEnabled = $True
                } )
            Return
            }
        $SyncHash.Window.Dispatcher.invoke( [action]{ $SyncHash.TextBoxOutput.AddText("`n Org Name & vApp Name Validated`n Proceed`n") } )
		$SyncHash.Window.Dispatcher.invoke( [action]{
            $SyncHash.TextBlock.Text = "Please continue `n`nPush the Deploy Button"
            $SyncHash.LabelStatus.Visibility = "Hidden"
            $SyncHash.LabelOrgName.Visibility = "Visible"
            $SyncHash.TextBoxOrgName.Visibility = "Visible"
            $SyncHash.TextBoxOrgName.IsReadOnly = $True
            $SyncHash.TextBoxOrgName.IsEnabled = $False
            $SyncHash.LabelUserName.Visibility = "Hidden"
            $SyncHash.TextBoxUserName.Visibility = "Hidden"
            $SyncHash.LabelPassword.Visibility = "Hidden"
            $SyncHash.PasswordBoxPassword.Visibility = "Hidden"
            $SyncHash.LabelVDC.Visibility = "Visible"
            $SyncHash.LabelOrgNet.Visibility = "Visible"
            $SyncHash.LabelWindowsTemplate.Visibility = "Visible"
            $SyncHash.ComboBoxVDC.Visibility = "Visible"
            $SyncHash.ComboBoxVDC.IsEnabled = $False
            $SyncHash.ComboBoxOrgNet.Visibility = "Visible"
            $SyncHash.ComboBoxOrgNet.IsEnabled = $False
            $SyncHash.ComboBoxWindowsTemplate.Visibility = "Visible"
            $SyncHash.ComboBoxWindowsTemplate.IsEnabled = $False
            $SyncHash.LabelVappName.Visibility = "Visible"
            $SyncHash.TextBoxVappName.Visibility = "Visible"
            $SyncHash.TextBoxVappName.IsEnabled = $False
            $SyncHash.LabelVmNamePrefix.Visibility = "Visible"
            $SyncHash.TextBoxVmNamePrefix.Visibility = "Visible"
            $SyncHash.TextBoxVmNamePrefix.IsEnabled = $False
            $SyncHash.BorderLogin.IsEnabled = $False
            $SyncHash.BorderLogin.Visibility = "Hidden"
            $SyncHash.BorderSelectVDC.IsEnabled = $Falde
            $SyncHash.BorderSelectVDC.Visibility = "Hidden"
            $SyncHash.BorderSelectOrgNet.IsEnabled = $Falde
            $SyncHash.BorderSelectOrgNet.Visibility = "Hidden"
            $SyncHash.BorderDeploy.IsEnabled = $True
            $SyncHash.BorderDeploy.Visibility = "Visible"
            } )
        }
	$PSinstance = [powershell]::Create().AddScript($Code)
    $PSinstance.Runspace = $Runspace
	$PSinstance.BeginInvoke()
    }
Function Deploy {
    Param($SyncHash)
	$Runspace = [runspacefactory]::CreateRunspace()
	$Runspace.Open()
	$Runspace.SessionStateProxy.SetVariable("SyncHash", $SyncHash )
	$Runspace.SessionStateProxy.SetVariable("OrgName", $SyncHash.TextBoxOrgName.Text )
	$Runspace.SessionStateProxy.SetVariable("UserName",$SyncHash.TextBoxUserName.Text )
	$Runspace.SessionStateProxy.SetVariable("Password",$SyncHash.PasswordBoxPassword.Password )
	$Runspace.SessionStateProxy.SetVariable("VdcName",$SyncHash.ComboBoxVDC.SelectedValue )
	$Runspace.SessionStateProxy.SetVariable("OrgNetName",$SyncHash.ComboBoxOrgNet.SelectedValue )
	$Runspace.SessionStateProxy.SetVariable("WindowsTemplateName",$SyncHash.ComboBoxWindowsTemplate.SelectedValue )
	$Runspace.SessionStateProxy.SetVariable("vAppName",$SyncHash.TextBoxVappName.Text )
	$Runspace.SessionStateProxy.SetVariable("VmNamePrefix",$SyncHash.TextBoxVmNamePrefix.Text )
    [ScriptBlock]$Code = {
        
        $Text = @"
# Terraform Block
terraform {
  required_providers {
    vcd = {
      source = "vmware/vcd"
    }
  }
}

# Var Block
variable "org_name" { default = $('"')$OrgName$('"') }
variable "user_name" { default = $('"')$UserName$('"') }
variable "user_password" { default = "password" }
variable "vdc_name" { default = $('"')$VdcName$('"') }
variable "vdc_network_name" { default = $('"')$OrgNetName$('"') }
variable "vapp_name" { default = $('"')$vAppName$('"') }
variable "vapp_network_name" { default = $('"')vAppNet-$vAppName$('"') }
variable "vm1_name" { default = $('"')$( $VmNamePrefix )DC$('"') }
variable "vm2_name" { default = $('"')$( $VmNamePrefix )RDS$('"') }
variable "vm3_name" { default = $('"')$( $VmNamePrefix )FireboxV$('"') }
variable "template_windows_name" { default = $('"')$WindowsTemplateName$('"') }
variable "template_watchguard_name" { default = "FireboxVTemplate" }

# Provider Block
provider "vcd" {
  user = var.user_name
  password = var.user_password
  auth_type = "integrated"
  org = var.org_name
  vdc = var.vdc_name 
  url = "https://my.bizzcloud.be/api"
}

# Data Block
data "vcd_org" "org" {
  name = var.org_name
}

# Resource Blocks
resource "vcd_vapp" "vapp" {
  name = var.vapp_name
}
resource "vcd_vapp_network" "vapp_net" {
  vapp_name = vcd_vapp.vapp.name
  name  = var.vapp_network_name
  gateway = "192.168.13.1"
  netmask = "255.255.255.0"
  dns1 = "195.238.2.21"
  dns2 = "8.8.8.8"
  static_ip_pool {
    start_address = "192.168.13.100"
    end_address = "192.168.13.199"
  }
}
resource "vcd_vapp_org_network" "vapp_org_net" {
  vapp_name = vcd_vapp.vapp.name
  org_network_name  = var.vdc_network_name
}
resource "vcd_vapp_vm" "vm1" {
  vapp_name = vcd_vapp.vapp.name
  name = var.vm1_name
  computer_name = var.vm1_name
  power_on = false
  cpu_hot_add_enabled = true
  memory_hot_add_enabled = true
  catalog_name = "Public_Catalog"
  template_name = var.template_windows_name
  memory = 4096
  cpus = 1
  cpu_cores = 1
  network {
    name = vcd_vapp_network.vapp_net.name
    type = "vapp"
    ip_allocation_mode = "MANUAL"
    ip = "192.168.13.100"
    adapter_type = "VMXNET3"
    is_primary = true
  }
}
resource "vcd_vapp_vm" "vm2" {
  vapp_name = vcd_vapp.vapp.name
  name = var.vm2_name
  computer_name = var.vm2_name
  power_on = false
  cpu_hot_add_enabled = true
  memory_hot_add_enabled = true
  catalog_name  = "Public_Catalog"
  template_name = var.template_windows_name
  memory = 6144
  cpus = 2
  cpu_cores = 1
  network {
    name = vcd_vapp_network.vapp_net.name
    type = "vapp"
    ip_allocation_mode = "MANUAL"
    ip = "192.168.13.101"
    adapter_type = "VMXNET3"
    is_primary = true
  }
}

resource "vcd_vm_internal_disk" "vm2_disk1" {
  vapp_name = vcd_vapp.vapp.name
  vm_name = vcd_vapp_vm.vm2.name
  bus_type = "paravirtual"
  size_in_mb = "5120"
  bus_number = 0
  unit_number = 1
}

resource "vcd_vm_internal_disk" "vm2_disk2" {
  vapp_name = vcd_vapp.vapp.name
  vm_name = vcd_vapp_vm.vm2.name
  bus_type = "paravirtual"
  size_in_mb = "5120"
  bus_number = 0
  unit_number = 2
  depends_on = [ vcd_vm_internal_disk.vm2_disk1 ]
}

resource "vcd_vapp_vm" "vm3" {
  vapp_name = vcd_vapp.vapp.name
  name = var.vm3_name
  computer_name = var.vm3_name
  power_on = false
  cpu_hot_add_enabled = true
  memory_hot_add_enabled = true
  catalog_name = "Public_Catalog"
  template_name = var.template_watchguard_name
  memory = 1024
  cpus = 1
  cpu_cores = 1
  network {
    name = var.vdc_network_name
    type = "org"
    ip_allocation_mode = "POOL"
    adapter_type = "VMXNET3"
    is_primary = true
  }
  network {
    name = vcd_vapp_network.vapp_net.name
    type = "vapp"
    ip_allocation_mode = "MANUAL"
    ip = "192.168.13.254"
    adapter_type = "VMXNET3"
    is_primary = false
  }
 network {
    type = "none"
	ip_allocation_mode = "NONE"
	adapter_type = "VMXNET3"
	is_primary = false
  }
  network {
    type = "none"
	ip_allocation_mode = "NONE"
	adapter_type = "VMXNET3"
	is_primary = false
  }
  network {
    type = "none"
	ip_allocation_mode = "NONE"
	adapter_type = "VMXNET3"
	is_primary = false
  }
}
"@
        Push-Location -Path "$ENV:LOCALAPPDATA"
        New-Item -ItemType Directory -Path 'Terraform' -Force
        Push-Location -Path 'Terraform'
        Remove-Item -Path "*" -Recurse -Force
        $Text | Out-File -FilePath 'main.tf' -Encoding ascii -Force
        # Check Terraform latest version for Windows
        $Arguments = @{
            Uri = "https://releases.hashicorp.com/terraform"
            UseBasicParsing = $True
            Method = 'get'
            }
        $Version = ( ( Invoke-WebRequest @Arguments ).Links.href |  Where-Object -FilterScript { $PSItem -notmatch 'alpha' } )[1].Split( '/' )[-2]
        # Dowload Terraform latest version for Windows
        $Arguments = @{
            Uri = "https://releases.hashicorp.com/terraform/$Version"
            UseBasicParsing = $True
            Method = 'get'
            }
        $UrlDownload = ( Invoke-WebRequest @Arguments ).Links.href |  Where-Object -FilterScript { $PSItem -match 'windows_amd64' } 
        $FileDownload = "$ENV:LOCALAPPDATA\Terraform\terraform.zip"
        $FolderDownload = "$ENV:LOCALAPPDATA\Terraform"
		$SyncHash.Window.Dispatcher.invoke( { $SyncHash.TextBoxOutput.AddText( " `n" ) } )
		$SyncHash.Window.Dispatcher.invoke( { $SyncHash.TextBoxOutput.AddText( " Start Terraform Download `n" ) } )
		$Error.Clear()
        ( New-Object System.Net.WebClient ).DownLoadFile( "$UrlDownload" , "$FileDownload" )
        If ( $Error ) {
		    $SyncHash.Window.Dispatcher.invoke( [action]{ $SyncHash.LabelStatus.Content = "Terraform Download Failure$(' '*4)$(' .'*90)$(' '*10)Please check Internet" } )
			$SyncHash.Window.Dispatcher.invoke( [action]{ $SyncHash.BorderDeploy.IsEnabled = $True } )
			$SyncHash.Window.Dispatcher.invoke( [action]{ $SyncHash.BorderDeploy.Visibility = "Visible"  } )
            Return
            }
        # Unzip FileDownload to FolderDownload
        Expand-Archive -Path $FileDownload -DestinationPath $FolderDownload -Force
		If ( Test-Path -Path "$ENV:LOCALAPPDATA\Terraform\terraform.exe" ) {
			$SyncHash.Window.Dispatcher.invoke( { $SyncHash.TextBoxOutput.AddText( " Terraform Version $Version has been successfully installed `n" ) } )
			}
			Else {
		    	$SyncHash.Window.Dispatcher.invoke( [action]{ $SyncHash.LabelStatus.Content = "Terraform Installation Failure$(' '*4)$(' .'*90)$(' '*10)Please check Internet" } )
				$SyncHash.Window.Dispatcher.invoke( [action]{ $SyncHash.BorderDeploy.IsEnabled = $True } )
				$SyncHash.Window.Dispatcher.invoke( [action]{ $SyncHash.BorderDeploy.Visibility = "Visible"  } )
            	Return
            	}
		$SyncHash.Window.Dispatcher.invoke( { $SyncHash.TextBoxOutput.AddText( " Start Terraform Init `n" ) } )
        $Error.Clear()
        [STRING]$Terraform = ./terraform.exe init -compact-warnings -no-color
        If ( $Error ) {
		    $SyncHash.Window.Dispatcher.invoke( [action]{ $SyncHash.LabelStatus.Content = "Terraform Init Failure$(' '*4)$(' .'*90)$(' '*10)Please check Internet" } )
			$SyncHash.Window.Dispatcher.invoke( [action]{ $SyncHash.BorderDeploy.IsEnabled = $True } )
			$SyncHash.Window.Dispatcher.invoke( [action]{ $SyncHash.BorderDeploy.Visibility = "Visible"  } )
            Return
            }
        If ( $Terraform.ToLower().Contains( 'Terraform has been successfully initialized' ) ) {
            $SyncHash.Window.Dispatcher.invoke( { $SyncHash.TextBoxOutput.AddText( " Terraform has been successfully initialized! `n" ) } )
            }
		$SyncHash.Window.Dispatcher.invoke( { $SyncHash.TextBoxOutput.AddText( " Start Terraform Validate `n" ) } )
        $Error.Clear()
        [STRING]$Terraform = ./terraform.exe validate -no-color
        If ( $Error ) {
		    $SyncHash.Window.Dispatcher.invoke( [action]{ $SyncHash.LabelStatus.Content = "Terraform Validation Failure$(' '*4)$(' .'*90)$(' '*10)Please check main.tf" } )
			$SyncHash.Window.Dispatcher.invoke( [action]{ $SyncHash.BorderDeploy.IsEnabled = $True } )
			$SyncHash.Window.Dispatcher.invoke( [action]{ $SyncHash.BorderDeploy.Visibility = "Visible"  } )
            Return
            }
        If ( $Terraform.ToLower().Contains( 'success' ) ) {
            $SyncHash.Window.Dispatcher.invoke( { $SyncHash.TextBoxOutput.AddText( " Terraform has been successfully validated `n" ) } )
            }
		$SyncHash.Window.Dispatcher.invoke( { $SyncHash.TextBoxOutput.AddText( " Start Terraform Refresh `n" ) } )
        $Error.Clear()
        [STRING]$Terraform = ./terraform.exe refresh -var "user_password=$Password" -no-color
        If ( $Error ) {
		    $SyncHash.Window.Dispatcher.invoke( [action]{ $SyncHash.LabelStatus.Content = "Terraform Refresh Failure$(' '*4)$(' .'*90)$(' '*10)Please check BizzCloud ( Password )" } )
			$SyncHash.Window.Dispatcher.invoke( [action]{ $SyncHash.BorderDeploy.IsEnabled = $True } )
			$SyncHash.Window.Dispatcher.invoke( [action]{ $SyncHash.BorderDeploy.Visibility = "Visible"  } )
            Return
            }
        If ( $Terraform.ToLower().Contains( 'success' ) ) {
            $SyncHash.Window.Dispatcher.invoke( { $SyncHash.TextBoxOutput.AddText( " Terraform has been successfully Refreshed `n" ) } )
            }

		$SyncHash.Window.Dispatcher.invoke( { $SyncHash.TextBoxOutput.AddText( " Start Terraform Apply `n" ) } )
        $Error.Clear()
        # [STRING]$Terraform = Invoke-Expression -Command "terraform.exe apply -var 'user_password=$Password' -auto-approve -compact-warnings -no-color" -ErrorAction SilentlyContinue
        [STRING]$Terraform = ./terraform.exe apply -var "user_password=$Password" -auto-approve -compact-warnings -no-color
        If ( $Terraform.ToLower().Contains('apply complete!') ) {
            $SyncHash.Window.Dispatcher.invoke( { $SyncHash.TextBoxOutput.AddText( " Terraform has been successfully applied `n" ) }  )
            }
        If ( $Error ) {
            [STRING]$ErrorMsg = $Error[-2]
            [STRING]$ErrorMsgPart = $ErrorMsg.Split( ':' )[1]
            $SyncHash.Window.Dispatcher.invoke( [action]{
		        $SyncHash.TextBoxOutput.AddText( " Terraform has NOT been successfully applied! `n`n" )
                $SyncHash.LabelStatus.Visibility = "Visible"
			    $SyncHash.LabelStatus.Content = "Error : $ErrorMsgPart$(' '*4)$(' .'*90)$(' '*10)Please Verify BizzCloud"
                $SyncHash.TextBlock.Text = "$ErrorMsg"
                $SyncHash.ProgressBar.Visibility = "Hidden"
			    $SyncHash.BorderDeploy.IsEnabled = $True
			    $SyncHash.BorderDeploy.Visibility = "Visible"
                } )
            Return
            }
		$SyncHash.Window.Dispatcher.invoke( [action]{
            $SyncHash.TextBlock.Text = "Deployment Finished `nPlease Verify in BizzCloud"
            $SyncHash.TextBoxOutput.AddText( " Deployment Finished `n Please Verify in BizzCloud" )
            $SyncHash.LabelStatus.Visibility = "Visible"
            $SyncHash.LabelStatus.Content = "Deployment Finished$(' '*4)$(' .'*110)$(' '*10)Please Verify BizzCloud"
            $SyncHash.ProgressBar.Visibility = "Hidden" 
            $SyncHash.BorderDeploy.IsEnabled = $False
            $SyncHash.BorderDeploy.Visibility = "Hidden"
            } )
        }
	$PSinstance = [powershell]::Create().AddScript($Code)
    $PSinstance.Runspace = $Runspace
	$PSinstance.BeginInvoke()
    }

# Init ( WPF - Windows Presentation Framework ) Actions
$SyncHash.ButtonLogin.Add_Click({
    $SyncHash.TextBoxOutput.Clear()
    $SyncHash.BorderLogin.IsEnabled = $False
    $SyncHash.LabelStatus.Content = "In Progress ...."
    $SyncHash.LabelStatus.Visibility = "Visible"
    Login -SyncHash $SyncHash
    })
$SyncHash.ButtonSelectVDC.Add_Click({
    $SyncHash.TextBoxOutput.Clear()
    $SyncHash.BorderSelectVDC.IsEnabled = $False
    $SyncHash.LabelStatus.Content = "In Progress ...."
    $SyncHash.LabelStatus.Visibility = "Visible"
    SelectVDC -SyncHash $SyncHash
    })
$SyncHash.ButtonSelectOrgNet.Add_Click({
    $SyncHash.TextBoxOutput.Clear()
    $SyncHash.BorderSelectOrgNet.IsEnabled = $False
    $SyncHash.LabelStatus.Content = "In Progress ...."
    $SyncHash.LabelStatus.Visibility = "Visible"
    Validate -SyncHash $SyncHash
    })
$SyncHash.ButtonDeploy.Add_Click({
    $SyncHash.TextBlock.Text = ""
    $SyncHash.TextBoxOutput.Clear()
    $SyncHash.BorderDeploy.IsEnabled = $False
    $SyncHash.LabelStatus.Content = "In Progress ...."
    $SyncHash.LabelStatus.Visibility = "Visible"
    Deploy -SyncHash $SyncHash
    })

# Start ( WPF - Windows Presentation Framework ) Process 
$SyncHash.Window.ShowDialog()

# End ( WPF - Windows Presentation Framework ) Process on Exit
$SyncHash.Window.Add_Closing( { [System.Windows.Forms.Application]::Exit() ; Stop-Process $PID } )
