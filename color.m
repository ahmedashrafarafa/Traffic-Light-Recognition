I = imread('t4.png');
imshow(I);
colormap jet;
h = colorbar;
set(h, 'ylim', [100 150])
cmap = colormap; %get current colormap
cmap=cmap([10 20],:); % set your range here
colormap(cmap); % apply new colormap
colorbar();
figure, imshow(I)
disp(colorbar)