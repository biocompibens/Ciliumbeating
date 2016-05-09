clear all
close all
clc

clc
yelo=[1 1 0];
red=[1 0 0];
green=[0 1 0];
white=[1 1 1];

   h = fspecial('gaussian',[3 3],0.5);

%     Datahome = uigetdir(pwd, 'Pick directory of Dataset');
%    Reshome = uigetdir(pwd, 'Pick directory of Results');
%    
%    Datahome=[Datahome filesep];
%     Reshome=[Reshome filesep];
Datahome='C:\ENS_CILTEX\ND vectors\TestR\';
Reshome='C:\ENS_CILTEX\ND vectors\TestR\';

Algorithm=2;

d=dir(fullfile(Datahome,'*Result.xlsx*'));
Types={d.name};

for imgid=1:numel(Types)
    
    filename=Types{imgid};
      
      filename2=strrep(filename,'_Result.xlsx','');
      Types{imgid}=filename2;
    
end

List{1}=[1];
List{2}=[1];
List{3}=[1];
List{4}=[1];
List{5}=[1];
List{6}=[1];
List{7}=[1];
List{8}=[1];
List{9}=[1];
List{10}=[1];

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

load([Reshome 'All_vector_angle.mat'],'CANG','CANN');  
NUMT=[];
NUMN=[];
NUMAR=[];
for imgid=1:numel(Types)
%     
      filename=Types{imgid};
      
      filename2=strrep(filename,'.czi','');
      resfile = [Reshome filename2 '_Result.xlsx'];
NUMTt = xlsread(resfile,'sheet1');
NUMTt=NUMTt(:,8);
NUMNt = xlsread(resfile,'sheet2');
NUMNt=NUMNt(:,8);
NUMARt = xlsread(resfile,'sheet3');
NUMARt=NUMARt(:,8);

NUMT=[NUMT;NUMTt];
NUMN=[NUMN;NUMNt];
NUMAR=[NUMAR;NUMARt];

end


data1=NUMT;
data2=NUMN;
data3=NUMAR;

