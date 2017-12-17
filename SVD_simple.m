msg = 'The Roomba vacuum cleaner just beat me to a piece of popcorn I dropped on the floor & this is how the war against the machines begins.';
encode('dog_900x632.jpg', msg, 'svdSimpleIn');

decode('svdSimpleIn.png')

A = imread('svdSimpleIn.png');
A = double(A);
[U, S, V] = svd(A);
B = U * S * V';

B = uint8(B);
imwrite(B, 'svdSimpleOut.png');
decode('svdSimpleOut.png')