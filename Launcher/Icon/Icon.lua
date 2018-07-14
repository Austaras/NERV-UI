function Initialize()
	bSO='!SetOption'
	bCM='!CommandMeasure'
	iF={0,0,0,0,0,0,0,0,0,0}
	sLP={}
	sEP={}
	sFP={}
	iLN=0
	while (type(SKIN:GetVariable('LauncherPath'..iLN+1))~='nil') do
		iLN=iLN+1
		sLP[iLN]=tostring(SKIN:GetVariable('LauncherPath'..iLN))
		sEP[iLN]=string.match(sLP[iLN],'(.*)\.[eE][xX][eE]')
		sFP[iLN]=string.gsub(sLP[iLN],'\\[^\\]*.[eE][xX][eE]','')
	end
	iPN=math.ceil(iLN/10)
	if iLN%10==0 then
		iPR=10
	else
		iPR=iLN%10
	end
	iLP=1
	D()
end

function Update()
	if iLP<iPN then
		iT=0
		for i=1,iS do
			iT=iT+iF[i]
		end
		if iT==iS then
			iLP=iLP+1
			iF={0,0,0,0,0,0,0,0,0,0}
			D()
		end
	end
end

function D()
	if iLP<iPN then
		iS=10
	else
		iS=iPR
	end
	for i=1,iS do
		if type(sEP[(iLP-1)*10+i])=='nil' then
			iF[i]=1
		else
			SKIN:Bang(bSO,'MeasureIcon'..i,'Path',sFP[(iLP-1)*10+i])
			SKIN:Bang(bSO,'MeasureIcon'..i,'Count',2)
			SKIN:Bang(bSO,'MeasureIcon'..i,'WildcardSearch',string.gsub(sEP[(iLP-1)*10+i],'.*%\\','')..'.exe')
			SKIN:Bang(bSO,'MeasureIcon'..i,'Index',2)
			SKIN:Bang(bSO,'MeasureIcon'..i,'Type','Icon')
			SKIN:Bang(bSO,'MeasureIcon'..i,'IconPath','#@#Images\\Icons\\Icon'..(iLP-1)*10+i..'.ico')
			SKIN:Bang(bSO,'MeasureIcon'..i,'IconSize','Large')
			SKIN:Bang(bSO,'MeasureIcon'..i,'FinishAction',bCM..' MeasureScript iF['..i..']=1')
			SKIN:Bang(bCM,'MeasureIcon'..i,'Update')
		end
	end
end