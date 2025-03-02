with Interfaces.C; use Interfaces.C;
with Interfaces.C.Strings;

package Windows_API is
   -- MessageBox
   function MessageBox (
      hWnd : int;
      Text : access constant char16_array;
      Caption : access constant char16_array;
      uType : unsigned) return int
   with Import, Convention => Stdcall, Link_Name => "MessageBoxW";

end Windows_API;