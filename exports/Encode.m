%read image into matrix
dog = imread('dog_900x632.jpg');
[n, m] = size(dog);
%show image
%imshow(dog);

%convert matrix to double precision for matrix operations
%dog = double(dog);

tweet = 'The Roomba vacuum cleaner just beat me to a piece of popcorn I dropped on the floor & this is how the war against the machines begins.';
%tweet = 'The Roomba vacuum cleaner just beat me to a piece of popcorn I dropped on the floor & this is how the war against the machines begins.                                                                                                        .';
tweet_len = length(tweet); %length of string
tweet_int = zeros(tweet_len, 1); %create an empty array to copy integers
%copy the reduced value of each character
for i = 1:tweet_len
   %tweet_int(i) = tweet(i) - 32;
   tweet_int(i) = uint8(tweet(i));
end

binStack = java.util.Stack(); %Look! Java stacks!! <3

%convert each character (int) to binary and store in the stack
for i = tweet_len : -1 : 1
    tweet_int_tmp = tweet_int(i);
    %while the value is greater than 0,
    %push reverse binary to stack
    %count = 0;
    if(tweet_int_tmp < 1)
        count = 7;
    elseif(tweet_int_tmp < 2)
        count = 6;
    elseif(tweet_int_tmp < 4)
        count = 5;
    elseif(tweet_int_tmp < 8)
        count = 4;
    elseif(tweet_int_tmp < 16)
        count = 3;
    elseif(tweet_int_tmp < 31)
        count = 2;
    elseif(tweet_int_tmp < 64)
        count = 1;
    else
        count = 0;
    end
    for j = 1 : count
        binStack.push(0);
    end
   while tweet_int_tmp > 0
        rem = mod(tweet_int_tmp, 2);
        binStack.push(rem);
        tweet_int_tmp = fix(tweet_int_tmp / 2);
        count = count + 1;
   end
    %if(count < 7)
    %    for j = 1 : 7-count
    %        binStack.push(0);
    %    end
    %end
end

%store binary tweet in new vector
bin_tweet = zeros(binStack.size(), 1);
index = 1;
while ~binStack.isEmpty()
    bin_tweet(index) = binStack.pop();
    index = index + 1;
end

%dawg = dog(1,1:31)
%maud = mod(dog(1,1:31), 2)
%modify the image
[b, a] = size(bin_tweet);
index = 0;
for i = 1:n
    for j = 1:m
        %make sure we don't go past the message
        index = index + 1;
        if(index <= b)
            % if the mod of the pixel doesn't match the bit
            if(mod( dog(i, j), 2) ~= bin_tweet(index))
                % change the pixel
                % if the pixel is already 0 we can't subtract
                if(dog(i, j) == 0)
                    dog(i, j) = dog(i, j) + 1;
                else
                    dog(i, j) = dog(i, j) - 1;
                end %0 check
            end %match check
        %add noise to the rest of the image
        else
            r = randi([0, 1], 1, 1);
            if(r == 1)
                if(dog(i, j) == 0)
                    dog(i, j) = dog(i, j) + 1;
                else
                    dog(i, j) = dog(i, j) - 1;
                end
            end %random noise
        end %message check
    end %inner loop
end %outer loop

%tweet_int(1);
%bin = bin_tweet(1:31)'
%dawg2 = dog(1, 1:31)
%maud2 = mod(dog(1, 1:31), 2)
%tweet_int(tweet_len);

% convert the matrix back into integers for image format
%dog = uint8(dog);
%export_fig(['dog_message', '.jpg'], '-jpg', '-transparent');
%imwrite(dog, 'dog_message.jpg', 'mode', 'lossless');
imwrite(dog, 'dog_message.png')
%imshow(dog)