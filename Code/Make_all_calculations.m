for imgid=1:numel(Types)

    
      filename=Types{imgid};
      
      filename2=strrep(filename,'.czi','');
      
      Im1=read(Tiff([Reshome filename2 '3-MAX_3D.tif']));
      Im2=read(Tiff([Reshome filename2 '1-MAX_3D.tif']));
%       Im3=read(Tiff([Reshome filename2 '2-MAX_3D.tif']));
      
        Im4=read(Tiff([Reshome filename2 '1-MAX_FEdited_V1N.tiff']));
      
      
      
%       
%       Im1=Im1(360:840,450:940);
%       Im2=Im2(360:840,450:940);
%       Im3=Im3(360:840,450:940);
%       Im4=Im4(360:840,450:940);
      
       Im1g=uint16(65535*mat2gray(read(Tiff([Reshome filename2 '3-MAX_F.tif']))));
      Im2g=uint16(65535*mat2gray(read(Tiff([Reshome filename2 '1-MAX_F.tif']))));
%       Im3g=uint16(65535*mat2gray(read(Tiff([Reshome filename2 '2-MAX_F.tif']))));
      
% % %       Im1g=Im1g(360:840,450:940);
% % %       Im2g=Im2g(360:840,450:940);
% % %       Im3g=Im3g(360:840,450:940);
      
      Fmap2G=zeros(size(Im1,1),size(Im1,2)); 
      
         Imk=cat(3,Im1g,Im2g,Fmap2G);
%    Imk=rgb2gray(Imk);
   Imk=uint16(65535*mat2gray(Imk));
   
   for k=1:3
       
       temp=Imk(:,:,k);
       
      temp(Im2>0)=65535*green(k); 
        temp(Im1>0)=65535*red(k); 
          temp(Im1>0 & Im2>0)=65535*white(k); 
        
       Imk(:,:,k)=temp;
   end
   
%    figure
%    imshow(Imk);

xyvalk=[];
diffvalk=[];
IDk=[];

NN=unique(Im4);
NN(1)=[];

for cells=1:length(NN)


      [points1x,points1y]=find(Im1>0 & Im4==NN(cells));
       [points2x,points2y]=find(Im2>0 & Im4==NN(cells));
       
       D = single(pdist2([points1x points1y],[points2x points2y],'euclidean'));  
       cosmatw=D;
        cosmat=D;
        NBP1=size(D,1);
         NBP2=size(D,2);
       idbox1=[1:NBP1];
        idbox2=[1:NBP2];
         Aida=[];
         diffval=[];
         
         if Algorithm==1
             
                xyval=[];
            diffval=[];
            ID=[];
                 for cp=1:min([NBP1 NBP2])
                     point=min(cosmatw(:));
                     [Aid,Bid]=find(cosmatw==point);
                      Aida=[Aida;[idbox1(Aid(1)) idbox2(Bid(1))]];

%                       cosmat(idbox1(Aid(1)),idbox2(Bid(1)))=10000;
                     idbox1(ismember(idbox1,Aida(:,1)))=[];
                        idbox2(ismember(idbox2,Aida(:,2)))=[];
                     cosmatw=cosmat(idbox1,idbox2);   

                     diffval(cp,1)=cosmat(Aida(cp,1),Aida(cp,2));
                     xyval(cp,1:2)=[points1x(Aida(cp,1)) points1y(Aida(cp,1))];
                        xyval(cp,3:4)=[points2x(Aida(cp,2)) points2y(Aida(cp,2))];

                        ID(cp,1)=cells;
                 end
         elseif Algorithm==2
             
%              if size(cosmat,1)>0
            [rowsol,cost,v,u,costMat] = lapjv(cosmat);

            xyval=[];
            diffval=[];
            ID=[];
                 for cp=1:min([NBP1 NBP2])

                     if NBP1>NBP2

                     diffval(cp,1)=cosmat(rowsol(cp),cp);
                     xyval(cp,1:2)=[points1x(rowsol(cp)) points1y(rowsol(cp))];
                        xyval(cp,3:4)=[points2x(cp) points2y(cp)];

                         ID(cp,1)=cells;

                     else

                             diffval(cp,1)=cosmat(cp,rowsol(cp));
                     xyval(cp,1:2)=[points1x(cp) points1y(cp)];
                        xyval(cp,3:4)=[points2x(rowsol(cp)) points2y(rowsol(cp))];

                        ID(cp,1)=cells;
                     end
                     cp;
                 end
