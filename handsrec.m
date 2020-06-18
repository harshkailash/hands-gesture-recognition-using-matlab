%gui code
function varargout = guidemo(varargin)

gui_Singleton = 1;

gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @guidemo_OpeningFcn, ...
                   'gui_OutputFcn',  @guidemo_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end
%gui code ends
if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code
% --- Executes just before captureGUI is made visible.
function Calcular_Callback(hObject, eventdata, handles)
  disp('Calcular_Callback called. What did you want to happen at this point?')
function guidemo_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved 
% handles    structure with handles and user data
% varargin   command line arguments to captureGUI
% Choose default command line output for captureGUI
handles.output = hObject;
% clear;
s1='0';
set(handles.timer,'String',s1);
s1='0';
set(handles.edit2,'String',s1);
s1='0';
set(handles.edit4,'String',s1);

axes(handles.axes1);
imshow(a);

%axes(handles.axes2);
%imshow(b);
axes(handles.axes3);
imshow(b);
axes(handles.axes4);
imshow(b);
axes(handles.axes5);
imshow(b);
axes(handles.axes6);
imshow(b);
guidata(hObject, handles);

% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = guidemo_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data

% Get default command line output from handles structure
varargout{1} = handles.output;

function Start_Callback(hObject, eventdata, handles)


%s1='Capturing Background';
%set(handles.edit2,'String',s1);
%set(handles.edit4,'String',s1);


%taking input from webcam
vid=videoinput('winvideo',1,'YUY2_640x480'); 
set(vid,'ReturnedColorSpace','rgb');                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
triggerconfig(vid,'manual'); 
%Capture one frame per trigger
set(vid,'FramesPerTrigger',1 );
set(vid,'TriggerRepeat', Inf);
start(vid); %start video

 BW = imread('mask.bmp'); %place where the sign is to be made
 BW=im2bw(BW);
 [B,L,N,A] = bwboundaries(BW);
axes(handles.axes1);
% imshow(BW); hold on;
       for k=1:length(B)
         if(~sum(A(k,:)))
           boundary = B{k};
           axes(handles.axes1);
           plot(boundary(:,2), boundary(:,1), 'r','LineWidth',2);
           for l=find(A(:,k))'
             boundary = B{l};
             axes(handles.axes1);
             save boundary boundary
             plot(boundary(:,2), boundary(:,1), 'g','LineWidth',2);
           end
         end
       end     
       % imshow(AA); hold on;
load boundary       
aa=1;
%Infinite while loop
load r;
load c;
%r=69:400;
%c=83:500;
while(1)
% preview(vid)
%Get Image
trigger(vid);
im=getdata(vid,1);
axes(handles.axes1);
imshow(im);
hold on
axes(handles.axes1);
plot(boundary(:,2), boundary(:,1), 'g','LineWidth',2);
aa=aa+1;
set(handles.timer,'String',num2str(aa));
disp(aa);
s1='Capturing Gesture';
set(handles.edit2,'String',s1);
if aa == 45
   break 
end
end
s1='Detecting Gesture';
set(handles.edit2,'String',s1);
stop(vid),delete(vid),clear vid; 
red=im(:,:,1);
Green=im(:,:,2);
Blue=im(:,:,3);
Out(:,:,1)=red(min(r):max(r),min(c):max(c));
Out(:,:,2)=Green(min(r):max(r),min(c):max(c));
Out(:,:,3)=Blue(min(r):max(r),min(c):max(c));
Out=uint8(Out);
imwrite(Out,'final.bmp');
%figure, 
axes(handles.axes3);
imshow(Out,[])
        a=imread('bg.bmp');
    img_input = Out;
 img_height = size(img_input,1);
  img_width = size(img_input,2);
  bin = zeros(img_height,img_width);
 Img_gray =grayalgo(img_input);
  figure;
  imshow(Img_gray);
  xlabel("grayworld");
  imgycbcr = rgb2ycbcr(Img_gray);
  YCb = imgycbcr(:,:,2);
  YCr = imgycbcr(:,:,3);
  [r,c,v] = find(YCb>=77 & YCb<=127 & YCr>=133 & YCr<=173);
  numind = size(r,1);
  for i=1:numind
    out(r(i),c(i),:) = [0 0 255];
    bin(r(i),c(i)) = 1;
  end
  axes(handles.axes4);
