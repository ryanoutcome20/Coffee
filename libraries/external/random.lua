-- Credits to homonovous.

do
    local META = {
       m_iv = {}, -- array, size == NTAB
    }
    META.__index = META
    META.__tostring = function(self)
       return 'UniformRandomStream [' .. self.m_idum .. ']'
    end
 
    function UniformRandomStream(seed)
       local obj = setmetatable({}, META)
       obj:SetSeed(tonumber(seed) or 0)
       return obj
    end
 
    -- https://github.com/VSES/SourceEngine2007/blob/master/src_main/vstdlib/random.cpp#L16
 
    local IA = 16807
    local IM = 2147483647
    local IQ = 127773
    local IR = 2836
    local NTAB = 32
    local NDIV = (1 + (IM - 1) / NTAB)
    local MAX_RANDOM_RANGE = 0x7FFFFFFF
 
    -- fran1 -- return a random floating-point number on the interval [0,1])
    local AM = (1 / IM)
    local EPS = 1.2e-7
    local RNMX = (1 - EPS)
 
    function META:SetSeed(iSeed)
       self.m_idum = iSeed < 0 and iSeed or -iSeed
       self.m_iy = 0
    end
 
    local int = math.floor
    function META:GenerateRandomNumber( )
       local j, k
       if (self.m_idum <= 0 or not self.m_iy) then
          if (-self.m_idum < 1) then
                self.m_idum = 1
          else
                self.m_idum = -self.m_idum
          end
 
          j = NTAB + 8
          while 1 do
                if j <= 0 then break end
                j = j - 1
 
                k = int(self.m_idum / IQ)
                self.m_idum = int(IA * (self.m_idum-k * IQ) - IR * k)
                if (self.m_idum < 0)  then
                   self.m_idum = int(self.m_idum + IM)
                end
                if (j < NTAB) then
                   self.m_iv[j] = int(self.m_idum)
                end
          end
          self.m_iy = self.m_iv[0]
       end
 
       k = int(self.m_idum / IQ)
       self.m_idum = int(IA * (self.m_idum-k * IQ) - IR * k)
       if (self.m_idum < 0) then
          self.m_idum = int(self.m_idum + IM)
       end
       j = int(self.m_iy / NDIV)
 
       -- We're seeing some strange memory corruption in the contents of s_pUniformStream. 
       -- Perhaps it's being caused by something writing past the end of this array? 
       -- Bounds-check in release to see if that's the case.
       if (j >= NTAB or j < 0) then
          ErrorNoHalt(string.format('CUniformRandomStream had an array overrun: tried to write to element %d of 0..31.', j))
          j = int(bit.band( j % NTAB, 0x7fffffff))
       end
 
       self.m_iy = int(self.m_iv[j])
       self.m_iv[j] = int(self.m_idum)
 
       return self.m_iy
    end
 
    function META:RandomFloat(flLow, flHigh)
       flLow = flLow or 0
       flHigh = flHigh or 1
 
       local fl = AM * self:GenerateRandomNumber( )
       if fl > RNMX then
          fl = RNMX
       end
 
       return (fl * ( flHigh - flLow ) ) + flLow -- float in [low,high]
    end
 
    function META:RandomFloatExp(flMinVal, flMaxVal, flExponent)
       flMinVal = flMinVal or 0
       flMaxVal = flMaxVal or 1
       flExponent = flExponent or 1
 
       local fl = AM * self:GenerateRandomNumber( )
       fl = math.min(fl, RNMX)
 
       if flExponent ~= 1 then
          fl = math.pow(fl, flExponent)
       end
 
       return (fl * ( flMaxVal - flMinVal ) ) + flMinVal
    end
 
    function META:RandomInt(iLow, iHigh)
       iLow = iLow or 0 iHigh = iHigh or 100
       iLow = math.floor(iLow) iHigh = math.floor(iHigh)
       local iMaxAcceptable, n
       local x = iHigh - iLow + 1
 
       if x <= 1 or MAX_RANDOM_RANGE < x-1 then
          return iLow
       end
 
       iMaxAcceptable = math.floor(MAX_RANDOM_RANGE - ((MAX_RANDOM_RANGE + 1) % x ))
       n = self:GenerateRandomNumber( )
       while n > iMaxAcceptable do
          n = self:GenerateRandomNumber( )
       end
 
       return iLow + (n % x)
    end
end