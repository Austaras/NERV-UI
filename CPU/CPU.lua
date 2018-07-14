function Initialize()
	bSO='!SetOption'
	bTMG='!ToggleMeterGroup'
	sCTU={'C','F'}
	if tonumber(SKIN:GetVariable('CPUTemp'))==0 then SKIN:Bang(bTMG,'Temp') end
	if tostring(SKIN:GetVariable('CPUTempUnit'))=='C' then
		iCTU=1
	else
		iCTU=2
	end
	SKIN:Bang(bSO,'MeasureCalcTemp','Formula','(MeasureTemp-#MinCPUTemp'..sCTU[iCTU]..'#)/(#MaxCPUTemp'..sCTU[iCTU]..'#-#MinCPUTemp'..sCTU[iCTU]..'#)')
end