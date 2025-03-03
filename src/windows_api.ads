with Interfaces.C; use Interfaces.C;

package Windows_API is
   subtype HWND_Type is int range -2 .. 1;
   HWND_TOPMOST : constant HWND_Type := -1;
   HWND_NOTOPMOST : constant HWND_Type := -2;
   HWND_DESKTOP : constant HWND_Type := 0;

   SWP_NOSIZE       : constant unsigned := 16#0001#;
   SWP_NOMOVE       : constant unsigned := 16#0002#;
   SWP_NOZORDER     : constant unsigned := 16#0004#;
   SWP_NOACTIVATE   : constant unsigned := 16#0010#;
   SWP_SHOWWINDOW   : constant unsigned := 16#0040#;
   
   function MessageBox (
      hWnd : int;
      Text : access constant char16_array;
      Caption : access constant char16_array;
      uType : unsigned) return int
   with Import, Convention => Stdcall, Link_Name => "MessageBoxW";

   function SetWindowPos (
      hWnd : int;
      hWindInsertAfter : HWND_Type;
      X : int;
      Y : int;
      Cx : int;
      Cy : int;
      uFlags : unsigned) return Boolean
   with Import, Convention => Stdcall, Link_Name => "SetWindowPos";

   function FindWindow(
      lpClassName : access constant char16_array;
      lpWindowName : access constant char16_array) return int
   with Import, Convention => Stdcall, Link_Name => "FindWindowW"; 

   function SetForegroundWindow (hWnd : int) return Boolean
   with Import, Convention => Stdcall, Link_Name => "SetForegroundWindow";

   function IsWindow (hWnd : int) return Boolean
   with Import, Convention => Stdcall, Link_Name => "IsWindow";
end Windows_API;