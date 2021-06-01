%############################################################################
% <Lab 10>
%
% Course: ENSC 180 Introduction to Engineering Analysis
% Instructor: Dr. Herbert H. Tsang
% Description: <using matlab functions to blurr and sharpen images.>
% Due date: <  2020/04/03 >
%
% Author: < Daniel Istifanus >
% Input: < Reading a .tiff image>
% Output: < Blurred imagesand a Sharpened image >
% I pledge that I have completed the programming assignment independently.
% I have not copied the code from a student or any source.
% I have not given my code to any student.
%
% Sign here: ___<Daniel Istifanus>_______
%############################################################################
clear;

%% ------------- Task 1 -------------
%Reading the image
X = imread('4.1.04.tiff');

%Converting to double
X = double(X);

%Extending image by 1 pixel on each side
Y = wextend('2D', 'sym', X, [1,1]);

%obtain row,column and plane
[r,c,p] = size(Y);

%Averaging each pixel by its 8 neighbors
for k = 1:p
 for i = 2:r-1
 for j = 2:c-1
           
    temp=Y(i,j,k)+Y(i-1,j,k)+Y(i,j-1,k)+Y(i-1,j-1,k)+Y(i+1,j+1,k)+Y(i-1,j+1,k)...
    +Y(i+1,j,k)+Y(i,j+1,k)+ Y(i+1,j-1,k); 
    Y(i,j,k)=temp/9;
 end
 end
 end
X1=Y;

%Displaying the original image
figure(1);
imshow(uint8(X));

%Displaying the new image
figure(2);
imshow(uint8(X1));




%% ------------- Task 2 -------------
%Extending image by 2 pixel on each side
Z = wextend('2D', 'sym', X, [2,2]);

%obtain row,column and plane
[r,c,p] = size(Z);


%Averaging each pixel by its  24 neighbors
for k = 1:p
 for i = 3:r-2
 for j = 3:c-2
           
    temp=Z(i,j,k)+Z(i-1,j,k)+Z(i-2,j,k)+Z(i,j-1,k)+Z(i,j-2,k)+Z(i-1,j-1,k)...
    +Z(i-2,j-2,k)+Z(i+1,j+1,k)+Z(i+2,j+2,k)+Z(i-1,j+1,k)+Z(i-2,j+2,k)...
    +Z(i+1,j,k)+Z(i+2,j,k)+Z(i,j+1,k)+Z(i,j+2,k)+ Z(i+1,j-1,k)+ Z(i+2,j-2,k)...
    + Z(i-2,j-1,k)+Z(i-2,j+1,k)+Z(i-1,j+2,k)+Z(i+1,j+2,k)+Z(i+2,j+1,k)...
    +Z(i+2,j-1,k)+Z(i+1,j-2,k)+Z(i-1,j-2,k);
    Z(i,j,k)=temp/25;
 end
 end
end
 
X2=Z;

%Displaying the new figure with 2 pixels on each side
figure(3);
imshow(uint8(X2));



%% ------------- Task 3 -------------
%Using he fspecial Averaging function to blurr the original image by 1
%pixel
H = fspecial('average',[3 3]);
X3_1 = imfilter(uint8(X), H, 'symmetric', 'same');
%Displaying the blurred image which is quite similar to our image in task 1
figure(4);
imshow(X3_1);

%Using he fspecial Averaging function to blurr the original image by 2
%pixels
I = fspecial('average',[5 5]);
X3_2 = imfilter(uint8(X), I, 'symmetric', 'same');
%Displaying the blurred image which is quite similar to our image in task 2
figure(5);
imshow(X3_2);

%Using he fspecial gaussian function to blurr the original image by 2
%pixels with sigma as 2
J= fspecial('gaussian',[5 5],2);
X3_3=imfilter(uint8(X), J, 'symmetric', 'same');
%Displaying the blurred image which is quite similar to our image in task 2
figure(6);
imshow(X3_3);



%% ------------- Task 4 -------------
Xb=X2;

%Further blurring X2 using the guassian kernel
Xg=double(imfilter(uint8(X2), J, 'symmetric', 'same'));

%0.63 is the best scaling parameter
c=0.63;

%Implement the sharpening function
X4=(Xb*(c./(2.*c -1)))-(Xg*((1-c)./(2.*c-1)));
%Displaying the new sharpened image
figure(7);
imshow(uint8(X4));