imshow(out,[]);
  figure; 
 imshow(out);
  figure; imshow(bin);
out=medfilt2(bin,[3 3]);
figure;
imshow(out);
xlabel("after filter");
ut=imfill(out,'holes');
figure;
imshow(ut);
C1 = imresize(ut,[256 256],'nearest');
axes(handles.axes5);
imshow(C1,[]);
str='.bmp';
str1='F'
for i=1:119
    a=strcat(num2str(i),str);
    b=imread(a);
    re1=corr2(b,C1);
    %correlation
    
      fresultValues_r(i) = re1;
    fresultNames_r(i) = {a};
  
    result1(i)=re1
    % figure;
     %subplot(1,2,1);imshow(C1);
     %subplot(1,2,2);imshow(b);
     %xlabel(re1);
end
%disp("huio");
%disp(max(result1));

[re image]=max(result1);
 a=strcat(num2str(image),str);
  fid1 = fopen('text.txt', 'a+');
 if image > 0 && image <= 10 || image>50 && image<57  
     s1='d';
     fprintf(fid1, '%s\r', s1);
     disp('d');
 elseif image > 10 && image <= 20 || image > 56 && image < 63 
     s1='v';
     fprintf(fid1, '%s\r', s1);
     disp('v');
 elseif image > 20 && image <= 30 || image > 62 && image < 70
     s1='y';
     fprintf(fid1, '%s\r', s1);
     disp('y');
  elseif image > 69 && image < 77 || image > 30 && image < 41
     s1='a';
     fprintf(fid1, '%s\r', s1);
     disp('a');
  elseif image > 40 && image <= 50 
      s1='s';
     fprintf(fid1, '%s\r', s1);
     disp('s');
  elseif image > 76 && image < 82 
     s1='f';
     fprintf(fid1, '%s\r', s1);
     disp('f');
  elseif image > 81 && image < 87 
     s1='x';
     fprintf(fid1, '%s\r', s1);
     disp('x');
  elseif image > 86 && image < 92 
     s1='q';
     fprintf(fid1, '%s\r', s1);
     disp('q');
  elseif image > 91 && image < 96 
     s1='l';
     fprintf(fid1, '%s\r', s1);
     disp('l');
   elseif image > 95 && image < 102 
     s1='w';
     fprintf(fid1, '%s\r', s1);
     disp('w');
     elseif image > 101 && image < 110 
     s1='u';
     fprintf(fid1, '%s\r', s1);
     disp('u');
     elseif image > 109 && image < 115 
     s1='b';
     fprintf(fid1, '%s\r', s1);
     disp('b');
     elseif image > 114 && image < 121 
     s1='i';
     fprintf(fid1, '%s\r', s1);
     disp('i');
     
 end
 fclose(fid1);
 fid3 = fopen('text.txt', 'r+');
 y='';
end
 %s1= fgets(fid1);
 s1='Output';
 fclose(fid1);
%s1='HELLO WELCOME';

b=imread(a);
axes(handles.axes6);
imshow(b);title('recognition result');
 speech(y);
[sortedValues_r, index_r] = sort(-fresultValues_r);
    fid = fopen('recognition.txt', 'w+');         
for i = 1:10
    imagename = char(fresultNames_r(index_r(i)));
    fprintf(fid, '%s\r', imagename);
end
disp('maximum correlation coefficient among pictures');
disp(max(result1));
fclose(fid);
disp('exit');
function timer_Callback(hObject, eventdata, handles)
function timer_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edit2_Callback(hObject, eventdata, handles)
function edit2_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function clear_Callback(hObject, eventdata, handles)
s1='0';
set(handles.timer,'String',s1);
s1='0';
set(handles.edit2,'String',s1);
s1='0';
set(handles.edit4,'String',s1);
a=ones(480,650);
axes(handles.axes1);
imshow(a);
b=ones(256,256);
axes(handles.axes3);
imshow(b);
axes(handles.axes4);
imshow(b);
axes(handles.axes5);
imshow(b);
axes(handles.axes6);
imshow(b);
function exit_Callback(hObject, eventdata, handles)
delete 'text.txt';
close all force
function edit4_Callback(hObject, eventdata, handles)
function edit4_CreateFcn(hObject, eventdata, handles)





