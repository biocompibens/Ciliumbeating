clear all
close all
clc

clc
yelo=[1 1 0];
red=[1 0 0];
green=[0 1 0];
white=[1 1 1];

FR='C:\ENS_CILTEX\ND_Paper\Vectors';

   h = fspecial('gaussian',[3 3],0.5);

%     Datahome = uigetdir(pwd, 'Pick directory of Dataset');
%    Reshome = uigetdir(pwd, 'Pick directory of Results');
%
%    Datahome=[Datahome filesep];
%     Reshome=[Reshome filesep];
TDatahome{1}='C:\ENS_CILTEX\ND_Paper\Plugin 151124 Raw data shCobl\';
TDatahome{2}='C:\ENS_CILTEX\ND_Paper\Plugin 151229 Animal 1 shCobl\';
TDatahome{3}='C:\ENS_CILTEX\ND_Paper\Plugin 151229 Animal 2 shCobl\';
TDatahome{4}='C:\ENS_CILTEX\ND_Paper\151120 Plugin shCobl A2\';

NDatahome{1}='C:\ENS_CILTEX\ND_Paper\Plugin 151124 Raw data shNeg\';
NDatahome{2}='C:\ENS_CILTEX\ND_Paper\Plugin 151229 Animal 1 shNeg\';
NDatahome{3}='C:\ENS_CILTEX\ND_Paper\151120 Plugin shNeg A2\';

%Tlist=shCobl, Nlist=shCtrl

TList{1,1}=[43];
TList{1,2}=[61];
TList{1,3}=[41];
TList{1,4}=[14;18];
TList{1,5}=[44];
TList{1,6}=[45];
TList{1,7}=[29;38;18];
TList{1,8}=[39;23];
TList{1,9}=[43;6];


TList{2,1}=[44];
TList{2,2}=[73];
TList{2,3}=[41];
TList{2,4}=[29;12];
TList{2,5}=[5;35];
TList{2,6}=[19;30];
TList{2,7}=[47;44;5];


TList{3,1}=[69];
TList{3,2}=[16];
TList{3,3}=[37];
TList{3,4}=[15;13];
TList{3,5}=[44;15];
TList{3,6}=[14];
TList{3,7}=[24];


TList{4,1}=[58;19;5;21;69;68;59];
TList{4,2}=[22;10;14;6;16];
TList{4,3}=[49;26;3];
TList{4,4}=[55;29;31];
TList{4,5}=[31;4;25;24];
TList{4,6}=[3;16;27;17];
TList{4,7}=[8];
TList{4,8}=[25;5;7];


NList{1,1}=[22;41];
NList{1,2}=[47;16;37];
NList{1,3}=[2;36;6];
NList{1,4}=[17;45;41];
NList{1,5}=[18;15;23;3;17];
NList{1,6}=[15;19;46];
NList{1,7}=[48;64;60;16;75;58;53];


NList{2,1}=[41;17];
NList{2,2}=[35;53];
NList{2,3}=[29;53;33;5];
NList{2,4}=[50;65;42];
NList{2,5}=[35;54;28;15;67;17];
NList{2,6}=[32];
NList{2,7}=[44;51;31];
NList{2,8}=[46;11;12;32;22];


NList{3,1}=[15;39;29];
NList{3,2}=[22;25];
NList{3,3}=[9;18;25;37];
NList{3,4}=[17;6];
NList{3,5}=[28;22];
NList{3,6}=[45;65];
NList{3,7}=[48;39];


% Reshomek='G:\NatD vectors\Plugin 151124 Raw data shCobl\';

Algorithm=2;

for TF=1:length(TDatahome)
    
    Datahome=TDatahome{TF};
    Reshome=TDatahome{TF};
    List=TList(TF,:);
    

d=dir(fullfile(Datahome,'*1-MAX_F.tif*'));
Types={d.name};

for imgid=1:numel(Types)
    
    filename=Types{imgid};
      
      filename2=strrep(filename,'1-MAX_F.tif','');
      Types{imgid}=filename2;
    
end

  Neigh= importdata(fullfile(Reshome, 'MyExpt_Object relationships.csv'));

                            vars = fieldnames(Neigh);
                            for i = 1:length(vars)
                                assignin('base', ['Neigh' vars{i}], Neigh.(vars{i}));
                            end
                 
     MTNp=str2double(Neightextdata(2:end,[5 6]));

                        Neighdata(:,1)=[];
                        
                        MTN=[MTNp Neighdata];
                        MTN(MTN(:,2)==MTN(:,3),:)=[];


