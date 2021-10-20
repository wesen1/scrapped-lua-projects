---
-- @author wesen
-- @copyright 2020 wesen <wesen-ac@web.de>
-- @release 0.1
-- @license MIT
--

-- Attempt to parse AssaultCube cgz header data

-- luarocks:
--
-- lua-struct
-- lzlib
-- bitop-lua



local struct = require "struct"
local zlib = require "zlib"
local bit = require "bit"


--[[

struct header                   // map file format header
{
    char head[4];               // "CUBE"
    int version;                // any >8bit quantity is little endian
    int headersize;             // sizeof(header)
    int sfactor;                // in bits
    int numents;
    char maptitle[128];
    uchar texlists[3][256];
    int waterlevel;
    uchar watercolor[4];
    int maprevision;
    int ambient;
    int reserved[12];
    //char mediareq[128];         // version 7 and 8 only.
};


--]]

--local ezlib = require 'ezlib'



--local cgzFile = gzip.open("3-min-gema-1.cgz", "rb")

local charSize = 1
local ucharSize = 1
local integerSize = 4

local headerSize = 19 * integerSize + (4 + 128) * charSize + (3 * 256 + 4) * ucharSize


local numberOfBytesToRead = 4-- headerSize - 16 * integerSize
local numberOfReadBytes = 0

--[[
local cgzContent = ""
local nextLine
repeat
  nextLine = cgzFile:read()
  if (nextLine) then
    cgzContent = cgzContent .. nextLine
  end

until (not nextLine)
--]]


--[[
for _, line in gzip.lines("3-min-gema-1.cgz") do
  print(line)
end
--]]


--[[
local cgzLine
local cgzContent = ""
repeat
  cgzLine = cgzFile:read()
  if (cgzLine) then
    cgzContent = cgzContent .. cgzLine
  end
until (not cgzLine)
--]]

local cgzFile = io.open("gibbed-gema12.cgz", "rb")
--local cgzFile = io.open("3-min-gema-1.cgz", "rb")
--local cgzFile = io.open("verwesen-gema-1.cgz", "rb")


local stream = zlib.inflate(cgzFile)

print(stream)

local cgzContent = ""
for line in stream:lines() do
  cgzContent = cgzContent .. line
end

print(cgzContent)

