function Initialize()
	bWKV='!WriteKeyValue'
	bRFA='!RefreshApp'
	bSM='!ShowMeter'
	bHM='!HideMeter'
	bSMG='!ShowMeterGroup'
	bHMG='!HideMeterGroup'
	-- sV=tostring(SKIN:GetVariable('SETTINGSPATH'))..'Rainmeter.ini'
	-- fR=io.open(sV,'r')
	-- sR=fR:read('*a')
	-- fR:close()
	-- iD=tonumber(string.match(sR,'%[Rainmeter%][^%[%]]*\n[uU][sS][eE][dD]2[dD]=(%d*)'))
	-- This won't work because the file is encoded in UTF-16LE
	-- so just set iD=0
	iD=0
	if type(iD)=='nil' then
		SKIN:Bang(bWKV,'Rainmeter','UseD2D',0,sV)
		SKIN:Bang(bRFA)
	elseif iD~=0 then
		SKIN:Bang(bWKV,'Rainmeter','UseD2D',0,sV)
		SKIN:Bang(bRFA)
	end
	sP=tostring(SKIN:GetVariable('AC'))
	P()
end

function P()
	if tonumber(SKIN:GetVariable('NERV'..sP))==0 then
		SKIN:Bang(bSMG,'NERV')
	else
		SKIN:Bang(bHMG,'NERV')
	end
	if tonumber(SKIN:GetVariable('Solid'..sP))==0 then
		SKIN:Bang(bSM,'MeterSolid')
	else
		SKIN:Bang(bHM,'MeterSolid')
	end
end