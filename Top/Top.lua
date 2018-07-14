function Initialize()
	bSO='!SetOption'
	bSOG='!SetOptionGroup'
	bWKV='!WriteKeyValue'
	bSV='!SetVariable'
	bAC='!ActivateConfig'
	bDC='!DeactivateConfig'
	bRF='!Refresh'
	bU='!Update'
	bRD='!Redraw'
	bSM='!ShowMeter'
	bHM='!HideMeter'
	bTM='!ToggleMeter'
	bUMT='!UpdateMeter'
	bHMG='!HideMeterGroup'
	bTMG='!ToggleMeterGroup'
	bUMTG='!UpdateMeterGroup'
	bUMS='!UpdateMeasure'
	bUMSG='!UpdateMeasureGroup'
	bCM='!CommandMeasure'
	iCT=tonumber(SKIN:GetVariable('CPUTemp'))
	iD={tonumber(SKIN:GetVariable('DriveX')),tonumber(SKIN:GetVariable('DriveY'))}
	iP=tonumber(SKIN:GetVariable('Player'))
	iPC=tonumber(SKIN:GetVariable('PlayerCover'))
	sC={'Hide','Show'}
	sD={'X','Y'}
	sM={'Free','Used','Total'}
	sT={'Fahrenheit','Celsius'}
	sV={'Off','On'}
	sCTU={'C','F'}
	sWTU={'C','F'}
	sWUU={'m','f'}
	sDL={}
	iLN=0
	iPN=0
	if iCT==0 then SKIN:Bang(bHM,'MeterCPUTemp') end
	SKIN:Bang(bSO,'MeterCPU','ToolTipText','Right-Click to '..sC[2-iCT]..' CPU Temp Display')
	if tostring(SKIN:GetVariable('CPUTempUnit'))=='C' then
		iCTU=1
	else
		iCTU=2
	end
	SKIN:Bang(bSO,'MeterCPUTemp','ToolTipText','Right-Click to Use '..sT[iCTU])
	for i=1,2 do
		iDN=0
		sDP=string.gsub(string.gsub(tostring(SKIN:GetVariable('Drive'..sD[i]..'Letter')),'%A',''),'(%l)',function(c) return string.upper(c) end)
		while sDP~='' do
			iDN=iDN+1
			sDL[iDN]=string.match(sDP,'(%a)%a*')
			sDP=string.sub(sDP,2)
		end
		if iDN>1 then
			sDMR='#CRLF#Right-Click to '..sDL[iD[i]%iDN+1]..':\\'
			SKIN:Bang(bSO,'MeterDrive'..sD[i],'RightMouseUpAction',bCM..' MeasureScript T() \"NERV UI\\Drive'..sD[i]..'\"')
		else
			sDMR=''
		end
		SKIN:Bang(bSO,'MeterDrive'..sD[i],'ToolTipText','Open '..sDL[iD[i]]..':\\'..sDMR)
		iDD=8-tonumber(SKIN:GetVariable('Drive'..sD[i]..'Up'))-tonumber(SKIN:GetVariable('Drive'..sD[i]..'Down'))
		SKIN:Bang(bSOG,'Drive'..sD[i],'ToolTipText','Right-Click to Display '..sM[iDD]..' Space')
	end
	if tonumber(SKIN:GetVariable('Launcher'))==0 then
		SKIN:Bang(bSO,'MeterLauncher','ToolTipText','Open Launcher')
		SKIN:Bang(bSO,'MeterLauncher','RightMouseUpAction','[]')
		SKIN:Bang(bHMG,'Page')
	else
		while (type(SKIN:GetVariable('LauncherPath'..iLN+1))~='nil') do
			iLN=iLN+1
		end
		if iLN<=10 then SKIN:Bang(bHMG,'Page') end
	end
	if type(SKIN:GetVariable('PlayerText'..iP))=='nil' then
		sP=tostring(SKIN:GetVariable('Player'..iP))
	else
		sP=tostring(SKIN:GetVariable('PlayerText'..iP))
	end
	while type(SKIN:GetVariable('Player'..iPN+1))~='nil' do
		iPN=iPN+1
	end
	if iPN>1 then
		if type(SKIN:GetVariable('PlayerText'..iP%iPN+1))=='nil' then
			sPN=tostring(SKIN:GetVariable('Player'..iP%iPN+1))
		else
			sPN=tostring(SKIN:GetVariable('PlayerText'..iP%iPN+1))
		end
		sPMR='#CRLF#Right-Click to Use '..sPN
		SKIN:Bang(bSO,'MeterPlayer','RightMouseUpAction',bCM..' MeasureScript T() \"NERV UI\\Player\"')
	else
		sPMR=''
	end
	SKIN:Bang(bSO,'MeterPlayer','ToolTipText','Open '..sP..sPMR)
	if iPC==0 then SKIN:Bang(bSO,'MeterPlayerCover','ToolTipText','Right-Click to Turn On Cover Color') end
	if tonumber(SKIN:GetVariable('Recycle'))==0 then
		SKIN:Bang(bSO,'MeterRecycle','ToolTipText','Open Recycle Bin')
		SKIN:Bang(bSO,'MeterRecycle','RightMouseUpAction','[]')
	end
	if tostring(SKIN:GetVariable('WeatherTempUnit'))=='C' then
		iWTU=1
	else
		iWTU=2
	end
	SKIN:Bang(bSO,'MeterWeatherTemp','ToolTipText','Right-Click to Use '..sT[iWTU])
	if tonumber(SKIN:GetVariable('NetworkWiFi'))==0 then
		SKIN:Bang(bSO,'MeterNetwork','ToolTipText','Open Network Connections#CRLF#Right-Click to Enable WiFi Display#CRLF#Mid-Click to Reset Stats')
		SKIN:Bang(bSO,'MeterNetwork','RightMouseUpAction',bCM..' MeasureScript WON()')
	end
	SKIN:Bang(bRF,'NERV UI\\Player')
