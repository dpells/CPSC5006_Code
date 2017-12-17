msg = 'The Roomba vacuum cleaner just beat me to a piece of popcorn I dropped on the floor & this is how the war against the machines begins.';
encode('dog_632x632.jpg', msg, 'LUIn');

decode('LUIn.png')

A = imread('LUIn.png');
A = double(A);
[L, U] = lu(A);
B = L * U;

B = uint8(B);
imwrite(B, 'LUOut.png');
decode('LUOut.png')