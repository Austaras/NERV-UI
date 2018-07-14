function Initialize()
	bSO='!SetOption'
	bWKV='!WriteKeyValue'
	bSV='!SetVariable'
	bU='!Update'
	bRD='!Redraw'
	bHM='!HideMeter'
	bUMT='!UpdateMeter'
	bHMG='!HideMeterGroup'
	bUMS='!UpdateMeasure'
	bCM='!CommandMeasure'
	iLP=tonumber(SKIN:GetVariable('LauncherPage'))
	iLT=tonumber(SKIN:GetVariable('LauncherType'))
	iRC={}
	sLP={}
	sLT={}
	sLI={}
	sLE={}
	iLN=0
	while (type(SKIN:GetVariable('LauncherPath'..iLN+1))~='nil') do
		iLN=iLN+1
		sLP[iLN]=tostring(SKIN:GetVariable('LauncherPath'..iLN))
		sEP=string.match(sLP[iLN],'(.*)\.[eE][xX][eE]')
		if type(SKIN:GetVariable('LauncherText'..iLN))=='nil' then
			if type(sEP)=='nil' then
				sLT[iLN]=''
			else
				sLT[iLN]=string.gsub(sEP,'.*%\\','')
			end
		else
			sLT[iLN]=tostring(SKIN:GetVariable('LauncherText'..iLN))
		end
		if type(SKIN:GetVariable('LauncherIcon'..iLN))=='nil' then
			if type(sEP)=='nil' then
				sLI[iLN]=''
			else
				sLI[iLN]='Icon'..iLN..'.ico'
			end
		else
			sLI[iLN]=tostring(SKIN:GetVariable('LauncherIcon'..iLN))
		end
		if type(SKIN:GetVariable('LauncherExe'..iLN))=='nil' then
			if type(sEP)=='nil' then
				sLE[iLN]=''
			else
				sLE[iLN]=string.gsub(sEP,'.*%\\','')
			end
		else
			sLE[iLN]=tostring(SKIN:GetVariable('LauncherExe'..iLN))
		end
	end
	iPN=math.ceil(iLN/10)
	if iLN%10==0 then
		iPR=10
	else
		iPR=iLN%10
	end
	if iPN==1 then
		SKIN:Bang(bHMG,'Page')
		SKIN:Bang(bSO,'MeterPageLabel','Text','Page')
	else
		SKIN:Bang(bSO,'MeterPageLabel','Text','Pages')
	end
	if iLP>iPN then
		iLP=1
		SKIN:Bang(bWKV,'Variables','LauncherPage',1,'#VARFILE#')
	end
	if iLP==iPN then
		for i=iPR+1,10 do
			SKIN:Bang(bHM,'MeterB'..i)
			SKIN:Bang(bHM,'MeterP'..i)
			for j=1,3 do
				SKIN:Bang(bHM,'MeterL'..j..i)
			end
		end
	end
	D()
	iR=0.8
	C()
	if tonumber(SKIN:GetVariable('Launcher'))==0 then
		for i=1,iS do
			SKIN:Bang(bHM,'MeterB'..i)
			SKIN:Bang(bHM,'MeterP'..i)
			for j=1,3 do
				SKIN:Bang(bHM,'MeterL'..j..i)
			end
		end
		SKIN:Bang(bHMG,'Page')
		SKIN:Bang(bHMG,'PageLabel')
		SKIN:Bang(bHM,'MeterB0')
		SKIN:Bang(bSO,'MeterTag','Text','OPEN')
	else
		for i=1,iS do
			SKIN:Bang(bHM,'MeterL'..(iLT%3+1)..i)
			SKIN:Bang(bHM,'MeterL'..((iLT+1)%3+1)..i)
		end
	end
end

function Update()
	if (sFC~=tostring(SKIN:GetVariable('FontColor2')))or(sSC~=tostring(SKIN:GetVariable('FontColor3'))) then
		C()
	end
end

function O(lM)
	iR=1
	CM(lM,iR)
	SKIN:Bang(bUMT,lM)
	SKIN:Bang(bRD)
end

function L(lM)
	iR=0.8
	CM(lM,iR)
	SKIN:Bang(bUMT,lM)
	SKIN:Bang(bRD)
end

function D()
	if iLP<iPN then
		iS=10
	else
		iS=iPR
	end
	for i=1,iS do
		SKIN:Bang(bSO,'MeasureProcess'..i,'ProcessName',sLE[(iLP-1)*10+i]..'.exe','NERV UI\\Launcher\\Process')
		SKIN:Bang(bUMS,'MeasureProcess'..i,'NERV UI\\Launcher\\Process')
		SKIN:Bang(bSO,'MeterL1'..i,'Text',sLT[(iLP-1)*10+i])
		if sLI[(iLP-1)*10+i]=='' then
			SKIN:Bang(bSO,'MeterL2'..i,'ImageName','')
			SKIN:Bang(bSO,'MeterL3'..i,'ImageName','')
		else
			SKIN:Bang(bSO,'MeterL2'..i,'ImageName','#@#Images\\Icons\\'..sLI[(iLP-1)*10+i])
			SKIN:Bang(bSO,'MeterL3'..i,'ImageName','#@#Images\\Icons\\'..sLI[(iLP-1)*10+i])
		end
		for j=1,3 do
			SKIN:Bang(bSO,'MeterL'..j..i,'TransformationMatrix','1;0;0;1;0;0')
			SKIN:Bang(bSO,'MeterL'..j..i,'LeftMouseUpAction','\"'..sLP[(iLP-1)*10+i]..'\"')
			SKIN:Bang(bUMT,'MeterL'..j..i)
		end
	end
	SKIN:Bang(bCM,'MeasureScript','iO=1','NERV UI\\Launcher\\Process')
	SKIN:Bang(bU,'NERV UI\\Launcher\\Process')
	SKIN:Bang(bSO,'MeterPage','Text',iLP..'/'..iPN)
	SKIN:Bang(bUMT,'MeterPage')
end

function C()
	sFC=tostring(SKIN:GetVariable('FontColor2'))
	sSC=tostring(SKIN:GetVariable('FontColor3'))
	iFC={string.match(sFC,'(%d*),%d*,%d*'),string.match(sFC,'%d*,(%d*),%d*'),string.match(sFC,'%d*,%d*,(%d*)')}
	iSC={string.match(sSC,'(%d*),%d*,%d*'),string.match(sSC,'%d*,(%d*),%d*'),string.match(sSC,'%d*,%d*,(%d*)')}
	for i=1,3 do
		iRC[i]=iFC[i]-iSC[i]
		iFC[i]=iFC[i]/255
	end
	iRS=math.abs(iRC[1])+math.abs(iRC[2])+math.abs(iRC[3])
	iVC=1
	for i=1,3 do
		iRC[i]=iRC[i]/iRS
		if iRC[i]<0 then iVC=iVC+iRC[i] end
	end
	for i=1,iS do
		CM('MeterL2'..i,iR)
	end
end

function CM(lM,lR)
	for i=1,3 do
		SKIN:Bang(bSO,lM,'ColorMatrix'..i,'0;0;0;'..lR*iRC[i]..';0')
	end
	SKIN:Bang(bSO,lM,'ColorMatrix4','0;0;0;'..lR..';0')
	SKIN:Bang(bSO,lM,'ColorMatrix5',iFC[1]..';'..iFC[2]..';'..iFC[3]..';'..-lR*iVC..';1')
end