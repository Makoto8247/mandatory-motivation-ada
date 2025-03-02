with Ada.Numerics.Discrete_Random;
with Ada.Strings.Unbounded;
with GNATCOLL.JSON;

package Motivational_Messages is
   use GNATCOLL.JSON;

   type Motivation_Manager is tagged private;

   function Initialize_JSON_Read (Self : in out Motivation_Manager) return 
      Integer;

   function Get_Random_Message (Self : Motivation_Manager) return
      Ada.Strings.Unbounded.Unbounded_String;

   function Get_Random_Minutes return Duration;

private
   type Motivation_Manager is tagged record
      Messages          : JSON_Array;
      Messages_Length   : Natural := 0;
      Initialized       : Boolean := False;
   end record;

   -- Get_Random_Message
   subtype Index_Range is Positive range 1 .. 1000;
   package Random_Natural is new Ada.Numerics.Discrete_Random (Index_Range);
   JSON_File : constant String := "./json/motivational_messages.json";
   NOT_GET_FILE : exception;
   NOT_INITIALIZED : exception;

   -- Get_Random_Minutes
   Max_Minutes : constant Natural := 15;
   subtype Time_Range is Natural range 1 .. Max_Minutes;
   package Random_Time is new Ada.Numerics.Discrete_Random (Time_Range);
   MINUTES : constant Duration := 60.0;

end Motivational_Messages;
