msg = 'According to me this is a dumb project';
encodeImprove('dog_632x632.jpg', msg, 'outmessage');
decodeImprove('outmessage.png')

%{
A = imread('svdCompressIn.png');
A = double(A);
%{
cond(A)
[U, S, V] = svd(A);
x=500;
[n, m] = size(U);
[c, d] = size(V);
B = U(:,1:x) * S(1:x,1:x) * V(:,1:x)';

B = uint8(B);
imshow(B)
%}

[L, U] = lu_partpivot(A);


B = L * U;
B = uint8(B);
imshow(B)
%}