local MAJOR, MINOR = "LibYACI-2.0", 1
local YACI, oldminor = LibStub:NewLibrary(MAJOR, MINOR)

if not YACI then return end -- No Upgrade needed.


YACI.Object = Object;

function YACI:Class(name, baseClass)
  return newclass(name,baseClass)
end

function YACI:GenericClass(name,type,baseClass)
  if not type.subclass then
    error("Failed to create GenericClass " .. name .. ". Type is not a class.")
  end
  local Class = newclass(name,baseClass)
  Class.Type = type
  return Class
end
