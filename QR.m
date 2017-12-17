msg = 'The Roomba vacuum cleaner just beat me to a piece of popcorn I dropped on the floor & this is how the war against the machines begins.';
encode('dog_632x632.jpg', msg, 'qrIn');

decode('qrIn.png')

A = imread('qrIn.png');
A = double(A);
[Q, R] = qr(A);
B = Q * R;

B = uint8(B);
imwrite(B, 'qrOut.png');
decode('qrOut.png')