end

function MCT()
	iCT=1-iCT
	SKIN:Bang(bWKV,'Variables','CPUTemp',iCT,'#VARFILE#')
	SKIN:Bang(bTMG,'Temp','NERV UI\\CPU')
	SKIN:Bang(bRD,'NERV UI\\CPU')
	SKIN:Bang(bTM,'MeterCPUTemp')
	SKIN:Bang(bSO,'MeterCPU','ToolTipText','Right-Click to '..sC[2-iCT]..' CPU Temp Display')
	SKIN:Bang(bU)
end

function MCTU()
	iCTU=3-iCTU
	SKIN:Bang(bWKV,'Variables','CPUTempUnit',sCTU[iCTU],'#VARFILE#')
	SKIN:Bang(bSV,'CPUTempUnit',sCTU[iCTU],'NERV UI\\CPU')
	SKIN:Bang(bSO,'MeasureCalcTemp','Formula','(MeasureTemp-#MinCPUTemp'..sCTU[iCTU]..'#)/(#MaxCPUTemp'..sCTU[iCTU]..'#-#MinCPUTemp'..sCTU[iCTU]..'#)','NERV UI\\CPU')
	SKIN:Bang(bUMSG,'Temp','NERV UI\\CPU')
	SKIN:Bang(bUMTG,'Temp','NERV UI\\CPU')
	SKIN:Bang(bRD,'NERV UI\\CPU')
	SKIN:Bang(bSO,'MeterCPUTemp','ToolTipText','Right-Click to Use '..sT[iCTU])
	SKIN:Bang(bU)
end

function MPC()
	iPC=1-iPC
	SKIN:Bang(bWKV,'Variables','PlayerCover',iPC,'#VARFILE#')
	SKIN:Bang(bTMG,'Cover','NERV UI\\Player')
	SKIN:Bang(bRD,'NERV UI\\Player')
	SKIN:Bang(bSO,'MeterPlayerCover','ToolTipText','Right-Click to Turn '..sV[2-iPC]..' Cover Color')
	SKIN:Bang(bU)
end

function MWTU()
	iWTU=3-iWTU
	SKIN:Bang(bWKV,'Variables','WeatherTempUnit',sWTU[iWTU],'#VARFILE#')
	SKIN:Bang(bWKV,'Variables','WeatherUrlUnit',sWUU[iWTU],'#VARFILE#')
	SKIN:Bang(bRF,'NERV UI\\Weather')
	SKIN:Bang(bSO,'MeterWeather','ToolTipText','Open Weather.com#CRLF#Mid-Click to Update Weather')
	SKIN:Bang(bSO,'MeterWeather','RightMouseUpAction','[]')
	SKIN:Bang(bSO,'MeterWeatherTemp','ToolTipText','Right-Click to Use '..sT[iWTU])
	SKIN:Bang(bU)
end

function WON()
	SKIN:Bang(bWKV,'Variables','NetworkWiFi',1,'#VARFILE#')
	SKIN:Bang(bSM,'MeterWiFi','NERV UI\\Network\\Ani')
	SKIN:Bang(bAC,'NERV UI\\Network\\WiFi')
	SKIN:Bang(bSO,'MeterNetwork','ToolTipText','Open Network Connections#CRLF#Right-Click to Disable WiFi Display#CRLF#Mid-Click to Reset Stats')
	SKIN:Bang(bSO,'MeterNetwork','RightMouseUpAction',bCM..' MeasureScript WOFF()')
	SKIN:Bang(bU)
end

function WOFF()
	SKIN:Bang(bWKV,'Variables','NetworkWiFi',0,'#VARFILE#')
	SKIN:Bang(bSV,'M',0,'NERV UI\\Network\\Ani')
	SKIN:Bang(bCM,'MeasureScript','iM=0;iT=0','NERV UI\\Network\\Ani')
	SKIN:Bang(bUMS,'MeasureWiFi','NERV UI\\Network\\Ani')
	SKIN:Bang(bUMT,'MeterWiFi','NERV UI\\Network\\Ani')
	SKIN:Bang(bHM,'MeterWiFi','NERV UI\\Network\\Ani')
	SKIN:Bang(bHMG,'WiFi','NERV UI\\Network\\WiFi')
	SKIN:Bang(bRD,'NERV UI\\Network\\WiFi')
	SKIN:Bang(bDC,'NERV UI\\Network\\WiFi')
	SKIN:Bang(bSO,'MeterNetwork','ToolTipText','Open Network Connections#CRLF#Right-Click to Enable WiFi Display#CRLF#Mid-Click to Reset Stats')
	SKIN:Bang(bSO,'MeterNetwork','RightMouseUpAction',bCM..' MeasureScript WON()')
	SKIN:Bang(bU)
end