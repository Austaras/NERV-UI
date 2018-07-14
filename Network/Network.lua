function Initialize()
	bCM='!CommandMeasure'
	iC=0
	iO=0
end

function Update()
	if iC<1 then
		iC=iC+1
	elseif iC==1 then
		if (iO==0)and(tonumber(SKIN:GetVariable('NetworkWiFi'))==1) then
			iC=2
			SKIN:Bang(bCM,'MeasureScript','WON()','NERV UI\\Top')
		end
	end
end