local header = cgzContent:sub(1, 923)
print(#header)


local structFormat = ">c4<iiiic128c256c256c256ic4iii12"
--.. string.rep("B", 256 * 3)
local structContent = { struct.unpack(structFormat, cgzContent) }

for k, v in pairs(structContent) do
  print(k, v)
end

print("head: " .. structContent[1])
print("version: " .. structContent[2])
print("headersize: " .. structContent[3])
print("sfactor: " .. structContent[4])
print("numents: " .. structContent[5])
print("maptitle: " .. structContent[6])

local firstTexlist = ""
local secondTexlist = ""
local thirdTexlist = ""

--[[
for i = 7, 262, 1 do
  firstTexlist = firstTexlist .. " " .. string.char(structContent[i])
end

for i = 263, 518, 1 do
  secondTexlist = secondTexlist .. " " .. string.char(structContent[i])
end

for i = 519, 774, 1 do
  thirdTexlist = thirdTexlist .. " " .. string.char(structContent[i])
end
--]]


print("texlists[0]: " .. structContent[7])
print("texlists[1]: " .. structContent[8])
print("texlists[2]: " .. structContent[9])
print("waterlevel: " .. structContent[10])
print("watercolor: " .. structContent[11])
print("maprevision: " .. structContent[12])
print("ambient: " .. structContent[13])
print("reserved: " .. structContent[14])


for k, v in pairs(structContent) do
  --print(k, v)
end


--print(cgzContent)

--print(stream:read("*a"))


--print(#cgzContent)
--print(cgzContent)
--print(stream(cgzContent))
--print(stream())
--print(stream())
--print(stream())
--print(stream())
--print(stream())
--print(stream())
--print(stream())
--print(stream())

--print(stream())


--print(cgzContent)
--print(stream)

--[[
local nextCharacter, nextByte
repeat

  nextCharacter = cgzFile:read(1)
  if (nextCharacter) then
    nextByte = cgzFile:read(1)
    nextByteThing = nextByteThing .. nextByte
    nextByte = string.byte(nextByte)

    print(nextByte)
    print(string.char(nextByte))
    -- string.char
  end

  numberOfReadBytes = numberOfReadBytes + 1

until (numberOfReadBytes == numberOfBytesToRead)
--]]

--[[
for byte in string.gfind(nextByteThing, ".") do
  print(string.char(string.byte(byte)))
end
print(nextByteThing)
--]]


--[[
print()
print(string.rep("-", 100))

local nextLine
repeat
  nextLine = cgzFile:read()
  if (nextLine) then
    print(nextLine)
  end
until (not nextLine)
--]]


--print("NONONONOO: " .. numberOfBytesToRead)

--[[
bool load_world(char *mname)        // still supports all map formats that have existed since the earliest cube betas!
{
    advancemaprevision = 1;
    setnames(mname);
    maploaded = getfilesize(ocgzname);
    if(maploaded > 0)
    {
        copystring(cgzname, ocgzname);
        copystring(mcfname, omcfname);
    }
    else maploaded = getfilesize(cgzname);
    if(!validmapname(mapname))
    {
        conoutf("\f3Invalid map name. It must only contain letters, digits, '-', '_' and be less than %d characters long", MAXMAPNAMELEN);
        return false;
    }
    stream *f = opengzfile(cgzname, "rb");
    if(!f) { conoutf("\f3could not read map %s", cgzname); return false; }
    header tmp;
    memset(&tmp, 0, sizeof(header));
    if(f->read(&tmp, sizeof(header)-sizeof(int)*16)!=sizeof(header)-sizeof(int)*16) { conoutf("\f3while reading map: header malformatted"); delete f; return false; }
    lilswap(&tmp.version, 4);
    if(strncmp(tmp.head, "CUBE", 4)!=0 && strncmp(tmp.head, "ACMP",4)!=0) { conoutf("\f3while reading map: header malformatted"); delete f; return false; }
    if(tmp.version>MAPVERSION) { conoutf("\f3this map requires a newer version of AssaultCube"); delete f; return false; }
    if(tmp.sfactor<SMALLEST_FACTOR || tmp.sfactor>LARGEST_FACTOR || tmp.numents > MAXENTITIES) { conoutf("\f3illegal map size"); delete f; return false; }
    if(tmp.version>=4 && f->read(&tmp.waterlevel, sizeof(int)*16)!=sizeof(int)*16) { conoutf("\f3while reading map: header malformatted"); delete f; return false; }
    if((tmp.version==7 || tmp.version==8) && !f->seek(sizeof(char)*128, SEEK_CUR)) { conoutf("\f3while reading map: header malformatted"); delete f; return false; }
    hdr = tmp;
    loadingscreen("%s", hdr.maptitle);
    resetmap();
    if(hdr.version>=4)
    {
        lilswap(&hdr.waterlevel, 1);
        if(!hdr.watercolor[3]) setwatercolor();
        lilswap(&hdr.maprevision, 2);
        curmaprevision = hdr.maprevision;
    }
    else
    {
        hdr.waterlevel = -100000;
        hdr.ambient = 0;
    }
    ents.shrink(0);
    loopi(3) numspawn[i] = 0;
    loopi(2) numflagspawn[i] = 0;
    loopi(hdr.numents)
    {
        entity &e = ents.add();
        f->read(&e, sizeof(persistent_entity));
        lilswap((short *)&e, 4);
        e.spawned = false;
        TRANSFORMOLDENTITIES(hdr)
        if(e.type == PLAYERSTART && (e.attr2 == 0 || e.attr2 == 1 || e.attr2 == 100))
        {
            if(e.attr2 == 100)
                numspawn[2]++;
            else
                numspawn[e.attr2]++;
        }
        if(e.type == CTF_FLAG && (e.attr2 == 0 || e.attr2 == 1)) numflagspawn[e.attr2]++;
    }
    delete[] world;
    setupworld(hdr.sfactor);

    DELETEA(mlayout);
    mlayout = new char[cubicsize + 256];
    memset(mlayout, 0, cubicsize * sizeof(char));
    int diff = 0;
    Mv = Ma = Hhits = 0;

    if(!mapinfo.numelems || (mapinfo.access(mname) && !cmpf(cgzname, mapinfo[mname]))) world = (sqr *)ents.getbuf();

    -- cgzname
    -- hdr.maprevision
    -- hdr.maptitle

}
--]]
