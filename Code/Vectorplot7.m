% %% This code takes the list of folders that have the images of the mutant
% %% and wild type. Then they process all the images and creates the final
% %% vector plot
% 
% clear all
% close all
% clc
% 
% %% Defining the colors
% yelo=[1 1 0];
% red=[1 0 0];
% green=[0 1 0];
% white=[1 1 1];
% 
% %% the address where to keep all the final results
% FR='C:\ENS_CILTEX\ND vectors\FinalR';
% 
% h = fspecial('gaussian',[3 3],0.5);
%  
% %% Defining the Mutant folders 
% TDatahome{1}='C:\ENS_CILTEX\ND vectors\TestR\';
% % TDatahome{2}='F:\Acquisition\shCobl Cen2GFP cep164\151229 Cen2GFP shCobl P14 Cep164\Plugin 151229 Animal 1 shCobl\';
% % TDatahome{3}='F:\Acquisition\shCobl Cen2GFP cep164\151229 Cen2GFP shCobl P14 Cep164\Plugin 151229 Animal 2 shCobl\';
% % TDatahome{4}='F:\Acquisition\shCobl Cen2GFP cep164\151120 shCobl P15 Cen2GFP Cep164\151120 Plugin shCobl A2\';
% 
% %% List of transfacted cells in each image
% 
% TList{1,1}=[35];
% TList{1,2}=[37];
% TList{1,3}=[27];
% TList{1,4}=[15;26];
% TList{1,5}=[32];
% TList{1,6}=[25];
% TList{1,7}=[30;32;18];
% TList{1,8}=[46;47];
% TList{1,9}=[36;29];
% 
% TList{2,1}=[44];
% TList{2,2}=[28];
% TList{2,3}=[36];
% TList{2,4}=[39;59];
% TList{2,5}=[24;26];
% TList{2,6}=[18;21];
% TList{2,7}=[38;39];
% 
% TList{3,1}=[43];
% TList{3,2}=[27];
% TList{3,3}=[23];
% TList{3,4}=[55;59];
% TList{3,5}=[23;68];
% TList{3,6}=[19];
% TList{3,7}=[31];
% 
% TList{4,1}=[71;18;5;20;61;58;57];
% TList{4,2}=[12;7;9;25;24];
% TList{4,3}=[44;25;3];
% TList{4,4}=[30;55;54];
% TList{4,5}=[17;18;11;10];
% TList{4,6}=[3;14;15;32];
% TList{4,7}=[8];
% TList{4,8}=[25;5];
% 
% %% Defining the negative control folders 
% NDatahome{1}='C:\ENS_CILTEX\ND vectors\TestR\';
% % NDatahome{2}='F:\Acquisition\shCobl Cen2GFP cep164\151229 Cen2GFP shCobl P14 Cep164\Plugin 151229 Animal 1 shNeg\';
% % NDatahome{3}='F:\Acquisition\shCobl Cen2GFP cep164\151120 shCobl P15 Cen2GFP Cep164\151120 Plugin shNeg A2\';
% 
% %% List of transfacted cells in each image
% 
% NList{1,1}=[31;27];
% NList{1,2}=[3;10;39];
% NList{1,3}=[6;31;29;28];
% NList{1,4}=[18;30;42];
% NList{1,5}=[27;9;7;11;3];
% NList{1,6}=[3;18;37];
% NList{1,7}=[61;52;56;35;8];
% 
% NList{2,1}=[33;25];
% NList{2,2}=[61;31];
% NList{2,3}=[53;48;37;23];
% NList{2,4}=[74;22];
% NList{2,5}=[5;39;44;59;67;63];
% NList{2,6}=[8;20;28];
% NList{2,7}=[28;55;60];
% NList{2,8}=[23;52;54;64;24];
% 
% NList{3,1}=[48;16];
% NList{3,2}=[21;42];
% NList{3,3}=[9;18;40;24;22];
% NList{3,4}=[24;29];
% NList{3,5}=[28;22];
% NList{3,6}=[39;59];
% NList{3,7}=[47;37];
% 
% % Reshomek='G:\NatD vectors\Plugin 151124 Raw data shCobl\';
% 
% Algorithm=2;
% 
% for TF=1:length(TDatahome)
%     
%     Datahome=TDatahome{TF};
%     Reshome=TDatahome{TF};
%     List=TList(TF,:);
%     
% 
% d=dir(fullfile(Datahome,'*1-MAX_F.tif*'));
% Types={d.name};
% 
% for imgid=1:numel(Types)
%     
%     filename=Types{imgid};
%       
%       filename2=strrep(filename,'1-MAX_F.tif','');
%       Types{imgid}=filename2;
%     
% end
% 
%   Neigh= importdata(fullfile(Reshome, 'MyExpt_Object relationships.csv'));
% 
%                             vars = fieldnames(Neigh);
%                             for i = 1:length(vars)
%                                 assignin('base', ['Neigh' vars{i}], Neigh.(vars{i}));
%                             end
%                  
%      MTNp=str2double(Neightextdata(2:end,[5 6]));
% 
%                         Neighdata(:,1)=[];
%                         
%                         MTN=[MTNp Neighdata];
%                         MTN(MTN(:,2)==MTN(:,3),:)=[];
% 
% % Make_all_calculations; 
% close all
% 
% end
% 
% for NF=1:length(NDatahome)
%     
%     Datahome=NDatahome{NF};
%     Reshome=NDatahome{NF};
%     List=NList(NF,:);
%     
% 
% d=dir(fullfile(Datahome,'*1-MAX_F.tif*'));
% Types={d.name};
% 
% for imgid=1:numel(Types)
%     
%     filename=Types{imgid};
%       
%       filename2=strrep(filename,'1-MAX_F.tif','');
%       Types{imgid}=filename2;
%     
% end
% 
%   Neigh= importdata(fullfile(Reshome, 'MyExpt_Object relationships.csv'));
% 
%                             vars = fieldnames(Neigh);
%                             for i = 1:length(vars)
%                                 assignin('base', ['Neigh' vars{i}], Neigh.(vars{i}));
%                             end
%                  
%      MTNp=str2double(Neightextdata(2:end,[5 6]));
% 
%                         Neighdata(:,1)=[];
%                         
%                         MTN=[MTNp Neighdata];
%                         MTN(MTN(:,2)==MTN(:,3),:)=[];
% 
% 
% % Make_all_calculations; 
% close all
% end
% 
% TNUMT=[];
% TNUMN=[];
% TNUMAR=[];
% 
% for TF=1:length(TDatahome)
%     
%     Datahome=TDatahome{TF};
%     Reshome=TDatahome{TF};
%     List=TList(TF,:);
%     
%     d=dir(fullfile(Datahome,'*1-MAX_F.tif*'));
% Types={d.name};
% 
% for imgid=1:numel(Types)
%     
%     filename=Types{imgid};
%       
%       filename2=strrep(filename,'1-MAX_F.tif','');
%       Types{imgid}=filename2;
%     
% end
% 
% load([Reshome 'All_vector_angle.mat'],'CANG','CANN');  
% 
% for imgid=1:numel(Types)
% %     
%       filename=Types{imgid};
%       
%       filename2=strrep(filename,'.czi','');
%       resfile = [Reshome filename2 '_Result.xlsx'];
% NUMTt = xlsread(resfile,'sheet1');
% NUMTt=NUMTt(:,[1 7]);
% NUMNt = xlsread(resfile,'sheet2');
% NUMNt=NUMNt(:,[1 7]);
% NUMARt = xlsread(resfile,'sheet3');
% NUMARt=NUMARt(:,[1 7]);
% 
% TNUMT=[TNUMT;NUMTt];
% TNUMN=[TNUMN;NUMNt];
% TNUMAR=[TNUMAR;NUMARt];
% imgid
% resfile
% end
% 
% end
% 
% NNUMT=[];
% NNUMN=[];
% NNUMAR=[];
% 
% for NF=1:length(NDatahome)
%     
%     Datahome=NDatahome{NF};
%     Reshome=NDatahome{NF};
%     List=NList(NF,:);
%     
%     d=dir(fullfile(Datahome,'*1-MAX_F.tif*'));
% Types={d.name};
% 
% for imgid=1:numel(Types)
%     
%     filename=Types{imgid};
%       
%       filename2=strrep(filename,'1-MAX_F.tif','');
%       Types{imgid}=filename2;
%     
% end
% 
% load([Reshome 'All_vector_angle.mat'],'CANG','CANN');  
% 
% for imgid=1:numel(Types)
% %     
%       filename=Types{imgid};
%       
%       filename2=strrep(filename,'.czi','');
%       resfile = [Reshome filename2 '_Result.xlsx'];
% NUMTt = xlsread(resfile,'sheet1');
% NUMTt=NUMTt(:,[1 7]);
% NUMNt = xlsread(resfile,'sheet2');
% NUMNt=NUMNt(:,[1 7]);
% NUMARt = xlsread(resfile,'sheet3');
% NUMARt=NUMARt(:,[1 7]);
% 
% NNUMT=[NNUMT;NUMTt];
% NNUMN=[NNUMN;NUMNt]; 
% NNUMAR=[NNUMAR;NUMARt];
% imgid
% resfile
% end
% 
% end
% 
% 
% data1=TNUMT(:,2);
% data2=NNUMT(:,2);
% data3=[TNUMN(:,2);NNUMN(:,2);TNUMAR(:,2);NNUMAR(:,2)];
% 
%  resfile = [FR filesep 'Test_Result2.xlsx'];
%   
%    if exist(resfile, 'file')==2
%   delete(resfile);
%    end
%   
%     MATN=TNUMT;
%   
%   
%     B = cell(size(MATN,1),size(MATN,2));
% for ii=1:size(MATN,1)
%     for jj=1:size(MATN,2)
%   B(ii,jj) = {MATN(ii,jj)};
%     end
% end
%     
% A = {'Cell id','360 Angle'};
% C=[A;B];
% xlswrite(resfile,C,1,'A1')    
% 
%    MATN=NNUMT;
%     B = cell(size(MATN,1),size(MATN,2));
% for ii=1:size(MATN,1)
%     for jj=1:size(MATN,2)
%   B(ii,jj) = {MATN(ii,jj)};
%     end
% end
%     
% A = {'Cell id','360 Angle'};
% C=[A;B];
% xlswrite(resfile,C,2,'A1')  
% 
%  
% 
% save([FR filesep 'data.mat'],'data1','data2','data3','TNUMT','NNUMT');
% load([FR filesep 'data.mat'],'data1','data2','data3','TNUMT','NNUMT');
% 
% 
%                                                                                                                
% col=[.8 .1 .1; 0.1 0.1 0.8; 0.5 0.5 0.5];
% 
%                                             minS=0;
%                                             maxS=360;
% 
%                                             Distk=[0 20 40 60 80 100 120 140 160 180 200 220 240 260 280 300 320 340 360];
%                                             Center=[10 30 50 70 90 110 130 150 170 190 210 230 250 270 290 310 330 350];
% %                                             figure()
%                                             [n1,x11] = histc(data1',Distk);
%                                             n1(19)=[];
%                                              [n2,x22] = histc(data2',Distk);
%                                             n2(19)=[];
%                                              [n3,x33] = histc(data3',Distk);
%                                             n3(19)=[];
%                                                                                      
%         n11=100*n1/sum(n1);
%             n22=100*n2/sum(n2);
%                 n33=100*n3/sum(n3);
%                                                                           valuesmean=[n11' n22' n33'];                        
%                                                                                    index = Distk; 
%                                                                                    center2=[5 95 185 275];
% %                                                                                    n44=n33;
%                                                                                    n44(1:4)=25%max([n33 n22 n11]);
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
 
text(-65,32,'Transfected','FontName','Times','fontsize',15,'Color',[0.8 0.1 0.1]);
text(-65,38,'Negative control','FontName','Times','fontsize',15,'Color',[0.1 0.1 0.8]);
% text(-35,21,'Others','FontName','Times','fontsize',15,'Color',[0.5 0.5 0.5]);
       
                                            title('Angular (360) beating direction histogram','FontName','Times','fontsize',20);
                                                                                
                                                ax = gca;
                                                grid off
                                                
                                                        a = get(gca,'XTickLabel');
                                                set(gca,'XTickLabel',a,'FontName','Times','fontsize',10);
                                                b = get(gca,'YTickLabel');
                                                set(gca,'YTickLabel',b,'FontName','Times','fontsize',10);

                                                                                            set(gcf,'PaperPositionMode','auto')

                                                        print([FR filesep 'Vector_angle6'], '-dpng', '-r300');
                                                                                        set(gcf,'Units','inches');
screenposition = get(gcf,'Position');
set(gcf,...
    'PaperPosition',[0 0 screenposition(3:4)],...
    'PaperSize',[screenposition(3:4)]);
% print -dpdf -painters epsFig
  
  
   print([FR filesep 'Vector_angle6'], '-dpdf', '-r300');  
                                                        
                                                       


[t,r] = rose(degtorad(data2'),18); 

ADJ=max(n22)./max(r);
r=r*ADJ;

%# this does not generate a plot

%# set plot's max radial ticks
figure
rMax = max(n22);
h = polar(0, rMax);
delete(h)
set(gca, 'Nextplot','add')

%# draw patches instead of lines: polar(t,r)
[x,y] = pol2cart(t,r);
Cut=1.2;
Xin=reshape(x,4,[]);
Xin(2,:)=Xin(2,:)./Cut;
Yin=reshape(y,4,[]);
Yin(2,:)=Yin(2,:)./Cut;
h = patch(Xin, Yin, 'b');
alpha(h, 0.4)       %# note: this switches to OpenGL renderer
set(h,'EdgeColor','None');
hold on
[t,r] = rose(degtorad(data1'+5),18);               %# this does not generate a plot

ADJ=max(n11)./max(r);
r=r*ADJ;
%# draw patches instead of lines: polar(t,r)
[x,y] = pol2cart(t,r);
Cut=1.5;
Xin=reshape(x,4,[]);
Xin(2,:)=Xin(2,:)./Cut;
Yin=reshape(y,4,[]);
Yin(2,:)=Yin(2,:)./Cut;
h = patch(Xin, Yin, 'r');
alpha(h, 0.6)             
 set(h,'EdgeColor','None');             
                       hold on                                                         
%                                                                                         hb = bar([1 2 3 4 5 6 7 8 9],valuesmean,0.6);
%                                                                                          set(hb,'edgecolor','none');
% grid off
% box off
text(-75,32,'Transfected','FontName','Times','fontsize',15,'Color',[0.8 0.1 0.1]);
text(-75,38,'Negative control','FontName','Times','fontsize',15,'Color',[0.1 0.1 0.8]);
% text(-35,21,'Others','FontName','Times','fontsize',15,'Color',[0.5 0.5 0.5]);
       
                                            title('Angular (360) beating direction histogram','FontName','Times','fontsize',20);
                                                                                
                                                ax = gca;
                                                grid off
                                                
                                                        a = get(gca,'XTickLabel');
                                                set(gca,'XTickLabel',a,'FontName','Times','fontsize',10);
                                                b = get(gca,'YTickLabel');
                                                set(gca,'YTickLabel',b,'FontName','Times','fontsize',10);

%                                                                                             set(gcf,'PaperPositionMode','auto')
% export_fig([FR filesep 'Vector_angle7'],'-native', '-a2', '-m4','-q101','-png', '-r600');
                                                        print([FR filesep 'Vector_angle7'], '-dpng', '-r300');
                                                                                        set(gcf,'Units','inches');
screenposition = get(gcf,'Position');
set(gcf,...
    'PaperPosition',[0 0 screenposition(3:4)],...
    'PaperSize',[screenposition(3:4)]);
% print -dpdf -painters epsFig
  
  
   print([FR filesep 'Vector_angle7'], '-dpdf', '-r300');  
                                                        
                                                       
MVAL=max([n11 n22]);
   
   [t,r] = rose(degtorad(data2'),18); 

ADJ=MVAL./max(r);
r=r*ADJ;

%# this does not generate a plot

%# set plot's max radial ticks
figure
rMax = MVAL;
h2 = compass(MVAL, 2);
set(h2,'Color',[1 1 1],'linewidth',0.001) 

%# draw patches instead of lines: polar(t,r)
[x,y] = pol2cart(t,r);
Cut=1.4;
Xin=reshape(x,4,[]);
Xin2=[Xin(1:2,:);mean(Xin(2:3,:));Xin(3:4,:)];
Xin2([2 4],:)=Xin2([2 4],:)./Cut;
Yin=reshape(y,4,[]);
Yin2=[Yin(1:2,:);mean(Yin(2:3,:));Yin(3:4,:)];
Yin2([2 4],:)=Yin2([2 4],:)./Cut;
h = patch(Xin2, Yin2, 'b');
alpha(h, 0.0)       %# note: this switches to OpenGL renderer
set(h,'EdgeColor','b','LineStyle',':','Linewidth',1.5);
hold on

   [arrowx,arrowy]=vekplot3(zeros(size(Center)),zeros(size(Center)),n22.*cosd(Center),n22.*sind(Center),0.99);
     plot(arrowx,arrowy,'Color',[0 0 1],'linewidth',1.5);



[t,r] = rose(degtorad(data1'),18);               %# this does not generate a plot

% ADJ=MVAL./max(r);
r=r*ADJ;
%# draw patches instead of lines: polar(t,r)
[x,y] = pol2cart(t+0.02,r);
Cut=1.4;
Xin=reshape(x,4,[]);
Xin2=[Xin(1:2,:);mean(Xin(2:3,:));Xin(3:4,:)];
Xin2([2 4],:)=Xin2([2 4],:)./Cut;
Yin=reshape(y,4,[]);
Yin2=[Yin(1:2,:);mean(Yin(2:3,:));Yin(3:4,:)];
Yin2([2 4],:)=Yin2([2 4],:)./Cut;
h = patch(Xin2, Yin2, 'r');
alpha(h, 0.0)             
 set(h,'EdgeColor','r','LineStyle',':','Linewidth',1.5); 
 
 hold on
    [arrowx,arrowy]=vekplot3(zeros(size(Center)),zeros(size(Center)),n11.*cosd(Center+1),n11.*sind(Center+1),0.99);
     plot(arrowx,arrowy,'Color',[1 0 0],'linewidth',1.5);
 
%                        grid off                                                         
%                                                                                         hb = bar([1 2 3 4 5 6 7 8 9],valuesmean,0.6);
%                                                                                          set(hb,'edgecolor','none');
% grid off
% box off
text(-65,32,'Transfected','FontName','Times','fontsize',15,'Color',[0.8 0.1 0.1]);
text(-65,38,'Negative control','FontName','Times','fontsize',15,'Color',[0.1 0.1 0.8]);
% text(-35,21,'Others','FontName','Times','fontsize',15,'Color',[0.5 0.5 0.5]);
       
                                            title('Angular (360) beating direction histogram','FontName','Times','fontsize',20);
                                                                                
                                                ax = gca;
                                                grid off
                                                
                                                        a = get(gca,'XTickLabel');
                                                set(gca,'XTickLabel',a,'FontName','Times','fontsize',10);
                                                b = get(gca,'YTickLabel');
                                                set(gca,'YTickLabel',b,'FontName','Times','fontsize',10);

                                                                                            set(gcf,'PaperPositionMode','auto')

                                                        print([FR filesep 'Vector_angle8'], '-dpng', '-r300');
                                                                                        set(gcf,'Units','inches');
screenposition = get(gcf,'Position');
set(gcf,...
    'PaperPosition',[0 0 screenposition(3:4)],...
    'PaperSize',[screenposition(3:4)]);
% print -dpdf -painters epsFig
  
  
   print([FR filesep 'Vector_angle8'], '-dpdf', '-r300');  
   
   
   
           figure
           
           MVAL=max([n11 n22]);
   [t,r] = rose(degtorad(data2'),18); 
ADJ=MVAL./max(r);
r=r*ADJ;

rMax = MVAL;
h2 = compass(MVAL, 2);
set(h2,'Color',[1 1 1],'linewidth',0.001) 

%# draw patches instead of lines: polar(t,r)
[x,y] = pol2cart(t,r);
Cut=1.4;
Xin=reshape(x,4,[]);
Xin2=[Xin(1:2,:);mean(Xin(2:3,:));Xin(3:4,:)];
Xin2([2 4],:)=Xin2([2 4],:)./Cut;
Yin=reshape(y,4,[]);
Yin2=[Yin(1:2,:);mean(Yin(2:3,:));Yin(3:4,:)];
Yin2([2 4],:)=Yin2([2 4],:)./Cut;
h = patch(Xin2, Yin2, 'w');
alpha(h, 1)       %# note: this switches to OpenGL renderer
set(h,'EdgeColor',[0.1 0.1 0.8],'LineStyle',':','Linewidth',.5);  
                       hold on                                                         

  [arrowx,arrowy]=vekplot3(zeros(size(Center)),zeros(size(Center)),n22.*cosd(Center),n22.*sind(Center),0.99);
     plot(arrowx,arrowy,'Color',[0 0 1],'linewidth',1);



[t,r] = rose(degtorad(data1'),18);               %# this does not generate a plot

% ADJ=MVAL./max(r);
r=r*ADJ;
%# draw patches instead of lines: polar(t,r)
[x,y] = pol2cart(t+0.02,r);
Cut=1.4;
Xin=reshape(x,4,[]);
Xin2=[Xin(1:2,:);mean(Xin(2:3,:));Xin(3:4,:)];
Xin2([2 4],:)=Xin2([2 4],:)./Cut;
Yin=reshape(y,4,[]);
Yin2=[Yin(1:2,:);mean(Yin(2:3,:));Yin(3:4,:)];
Yin2([2 4],:)=Yin2([2 4],:)./Cut;
h = patch(Xin2, Yin2, 'w');
alpha(h, 1)             
 set(h,'EdgeColor',[0.8 0.1 0.1],'LineStyle',':','Linewidth',1); 
 
 hold on
    [arrowx,arrowy]=vekplot3(zeros(size(Center)),zeros(size(Center)),n11.*cosd(Center+1),n11.*sind(Center+1),0.99);
     plot(arrowx,arrowy,'Color',[1 0 0],'linewidth',.5);                       
                       
 
text(-65,32,'Transfected','FontName','Times','fontsize',15,'Color',[0.8 0.1 0.1]);
text(-65,38,'Negative control','FontName','Times','fontsize',15,'Color',[0.1 0.1 0.8]);
% text(-35,21,'Others','FontName','Times','fontsize',15,'Color',[0.5 0.5 0.5]);
       
                                            title('Angular (360) beating direction histogram','FontName','Times','fontsize',20);
                                                                                
                                                ax = gca;
                                                grid off
                                                
                                                        a = get(gca,'XTickLabel');
                                                set(gca,'XTickLabel',a,'FontName','Times','fontsize',10);
                                                b = get(gca,'YTickLabel');
                                                set(gca,'YTickLabel',b,'FontName','Times','fontsize',10);

%                                                                                             set(gcf,'PaperPositionMode','auto')
 set(gcf,'PaperPositionMode','auto')
%  export_fig([FR filesep 'Vector_angle9'],'-native', '-a2', '-m4','-q101','-png', '-r600');
                                                        print([FR filesep 'Vector_angle9'], '-dpng', '-r600');
                                                                                        set(gcf,'Units','inches');
screenposition = get(gcf,'Position');
set(gcf,...
    'PaperPosition',[0 0 screenposition(3:4)],...
    'PaperSize',[screenposition(3:4)]);
% print -dpdf -painters epsFig
  
  
   print([FR filesep 'Vector_angle9'], '-dpdf', '-r300');     
   
   