%              end
         end
     
     xyvalk=[xyvalk;xyval];
      diffvalk=[diffvalk;diffval];
      IDk=[IDk;ID]; 
           
end 

TH=100;

   xyvalk(diffvalk==0 | diffvalk>TH,:)=[];
 IDk(diffvalk==0 | diffvalk>TH,:)=[];
  diffvalk(diffvalk==0 | diffvalk>TH,:)=[];

  figure
      m=4;
     Imk2=imresize(Imk,m);
     
     
     % Black background
     Imk2(Imk2>0)=0;
     % White background
%         Imk2(Imk2<65535)=65535;
        
        
        
    
   imagesc(Imk2);hold on
   xyval=xyvalk;
   U=m*xyval(:,4)-m*xyval(:,2);
   V=m*xyval(:,3)-m*xyval(:,1);
   Z=sqrt(U.^2+V.^2);   
   U=6*m*U./Z;
    V=6*m*V./Z;
    
    %     Small arrows
    
      [arrowx,arrowy]=vekplot2(m*xyval(:,2),m*xyval(:,1),U,V,0.85);
     plot(arrowx,arrowy,'Color',[1 1 1],'linewidth',0.2);
    
%     quiver(m*xyval(:,2),m*xyval(:,1),U,V,0,'color',[1 1 1],'maxheadsize',2,'linewidth',0.15) 
%      h = quiver(...);
% set(h,'MaxHeadSize',1e2,'AutoScaleFactor',0.5);

set(gca,'XTick',[]) % Remove the ticks in the x axis!
set(gca,'YTick',[]) % Remove the ticks in the y axis
set(gca,'Position',[0 0 1 1]) % Make the axes occupy the hole figure    
   
    ha = axes('Position',[0 0 1 1],'Xlim',[0 1],'Ylim',[0 1],'Box','off','Visible','off','Units','normalized', 'clipping' , 'off');
                                            set(gcf,'PaperPositionMode','auto')
                                     
%         print('Iteration_parameters', '-dpng', '-r600');
export_fig([Reshome filename2 '_vector_directionP'],'-native', '-a2', '-m8','-q101','-png', '-r600');
close all

 figure
      m=4;
     Imk2=imresize(Imk,m);
     
     
     % Black background
%      Imk2(Imk2>0)=0;
     % White background
        Imk2(Imk2<65535)=65535;
        
        
        
    
   imagesc(Imk2);hold on
   xyval=xyvalk;
   U=m*xyval(:,4)-m*xyval(:,2);
   V=m*xyval(:,3)-m*xyval(:,1);
   Z=sqrt(U.^2+V.^2);   
   U=6*m*U./Z;
    V=6*m*V./Z;
    
    %     Small arrows
%     quiver(m*xyval(:,2),m*xyval(:,1),U,V,0,'color',[0 0 0],'maxheadsize',2,'linewidth',0.15) 
    
       [arrowx,arrowy]=vekplot2(m*xyval(:,2),m*xyval(:,1),U,V,0.85);
     plot(arrowx,arrowy,'Color',[0 0 0],'linewidth',0.2);
    
% set(h,'MaxHeadSize',1e2,'AutoScaleFactor',0.5);

   
     UP=[];
      VP=[];
       XP=[];
        YP=[];
   for cells=1:length(NN) 
       xyvalt=xyval;
       xyvalt(IDk~=cells,:)=[];
       
       UP(cells,1)=sum(U(IDk==cells));
         VP(cells,1)=sum(V(IDk==cells));
           XP(cells,1)=mean(xyvalt(:,2));
         YP(cells,1)=mean(xyvalt(:,1));
   end
   
    ZP=sqrt(UP.^2+VP.^2);
%    
%    UP=36*m*UP./ZP;
%     VP=36*m*VP./ZP; 
%     VG=[XP YP UP VP double(NN)];

UPm=UP/m;
VPm=VP/m;

ZPm=sqrt(UPm.^2+VPm.^2);

 UPm=36*m*UPm./ZPm;
    VPm=36*m*VPm./ZPm;
    
      VGK2=[double(NN) XP YP UP VP];
    
    
    TID=List{imgid};
    
%     Transfected big
    
     quiver(m*XP(TID),m*YP(TID),UPm(TID),VPm(TID),0,'color',[1 0 0],'maxheadsize',1,'linewidth',0.5)

MTNt=MTN(MTN(:,1)==imgid,:); 
MTNtt=[];
for loop =1:length(TID)
 MTNt(MTNt(:,2)~=TID(loop),:)=[];
 MTNtt=[MTNtt;MTNt];
 MTNt=MTN(MTN(:,1)==imgid,:); 
