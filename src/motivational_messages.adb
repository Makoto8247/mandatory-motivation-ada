with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Text_IO; use Ada.Text_IO;
with GNATCOLL.JSON; use GNATCOLL.JSON;

package body Motivational_Messages is

   function Initialize_JSON_Read (Self : in out Motivation_Manager) return Integer is
      JSON_Root : Read_Result;
   begin
      -- JSONをパース
      JSON_Root := Read_File (JSON_File);
      case JSON_Root.Success is
         when True =>
            Self.Messages := JSON_Root.Value.Get ("messages");
            Self.Messages_Length := Length (Self.Messages);
            Put_Line ("Get JSON file");
         when False =>
            raise NOT_GET_FILE;
      end case;

      Self.Initialized := True;

      return 0;
   exception
      when NOT_GET_FILE =>
         Put_Line ("Failed to get JSON file");
         return 1;
      when others =>
         Put_Line ("Failed to get JSON Values");
         return 1;
   end Initialize_JSON_Read;

   function Get_Random_Message (Self : Motivation_Manager) return Unbounded_String is
      Message_Value     : JSON_Value;
      Message_Str       : UTF8_Unbounded_String;
      Gen               : Random_Natural.Generator;
      Rnd_Num           : Positive;

   begin
      if Self.Initialized = False then
         raise NOT_INITIALIZED;
      end if;

      -- ランダム生成器の初期化
      Random_Natural.Reset (Gen);
      
      -- ランダムに1つ選択
      Rnd_Num := Random_Natural.Random (Gen, 1, Self.Messages_Length);

      -- JSON配列から文字列を取得
      Message_Value := Get (Self.Messages, Rnd_Num);
      Message_Str := Get (Message_Value);
      Message_Str := Message_Str & Character'First;

      return Message_Str;
   exception
      when NOT_INITIALIZED =>
         Put_Line ("Please Initialized");
         return To_Unbounded_String ("Please Initialized");
      when others =>
         Put_Line ("An unexpected error occurred");
         return To_Unbounded_String ("An unexpected error occurred");
   end Get_Random_Message;

   function Get_Random_Minutes return Duration is
      Gen : Random_Time.Generator;
      Result : Duration;
      Rnd_Num : Natural;
   begin
      -- ランダム生成器の初期化
      Random_Time.Reset (Gen);

      Rnd_Num := Random_Time.Random (Gen, 1, Max_Minutes);
      Result := Rnd_Num * MINUTES;
      Put_Line (Rnd_Num'Image & " Minutes!");
      return Result;
   end Get_Random_Minutes;

end Motivational_Messages;
