function Initialize()
	bSO='!SetOption'
	bSV='!SetVariable'
	bRD='!Redraw'
	bSM='!ShowMeter'
	bHM='!HideMeter'
	bUMT='!UpdateMeter'
	bMM='!MoveMeter'
	bUMS='!UpdateMeasure'
	if tonumber(SKIN:GetVariable('NetworkWiFi'))==0 then SKIN:Bang(bHM,'MeterWiFi') end
	SKIN:Bang(bSV,'M',0)
	iM=0
	iT=0
end

function Update()
	if iM~=iT then
		iM=iM+math.abs(iT-iM)/(iT-iM)
		U()
		E()
	end
end

function M(lW)
	if iT~=lW then
		iT=lW
		SKIN:Bang(bSO,'MeasureWiFi','UpdateDivider',1)
		SKIN:Bang(bSO,'MeterWiFi','UpdateDivider',1)
		SKIN:Bang(bUMS,'MeasureWiFi')
		SKIN:Bang(bUMT,'MeterWiFi')
	end
end

function U()
	SKIN:Bang(bSV,'M',iM)
	if (iM==1)and(iM>iT) then
		SKIN:Bang(bHM,'MeterQuality5','NERV UI\\Network\\WiFi')
		SKIN:Bang(bRD,'NERV UI\\Network\\WiFi')
	elseif iM>1 then
		if (iM==2)and(iM<iT) then
			SKIN:Bang(bSM,'MeterQuality5','NERV UI\\Network\\WiFi')
		elseif (iM==2)and(iM>iT) then
			SKIN:Bang(bHM,'MeterQuality4','NERV UI\\Network\\WiFi')
		else
			if (iM==3)and(iM<iT) then
				SKIN:Bang(bSM,'MeterQuality4','NERV UI\\Network\\WiFi')
			elseif (iM==3)and(iM>iT) then
				SKIN:Bang(bHM,'MeterQuality3','NERV UI\\Network\\WiFi')
			else
				if (iM==4)and(iM<iT) then
					SKIN:Bang(bSM,'MeterQuality3','NERV UI\\Network\\WiFi')
				elseif (iM==4)and(iM>iT) then
					SKIN:Bang(bHM,'MeterQuality2','NERV UI\\Network\\WiFi')
					SKIN:Bang(bHM,'MeterWiFiLabel','NERV UI\\Network\\WiFi')
					SKIN:Bang(bHM,'MeterEncryption','NERV UI\\Network\\WiFi')
				else
					if (iM==5)and(iM<iT) then
						SKIN:Bang(bSM,'MeterQuality2','NERV UI\\Network\\WiFi')
						SKIN:Bang(bSM,'MeterWiFiLabel','NERV UI\\Network\\WiFi')
						SKIN:Bang(bSM,'MeterEncryption','NERV UI\\Network\\WiFi')
					elseif (iM==5)and(iM>iT) then
						SKIN:Bang(bHM,'MeterQuality1','NERV UI\\Network\\WiFi')
						SKIN:Bang(bHM,'MeterSSID','NERV UI\\Network\\WiFi')
					else
						SKIN:Bang(bSM,'MeterQuality1','NERV UI\\Network\\WiFi')
						SKIN:Bang(bSM,'MeterSSID','NERV UI\\Network\\WiFi')
					end
					SKIN:Bang(bMM,-34+iM*76/8,36,'MeterQuality2','NERV UI\\Network\\WiFi')
					SKIN:Bang(bMM,-19+iM*76/8,5,'MeterWiFiLabel','NERV UI\\Network\\WiFi')
					SKIN:Bang(bMM,-19+iM*76/8,47,'MeterEncryption','NERV UI\\Network\\WiFi')
				end
				SKIN:Bang(bMM,-24+iM*76/8,30,'MeterQuality3','NERV UI\\Network\\WiFi')
			end
			SKIN:Bang(bMM,-14+iM*76/8,24,'MeterQuality4','NERV UI\\Network\\WiFi')
		end
		SKIN:Bang(bMM,-4+iM*76/8,18,'MeterQuality5','NERV UI\\Network\\WiFi')
		SKIN:Bang(bRD,'NERV UI\\Network\\WiFi')
	end
end

function E()
	if iM==iT then
		SKIN:Bang(bSO,'MeasureWiFi','UpdateDivider',50)
		SKIN:Bang(bSO,'MeterWiFi','UpdateDivider',50)
	end
end