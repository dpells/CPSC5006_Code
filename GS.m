msg = 'The Roomba vacuum cleaner just beat me to a piece of popcorn I dropped on the floor & this is how the war against the machines begins.';
encode('dog_632x632.jpg', msg, 'mgsIn');

decode('mgsIn.png')

A = imread('mgsIn.png');
A = double(A);
[Q, R] = mgs(A);
B = Q * R;

B = uint8(B);
imwrite(B, 'mgsOut.png');
decode('mgsOut.png')