col=[0.5 .1 .1; 0.5 0.5 0.5; 0.7 0.7 0.1];

                                            minS=0;
                                            maxS=180;

                                            Distk=[0 20 40 60 80 100 120 140 160 180];
                                            figure()
                                            [n1,x11] = histc(data1',Distk);
                                            n1(10)=[];
                                             [n2,x22] = histc(data2',Distk);
                                            n2(10)=[];
                                             [n3,x33] = histc(data3',Distk);
                                            n3(10)=[];
                                                                                     
        n11=100*n1/sum(n1);
            n22=100*n2/sum(n2);
                n33=100*n3/sum(n3);
                                                                          valuesmean=[n11' n22' n33'];                        
                                                                                   index = Distk; 
                                                                                        hb = bar([1 2 3 4 5 6 7 8 9],valuesmean,0.6);
                                                                                         set(hb,'edgecolor','none');
                                                                                         
                                                                
                                                                                   h1=legend({'Transfected','Neighbouring','Others'}, 'Location', 'northeast'); 
                                                                                   set(h1,'FontSize',15);

                                                                                   set(gca, 'Ticklength', [0 0])

                                                                                legend('boxoff')
                                                                                % col=summer(5);

                                                                                hbc = get(hb, 'Children');
                                                                                set(hbc{1}, 'FaceColor', col(1,:));
                                                                                set(hbc{2}, 'FaceColor', col(2,:));
                                                                                set(hbc{3}, 'FaceColor', col(3,:));
                                                                      

                                                                                hbch1 = get(hbc{1}, 'FaceColor');
                                                                                hbch2 = get(hbc{2}, 'FaceColor');
                                                                                hbch3 = get(hbc{3}, 'FaceColor');
                                                                
                                                                                hc = findobj(h1, '-property', 'FaceColor');

                                                                                set(hc(1), 'FaceColor', hbch3)
                                                                                set(hc(2), 'FaceColor', hbch2)
                                                                                set(hc(3), 'FaceColor', hbch1)
                                                                   

                                             
                                                                                 
                                            xlim([.5 9.5])
                                            ylim([0 max(valuesmean(:))+5])

%                                             xlabel('Angular deviation from principal direction','FontSize', 17,'FontName','Times') % x-axis label
                                            ylabel('Percentile','FontSize', 17,'FontName','Times') % y-axis label
%                                             title('Probability density function');
                                            
                                     

                                                                                 set(gca, 'Ticklength', [0 0])
                                                                                 set(gca,'XTick',1:9)
                                                                                    ax = gca;
                                               set(ax,'XTickLabel',{[sprintf('0%c-20%c',char(176),char(176))],...
                                                   [sprintf('20%c-40%c',char(176),char(176))],...
                                                   [sprintf('40%c-60%c',char(176),char(176))],...
                                                   [sprintf('60%c-80%c',char(176),char(176))],...
                                                   [sprintf('80%c-100%c',char(176),char(176))],...
                                                   [sprintf('100%c-120%c',char(176),char(176))],...
                                                   [sprintf('120%c-140%c',char(176),char(176))],...
                                                   [sprintf('140%c-160%c',char(176),char(176))],...
                                                   [sprintf('160%c-180%c',char(176),char(176))]});
                                                ax = gca;
                                                grid off

%                                                 legend('boxoff')

%                                               xticklabel_rotate([],85,[],'Fontsize',14)


                                                    title('Cilia beating direction histogram','FontSize', 20,'FontName','Times');
% 
                                                a = get(gca,'XTickLabel');
                                                set(gca,'XTickLabel',a,'FontName','Times','fontsize',10);
                                                b = get(gca,'YTickLabel');
                                                set(gca,'YTickLabel',b,'FontName','Times','fontsize',10);
                                                  
                                                set(hc(1), 'FaceColor', hbch3)
                                                                                set(hc(2), 'FaceColor', hbch2)
                                                                                set(hc(3), 'FaceColor', hbch1)
                                                                                
                                                                                 xticklabel_rotate([],45,[]);

%                                                 ha = axes('Position',[0 0 1 1],'Xlim',[0 1],'Ylim',[0 1],'Box','off','Visible','off','Units','normalized', 'clipping' , 'off');
                                                %                                             text(0.5,1,['Comparison of nMI' ],'HorizontalAlignment','center','VerticalAlignment', 'top');
                                                                                            set(gcf,'PaperPositionMode','auto')

                                                        print([Reshome 'Vector_angle'], '-dpng', '-r300');
                                                                                        set(gcf,'Units','inches');
screenposition = get(gcf,'Position');
set(gcf,...
    'PaperPosition',[0 0 screenposition(3:4)],...
    'PaperSize',[screenposition(3:4)]);
% print -dpdf -painters epsFig
  
  
   print([Reshome 'Vector_angle'], '-dpdf', '-r300');  
        
 
                                                        
                                                        
NUMT=[];
NUMN=[];
NUMAR=[];
for imgid=1:numel(Types)
%     
      filename=Types{imgid};
      
      filename2=strrep(filename,'.czi','');
      resfile = [Reshome filename2 '_Result.xlsx'];
NUMTt = xlsread(resfile,'sheet1');
NUMTt=NUMTt(:,7);
NUMNt = xlsread(resfile,'sheet2');
NUMNt=NUMNt(:,7);
NUMARt = xlsread(resfile,'sheet3');
NUMARt=NUMARt(:,7);

NUMT=[NUMT;NUMTt];
NUMN=[NUMN;NUMNt];
NUMAR=[NUMAR;NUMARt];

end


data1=NUMT;
data2=NUMN;
data3=NUMAR;

col=[0.5 .1 .1; 0.5 0.5 0.5; 0.7 0.7 0.1];

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
               figure
              h1=compass(n11.*cosd(Center),n11.*sind(Center)); 
               set(h1,'Color',[0.5 0.25 0.25],'linewidth',0.5) 
                hold on, h2=compass(n22.*cosd(Center),n22.*sind(Center));
                    set(h2,'Color',[0 0 0],'linewidth',1) 
                 hold on, h3=compass(n33.*cosd(Center),n33.*sind(Center));    
                       set(h3,'Color',[0.5 0.5 0],'linewidth',1.5)  
                       hold on                                                         
%                                                                                         hb = bar([1 2 3 4 5 6 7 8 9],valuesmean,0.6);
%                                                                                          set(hb,'edgecolor','none');
 
text(-28,15,'Transfected','FontName','Times','fontsize',15,'Color',[0.5 0.25 0.25]);
text(-28,20,'Neighbouring','FontName','Times','fontsize',15,'Color',[0 0 0]);
text(-28,25,'Others','FontName','Times','fontsize',15,'Color',[0.5 0.5 0]);

                                                                
                                    
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

                                                        print([Reshome 'Vector_angle2'], '-dpng', '-r300');
                                                                                        set(gcf,'Units','inches');
screenposition = get(gcf,'Position');
set(gcf,...
    'PaperPosition',[0 0 screenposition(3:4)],...
    'PaperSize',[screenposition(3:4)]);
% print -dpdf -painters epsFig
  
  
   print([Reshome 'Vector_angle2'], '-dpdf', '-r300');  
                                                        
                                                       
NUMT=[];
NUMN=[];
NUMAR=[];
for imgid=1:numel(Types)
%     
      filename=Types{imgid};
      
      filename2=strrep(filename,'.czi','');
      resfile = [Reshome filename2 '_Result.xlsx'];
NUMTt = xlsread(resfile,'sheet4');
NUMTt=NUMTt(:,[6 10 11]);

NUMT=[NUMT;NUMTt];
end

data1=NUMT;
               figure
              h1=compass(NUMT(NUMT(:,3)==1,2).*cosd(NUMT(NUMT(:,3)==1,1)),NUMT(NUMT(:,3)==1,2).*sind(NUMT(NUMT(:,3)==1,1))); 
               set(h1,'Color',[.5 .5 0],'linewidth',.5) 
            hold on
            h2=compass(NUMT(NUMT(:,3)==2,2).*cosd(NUMT(NUMT(:,3)==2,1)),NUMT(NUMT(:,3)==2,2).*sind(NUMT(NUMT(:,3)==2,1)));
                    set(h2,'Color',[0 0 0],'linewidth',1) 
            hold on
                    h3=compass(NUMT(NUMT(:,3)==3,2).*cosd(NUMT(NUMT(:,3)==3,1)),NUMT(NUMT(:,3)==3,2).*sind(NUMT(NUMT(:,3)==3,1)));
                       set(h3,'Color',[0.5 0.25 0.25],'linewidth',1.5)  
                       hold on                                                         
%                                                                                         hb = bar([1 2 3 4 5 6 7 8 9],valuesmean,0.6);
%                                                                                          set(hb,'edgecolor','none');
 
text(-1000,450,'Transfected','FontName','Times','fontsize',15,'Color',[0.5 0.25 0.25]);
text(-1000,650,'Neighbouring','FontName','Times','fontsize',15,'Color',[0 0 0]);
text(-1000,850,'Others','FontName','Times','fontsize',15,'Color',[0.5 0.5 0]);
                           
                                            title('Angular (360) beating direction','FontName','Times','fontsize',20);
                                                                                
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

                                                        print([Reshome 'Vector_angle3'], '-dpng', '-r300');
                                                        
                                                         set(gcf,'Units','inches');
screenposition = get(gcf,'Position');
set(gcf,...
    'PaperPosition',[0 0 screenposition(3:4)],...
    'PaperSize',[screenposition(3:4)]);
% print -dpdf -painters epsFig
  
  
   print([Reshome 'Vector_angle3'], '-dpdf', '-r300');  
%                                                         close all


                                                        
                                                        
NUMT=[];
NUMN=[];
NUMAR=[];
for imgid=1:numel(Types)
%     
      filename=Types{imgid};
      
      filename2=strrep(filename,'.czi','');
      resfile = [Reshome filename2 '_Result.xlsx'];
NUMTt = xlsread(resfile,'sheet1');
NUMTt=NUMTt(:,8);
NUMNt = xlsread(resfile,'sheet2');
NUMNt=NUMNt(:,8);
NUMARt = xlsread(resfile,'sheet3');
NUMARt=NUMARt(:,8);

NUMT=[NUMT;NUMTt];
NUMN=[NUMN;NUMNt];
NUMAR=[NUMAR;NUMARt];

end


data1=NUMT;
data2=NUMN;
data3=NUMAR;

col=[0.5 .1 .1; 0.5 0.5 0.5; 0.7 0.7 0.1];

                                            minS=0;
                                            maxS=360;

                                            Distk=[0 20 40 60 80 100 120 140 160 180];
                                            Center=[10 30 50 70 90 110 130 150 170];
%                                             figure()
                                            [n1,x11] = histc(data1',Distk);
                                            n1(10)=[];
                                             [n2,x22] = histc(data2',Distk);
                                            n2(10)=[];
                                             [n3,x33] = histc(data3',Distk);
                                            n3(10)=[];
                                                                                     
        n11=100*n1/sum(n1);
            n22=100*n2/sum(n2);
                n33=100*n3/sum(n3);
                                                                          valuesmean=[n11' n22' n33'];                        
                                                                                   index = Distk; 
               figure
              h1=compass(n11.*cosd(Center),n11.*sind(Center)); 
               set(h1,'Color',[.5 .25 .25],'linewidth',0.5) 
                hold on, h2=compass(n22.*cosd(Center),n22.*sind(Center));
                    set(h2,'Color',[0 0 0],'linewidth',1) 
                 hold on, h3=compass(n33.*cosd(Center),n33.*sind(Center));    
                       set(h3,'Color',[0.5 0.5 0],'linewidth',1.5)  
                       hold on                                                         
%                                                                                         hb = bar([1 2 3 4 5 6 7 8 9],valuesmean,0.6);
%                                                                                          set(hb,'edgecolor','none');
 
text(-28,21,'Transfected','FontName','Times','fontsize',15,'Color',[0.5 0.25 0.25]);
text(-28,28,'Neighbouring','FontName','Times','fontsize',15,'Color',[0 0 0]);
text(-28,35,'Others','FontName','Times','fontsize',15,'Color',[0.5 0.5 0]);

                                                                
                                    
                                            title('Angular (180) beating direction histogram','FontName','Times','fontsize',20);
                                                                                
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

                                                        print([Reshome 'Vector_angle4'], '-dpng', '-r300');
                                                                                        set(gcf,'Units','inches');
screenposition = get(gcf,'Position');
set(gcf,...
    'PaperPosition',[0 0 screenposition(3:4)],...
    'PaperSize',[screenposition(3:4)]);
% print -dpdf -painters epsFig
  
  
   print([Reshome 'Vector_angle4'], '-dpdf', '-r300');  
   
   
   
   
   
   NUMT=[];
NUMN=[];
NUMAR=[];
for imgid=1:numel(Types)
%     
      filename=Types{imgid};
      
      filename2=strrep(filename,'.czi','');
      resfile = [Reshome filename2 '_Result.xlsx'];
NUMTt = xlsread(resfile,'sheet4');
NUMTt=NUMTt(:,[6 10 11]);

NUMT=[NUMT;NUMTt];
end

data1=NUMT(:,1);


col=[0.5 .1 .1; 0.5 0.5 0.5; 0.7 0.7 0.1];

                                            minS=0;
                                            maxS=360;

                                            Distk=[0 20 40 60 80 100 120 140 160 180 200 220 240 260 280 300 320 340 360];
                                            Center=[10 30 50 70 90 110 130 150 170 190 210 230 250 270 290 310 330 350];
%                                             figure()
                                            [n1,x11] = histc(data1(NUMT(:,3)==1,1)',Distk);
                                            n1(19)=[];
                                             [n2,x22] = histc(data1(NUMT(:,3)==2,1)',Distk);
                                            n2(19)=[];
                                             [n3,x33] = histc(data1(NUMT(:,3)==3,1)',Distk);
                                            n3(19)=[];
                                                                                     
%         n11=100*mat2gray(n1/sum(n1));
%             n22=100*mat2gray(n2/sum(n2));
%                 n33=100*mat2gray(n3/sum(n3));
                
                        n11=100*n1/sum(n1);
            n22=100*n2/sum(n2);
                n33=100*n3/sum(n3);
                
%                  n11=n1;
%             n22=n2;
%                 n33=n3;
                                                                          valuesmean=[n11' n22' n33'];                        
                                                                                   index = Distk; 
               figure
               
                  h3=compass(n33.*cosd(Center),n33.*sind(Center));    
                       set(h3,'Color',[0.5 0.25 0.25],'linewidth',0.5)  
                       hold on 
                       
                    h1=compass(n11.*cosd(Center),n11.*sind(Center)); 
               set(h1,'Color',[0.5 0.5 0],'linewidth',1.5) 
                hold on 
           
                       h2=compass(n22.*cosd(Center),n22.*sind(Center));
                    set(h2,'Color',[0 0 0],'linewidth',1) 
                 hold on
                 
                  
         
                                                           
%                                                                                         hb = bar([1 2 3 4 5 6 7 8 9],valuesmean,0.6);
%                                                                                          set(hb,'edgecolor','none');
 
text(-80,39,'Transfected','FontName','Times','fontsize',15,'Color',[0.5 0.25 0.25]);
text(-80,52,'Neighbouring','FontName','Times','fontsize',15,'Color',[0 0 0]);
text(-80,65,'Others','FontName','Times','fontsize',15,'Color',[0.5 0.5 0]);
                           
                                            title('Angular (360) beating global histogram','FontName','Times','fontsize',20);
                                                                                
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

                                                        print([Reshome 'Vector_angle5'], '-dpng', '-r300');
                                                        
                                                         set(gcf,'Units','inches');
screenposition = get(gcf,'Position');
set(gcf,...
    'PaperPosition',[0 0 screenposition(3:4)],...
    'PaperSize',[screenposition(3:4)]);
% print -dpdf -painters epsFig
  
  
   print([Reshome 'Vector_angle5'], '-dpdf', '-r300');  