end
       
NNA=MTNtt(:,3);
NNA(ismember(NNA,TID))=[];

%     Neighbour big

    quiver(m*XP(NNA),m*YP(NNA),UPm(NNA),VPm(NNA),0,'color',[1 1 0],'maxheadsize',1,'linewidth',0.5)
    
    
AR=NN;
AR(ismember(AR,TID))=[];
AR(ismember(AR,NNA))=[];

%     Rest big
    
    quiver(m*XP(AR),m*YP(AR),UPm(AR),VPm(AR),0,'color',[1 1 0],'maxheadsize',1,'linewidth',0.5)   
    
   CANG=[]; 
   ANG=[];
   for cells=1:length(NN) 
   
        Vector1=[U(IDk==cells) V(IDk==cells)];
        Vector2=repmat([UP(cells,1) VP(cells,1)],[size(Vector1,1) 1]);
        
        ANG=[];
        for AID=1:size(Vector1,1)
         Vector11=Vector1(AID,:);
          Vector22=Vector2(AID,:);
          
          an1=atan2(Vector11(1),Vector11(2));
           an2=atan2(Vector22(1),Vector22(2));
           
           angle = (an2 - an1)*360 / (2*pi);
           
  if angle<0 
    angle = angle + 360;
  end
  
  angle=360-angle;
%      ANG(AID)=acosd(dot(Vector11,Vector22)/(norm(Vector11)*norm(Vector22)));
       ANG(AID)=angle;
        end
    CANG{imgid,cells}=ANG;
   end
      
   ANGL=[];
     for cells=1:length(NN)       
        ANGt=CANG{imgid,cells};
        
        ANGL=[ANGL ANGt];
        
     end
      
       CANN=[]; 
       
      ListN= List{imgid};
    for cells=1:length(ListN)
       
       NID=ListN(cells);
       
       MTNt=MTN(MTN(:,1)==imgid,:); 
       MTNt(MTNt(:,2)~=NID,:)=[];
       SP=MTNt(:,3);
       SP(ismember(SP,TID))=[];
       
                           Vector1=[UP(SP) VP(SP)];
                    Vector2=repmat([UP(NID) VP(NID)],[size(Vector1,1) 1]);

                    ANG=[];
                    for AID=1:size(Vector1,1)
                     Vector11=Vector1(AID,:);
                      Vector22=Vector2(AID,:);

                                      an1=atan2(Vector11(1),Vector11(2));
                               an2=atan2(Vector22(1),Vector22(2));

                               angle = (an2 - an1)*360 / (2*pi);

                      if angle<0 
                        angle = angle + 360;
                      end
                      angle=360-angle;
                    %      ANG(AID)=acosd(dot(Vector11,Vector22)/(norm(Vector11)*norm(Vector22)));
                           ANG(AID)=angle;
                    end
                CANN{imgid,cells}=ANG;
 
    end
    
    
AGL=[];    
    
    
    UG=sum(UP,1);
    VG=sum(VP,1);
%       ZP=sqrt(UG.^2+VG.^2);
%    
%    UG=5*36*m*UG./ZP;
%     VG=5*36*m*VG./ZP; 

UGm=UG/(m^3);
VGm=VG/(m^3);
    
%        quiver(m*round(size(Im1,2)/2),m*round(size(Im1,1)/2),UGm,VGm,0,'color',[0.75 0.75 0.75],'maxheadsize',1.25,'linewidth',1.5)
       
       
      for cells=NN'
       
       
                           Vector11=[UP(cells) VP(cells)];
                    Vector22=[UG VG];
                    

                                      an1=atan2(Vector11(1),Vector11(2));
                               an2=atan2(Vector22(1),Vector22(2));

                               angle = (an2 - an1)*360 / (2*pi);

                      if angle<0 
                        angle = angle + 360;
                      end
                      angle=360-angle;
                    %      ANG(AID)=acosd(dot(Vector11,Vector22)/(norm(Vector11)*norm(Vector22)));
                           AGL(cells)=angle;
                   
               
 
      end
   AGLA{imgid}=AGL; 
   
      AGL180=AGL;
   AGL180(AGL>180)=360-AGL(AGL>180);
   
   
   Class=NN;
   Class(ismember(NN,TID))=3;
   Class(ismember(NN,NNA))=2;
   Class(ismember(NN,AR))=1;
   
   
   VGK2=[double(VGK2) double(AGL') double(AGL180') double(UP) double(VP) double(ZP) double(Class)];
   
   ANGL180=ANGL;
   ANGL180(ANGL>180)=360-ANGL(ANGL>180);
    
 MAT=[IDk diffvalk xyvalk ANGL' ANGL180'];
 
 MATT=MAT(ismember(MAT(:,1),TID),:);
 
  MATN=MAT(ismember(MAT(:,1),NNA),:);
  
   MATAR=MAT(ismember(MAT(:,1),AR),:);
 
  
    resfile = [Reshome filename2 '_Result.xlsx'];
    
    if exist(resfile, 'file')==2
  delete(resfile);
    end
    
    B = cell(size(MATT,1),size(MATT,2));
