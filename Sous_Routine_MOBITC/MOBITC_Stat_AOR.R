#verif utf-8
#version 18-12-2020
#réalisée par C Trmal Cerema

MOBITC_Stat_AOR<-function(distTDC,numdateTDC,IC,datex,numdateprosp)
{
	if (length(distTDC)>1)
	{
		Combi=combn(seq(1,length(distTDC)),2)

		for (icomb in 1 : ncol(Combi))
		{
		model=lm(distTDC[Combi[,icomb]] ~ numdateTDC[Combi[,icomb]])
		
			if (icomb==1)
			{
				resi=cbind(coef(model)[2],coef(model)[1])
			} else {
				resi=rbind(resi,cbind(coef(model)[2],coef(model)[1]))
			}
		}
		row.names(resi) <- 1:nrow(resi)
		colnames(resi)[2]="bi"
		colnames(resi)[1]="ai"

		res=mean(resi[,1],na.rm = TRUE)*datex+mean(resi[,2],na.rm = TRUE)
	colnames(res)[1]="AORfit"
	taux=round(mean(resi[,1],na.rm = TRUE)*365.25*24*3600,digits=2)
	} else {
	taux=NA
	res=cbind(NA*seq(1,1,length=length(datex[,1])))
	}

	return(list(taux,res))
}