% Make_all_calculations; 
close all

end

for NF=1:length(NDatahome)
    
    Datahome=NDatahome{NF};
    Reshome=NDatahome{NF};
    List=NList(NF,:);
    

d=dir(fullfile(Datahome,'*1-MAX_F.tif*'));
Types={d.name};

for imgid=1:numel(Types)
    
    filename=Types{imgid};
      
      filename2=strrep(filename,'1-MAX_F.tif','');
      Types{imgid}=filename2;
    
end

  Neigh= importdata(fullfile(Reshome, 'MyExpt_Object relationships.csv'));

                            vars = fieldnames(Neigh);
                            for i = 1:length(vars)
                                assignin('base', ['Neigh' vars{i}], Neigh.(vars{i}));
                            end
                 
     MTNp=str2double(Neightextdata(2:end,[5 6]));

                        Neighdata(:,1)=[];
                        
                        MTN=[MTNp Neighdata];
                        MTN(MTN(:,2)==MTN(:,3),:)=[];


% Make_all_calculations; 
close all
end



TNUMT=[];
TNUMN=[];
TNUMAR=[];

for TF=1:length(TDatahome)
    
    Datahome=TDatahome{TF};
    Reshome=TDatahome{TF};
    List=TList(TF,:);
    
    d=dir(fullfile(Datahome,'*1-MAX_F.tif*'));
Types={d.name};

for imgid=1:numel(Types)
    
    filename=Types{imgid};
      
      filename2=strrep(filename,'1-MAX_F.tif','');
      Types{imgid}=filename2;
    
end

load([Reshome 'All_vector_angle.mat'],'CANG','CANN');  

for imgid=1:numel(Types)
%     
      filename=Types{imgid};
      
      filename2=strrep(filename,'.czi','');
      resfile = [Reshome filename2 '_Result.xlsx'];
NUMTt = xlsread(resfile,'Feuil1');
NUMTt=NUMTt(:,[1 7]);
NUMNt = xlsread(resfile,'Feuil2');
NUMNt=NUMNt(:,[1 7]);
NUMARt = xlsread(resfile,'Feuil3');
NUMARt=NUMARt(:,[1 7]);

TNUMT=[TNUMT;NUMTt];
TNUMN=[TNUMN;NUMNt];
TNUMAR=[TNUMAR;NUMARt];
imgid
resfile
end

end

NNUMT=[];
NNUMN=[];
NNUMAR=[];

for NF=1:length(NDatahome)
    
    Datahome=NDatahome{NF};
    Reshome=NDatahome{NF};
    List=NList(NF,:);
    
    d=dir(fullfile(Datahome,'*1-MAX_F.tif*'));
Types={d.name};

for imgid=1:numel(Types)
    
    filename=Types{imgid};
      
      filename2=strrep(filename,'1-MAX_F.tif','');
      Types{imgid}=filename2;
    
end

load([Reshome 'All_vector_angle.mat'],'CANG','CANN');  

for imgid=1:numel(Types)
%     
      filename=Types{imgid};
      
      filename2=strrep(filename,'.czi','');
      resfile = [Reshome filename2 '_Result.xlsx'];
NUMTt = xlsread(resfile,'Feuil1');
NUMTt=NUMTt(:,[1 7]);
NUMNt = xlsread(resfile,'Feuil2');
NUMNt=NUMNt(:,[1 7]);
NUMARt = xlsread(resfile,'Feuil3');
NUMARt=NUMARt(:,[1 7]);

NNUMT=[NNUMT;NUMTt];
NNUMN=[NNUMN;NUMNt]; 
NNUMAR=[NNUMAR;NUMARt];
imgid
resfile
end

end


data1=TNUMT(:,2);
data2=NNUMT(:,2);
data3=[TNUMN(:,2);NNUMN(:,2);TNUMAR(:,2);NNUMAR(:,2)];

 resfile = [FR filesep 'Test_Result.xlsx'];
  
   if exist(resfile, 'file')==2
  delete(resfile);
    end

  
  
  
    MATN=TNUMT;
  
  
    B = cell(size(MATN,1),size(MATN,2));
for ii=1:size(MATN,1)
    for jj=1:size(MATN,2)
  B(ii,jj) = {MATN(ii,jj)};
    end
end
    
