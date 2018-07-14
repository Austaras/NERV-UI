function Initialize()
	bSO='!SetOption'
	bSOG='!SetOptionGroup'
	bWKV='!WriteKeyValue'
	bU='!Update'
	bRD='!Redraw'
	bSM='!ShowMeter'
	bHM='!HideMeter'
	bUMT='!UpdateMeter'
	bSMG='!ShowMeterGroup'
	bHMG='!HideMeterGroup'
	bUMTG='!UpdateMeterGroup'
	bCM='!CommandMeasure'
	iLP=tonumber(SKIN:GetVariable('LauncherPage'))
	iLT=tonumber(SKIN:GetVariable('LauncherType'))
	iLN=0
	while (type(SKIN:GetVariable('LauncherPath'..iLN+1))~='nil') do
		iLN=iLN+1
	end
	iPN=math.ceil(iLN/10)
	if iLN%10==0 then
		iPR=10
	else
		iPR=iLN%10
	end
	if iLP>iPN then iLP=1 end
	D()
	if tonumber(SKIN:GetVariable('Launcher'))==0 then
		iM=0
	else
		iM=iSL*2
	end
	iT=iM
end

function Update()
	if iM~=iT then
		iM=iM+math.abs(iT-iM)/(iT-iM)
		U()
		E()
	end
end

function M()
	if iM==0 then
		iT=iSL*2
	else
		iT=0
	end
	SKIN:Bang(bHMG,'Launcher','NERV UI\\Top')
	SKIN:Bang(bRD,'NERV UI\\Top')
	if sNP=='C' then SKIN:Bang(bHMG,'Page','NERV UI\\Launcher') end
end

function T()
	if iM>0 then
		for i=1,iS do
			SKIN:Bang(bHM,'MeterL'..iLT..i,'NERV UI\\Launcher')
		end
		iLT=iLT%3+1
		for i=1,iS do
			SKIN:Bang(bSM,'MeterL'..iLT..i,'NERV UI\\Launcher')
		end
		SKIN:Bang(bWKV,'Variables','LauncherType',iLT,'#VARFILE#')
	end
	SKIN:Bang(bRD,'NERV UI\\Launcher')
end

function U()
	if sNP=='C' then
		if iM==0 then
			SKIN:Bang(bHMG,'PageLabel','NERV UI\\Launcher')
			SKIN:Bang(bHM,'MeterB0','NERV UI\\Launcher')
		elseif (iM>0)and(iM<=2) then
			if iM==1 then
				SKIN:Bang(bSMG,'PageLabel','NERV UI\\Launcher')
				SKIN:Bang(bSM,'MeterB0','NERV UI\\Launcher')
			end
			SKIN:Bang(bSOG,'PageLabel','TransformationMatrix',(0.2+iM*0.4)..';0;0;'..(0.2+iM*0.4)..';'..((0.8-iM*0.4)*152)..';'..(0.8-iM*0.4)*66,'NERV UI\\Launcher')
			SKIN:Bang(bSO,'MeterB0','TransformationMatrix',(0.2+iM*0.4)..';0;0;'..(0.2+iM*0.4)..';'..((0.8-iM*0.4)*152)..';'..(0.8-iM*0.4)*66,'NERV UI\\Launcher')
			SKIN:Bang(bUMTG,'PageLabel','NERV UI\\Launcher')
			SKIN:Bang(bUMT,'MeterB0','NERV UI\\Launcher')
		end
	end
	for i=1,iS do
		iIL=math.ceil((i+2)/4)
		if (iIL-1)*4-2>0 then
			iI=i-((iIL-1)*4-2)
		else
			iI=i
		end
		if iM==iIL*2-2 then
			SKIN:Bang(bHM,'MeterB'..i,'NERV UI\\Launcher')
			SKIN:Bang(bHM,'MeterP'..i,'NERV UI\\Launcher')
			SKIN:Bang(bHM,'MeterL'..iLT..i,'NERV UI\\Launcher')
		elseif (iM>iIL*2-2)and(iM<=iIL*2) then
			if (iM==iIL*2-1)and(iM<iT) then
				SKIN:Bang(bSM,'MeterB'..i,'NERV UI\\Launcher')
				SKIN:Bang(bSM,'MeterP'..i,'NERV UI\\Launcher')
				SKIN:Bang(bSM,'MeterL'..iLT..i,'NERV UI\\Launcher')
			end
			SKIN:Bang(bSO,'MeterB'..i,'TransformationMatrix',(0.2+(iM-iIL*2+2)*0.4)..';0;0;'..(0.2+(iM-iIL*2+2)*0.4)..';'..(iI*57-19)*(0.8-(iM-iIL*2+2)*0.4)..';'..(33+iIL*66-math.abs(iI-2)*33)*(0.8-(iM-iIL*2+2)*0.4),'NERV UI\\Launcher')
			SKIN:Bang(bSO,'MeterP'..i,'TransformationMatrix',(0.2+(iM-iIL*2+2)*0.4)..';0;0;'..(0.2+(iM-iIL*2+2)*0.4)..';'..(iI*57-19)*(0.8-(iM-iIL*2+2)*0.4)..';'..(33+iIL*66-math.abs(iI-2)*33)*(0.8-(iM-iIL*2+2)*0.4),'NERV UI\\Launcher')
			SKIN:Bang(bSO,'MeterL'..iLT..i,'TransformationMatrix',(0.2+(iM-iIL*2+2)*0.4)..';0;0;'..(0.2+(iM-iIL*2+2)*0.4)..';'..(iI*57-19)*(0.8-(iM-iIL*2+2)*0.4)..';'..(33+iIL*66-math.abs(iI-2)*33)*(0.8-(iM-iIL*2+2)*0.4),'NERV UI\\Launcher')
			SKIN:Bang(bUMT,'MeterB'..i,'NERV UI\\Launcher')
			SKIN:Bang(bUMT,'MeterP'..i,'NERV UI\\Launcher')
			SKIN:Bang(bUMT,'MeterL'..iLT..i,'NERV UI\\Launcher')
		end
	end
	SKIN:Bang(bRD,'NERV UI\\Launcher')
