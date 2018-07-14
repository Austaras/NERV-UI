function Initialize()
	bSO='!SetOption'
	bSV='!SetVariable'
	bU='!Update'
	bRD='!Redraw'
	bHM='!HideMeter'
	bUMT='!UpdateMeter'
	bHMG='!HideMeterGroup'
	bUMTG='!UpdateMeterGroup'
	bCM='!CommandMeasure'
	sT={'Temp','FH0','FL0','FH1','FL1','FH2','FL2'}
	sI={'Icon','FI0','FI1','FI2'}
	msMT={}
	msMI={}
	sMT={}
	for i=1,7 do
		msMT[i]=SKIN:GetMeasure('Measure'..sT[i])
	end
	for i=1,4 do
		msMI[i]=SKIN:GetMeasure('Measure'..sI[i])
	end
	SKIN:Bang(bCM,'MeasureScript','M(0)','NERV UI\\Weather\\Ani')
	SKIN:Bang(bHMG,'Forecast')
end

function Update()
	if sFC~=tostring(SKIN:GetVariable('FontColor2')) then
		sFC=tostring(SKIN:GetVariable('FontColor2'))
		SKIN:Bang(bSV,'MC1',string.match(sFC,'(%d*),%d*,%d*')/255)
		SKIN:Bang(bSV,'MC2',string.match(sFC,'%d*,(%d*),%d*')/255)
		SKIN:Bang(bSV,'MC3',string.match(sFC,'%d*,%d*,(%d*)')/255)
	end
end

function F()
	if tonumber(SKIN:GetVariable('WeatherForecast'))==1 then
		SKIN:Bang(bCM,'MeasureScript','M(6)','NERV UI\\Weather\\Ani')
		sE='Hide'
	else
		sE='Show'
	end
	for i=1,7 do
		sMT[i]=msMT[i]:GetStringValue()
		if sMT[i]~='N/A' then SKIN:Bang(bSO,'Meter'..sT[i],'Text',sMT[i]..'\'#WeatherTempUnit#') end
	end
	for i=1,4 do
		SKIN:Bang(bSO,'Meter'..sI[i],'ImageName','#@#Images\\Weather\\'..msMI[i]:GetStringValue())
	end
	SKIN:Bang(bSO,'MeterWeather','ToolTipText','Open Weather.com#CRLF#Right-Click to '..sE..' Forecast#CRLF#Mid-Click to Update Weather','NERV UI\\Top')
	SKIN:Bang(bSO,'MeterWeather','RightMouseUpAction',bCM..' MeasureScript T() \"NERV UI\\Weather\\Ani\"','NERV UI\\Top')
	SKIN:Bang(bU,'NERV UI\\Top')
	SKIN:Bang(bHM,'MeterIconNA')
	SKIN:Bang(bU)
end

function O()
	SKIN:Bang(bSO,'MeterWeatherLabel','FontColor','#*FontColor2*#')
	SKIN:Bang(bSO,'MeterIconNA','ImageAlpha',255)
	SKIN:Bang(bSO,'MeterIcon','ColorMatrix4','0;0;0;1;0')
	SKIN:Bang(bUMT,'MeterWeatherLabel')
	SKIN:Bang(bUMTG,'Icon')
	SKIN:Bang(bRD)
end

function L()
	SKIN:Bang(bSO,'MeterWeatherLabel','FontColor','#*FontColor1*#')
	SKIN:Bang(bSO,'MeterIconNA','ImageAlpha',204)
	SKIN:Bang(bSO,'MeterIcon','ColorMatrix4','0;0;0;0.8;0')
	SKIN:Bang(bUMT,'MeterWeatherLabel')
	SKIN:Bang(bUMTG,'Icon')
	SKIN:Bang(bRD)
end