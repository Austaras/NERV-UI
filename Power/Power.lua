function Initialize()
	bSW='!SetWallpaper'
	bSO='!SetOption'
	bWKV='!WriteKeyValue'
	bSV='!SetVariable'
	bSVG='!SetVariableGroup'
	bUG='!UpdateGroup'
	bCM='!CommandMeasure'
	msMAC=SKIN:GetMeasure('MeasureAC')
	msMC=SKIN:GetMeasure('MeasureCPU')
	sP=tostring(SKIN:GetVariable('AC'))
	sWP={tostring(SKIN:GetVariable('WallpaperB')),tostring(SKIN:GetVariable('WallpaperW'))}
	sPS={tostring(SKIN:GetVariable('PositionB')),tostring(SKIN:GetVariable('PositionW'))}
	sA={'B','W'}
	sC={'ON','OFF'}
	sB={'B','TC'}
	sT={'T','Life','Percent'}
	sO={'ImageTint','FontColor','FontColor'}
	iC=0
end

function Update()
	if iC==0 then
		iC=1
		SKIN:Bang(bSO,'MeterB1','ImageName','#@#Images\\B'..sP..'1')
		SKIN:Bang(bSO,'MeterB2','ImageName','#@#Images\\B'..sP..'2')
		if (tonumber(SKIN:GetVariable('Solid'..sP))==0) then
			if sP=='B' then
				T00()
			else
				T01()
			end
			for i=1,2 do
				SKIN:Bang(bSO,'Meter'..sB[i]..'1','ImageTint','#*FontColor3*#')
				SKIN:Bang(bSO,'Meter'..sB[i]..'2','ImageTint','#*FontColor3*#,51')
			end
		else
			if sP=='B' then
				T10()
			else
				T11()
			end
			for i=1,2 do
				SKIN:Bang(bSO,'Meter'..sB[i]..'1','ImageTint','#*FontColor1*#')
				SKIN:Bang(bSO,'Meter'..sB[i]..'2','ImageTint','#*FontColor3*#,#*Alpha*#')
			end
		end
	else
		if iP~=msMAC:GetValue() then
			iP=msMAC:GetValue()
			P(iP+1)
		end
		if iS~=tonumber(SKIN:GetVariable('Solid'..sA[iP+1])) then
			iS=tonumber(SKIN:GetVariable('Solid'..sA[iP+1]))
			S(iS)
		end
	end
	iMC=msMC:GetValue()
	SKIN:Bang(bSO,'MeterTC1','ImageName','#@#Images\\TT'..math.ceil(math.abs(math.log((iMC+1)/5)/(2*math.log(2))+1)))
	SKIN:Bang(bSO,'MeterTC2','ImageName','#@#Images\\TB'..math.ceil(math.abs(math.log((iMC+1)/5)/(2*math.log(2))+1)))
end

function P(lP)
	SKIN:Bang(bSW,sWP[lP],sPS[lP])
	SKIN:Bang(bWKV,'Variables','AC',sA[lP],'#VARFILE#')
	SKIN:Bang(bWKV,'Variables','FontColor1','#ColorText'..sA[lP]..'#,204','#VARFILE#')
	SKIN:Bang(bWKV,'Variables','FontColor2','#ColorText'..sA[lP]..'#','#VARFILE#')
	SKIN:Bang(bWKV,'Variables','FontColor3','#ColorBackground'..sA[lP]..'#','#VARFILE#')
	SKIN:Bang(bSVG,'FontColor1','#ColorText'..sA[lP]..'#,204','NonePower')
	SKIN:Bang(bSVG,'FontColor2','#ColorText'..sA[lP]..'#','NonePower')
	SKIN:Bang(bSVG,'FontColor3','#ColorBackground'..sA[lP]..'#','NonePower')
	SKIN:Bang(bSV,'FontColor1','#ColorText'..sA[lP]..'#,204')
	SKIN:Bang(bSV,'FontColor2','#ColorText'..sA[lP]..'#')
	SKIN:Bang(bSV,'FontColor3','#ColorBackground'..sA[lP]..'#')
	SKIN:Bang(bSO,'MeterB1','ImageName','#@#Images\\B'..sA[lP]..'1')
	SKIN:Bang(bSO,'MeterB2','ImageName','#@#Images\\B'..sA[lP]..'2')
	SKIN:Bang(bCM,'MeasureScript','sP=\''..sA[lP]..'\';P()','NERV UI\\Background')
	SKIN:Bang(bCM,'MeasureScript','sP=\''..sA[lP]..'\';MN'..sC[tonumber(SKIN:GetVariable('NERV'..sA[lP]))+1]..'();MS'..sC[tonumber(SKIN:GetVariable('Solid'..sA[lP]))+1]..'()','NERV UI\\Panel')
	SKIN:Bang(bUG,'NonePower')
	if (tonumber(SKIN:GetVariable('Solid'..sA[lP]))==0) then
		if lP==1 then
			T00()
		else
			T01()
		end
	else
		if lP==1 then
			T10()
		else
			T11()
		end
	end
end

function S(lS)
	if lS==0 then
		if iP==0 then
			T00()
		else
			T01()
		end
		for i=1,2 do
			SKIN:Bang(bSO,'Meter'..sB[i]..'1','ImageTint','#*FontColor3*#')
			SKIN:Bang(bSO,'Meter'..sB[i]..'2','ImageTint','#*FontColor3*#,51')
		end
	else
		if iP==0 then
			T10()
		else
			T11()
		end
		for i=1,2 do
			SKIN:Bang(bSO,'Meter'..sB[i]..'1','ImageTint','#*FontColor1*#')
			SKIN:Bang(bSO,'Meter'..sB[i]..'2','ImageTint','#*FontColor3*#,#*Alpha*#')
		end
	end
end

function T00()
	for i=1,3 do
		SKIN:Bang(bSO,'Meter'..sT[i],sO[i],'#*FontColor3*#')
	end
	SKIN:Bang(bSO,'MeterTB','ImageTint','#*FontColor3*#,51')
end

function T01()
	for i=1,3 do
		SKIN:Bang(bSO,'Meter'..sT[i],sO[i],'#*FontColor3*#,51')
	end
	SKIN:Bang(bSO,'MeterTB','ImageTint','0,0,0,0')
end

function T10()
	for i=1,3 do
		SKIN:Bang(bSO,'Meter'..sT[i],sO[i],'#*FontColor1*#')
	end
	SKIN:Bang(bSO,'MeterTB','ImageTint','#*FontColor3*#,#*Alpha*#')
end

function T11()
	for i=1,3 do
		SKIN:Bang(bSO,'Meter'..sT[i],sO[i],'#*FontColor3*#,#*Alpha*#')
	end
	SKIN:Bang(bSO,'MeterTB','ImageTint','0,0,0,0')
end