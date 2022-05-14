clear,clc,close all
image=imread('1.jpg');
%figure,imshow(image);
%title('Original image');
b=image(:,:,3);
%figure,imshow(image)
%I = rgb2gray(image);
%figure,imshow(I);
bw1=im2bw(b);
%figure,imshow(I);
%bw = imbinarize(I);
%figure,imshow(bw);
bw=imcomplement(bw1);
%figure,imshow(bw);
bwfill= imfill(bw,'holes');
%figure,imshow(bwfill);
seD = strel('disk',10);
BWfinal=imopen(bwfill,seD);





[v,~]=bwlabel(BWfinal);
%disp(num);
%figure,imshow(BWfinal);
blobs= regionprops(v,'BoundingBox');



%figure,imshow(BWfinal);

%disp(blobs(1).BoundingBox);
%disp(blobs(2).BoundingBox);



[~,num]=bwlabel(BWfinal);
%disp(num);
if num>1
    for i=1:num
       width=blobs(i).BoundingBox(3);
       hight=blobs(i).BoundingBox(4);
       %disp(blobs(i).BoundingBox);

       diff=abs(width-hight);

       area=width*hight;

       %disp(diff);
       if diff<50
           BWfinal = bwareaopen(BWfinal, area);
           %disp('****')
       end

    end
end

%label=bwlabel(BWfinal);
%ima=(label==1);
%figure,imshow(label==1);

[~,num]=bwlabel(BWfinal);
%disp(num);

   if num>1
       BWnobord = imclearborder(bw,4);
       %figure,imshow(BWnobord);
       seD = strel('rectangle',[20 ,20]);
       BWfinal=imopen(BWnobord,seD);
   end
   




%seD = strel('square',19);
%seD = strel('rectangle',[20 20]);

%figure,imshow(BWfinal);
%title('Segmented Image');

s=regionprops(BWfinal,'Centroid','Area','Perimeter');
cen=cat(1,s.Centroid);
area=cat(1,s.Area);
per=cat(1,s.Perimeter);

hold on
plot(cen(:,1),cen(:,2),'b*');
hold on


[B,L] = bwboundaries(BWfinal,'noholes');
%disp(B(1));

%figure,imshow(labeloverlay(image,BWfinal));
%title('Mask Over Original Image');

s=regionprops(BWfinal,'BoundingBox');
bbox=cat(1,s.BoundingBox);
image= insertShape(image,'rectangle',bbox,'color','g');
%figure,imshow(image);
%title('detection');


[x,~]=bwlabel(BWfinal);
blobs= regionprops(x,'BoundingBox');
arr=blobs(1).BoundingBox();
disp(arr);
I = imcrop(image,arr);
%figure,imshow(I);
%title('cropped image');



%show results
% figure,
% subplot(2,2,1),imshow(image);title('Original Image');
% subplot(2,2,2),imshow(BWfinal);title('Segmented Image');
% subplot(2,2,3),imshow(labeloverlay(image,BWfinal));title('Mask Over Original Image');
% subplot(2,2,4),imshow(ima);title('Sign Detection');
% subplot(2,2,5),imshow(I);title('cropped image');