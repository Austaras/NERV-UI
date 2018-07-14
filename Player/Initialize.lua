function Initialize()
	bSO='!SetOption'
	iP=tonumber(SKIN:GetVariable('Player'))
	sP={}
	sPP={}
	iPN=0
	while type(SKIN:GetVariable('Player'..iPN+1))~='nil' do
		iPN=iPN+1
		sP[iPN]=tostring(SKIN:GetVariable('Player'..iPN))
		if type(SKIN:GetVariable('PlayerPath'..iPN))=='nil' then
			sPP[iPN]=''
		else
			sPP[iPN]=tostring(SKIN:GetVariable('PlayerPath'..iPN))
		end
	end
	if iP>iPN then iP=1 end
	SKIN:Bang(bSO,'MeasureArtist','PlayerName',sP[iP])
	SKIN:Bang(bSO,'MeasureArtist','PlayerPath',sPP[iP])
end