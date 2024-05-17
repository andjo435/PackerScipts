<?xml version="1.0" encoding="utf-8"?>
<unattend xmlns="urn:schemas-microsoft-com:unattend">
<settings pass="windowsPE">
<component name="Microsoft-Windows-International-Core-WinPE" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS" xmlns:wcm="
http://schemas.microsoft.com/WMIConfig/2002/State"
xmlns:xsi="
http://www.w3.org/2001/XMLSchema-instance">
<SetupUILanguage>
<UILanguage>en-US</UILanguage>
</SetupUILanguage>
<InputLocale>en-US</InputLocale>
<SystemLocale>en-US</SystemLocale>
<UILanguage>en-US</UILanguage>
<UserLocale>en-US</UserLocale>
</component>
<component name="Microsoft-Windows-Setup" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS" xmlns:wcm="
http://schemas.microsoft.com/WMIConfig/2002/State"
xmlns:xsi="
http://www.w3.org/2001/XMLSchema-instance">
<DiskConfiguration>
<Disk wcm:action="add">
<ModifyPartition wcm:action="add">
<Format>NTFS</Format>
<Label>Windows</Label>
<Order>1</Order>
<PartitionID>1</PartitionID>
<Extend>true</Extend>
<TypeID>GUID={EBD0A0A2-B9E5-4433-87C0-68B6B72699C7}</TypeID>
</ModifyPartition>
</Disk>
</DiskConfiguration>
<ImageInstall>
<OSImage>
<InstallFrom>
<MetaData wcm:action="add">
<Key>/IMAGE/NAME</Key>
<Value>Windows Server 2022 SERVERSTANDARD</Value>
</MetaData>
</InstallFrom>
<InstallTo>
<DiskID>0</DiskID>
<PartitionID>1</PartitionID>
</InstallTo>
<WillShowUI>OnError</WillShowUI>
<InstallToAvailablePartition>false</InstallToAvailablePartition>
</OSImage>
</ImageInstall>
<UserData>
<AcceptEula>true</AcceptEula>
<ProductKey>
<WillShowUI>Never</WillShowUI>
<Key>VDYBN-27WPP-V4HQT-9VMD4-VMK7H</Key>
</ProductKey>
</UserData>
</component>
</settings>
<settings pass="specialize">
<component name="Microsoft-Windows-Shell-Setup" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS" xmlns:wcm="
http://schemas.microsoft.com/WMIConfig/2002/State"
xmlns:xsi="
http://www.w3.org/2001/XMLSchema-instance">
<TimeZone>Central Standard Time</TimeZone>
</component>
</settings>
<settings pass="oobeSystem">
<component name="Microsoft-Windows-Shell-Setup" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS" xmlns:wcm="
http://schemas.microsoft.com/WMIConfig/2002/State"
xmlns:xsi="
http://www.w3.org/2001/XMLSchema-instance">
<AutoLogon>
<Password>
<Value>secretpassword</Value>
<PlainText>true</PlainText>
</Password>
<LogonCount>2</LogonCount>
<Username>Administrator</Username>
<Enabled>true</Enabled>
</AutoLogon>
<FirstLogonCommands>
<SynchronousCommand wcm:action="add">
<Order>1</Order>
<CommandLine>powershell -ExecutionPolicy Bypass -File a:\setup.ps1</CommandLine>
<Description>Enable WinRM service</Description>
<RequiresUserInput>true</RequiresUserInput>
</SynchronousCommand>
</FirstLogonCommands>
<UserAccounts>
<AdministratorPassword>
<Value>secretpassword</Value>
<PlainText>true</PlainText>
</AdministratorPassword>
</UserAccounts>
</component>
</settings>
<cpi:offlineImage cpi:source="wim:c:/wims/install.wim#Windows Server 2022 SERVERDATACENTER" xmlns:cpi="urn:schemas-microsoft-com:cpi" />
</unattend>
