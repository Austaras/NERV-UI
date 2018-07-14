function Initialize()
	bSO='!SetOption'
	bRD='!Redraw'
	bUMT='!UpdateMeter'
	iLP=tonumber(SKIN:GetVariable('LauncherPage'))
	msMP={}
	iMP={}
	sLP={}
	sLE={}
	for i=1,10 do
		msMP[i]=SKIN:GetMeasure('MeasureProcess'..i)
	end
	iLN=0
	while (type(SKIN:GetVariable('LauncherPath'..iLN+1))~='nil') do
		iLN=iLN+1
		sLP[iLN]=tostring(SKIN:GetVariable('LauncherPath'..iLN))
		sEP=string.match(sLP[iLN],'(.*)\.[eE][xX][eE]')
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
	if iLP>iPN then iLP=1 end
	if iLP<iPN then
		iS=10
	else
		iS=iPR
	end
	for i=1,iS do
		SKIN:Bang(bSO,'MeasureProcess'..i,'ProcessName',sLE[(iLP-1)*10+i]..'.exe')
	end
	iC=0
	iO=0
end

function Update()
	if iO==1 then
		for i=1,10 do
			if iMP[i]~=msMP[i]:GetValue() then
				iMP[i]=msMP[i]:GetValue()
				iC=1
				if iMP[i]==1 then
					SKIN:Bang(bSO,'MeterP'..i,'ImageName','#@#Images\\On','NERV UI\\Launcher')
				else
					SKIN:Bang(bSO,'MeterP'..i,'ImageName','','NERV UI\\Launcher')
				end
				SKIN:Bang(bUMT,'MeterP'..i,'NERV UI\\Launcher')
			end
		end
		if iC==1 then
			SKIN:Bang(bRD,'NERV UI\\Launcher')
			iC=0
		end
	end
end