function Initialize()
	bSO='!SetOption'
	bSOG='!SetOptionGroup'
	bWKV='!WriteKeyValue'
	bSV='!SetVariable'
	bSVG='!SetVariableGroup'
	bU='!Update'
	bRD='!Redraw'
	bSM='!ShowMeter'
	bHM='!HideMeter'
	bUMT='!UpdateMeter'
	bTMG='!ToggleMeterGroup'
	bUMTG='!UpdateMeterGroup'
	bCM='!CommandMeasure'
	msMC=SKIN:GetMeasure('MeasureCover')
	msMS=SKIN:GetMeasure('MeasureState')
	msMO=SKIN:GetMeasure('MeasureStatus')
	msMV=SKIN:GetMeasure('MeasureVolume')
	mtMP=SKIN:GetMeter('MeterPosition')
	mtMD=SKIN:GetMeter('MeterDuration')
	iP=tonumber(SKIN:GetVariable('Player'))
	sM={'Title','Artist','Album'}
	sS={'Play','Pause','Play'}
	sT={'Mute','Resume'}
	msM={}
	mtM={}
	iC={}
	iRC={}
	sMT={}
	sP={}
	sPP={}
	sPT={}
	iPN=0
	for i=1,3 do
		msM[i]=SKIN:GetMeasure('Measure'..sM[i])
		mtM[i]=SKIN:GetMeter('Meter'..sM[i]..'Test')
	end
	while type(SKIN:GetVariable('Player'..iPN+1))~='nil' do
		iPN=iPN+1
		sP[iPN]=tostring(SKIN:GetVariable('Player'..iPN))
		if type(SKIN:GetVariable('PlayerPath'..iPN))=='nil' then
			sPP[iPN]=''
		else
			sPP[iPN]=tostring(SKIN:GetVariable('PlayerPath'..iPN))
		end
		if type(SKIN:GetVariable('PlayerText'..iPN))=='nil' then
			sPT[iPN]=sP[iPN]
		else
			sPT[iPN]=tostring(SKIN:GetVariable('PlayerText'..iPN))
		end
	end
	if iP>iPN then
		iP=1
		SKIN:Bang(bWKV,'Variables','Player',1,'#VARFILE#')
	end
	if tonumber(SKIN:GetVariable('PlayerCover'))==0 then SKIN:Bang(bTMG,'Cover') end
	SKIN:Bang(bSO,'MeterTag','Text',sPT[iP])
	iR=0.8
	C()
	iPO=-1
	iVP=100
end

function Update()
	if sMC~=msMC:GetStringValue() then
		sMC=msMC:GetStringValue()
		if sMC=='' then
			iMC=0
		else
			iMC=1
		end	
	end
	if iCL~=iMC then
		iCL=iMC
		iTL=254-57*iCL
		iMP=0
		iMD=0
		SKIN:Bang(bSVG,'TextL',iTL,'NonePower')
		SKIN:Bang(bSVG,'PlayerCover',56*iCL,'NonePower')
		for i=1,3 do
			SKIN:Bang(bSO,'Meter'..sM[i],'W',iTL)
			SKIN:Bang(bUMT,'Meter'..sM[i])
		end
		SKIN:Bang(bSO,'MeterDuration','X',26+iTL)
		SKIN:Bang(bSO,'MeterProgress','W','('..(iTL-3)..'-[MeterPosition:W]-[MeterDuration:W])')
	else
		for i=1,3 do
			if sMT[i]~=msM[i]:GetStringValue() then
				sMT[i]=msM[i]:GetStringValue()
				iC[i]=2
				SKIN:Bang(bSO,'Meter'..sM[i]..'Test','Text',sMT[i])
			end
			if iC[i]==1 then
				iC[i]=0
				if mtM[i]:GetW()<iTL then
					SKIN:Bang(bSVG,sM[i],'','NonePower')
				else
					SKIN:Bang(bSVG,sM[i],sMT[i],'NonePower')
				end
			elseif iC[i]==2 then
				iC[i]=1
			end
		end
	end
	if iST~=msMS:GetValue() then
		iST=msMS:GetValue()
		SKIN:Bang(bSVG,'State',sS[iST+1],'NonePower')
		SKIN:Bang(bSO,'MeterPP','ImageName','#@#Images\\'..sS[iST+1])
	end
	if iPO~=msMO:GetValue() then
		iPO=msMO:GetValue()
		if iPO==0 then
			iMA=51
			SKIN:Bang(bHM,'MeterVolume')
		else
			iMA=204
			SKIN:Bang(bSM,'MeterVolume')
		end
		SKIN:Bang(bSOG,'Control','ImageAlpha',iMA)
	end
	if iMV~=msMV:GetValue() then
		iMV=msMV:GetValue()
		if iMV>0 then
			iMM=1
			iVP=iMV
		else
			iMM=2
		end	
	end
	if iMS~=iMM then
		iMS=iMM
		SKIN:Bang(bSVG,'Mute',sT[iMS],'NonePower')
	end
	if (iMP~=mtMP:GetW())or(iMD~=mtMD:GetW()) then
		iMP=mtMP:GetW()
		iMD=mtMD:GetW()
		SKIN:Bang(bSVG,'Position',155+iMP,'NonePower')
		SKIN:Bang(bSVG,'Duration',iTL+5-iMP-iMD,'NonePower')
	end
	if (sFC~=tostring(SKIN:GetVariable('FontColor2')))or(sSC~=tostring(SKIN:GetVariable('FontColor3'))) then
		C()
	end
