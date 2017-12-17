msg = 'The Roomba vacuum cleaner just beat me to a piece of popcorn I dropped on the floor & this is how the war against the machines begins.';
encode('dog_900x632.jpg', msg, 'svdCompressIn');

decode('svdCompressIn.png')

A = imread('svdCompressIn.png');
A = double(A);
[U, S, V] = svd(A);
%[k, ~]=size(S);
k = rank(A);
%k = k - 200;
k = 100;
%[n, m] = size(U);
%[c, d] = size(V);
B = U(:,1:k) * S(1:k,1:k) * V(:,1:k)';

B = uint8(B);
imshow(B)
imwrite(B, 'svdCompressOut.png');
decode('svdCompressOut.png')