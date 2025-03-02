with Ada.Strings.Unbounded;
with GNAT.Decode_UTF8_String;
with Interfaces.C;
with Windows_API;
with Motivational_Messages;

procedure Mandatory_Motivation is
   use Ada.Strings.Unbounded;
   use Interfaces.C;

   H_Wnd       : constant int := 0;
   Caption     : constant char16_array := To_C ("Mandatory Motivation");
   Caption_Ali : aliased char16_array := Caption;
   Lp_Caption  : constant access char16_array := Caption_Ali'Access;
   U_Type      : constant unsigned := 48;
   Result      : int;

   Get_Message : Unbounded_String;

   Next_Time : Duration;

begin
   loop
      Get_Message := Motivational_Messages.Get_Random_Message;
      declare
         -- UTF16にする必要のため、Get_Messageを変換する
         use GNAT.Decode_UTF8_String;

         Message_Str    : constant String := To_String (Get_Message);
         Message_WStr   : constant Wide_String := Decode_Wide_String (Message_Str);
         Message_Char   : constant char16_array := To_C (Message_WStr);
         Message_Ali    : aliased char16_array := Message_Char;
         Message_Ptr    : constant access char16_array := Message_Ali'Access;
      begin
         Result := Windows_API.MessageBox (H_Wnd,
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
