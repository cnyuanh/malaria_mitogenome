rm(list=ls())

"cnvrt.coords" <-function(x,y=NULL){
  xy <- xy.coords(x,y, recycle=TRUE)
  cusr <- par('usr')
  cplt <- par('plt')	
  plt <- list()
  plt$x <- (xy$x-cusr[1])/(cusr[2]-cusr[1])
  plt$y <- (xy$y-cusr[3])/(cusr[4]-cusr[3])
  fig <- list()
  fig$x <- plt$x*(cplt[2]-cplt[1])+cplt[1]
  fig$y <- plt$y*(cplt[4]-cplt[3])+cplt[3]
  return( list(fig=fig) )
}

subplot <- function(fun, x, y=NULL){
  old.par <- par(no.readonly=TRUE)
  on.exit(par(old.par))
  xy <- xy.coords(x,y)
  xy <- cnvrt.coords(xy)$fig
  par(plt=c(xy$x,xy$y), new=TRUE)
  fun
  tmp.par <- par(no.readonly=TRUE)
  return(invisible(tmp.par))
}

gap <- read.csv("Results/gap_stats.csv", header=TRUE)

gap.expanded <- gap[rep(row.names(gap),gap$Count),1:2]
count <- table(gap.expanded$Nucleotide,gap.expanded$Conce_Position)

lower=c(0,80)
upper=c(340,360)
y_outer=21

lowspan=c(0,11)
topspan=c(lowspan[2]+1,21)

ylabel="Repetitions"
legendtext=c('A','C','T')

png("Results/Insert_freq.png",width=1000,height=600)
  plot(c(0,1),c(0,y_outer),type='n',axes=FALSE,ylab=ylabel,xlab="Position in the concensus")
  subplot(barplot(count,col=heat.colors(3),ylim=lower,xpd=FALSE,las=3),x=c(0,1),y=lowspan)
  subplot(barplot(count,col=heat.colors(3),ylim=upper,xpd=FALSE,names.arg=vector(mode="character",length=length(colnames(count)))), x=c(0,1),y=topspan)

  legend("topright",legendtext,fill=heat.colors(3))
dev.off()
