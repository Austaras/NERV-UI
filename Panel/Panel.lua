function Initialize()
	bSO='!SetOption'
	bWKV='!WriteKeyValue'
	bSV='!SetVariable'
	bSVG='!SetVariableGroup'
	bU='!Update'
	bUG='!UpdateGroup'
	bRD='!Redraw'
	bUMT='!UpdateMeter'
	bUMTG='!UpdateMeterGroup'
	bCM='!CommandMeasure'
	sP=tostring(SKIN:GetVariable('AC'))
	SKIN:Bang(bSO,'MeterAlpha'..(1+tonumber(SKIN:GetVariable('AlphaTrans'..sP))/51),'FontColor','#*FontColor1*#')
	if tonumber(SKIN:GetVariable('NERV'..sP))==0 then
		INON()
	else
		INOFF()
	end
	if tonumber(SKIN:GetVariable('Solid'..sP))==0 then
		ISON()
	else
		ISOFF()
	end
end

function CT()
	SKIN:Bang('\"#@#Addons\\RainRGB4.exe\" \"VarName=ColorText'..sP..'\" \"FileName=#VARFILE#\"')
end

function CB()
	SKIN:Bang('\"#@#Addons\\RainRGB4.exe\" \"VarName=ColorBackground'..sP..'\" \"FileName=#VARFILE#\"')
end

function LA(lA)
	SKIN:Bang(bSO,'MeterAlpha'..(1+lA/51),'FontColor','#*FontColor2*#,51')
	SKIN:Bang(bSO,'MeterAlpha'..(1+tonumber(SKIN:GetVariable('Alpha'..sP))/51),'FontColor','#*FontColor1*#')
	SKIN:Bang(bU)
end

function MA(lA)
	SKIN:Bang(bSO,'MeterAlpha'..(1+tonumber(SKIN:GetVariable('Alpha'..sP))/51),'FontColor','#*FontColor2*#,51')
	SKIN:Bang(bWKV,'Variables','Alpha',lA,'#VARFILE#')
	SKIN:Bang(bWKV,'Variables','Alpha'..sP,lA,'#VARFILE#')
	SKIN:Bang(bWKV,'Variables','AlphaTrans'..sP,lA,'#VARFILE#')
	SKIN:Bang(bSVG,'Alpha',lA,'Background')
	SKIN:Bang(bUG,'Background')
	SKIN:Bang(bUMTG,'B','NERV UI\\Launcher\\Ani')
	SKIN:Bang(bUMT,'MeterWiFi','NERV UI\\Network\\Ani')
	SKIN:Bang(bUMT,'MeterForecast','NERV UI\\Weather\\Ani')
	SKIN:Bang(bRD,'NERV UI\\Launcher')
	SKIN:Bang(bRD,'NERV UI\\Network\\Ani')
	SKIN:Bang(bRD,'NERV UI\\Weather\\Ani')
	SKIN:Bang(bSV,'Alpha'..sP,lA)
	SKIN:Bang(bSV,'AlphaTrans'..sP,lA)
	SKIN:Bang(bSO,'MeterAlpha'..(1+lA/51),'FontColor','#*FontColor2*#')
	SKIN:Bang(bU)
end

function MNON()
	SKIN:Bang(bWKV,'Variables','NERV'..sP,0,'#VARFILE#')
	SKIN:Bang(bSVG,'NERV'..sP,0,'Background')
	SKIN:Bang(bCM,'MeasureScript','P()','NERV UI\\Background')
	SKIN:Bang(bRD,'NERV UI\\Background')
	INON()
	SKIN:Bang(bU)
end

function MNOFF()
	SKIN:Bang(bWKV,'Variables','NERV'..sP,1,'#VARFILE#')
	SKIN:Bang(bSVG,'NERV'..sP,1,'Background')
	SKIN:Bang(bCM,'MeasureScript','P()','NERV UI\\Background')
	SKIN:Bang(bRD,'NERV UI\\Background')
	INOFF()
	SKIN:Bang(bU)
end

function MSON()
	SKIN:Bang(bWKV,'Variables','Alpha',255,'#VARFILE#')
	SKIN:Bang(bWKV,'Variables','Solid'..sP,0,'#VARFILE#')
	SKIN:Bang(bWKV,'Variables','Alpha'..sP,255,'#VARFILE#')
	SKIN:Bang(bSVG,'Alpha',255,'Background')
	SKIN:Bang(bSVG,'Solid'..sP,0,'Background')
	SKIN:Bang(bCM,'MeasureScript','P()','NERV UI\\Background')
	SKIN:Bang(bUG,'Background')
	SKIN:Bang(bUMTG,'B','NERV UI\\Launcher\\Ani')
	SKIN:Bang(bUMT,'MeterWiFi','NERV UI\\Network\\Ani')
	SKIN:Bang(bUMT,'MeterForecast','NERV UI\\Weather\\Ani')
	SKIN:Bang(bRD,'NERV UI\\Launcher')
	SKIN:Bang(bRD,'NERV UI\\Network\\Ani')
	SKIN:Bang(bRD,'NERV UI\\Weather\\Ani')
	SKIN:Bang(bSV,'Alpha'..sP,255)
	ISON()
	SKIN:Bang(bU)
