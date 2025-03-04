with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings.Unbounded;
with GNAT.Decode_UTF8_String;
with Interfaces.C;
with System.Win32;
with Windows_API;
with Motivational_Messages;

procedure Mandatory_Motivation is
   use Ada.Strings.Unbounded;
   use Interfaces.C;

   Manager     : Motivational_Messages.Motivation_Manager;
   Caption     : constant char16_array := To_C ("Mandatory Motivation");
   Caption_Ali : aliased char16_array := Caption;
   Lp_Caption  : constant access char16_array := Caption_Ali'Access;
   U_Type      : constant unsigned := 48;
   Result      : int;

   Is_Set      : Boolean := False;

   Get_Message : Unbounded_String;

   Next_Time : Duration;

   Get_Err : System.Win32.DWORD;

   task Window_At_Top is
      entry Start;
   end Window_At_Top;

   task body Window_At_Top is
      H_Wnd          : int := 0;
      Window_Class   : constant char16_array := To_C ("#32770");
      Class_Ali      : aliased char16_array := Window_Class;
      Class_Ptr      : access char16_array := Class_Ali'Access;
   begin
      accept Start;
      Put_Line ("Window is brought to the forefront.");

      while H_Wnd = 0 loop
         Put_Line ("Window Finding now ...");
         H_Wnd := Windows_API.FindWindow (Class_Ptr, Lp_Caption);
      end loop;
      Put_Line ("Find H_Wnd : " & H_Wnd'Image);

      while Windows_API.SetForegroundWindow (H_Wnd) = False loop
         Get_Err := System.Win32.GetLastError;
         Put_Line ("Get_Err : " & Get_Err'Image);

         if Windows_API.IsWindow(H_Wnd) then
            Put_Line ("Set Foreground Window now ...");
         else
            Put_Line("Window handle is not invalid.");
         end if;
         delay 0.1;
      end loop;
      delay 0.1;
      Put_Line ("Set Foreground Window");

      while Windows_API.SetWindowPos (
         H_Wnd,
         0,
         0, 0,
         0, 0,
         Windows_API.SWP_NOSIZE or Windows_API.SWP_NOMOVE or Windows_API.SWP_SHOWWINDOW) = False loop

         Get_Err := System.Win32.GetLastError;
         Put_Line ("Get_Err : " & Get_Err'Image);

         if Windows_API.IsWindow(H_Wnd) then
            Put_Line ("Set Window Pos now ...");
         else
            Put_Line("Window handle is not invalid.");
         end if;
         delay 0.1;
      end loop;
      Put_Line ("Set Top Window");

   end Window_At_Top;

begin
   if Manager.Initialize_JSON_Read = 1 then
      Put_Line ("[ERROR] Failed to initialize messages.");
   end if;

   loop
      Window_At_Top.Start;

      Get_Message := Manager.Get_Random_Message;
      declare
         -- UTF16にする必要のため、Get_Messageを変換する
         use GNAT.Decode_UTF8_String;

         Message_Str    : constant String := To_String (Get_Message);
         Message_WStr   : constant Wide_String := Decode_Wide_String (Message_Str);
         Message_Char   : constant char16_array := To_C (Message_WStr);
         Message_Ali    : aliased char16_array := Message_Char;
         Message_Ptr    : constant access char16_array := Message_Ali'Access;
      begin
         Result := Windows_API.MessageBox (0,
                                          Message_Ptr,
                                          Lp_Caption,
                                          U_Type);
      end;

      Next_Time := Motivational_Messages.Get_Random_Minutes;
      delay Next_Time;
   end loop;

   if Result = 0 then
      null;
   end if;

end Mandatory_Motivation;
