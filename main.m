clear,clc,close all
%-------------------------------------------------------------------------
%Sign Detection:
%---------------
image=imread('8.jpg');
figure,imshow(image);
title('Original image');
I = rgb2gray(image);
I = imbinarize(I);
I=imcomplement(I);
I= imfill(I,'holes');
seD = strel('rectangle',[20 ,10]);
I=imopen(I,seD);
I = bwareaopen(I, 800);
%figure,imshow(I);

[labels,objects]=bwlabel(I);

if objects>1
    
    blobs= regionprops(labels,'Area');
    Clear_other_objects = ismember(labels, find([blobs.Area] ==885582 ...
    | [blobs.Area] ==4866 ...
    | [blobs.Area] ==41201));
    I = imclearborder(Clear_other_objects);
    
    if blobs(1).Area ==885582
        seD = strel('rectangle',[200,300]);
        I=imopen(I,seD);
    end
    
end

 %figure,imshow(I);
 %title('Segmented Image');

 %figure,imshow(labeloverlay(image,I));
 %title('Mask Over Original Image');

%--------------------------------------------------------------------------
%Sign Recognition:
%-----------------
blobs= regionprops(I,'BoundingBox');
Image = imcrop(image,blobs(1).BoundingBox());
%figure,imshow(Image);
%title('cropped image');
choice=1;
%----------------------------------
%Red Recognition using thresholder:
%----------------------------------

Red_Min = 200.000;
Red_Max = 255.000;

Green_Min = 0.000;
Green_Max = 120.000;

Blue_Min = 0.000;
Blue_Max = 120.000;

I = (Image(:,:,1) >= Red_Min ) & (Image(:,:,1) <= Red_Max) & ...
    (Image(:,:,2) >= Green_Min) & (Image(:,:,2) <= Green_Max) & ...
    (Image(:,:,3) >= Blue_Min) & (Image(:,:,3) <= Blue_Max);

I= bwareaopen(I, 20);
[~,objects]=bwlabel(I);
disp(objects)

%-------------------------------------
%Yellow Recognition using thresholder:
%-------------------------------------
if objects==0
   
    Red_Min = 200.000;
    Red_Max = 255.000;

    Green_Min = 149.000;
    Green_Max = 255.000;

    Blue_Min = 0.000;
    Blue_Max = 47.000;

    I = (Image(:,:,1) >= Red_Min ) & (Image(:,:,1) <= Red_Max) & ...
        (Image(:,:,2) >= Green_Min) & (Image(:,:,2) <= Green_Max) & ...
        (Image(:,:,3) >= Blue_Min) & (Image(:,:,3) <= Blue_Max);

    [~,objects]=bwlabel(I);
    disp(objects)
    choice=2;
    %-------------------------------------
    %Green Recognition using thresholder:
    %-------------------------------------
    if objects==0
        Red_Min = 0.000;
        Red_Max = 120.000;

        Green_Min = 170.000;
        Green_Max = 255.000;

        Blue_Min = 0.000;
        Blue_Max = 220.000;
        
        I = (Image(:,:,1) >= Red_Min ) & (Image(:,:,1) <= Red_Max) & ...
            (Image(:,:,2) >= Green_Min) & (Image(:,:,2) <= Green_Max) & ...
            (Image(:,:,3) >= Blue_Min) & (Image(:,:,3) <= Blue_Max);
        choice=3;
    end

end

%figure,imshow(I)
 
 if choice==1
     figure,imshow(Image);
     title('Light:Red');
     disp('Light:Red');
 elseif choice==2
     figure,imshow(Image);
     title('Light:Yellow');
     disp('Light:Yellow');
 else
     figure,imshow(Image);
     title('Light:Green');
     disp('Light:Green');
 end