end

function MSOFF()
	iAT=tonumber(SKIN:GetVariable('AlphaTrans'..sP))
	SKIN:Bang(bWKV,'Variables','Alpha',iAT,'#VARFILE#')
	SKIN:Bang(bWKV,'Variables','Solid'..sP,1,'#VARFILE#')
	SKIN:Bang(bWKV,'Variables','Alpha'..sP,iAT,'#VARFILE#')
	SKIN:Bang(bSVG,'Alpha',iAT,'Background')
	SKIN:Bang(bSVG,'Solid'..sP,1,'Background')
	SKIN:Bang(bCM,'MeasureScript','P()','NERV UI\\Background')
	SKIN:Bang(bUG,'Background')
	SKIN:Bang(bUMTG,'B','NERV UI\\Launcher\\Ani')
	SKIN:Bang(bUMT,'MeterWiFi','NERV UI\\Network\\Ani')
	SKIN:Bang(bUMT,'MeterForecast','NERV UI\\Weather\\Ani')
	SKIN:Bang(bRD,'NERV UI\\Launcher')
	SKIN:Bang(bRD,'NERV UI\\Network\\Ani')
	SKIN:Bang(bRD,'NERV UI\\Weather\\Ani')
	SKIN:Bang(bSV,'Alpha'..sP,iAT)
	ISOFF()
	SKIN:Bang(bU)
end

function INON()
	SKIN:Bang(bSO,'MeterNERV','Text','ON')
	SKIN:Bang(bSO,'MeterNERV','ToolTipText','Turn Off NERV Icon')
	SKIN:Bang(bSO,'MeterNERV','LeftMouseUpAction',bCM..' MeasureScript MNOFF()')
end

function INOFF()
	SKIN:Bang(bSO,'MeterNERV','Text','OFF')
	SKIN:Bang(bSO,'MeterNERV','ToolTipText','Turn On NERV Icon')
	SKIN:Bang(bSO,'MeterNERV','LeftMouseUpAction',bCM..' MeasureScript MNON()')
end

function ISON()
	SKIN:Bang(bSO,'MeterSolid','Text','ON')
	SKIN:Bang(bSO,'MeterSolid','ToolTipText','Turn Off Solid Background')
	SKIN:Bang(bSO,'MeterSolid','LeftMouseUpAction',bCM..' MeasureScript MSOFF()')
	SKIN:Bang(bSO,'MeterAlphaLabel','FontColor','#*FontColor2*#,51')
	for i=1,6 do
		SKIN:Bang(bSO,'MeterAlpha'..i,'FontColor','#*FontColor2*#,51')
		SKIN:Bang(bSO,'MeterAlpha'..i,'MouseOverAction','')
		SKIN:Bang(bSO,'MeterAlpha'..i,'MouseLeaveAction','')
		SKIN:Bang(bSO,'MeterAlpha'..i,'LeftMouseUpAction','')
	end
end

function ISOFF()
	SKIN:Bang(bSO,'MeterSolid','Text','OFF')
	SKIN:Bang(bSO,'MeterSolid','ToolTipText','Turn On Solid Background')
	SKIN:Bang(bSO,'MeterSolid','LeftMouseUpAction',bCM..' MeasureScript MSON()')
	SKIN:Bang(bSO,'MeterAlphaLabel','FontColor','#*FontColor1*#')
	for i=1,6 do
		SKIN:Bang(bSO,'MeterAlpha'..i,'FontColor','#*FontColor2*#,51')
		SKIN:Bang(bSO,'MeterAlpha'..i,'MouseOverAction','['..bSO..' #*CURRENTSECTION*# FontColor #*FontColor2*#]['..bU..']')
		SKIN:Bang(bSO,'MeterAlpha'..i,'MouseLeaveAction',bCM..' MeasureScript LA('..((i-1)*51)..')')
		SKIN:Bang(bSO,'MeterAlpha'..i,'LeftMouseUpAction',bCM..' MeasureScript MA('..((i-1)*51)..')')
	end
	SKIN:Bang(bSO,'MeterAlpha'..(1+tonumber(SKIN:GetVariable('Alpha'..sP))/51),'FontColor','#*FontColor1*#')
end