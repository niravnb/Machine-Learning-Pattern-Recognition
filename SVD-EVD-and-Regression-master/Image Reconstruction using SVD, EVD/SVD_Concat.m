function [ forbeniusNormarray ] = SVD( img,N,imagetype )
%% To perform SVD on given Image and return frobenius Norm

%% Performing SVD & Reconstructing Original Image
[U S V] = my_svd(double(img));

reconstructedImage = U*S*V';
reconstructedImageConcat=ReconstructedConcat(reconstructedImage);

% figure;
% subplot(2,1,1); imshow(uint8(ReconstructedConcat(img))); title('Original image');
% subplot(2,1,2); imshow(uint8(reconstructedImageConcat)); title('Reconstructed image using SVD');

forbeniusNormError = frobeniusNorm(reconstructedImage,double(img));
fprintf('frobenius Norm on reconstructed image with original image %f \n',forbeniusNormError);    

%% Selecting Top N Eigne Values and reconstructing image with corresponding error image


forbeniusNormarray = zeros(1,length(N));
i = 1;
j = 1;
for n = N 
    kEigVal = S;
    kEigVal(n+1:end,:) = 0;

     reconstructedImagewithN = U*kEigVal*V';
     reconstructedImagewithNConcat=ReconstructedConcat(reconstructedImagewithN);
   
     subplot(3,4,j); imshow(uint8(reconstructedImagewithNConcat)); 
    if i > 3
         title(['Reconstructed image for random N = ',num2str(n),' singular values']);
    else
         title(['Reconstructed image for top N = ',num2str(n),' singular values']);
    end    
   
     errorImageN = reconstructedImage-reconstructedImagewithN;
    subplot(3,4,j+1); imshow(uint8(ReconstructedConcat(errorImageN))); 
    if i > 3
          title(['Error image for random N = ',num2str(n),' singular values']);
    else
          title(['Error image for top N = ',num2str(n),' singular values']);
    end   
     

    forbeniusNormarray(i) = frobeniusNorm(reconstructedImage,reconstructedImagewithN)/2^16;
    fprintf('frobenius Norm with K = %d is %f \n',n,forbeniusNormarray(i));
     i = i+1;
     j = j+2;
end

%% Plotting Forbenius Norm Error for Gray Image
figure;
plot(N,abs(forbeniusNormarray),'-o','MarkerIndices',1:length(N),'LineWidth',2)
xlabel('Top N singular Values');
ylabel('Frobenius Norm of Error Image');
title([imagetype,' Rectangle Image']);



end

