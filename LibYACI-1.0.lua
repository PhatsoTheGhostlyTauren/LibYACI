local MAJOR, MINOR = "LibYACI-1.0", 1
local YACI, oldminor = LibStub:NewLibrary(MAJOR, MINOR)

if not YACI then return end -- No Upgrade needed.


YACI.Object = Object;

function YACI:Class(name, baseClass)
  return newclass(name,baseClass)
end
