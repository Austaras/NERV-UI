function Initialize()
	bSO='!SetOption'
	bWKV='!WriteKeyValue'
	bU='!Update'
	bSM='!ShowMeter'
	bHM='!HideMeter'
	bSMG='!ShowMeterGroup'
	bHMG='!HideMeterGroup'
	bCM='!CommandMeasure'
	msMC=SKIN:GetMeasure('MeasureCount')
	iC=0
end

function Update()
	if iC==0 then
		iC=1
	else
		if iMC~=msMC:GetValue() then
			iMC=msMC:GetValue()
			if iMC==0 then
				SKIN:Bang(bWKV,'Variables','Recycle',0,'#VARFILE#')
				SKIN:Bang(bSO,'MeterRecycle','ToolTipText','Open Recycle Bin','NERV UI\\Top')
				SKIN:Bang(bSO,'MeterRecycle','RightMouseUpAction','[]','NERV UI\\Top')
				SKIN:Bang(bHMG,'Count')
				SKIN:Bang(bSM,'MeterEmpty')
			else
				SKIN:Bang(bWKV,'Variables','Recycle',1,'#VARFILE#')
				SKIN:Bang(bSO,'MeterRecycle','ToolTipText','Open Recycle Bin#CRLF#Right-Click to Empty Recycle Bin','NERV UI\\Top')
				SKIN:Bang(bSO,'MeterRecycle','RightMouseUpAction',bCM..' MeasureCount EmptyBin \"NERV UI\\Recycle\"','NERV UI\\Top')
				SKIN:Bang(bSMG,'Count')
				SKIN:Bang(bHM,'MeterEmpty')
			end
			SKIN:Bang(bU,'NERV UI\\Top')
			if iMC<2 then
				SKIN:Bang(bSO,'MeterItemLabel','Text','Item')
			else
				SKIN:Bang(bSO,'MeterItemLabel','Text','Items')
			end
		end
	end
end