A = {'Cell id','360 Angle'};
C=[A;B];
xlswrite(resfile,C,1,'A1')    

   MATN=NNUMT;
    B = cell(size(MATN,1),size(MATN,2));
for ii=1:size(MATN,1)
    for jj=1:size(MATN,2)
  B(ii,jj) = {MATN(ii,jj)};
    end
end
    
A = {'Cell id','360 Angle'};
C=[A;B];
xlswrite(resfile,C,2,'A1')  

 

save([FR filesep 'data.mat'],'data1','data2','data3','TNUMT','NNUMT');
load([FR filesep 'data.mat'],'data1','data2','data3','TNUMT','NNUMT');


                                                                                                               
col=[.8 .1 .1; 0.1 0.1 0.8; 0.5 0.5 0.5];

                                            minS=0;
                                            maxS=360;

                                            Distk=[0 20 40 60 80 100 120 140 160 180 200 220 240 260 280 300 320 340 360];
                                            Center=[10 30 50 70 90 110 130 150 170 190 210 230 250 270 290 310 330 350];
%                                             figure()
                                            [n1,x11] = histc(data1',Distk);
                                            n1(19)=[];
                                             [n2,x22] = histc(data2',Distk);
                                            n2(19)=[];
                                             [n3,x33] = histc(data3',Distk);
                                            n3(19)=[];
                                                                                     
        n11=100*n1/sum(n1);
            n22=100*n2/sum(n2);
                n33=100*n3/sum(n3);
                                                                          valuesmean=[n11' n22' n33'];                        
                                                                                   index = Distk; 
                                                                                   center2=[5 95 185 275];
%                                                                                    n44=n33;
                                                                                   n44(1:4)=25%max([n33 n22 n11]);
               figure
%                h4=compass(n44.*cosd(center2),n44.*sind(center2));    
%                        set(h4,'Color',[1 1 1],'linewidth',0.001)
% %                   hold on
%                        h3=compass(n33.*cosd(Center),n33.*sind(Center));    
%                        set(h3,'Color',[0.5 0.5 0.5],'linewidth',1)
%                           hold on, 
                          h2=compass(n22.*cosd(Center+1),n22.*sind(Center+1));
                    set(h2,'Color',[0.1 0.1 0.8],'linewidth',1) 
                    hold on
              h1=compass(n11.*cosd(Center+2),n11.*sind(Center+2)); 
               set(h1,'Color',[0.8 0.1 0.1],'linewidth',1) 
             
              
                       hold on                                                         
%                                                                                         hb = bar([1 2 3 4 5 6 7 8 9],valuesmean,0.6);
%                                                                                          set(hb,'edgecolor','none');
 
text(-35,15,'Transfected','FontName','Times','fontsize',15,'Color',[0.8 0.1 0.1]);
text(-35,18,'Negative control','FontName','Times','fontsize',15,'Color',[0.1 0.1 0.8]);
% text(-35,21,'Others','FontName','Times','fontsize',15,'Color',[0.5 0.5 0.5]);

                                                                
                                    
                                            title('Angular (360) beating direction histogram','FontName','Times','fontsize',20);
                                                                                
                                                ax = gca;
                                                grid off
                                                
                                                        a = get(gca,'XTickLabel');
                                                set(gca,'XTickLabel',a,'FontName','Times','fontsize',10);
                                                b = get(gca,'YTickLabel');
                                                set(gca,'YTickLabel',b,'FontName','Times','fontsize',10);

%                                                     title('Cilia beating direction distribution','FontSize', 20,'FontName','Times');
%                                                 ha = axes('Position',[0 0 1 1],'Xlim',[0 1],'Ylim',[0 1],'Box','off','Visible','off','Units','normalized', 'clipping' , 'off');
                                                %                                             text(0.5,1,['Comparison of nMI' ],'HorizontalAlignment','center','VerticalAlignment', 'top');
                                                                                            set(gcf,'PaperPositionMode','auto')

                                                        print([FR filesep 'Vector_angle6'], '-dpng', '-r300');
                                                                                        set(gcf,'Units','inches');
screenposition = get(gcf,'Position');
set(gcf,...
    'PaperPosition',[0 0 screenposition(3:4)],...
    'PaperSize',[screenposition(3:4)]);
% print -dpdf -painters epsFig
  
  
   print([FR filesep 'Vector_angle6'], '-dpdf', '-r300');  
                                                        
                                                       