end

function T()
	iP=iP%iPN+1
	SKIN:Bang(bWKV,'Variables','Player',iP,'#VARFILE#')
	SKIN:Bang(bSO,'MeterPlayer','ToolTipText','Open '..sPT[iP]..'#CRLF#Right-Click to Use '..sPT[iP%iPN+1],'NERV UI\\Top')
	SKIN:Bang(bU,'NERV UI\\Top')
	SKIN:Bang(bSO,'MeasureArtist','PlayerName',sP[iP])
	SKIN:Bang(bSO,'MeasureArtist','PlayerPath',sPP[iP])
	SKIN:Bang(bSO,'MeterTag','Text',sPT[iP])
	SKIN:Bang(bU)
end

function P(lX)
	if lX<4 then
		SKIN:Bang(bCM,'MeasureArtist','SetPosition 0')
	else
		SKIN:Bang(bCM,'MeasureArtist','SetPosition '..(lX-4)*100/(iTL-3-iMP-iMD))
	end
	SKIN:Bang(bU)
end

function V(lX)
	if lX<4 then
		SKIN:Bang(bCM,'MeasureArtist','SetVolume 0')
	else
		SKIN:Bang(bCM,'MeasureArtist','SetVolume '..(lX-4)*100/52)
	end
	SKIN:Bang(bU)
end

function M()
	if iMV>0 then
		SKIN:Bang(bCM,'MeasureArtist','SetVolume 0')
	else
		SKIN:Bang(bCM,'MeasureArtist','SetVolume '..iVP)
	end
	SKIN:Bang(bU)
end

function CO()
	iR=1
	CM(iR)
	SKIN:Bang(bSO,'MeterCoverColor','ImageAlpha',255)
	SKIN:Bang(bUMTG,'Cover')
	SKIN:Bang(bRD)
end

function CL()
	iR=0.8
	CM(iR)
	SKIN:Bang(bSO,'MeterCoverColor','ImageAlpha',204)
	SKIN:Bang(bUMTG,'Cover')
	SKIN:Bang(bRD)
end

function VO()
	SKIN:Bang(bSO,'MeterVolumeBar','ImageAlpha',255)
	SKIN:Bang(bSO,'MeterVolumeBarSolid','ImageAlpha',64)
	SKIN:Bang(bUMTG,'Volume')
	SKIN:Bang(bRD)
end

function VL()
	SKIN:Bang(bSO,'MeterVolumeBar','ImageAlpha',191)
	SKIN:Bang(bSO,'MeterVolumeBarSolid','ImageAlpha',51)
	SKIN:Bang(bUMTG,'Volume')
	SKIN:Bang(bRD)
end

function MO(lM)
	SKIN:Bang(bSO,lM,'ImageAlpha',1.25*iMA)
	SKIN:Bang(bUMT,lM)
	SKIN:Bang(bRD)
end

function ML(lM)
	SKIN:Bang(bSO,lM,'ImageAlpha',iMA)
	SKIN:Bang(bUMT,lM)
	SKIN:Bang(bRD)
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
	CM(iR)
end

function CM(lR)
	for i=1,3 do
		SKIN:Bang(bSO,'MeterCover','ColorMatrix'..i,'0;0;0;'..lR*iRC[i]..';0')
	end
	SKIN:Bang(bSO,'MeterCover','ColorMatrix4','0;0;0;'..lR..';0')
	SKIN:Bang(bSO,'MeterCover','ColorMatrix5',iFC[1]..';'..iFC[2]..';'..iFC[3]..';'..-lR*iVC..';1')
end