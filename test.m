I=imread('2.jpg');
%imhist(I);
%figure,imshow(I);
 red=I(:,:,1);
 green=I(:,:,2);
 blue=I(:,:,3);
 %imhist(red);
%figure,imshow(red);
% figure,imshow(green);
% figure,imshow(blue);


redthreshold = 200;
greenThreshold = 200;
blueThreshold = 200;

%disp(blobs(1).BoundingBox);


out=(red >= 0 ) & (red <= redthreshold)& ...
    (green >= 0 ) & (green <= greenThreshold) & ...
    (blue >= 0 ) & (blue <= blueThreshold);
%bw1=imcomplement(out);


[v,~]=bwlabel(out);
%disp(num);

blobs= regionprops(v,'BoundingBox');
hight=blobs(1).BoundingBox(4);
x=hight/3;

newy=blobs(1).BoundingBox(2);
y2=newy+x;
y3=y2+x;
arr1=[blobs(1).BoundingBox(1),blobs(1).BoundingBox(2),blobs(1).BoundingBox(3),x];
arr2=[blobs(1).BoundingBox(1),y2,blobs(1).BoundingBox(3),x];
arr3=[blobs(1).BoundingBox(1),y3,blobs(1).BoundingBox(3),x];

I1 = imcrop(out,arr1);
[~,num1]=bwlabel(I1);
disp(num1);

I2 = imcrop(out,arr2);
[~,num2]=bwlabel(I2);
disp(num2);
I3 = imcrop(out,arr3);
[~,num3]=bwlabel(I3);
disp(num3);
if num1==1
    disp('Light:Red');

elseif num2==1
    disp('Light:yellow');

elseif num3==1
    disp('Light:green')
end


%I = imcrop(image,arr);

 figure,imshow(I1);
 figure,imshow(I2);
 figure,imshow(I3);
% BWnobord = imclearborder(out,4);
% figure,imshow(BWnobord);
%o=green>50;
%figure,imshow(out);