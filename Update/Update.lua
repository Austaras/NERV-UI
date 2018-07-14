function Initialize()
	bSO='!SetOption'
	bU='!Update'
	msU={SKIN:GetMeasure('MeasureUpdate1'),SKIN:GetMeasure('MeasureUpdate2'),SKIN:GetMeasure('MeasureUpdate3')}
	sUT={'deviantART','bbs.rainmeter.cn','Customize.org'}
	sUU={'http://xanci.deviantart.com/art/NERV-UI-Rainmeter-Suite-259921353','https://bbs.rainmeter.cn/thread-55213-1-1.html','http://customize.org/rainmeter/skins/65669740'}
	sV=tostring(SKIN:GetVariable('Version'))
	iV={string.match(sV,'(%d*).%d*.%d*'),string.match(sV,'%d*.(%d*).%d*'),string.match(sV,'%d*.%d*.(%d*)')}
	iO=4
end

function F(lU)
	if lU<=iO then
		sU=msU[lU]:GetStringValue()
		if (type(string.match(sU,'(%d*.%d*.%d*)'))~='nil') then
			iO=lU
			iU={string.match(sU,'(%d*).%d*.%d*'),string.match(sU,'%d*.(%d*).%d*'),string.match(sU,'%d*.%d*.(%d*)')}
			if  (iV[1]>iU[1])or((iV[1]==iU[1])and(iV[2]>iU[2]))or((iV[1]==iU[1])and(iV[2]==iU[2])and(iV[3]>=iU[3])) then
				SKIN:Bang(bSO,'MeterUpdate','Text','Latest#CRLF#Version')
			else
				SKIN:Bang(bSO,'MeterUpdate','Text','New#CRLF#Version#CRLF#'..sU)
			end
			SKIN:Bang(bSO,'MeterUpdate','ToolTipText','NERV UI Rainmeter Suite on '..sUT[lU]..'#CRLF#Mid-Click to Update Version Info','NERV UI\\Top')
			SKIN:Bang(bSO,'MeterUpdate','LeftMouseUpAction',sUU[lU],'NERV UI\\Top')
			SKIN:Bang(bU,'NERV UI\\Top')
			SKIN:Bang(bU)
		end
	end
end