for ii=1:size(MATT,1)
    for jj=1:size(MATT,2)
  B(ii,jj) = {MATT(ii,jj)};
    end
end
    
A = {'Cell id','Vector length', 'Vector X1','Vector Y1','Vector X2','Vector Y2','360 Angle with global','180 Angle with global'};
C=[A;B];
xlswrite(resfile,C,1,'A1')
    
     
    resfile = [Reshome filename2 '_Result.xlsx'];
    
    B = cell(size(MATN,1),size(MATN,2));
for ii=1:size(MATN,1)
    for jj=1:size(MATN,2)
  B(ii,jj) = {MATN(ii,jj)};
    end
end
    
A = {'Cell id','Vector length', 'Vector X1','Vector Y1','Vector X2','Vector Y2','360 Angle with global','180 Angle with global'};
C=[A;B];
xlswrite(resfile,C,2,'A1')    
    

    resfile = [Reshome filename2 '_Result.xlsx'];
    
    B = cell(size(MATAR,1),size(MATAR,2));
for ii=1:size(MATAR,1)
    for jj=1:size(MATAR,2)
  B(ii,jj) = {MATAR(ii,jj)};
    end
end
    
A = {'Cell id','Vector length', 'Vector X1','Vector Y1','Vector X2','Vector Y2','360 Angle with global','180 Angle with global'};
C=[A;B];
xlswrite(resfile,C,3,'A1')  

    B = cell(size(VGK2,1),size(VGK2,2));
for ii=1:size(VGK2,1)
    for jj=1:size(VGK2,2)
  B(ii,jj) = {VGK2(ii,jj)};
    end
end
    
A = {'Cell id','Vector X1','Vector Y1','Vector X2','Vector Y2','360 Angla with image','180 Angla with image','U','V','Z','Type'};
C=[A;B];
xlswrite(resfile,C,4,'A1')  


   for cells=1:length(ListN)
       
       NID=ListN(cells);
      
          ANG=CANN{imgid,cells};
          
                 MTNt=MTN(MTN(:,1)==imgid,:); 
       MTNt(MTNt(:,2)~=NID,:)=[];
       SP=MTNt(:,3);
       SP(ismember(SP,TID))=[];
       
           B = cell(3,length(SP)+1);
           B(1,1)={'Transfiction id'};
           B(2,1)={NID};
           
                for jj=2:length(SP)+1
              B(1,jj) = {['Neighbour' num2str(jj-1)]};
                B(2,jj) = {SP(jj-1)};
                 B(3,jj) = {ANG(jj-1)};
                end

            xlswrite(resfile,B,4+cells,'A1')  

    end

    
  
set(gca,'XTick',[]) % Remove the ticks in the x axis!
set(gca,'YTick',[]) % Remove the ticks in the y axis
set(gca,'Position',[0 0 1 1]) % Make the axes occupy the hole figure    
   
    ha = axes('Position',[0 0 1 1],'Xlim',[0 1],'Ylim',[0 1],'Box','off','Visible','off','Units','normalized', 'clipping' , 'off');
                                            set(gcf,'PaperPositionMode','auto')
                                     
%         print('Iteration_parameters', '-dpng', '-r600');
export_fig([Reshome filename2 '_vector_direction'],'-native', '-a2', '-m8','-q101','-png', '-r600');
         
%           set(gcf,'Units','inches');
% screenposition = get(gcf,'Position');
% set(gcf,...
%     'PaperPosition',[0 0 screenposition(3:4)],...
%     'PaperSize',[screenposition(3:4)]);
% 
%    print([Reshome filename2 'Iteration_parameters2'], '-dpdf', '-r300');
   
end   

save([Reshome 'All_vector_angle.mat'],'CANG','CANN'); 