#Guillame's LibDiversity has a bug/issue when calculating Tajima's D, Fu_and_Li's D and Fu_and_Li's F of three sequences. If haplotype > 1, the program doesn't report values for these statistics. If, however, haplotype = 1, the program reports 0. Consider using data=data[which(data$N_sequeces > 3),] in construc_plot_gt_3 to exclude such zeros from the plot.

construc_plot_gt_3 <- function(data_set,stats,sha,col){
    ggplot(data=data_set[which(data_set$N_sequences > 3),], aes_string(x="N_sequences",y=stats,color="species",shape="species")) +
    geom_point() +
    guides(color=guide_legend(ncol=2)) +
    scale_shape_manual("",values=sha,drop=FALSE)+
    scale_color_manual("",values=col,drop=FALSE)
}

construc_plot <- function(data_set,stats,sha,col){
    ggplot(data=data_set, aes_string(x="N_sequences",y=stats,color="species",shape="species")) +
    geom_point() +
    guides(color=guide_legend(ncol=2)) +
    scale_shape_manual("",values=sha,drop=FALSE)+
    scale_color_manual("",values=col,drop=FALSE)
}

make_trend_plot <- function(data,level,variance) {

  if(level=="concens"){
        print("Load vector concens")
        col = c("tomato","goldenrod3","red4","darkorchid3","goldenrod1","blue4","red","darkorchid1","orchid2","purple4","darkgray","pink","darkgreen","blueviolet","green","gold","peachpuff","coral4","violet","cadetblue4")
        sha = c(17,15,15,15,17,17,17,17,17,15,15,16,16,15,18,16,16,16,16,18)
  }else{
    print("Load vector species")
    col = c("darkgray","goldenrod1","blueviolet","coral4","red4","darkorchid3","blue4","darkgreen","cadetblue4")
    sha = c(8,15,16,17,18,8,15,16,17)
  }

  data$N_sequences <- as.numeric(levels(data$N_sequences)[data$N_sequences])
  data$Tajima <- as.numeric(levels(data$Tajima)[data$Tajima])
  data$Tajima_v <- sqrt(as.numeric(levels(variance$Tajima)[variance$Tajima]))
  data$pi <- as.numeric(levels(data$pi)[data$pi])
  data$pi_v <- as.numeric(levels(variance$pi)[variance$pi])
  data$theta_S_1 <- as.numeric(levels(data$theta_S_1)[data$theta_S_1])
  data$theta_S_1_v <- as.numeric(levels(variance$theta_S_1)[variance$theta_S_1])
  data$theta_pi_1 <- as.numeric(levels(data$theta_pi_1)[data$theta_pi_1])
  data$theta_pi_1_v <- as.numeric(levels(variance$theta_pi_1)[variance$theta_pi_1])
  data$S_1 <- as.numeric(levels(data$S_1)[data$S_1])
  data$S_1_v <- as.numeric(levels(variance$S_1)[variance$S_1])
  data$Fu_and_LiD <- as.numeric(levels(data$Fu_and_LiD)[data$Fu_and_LiD])
  data$Fu_and_LiD_v <- as.numeric(levels(variance$Fu_and_LiD)[variance$Fu_and_LiD])
  data$Fu_and_LiF <- as.numeric(levels(data$Fu_and_LiF)[data$Fu_and_LiF])
  data$Fu_and_LiF_v <- as.numeric(levels(variance$Fu_and_LiF)[variance$Fu_and_LiF])

  wd=7
  he=5.5
  p1 <- construc_plot_gt_3(data,"Tajima",sha,col)
  ggsave(p1,file=paste("Results/",level,"/Tajima.png",sep=""),width=wd,height=he,dpi=300)

  p2 <- construc_plot(data,"pi",sha,col)
  ggsave(p2,file=paste("Results/",level,"/Pi.png",sep=""),width=wd,height=he,dpi=300)

  p3 <- construc_plot(data,"theta_S_1",sha,col)
  ggsave(p3,file=paste("Results/",level,"/Theta_S.png",sep=""),width=wd,height=he,dpi=300)

  p4 <- construc_plot(data,"theta_pi_1",sha,col)
  ggsave(p4,file=paste("Results/",level,"/Theta_pi.png",sep=""),width=wd,height=he,dpi=300)

  p5 <- construc_plot(data,"S_1",sha,col)
  ggsave(p5,file=paste("Results/",level,"/S.png",sep=""),width=wd,height=he,dpi=300)

  p6 <-  construc_plot_gt_3(data,"Fu_and_LiD",sha,col)
  ggsave(p6,file=paste("Results/",level,"/Fu_Li_D.png",sep=""),width=wd,height=he,dpi=300)

  p7 <-  construc_plot_gt_3(data,"Fu_and_LiF",sha,col)
  ggsave(p7,file=paste("Results/",level,"/Fu_Li_F.png",sep=""),width=wd,height=he,dpi=300)

 # png(paste("Results/",level,"/Tajima.png",sep=""),width=500,height=500,res=300)
#    print(
 #   p1 <- ggplot(data=data[which(data$N_sequences > 3),], aes(x=N_sequences,y=Tajima,color=factor(species),shape=factor(species))) +
 #   geom_point() +
    #geom_errorbar(aes(ymin=Tajima-Tajima_v,ymax=Tajima+Tajima_v),width=0.1) +
#    guides(color=guide_legend(ncol=2)) +
 #   scale_shape_manual("",values=sha)+
  #  scale_color_manual("",values=col)
  #dev.off()

#   png(paste("Results/",level,"/Pi.png",sep=""),width=500,height=500,res=300)
#    print(ggplot(data=data, aes(x=N_sequences,y=pi,color=factor(species),shape=factor(species))) +
#    geom_point() +
#    geom_errorbar(aes(ymin=pi-pi_v,ymax=pi+pi_v),width=0.1) +
#    scale_shape_manual("",values=sha)+
#    scale_color_manual("",values=col))
#  dev.off()

 # png(paste("Results/",level,"/Theta_S.png",sep=""),width=500,height=500,res=300)
  #print(ggplot(data=data, aes(x=N_sequences,y=theta_S_1,color=factor(species),shape=factor(species))) +
   # geom_point() +
    #geom_errorbar(aes(ymin=theta_S_1-theta_S_1_v,ymax=theta_S_1+theta_S_1_v),width=0.1) +
#    scale_shape_manual("",values=sha)+
 #   scale_color_manual("",values=col))
  #dev.off()

#  png(paste("Results/",level,"/Theta_pi.png",sep=""),width=500,height=500,res=300)
#  print(ggplot(data=data, aes(x=N_sequences,y=theta_pi_1,color=factor(species),shape=factor(species))) +
 #     geom_point() +
 #     geom_errorbar(aes(ymin=theta_pi_1-theta_pi_1_v,ymax=theta_pi_1+theta_pi_1_v),width=0.1) +
 #     scale_shape_manual("",values=sha)+
 #     scale_color_manual("",values=col))
 # dev.off()

 # png(paste("Results/",level,"/S.png",sep=""),width=500,height=500,res=300)
 # print(ggplot(data=data, aes(x=N_sequences,y=S_1,color=factor(species),shape=factor(species))) +
 #     geom_point() +
  #    geom_errorbar(aes(ymin=S_1-S_1_v,ymax=S_1+S_1_v),width=0.1) +
#      scale_shape_manual("",values=sha)+
#      scale_color_manual("",values=col))
#  dev.off()

#  png(paste("Results/",level,"/Fu_Li_D.png",sep=""),width=500,height=500,res=300)
#  print(ggplot(data=data, aes(x=N_sequences,y=Fu_and_LiD,color=factor(species),shape=factor(species))) +
 #   geom_point() +
 #   geom_errorbar(aes(ymin=Fu_and_LiD-Fu_and_LiD_v,ymax=Fu_and_LiD+Fu_and_LiD_v),width=0.1) +
 #   scale_shape_manual("",values=sha)+
 #   scale_color_manual("",values=col))
 # dev.off()

 # png(paste("Results/",level,"/Fu_Li_F.png",sep=""),width=500,height=500,res=300)
 # print(ggplot(data=data, aes(x=N_sequences,y=Fu_and_LiF,color=factor(species),shape=factor(species))) +
 #   geom_point() +
 #   geom_errorbar(aes(ymin=Fu_and_LiF-Fu_and_LiF_v,ymax=Fu_and_LiF+Fu_and_LiF_v),width=0.1) +
 #   scale_shape_manual("",values=sha)+
 #   scale_color_manual("",values=col))
 # dev.off()

}
              
