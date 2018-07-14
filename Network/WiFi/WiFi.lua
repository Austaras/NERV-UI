function Initialize()
	bSO='!SetOption'
	bSOG='!SetOptionGroup'
	bDC='!DeactivateConfig'
	bHMG='!HideMeterGroup'
	bCM='!CommandMeasure'
	msMS=SKIN:GetMeasure('MeasureSSID')
	msMQ=SKIN:GetMeasure('MeasureQuality')
	msME=SKIN:GetMeasure('MeasureEncryption')
	if tonumber(SKIN:GetVariable('NetworkWiFi'))==0 then SKIN:Bang(bDC,'NERV UI\\Network\\WiFi') end
	SKIN:Bang(bCM,'MeasureScript','iO=1','NERV UI\\Network')
	SKIN:Bang(bHMG,'WiFi')
end

function Update()
	if sMS~=msMS:GetStringValue() then
		sMS=msMS:GetStringValue()
		if sMS=='' then
			SKIN:Bang(bCM,'MeasureScript','M(0)','NERV UI\\Network\\Ani')
		else
			SKIN:Bang(bCM,'MeasureScript','M(6)','NERV UI\\Network\\Ani')
		end
	end
	iMQ=msMQ:GetValue()
	SKIN:Bang(bSOG,'Q'..math.ceil(iMQ/20),'SolidColor','#*FontColor2*#,102')
	SKIN:Bang(bSOG,'NQ'..math.ceil(iMQ/20),'SolidColor','#*FontColor2*#,51')
	if msME:GetStringValue()~='NONE' then
		SKIN:Bang(bSO,'MeterEncryption','Text','LOCK')
	else
		SKIN:Bang(bSO,'MeterEncryption','Text','NONE')
	end
end