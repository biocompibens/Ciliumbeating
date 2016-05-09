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

Dispersion=[];
DispersionA=[];

TID=List{imgid};
cellsloop=1;
for cells=TID'%1:length(NN)


      [points1x,points1y]=find(Im1>0 & Im4==NN(cells));
       [points2x,points2y]=find(Im2>0 & Im4==NN(cells));
       
       
       centerx=mean(points2x);
       centery=mean(points2y);
       
        centerD = single(pdist2([points2x points2y],[centerx centery],'euclidean'));
       
        
%             block=classmap4==neighbourLabels(kin) | classmap4==label;
%     [X,Y]=find(block==1);
        
       centerDSTD=std(centerD);
           centerDmean=mean(centerD);
        [CH,Ak]= convhull(points2x,points2y);
       
       RK=sqrt(Ak/(2*pi));
       
       Dispersion(cellsloop,1)=centerDSTD/centerDmean;
       Dispersion(cellsloop,2)=centerDSTD/RK;
       DispersionA=[DispersionA; centerD/centerDmean];
       cellsloop=cellsloop+1;
       
end 


% 
MATT=Dispersion;

  
  
    resfile = [Reshome filename2 '_Result2.xlsx'];
    
    if exist(resfile, 'file')==2
  delete(resfile);
    end
    
    B = cell(size(MATT,1),size(MATT,2));
for ii=1:size(MATT,1)
    for jj=1:size(MATT,2)
  B(ii,jj) = {MATT(ii,jj)};
    end
end
    
A = {'DispersionA','DispersionM'};
C=[A;B];
xlswrite(resfile,C,1,'A1')   



MATT=DispersionA;

  
  
    resfile = [Reshome filename2 '_Result3.xlsx'];
    
    if exist(resfile, 'file')==2
  delete(resfile);
    end
    
    B = cell(size(MATT,1),size(MATT,2));
for ii=1:size(MATT,1)
    for jj=1:size(MATT,2)
  B(ii,jj) = {MATT(ii,jj)};
    end
end
    
A = {'DispersionArray'};
C=[A;B];
xlswrite(resfile,C,1,'A1')   


end   
