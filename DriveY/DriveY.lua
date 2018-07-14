function Initialize()
	bSO='!SetOption'
	bSOG='!SetOptionGroup'
	bWKV='!WriteKeyValue'
	bU='!Update'
	bUMSG='!UpdateMeasureGroup'
	iD=tonumber(SKIN:GetVariable('DriveY'))
	iDU=tonumber(SKIN:GetVariable('DriveYUp'))
	iDD=tonumber(SKIN:GetVariable('DriveYDown'))
	sDL=tostring(SKIN:GetVariable('DriveYLetter'))
	sM={'Label','Free','Used','Total','Type'}
	sD={}
	sDP=string.gsub(string.gsub(sDL,'%A',''),'(%l)',function(c) return string.upper(c) end)
	if sDL~=sDP then
		sDL=sDP
		SKIN:Bang(bWKV,'Variables','DriveYLetter',sDL,'#CUSFILE#')
	end
	iDN=0
	while sDL~='' do
		iDN=iDN+1
		sD[iDN]=string.match(sDL,'(%a)%a*')
		sDL=string.sub(sDL,2)
	end
	if iD>iDN then
		iD=1
		SKIN:Bang(bWKV,'Variables','DriveY',1,'#VARFILE#')
	end
	if iDN>1 then
		sDMR='#CRLF#Right-Click to '..sD[iD%iDN+1]..':\\'
	else
		sDMR=''
	end
	for i=1,5 do
		SKIN:Bang(bSO,'MeasureDisk'..sM[i],'Drive',sD[iD]..':')
	end
	SKIN:Bang(bSO,'MeterDisk','Text',sD[iD])
	SKIN:Bang(bSO,'MeterLabelUp','Text',sM[iDU])
	SKIN:Bang(bSO,'MeterUp','MeasureName','MeasureDisk'..sM[iDU])
	SKIN:Bang(bSO,'MeterLabelDown','Text',sM[iDD])
	SKIN:Bang(bSO,'MeterDown','MeasureName','MeasureDisk'..sM[iDD])
end

function T()
	iD=iD%iDN+1
	sDMR='#CRLF#Right-Click to '..sD[iD%iDN+1]..':\\'
	SKIN:Bang(bWKV,'Variables','DriveY',iD,'#VARFILE#')
	SKIN:Bang(bSO,'MeterDriveY','ToolTipText','Open '..sD[iD]..':\\'..sDMR,'NERV UI\\Top')
	SKIN:Bang(bU,'NERV UI\\Top')
	for i=1,5 do
		SKIN:Bang(bSO,'MeasureDisk'..sM[i],'Drive',sD[iD]..':')
	end
	SKIN:Bang(bUMSG,'Drive')
	SKIN:Bang(bSO,'MeterDisk','Text',sD[iD])
	SKIN:Bang(bU)
end

function U()
	SKIN:Bang(bSOG,'DriveY','ToolTipText','Right-Click to Display '..sM[iDU]..' Space','NERV UI\\Top')
	SKIN:Bang(bU,'NERV UI\\Top')
	iDU=9-iDU-iDD
	SKIN:Bang(bWKV,'Variables','DriveYUp',iDU,'#VARFILE#')
	SKIN:Bang(bSO,'MeterLabelUp','Text',sM[iDU])
	SKIN:Bang(bSO,'MeterUp','MeasureName','MeasureDisk'..sM[iDU])
	SKIN:Bang(bU)
end

function D()
	SKIN:Bang(bSOG,'DriveY','ToolTipText','Right-Click to Display '..sM[iDD]..' Space','NERV UI\\Top')
	SKIN:Bang(bU,'NERV UI\\Top')
	iDD=9-iDU-iDD
	SKIN:Bang(bWKV,'Variables','DriveYDown',iDD,'#VARFILE#')
	SKIN:Bang(bSO,'MeterLabelDown','Text',sM[iDD])
	SKIN:Bang(bSO,'MeterDown','MeasureName','MeasureDisk'..sM[iDD])
	SKIN:Bang(bU)
end

function O()
	SKIN:Bang(sD[iD]..':')
end