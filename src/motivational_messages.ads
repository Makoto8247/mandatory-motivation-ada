with Ada.Numerics.Discrete_Random;
with Ada.Strings.Unbounded;

package Motivational_Messages is
   function Get_Random_Message return
      Ada.Strings.Unbounded.Unbounded_String;

   function Get_Random_Minutes return Duration;

private
   -- Get_Random_Message
   subtype Index_Range is Positive range 1 .. 1000;
   package Random_Natural is new Ada.Numerics.Discrete_Random (Index_Range);
   JSON_File : constant String := "./json/motivational_messages.json";
   NOT_GET_FILE : exception;

   -- Get_Random_Minutes
   Max_Minutes: constant Natural := 15;
   subtype Time_Range is Natural range 1 .. Max_Minutes;
   package Random_Time is new Ada.Numerics.Discrete_Random (Time_Range);
   MINUTES : constant Duration := 60.0;

end Motivational_Messages;