end

function E()
	if iM==iT then
		if iM>0 then
			SKIN:Bang(bWKV,'Variables','Launcher',1,'#VARFILE#')
			SKIN:Bang(bSO,'MeterLauncher','ToolTipText','Close Launcher#CRLF#Right-Click to Switch Type','NERV UI\\Top')
			SKIN:Bang(bSO,'MeterLauncher','RightMouseUpAction',bCM..' MeasureScript T() \"NERV UI\\Launcher\\Ani\"','NERV UI\\Top')
			SKIN:Bang(bSMG,'Launcher','NERV UI\\Top')
			if iPN==1 then
				SKIN:Bang(bHMG,'Page','NERV UI\\Top')
			else
				SKIN:Bang(bSMG,'Page','NERV UI\\Launcher')
			end
			SKIN:Bang(bU,'NERV UI\\Top')
			SKIN:Bang(bSO,'MeterTag','FontColor','#*FontColor1*#','NERV UI\\Launcher')
			SKIN:Bang(bSO,'MeterTag','Text','CLOSE','NERV UI\\Launcher')
			SKIN:Bang(bUMT,'MeterTag','NERV UI\\Launcher')
			SKIN:Bang(bRD,'NERV UI\\Launcher')
		elseif sNP=='C' then
			SKIN:Bang(bWKV,'Variables','Launcher',0,'#VARFILE#')
			SKIN:Bang(bSO,'MeterLauncher','ToolTipText','Open Launcher','NERV UI\\Top')
			SKIN:Bang(bSO,'MeterLauncher','RightMouseUpAction','[]','NERV UI\\Top')
			SKIN:Bang(bSM,'MeterLauncher','NERV UI\\Top')
			SKIN:Bang(bU,'NERV UI\\Top')
			SKIN:Bang(bSO,'MeterTag','FontColor','#*FontColor1*#','NERV UI\\Launcher')
			SKIN:Bang(bSO,'MeterTag','Text','OPEN','NERV UI\\Launcher')
			SKIN:Bang(bUMT,'MeterTag','NERV UI\\Launcher')
			SKIN:Bang(bRD,'NERV UI\\Launcher')
		elseif sNP=='P' then
			iLP=(iLP+iPN-2)%iPN+1
			SKIN:Bang(bWKV,'Variables','LauncherPage',iLP,'#VARFILE#')
			SKIN:Bang(bCM,'MeasureScript','iLP='..iLP..';D()','NERV UI\\Launcher')
			D()
			iT=iSL*2
		elseif sNP=='N' then
			iLP=iLP%iPN+1
			SKIN:Bang(bWKV,'Variables','LauncherPage',iLP,'#VARFILE#')
			SKIN:Bang(bCM,'MeasureScript','iLP='..iLP..';D()','NERV UI\\Launcher')
			D()
			iT=iSL*2
		end
	end
end

function D()
	if iLP<iPN then
		iS=10
	else
		iS=iPR
	end
	iSL=math.ceil((iS+2)/4)
end